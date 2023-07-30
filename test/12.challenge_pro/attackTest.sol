// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "./interface.sol";

contract attackTest is Test {
    string constant fakeWETH_Artifact = 'out/fakeWETH.sol/fakeWETH.json';
    string constant Demo_Artifact = 'out/Demo.sol/Demo.json';
    
    IfakeWETH weth;
    IDemo demo;

    function setUp() public payable{
        weth = IfakeWETH(deployHelper(fakeWETH_Artifact));
        demo = IDemo(this.deployHelper{value:5 ether}(Demo_Artifact));
    }

    function test_isComplete() public {

    }

    function deployHelper(string memory what) public payable returns (address addr) {
        bytes memory bytecode = vm.getCode(what);
        assembly {
            addr := create(5000000000000000000, add(bytecode, 0x20), mload(bytecode))
        }
    }

}
