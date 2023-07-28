// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.13;

import "./bytecode.sol";

contract toGetBytecodeHash{
    // 从remix那里编译得到bytecode，因为foundry在一次测试中存在编译器版本问题，
    // 题目的版本很低无法通过编译，因此我把题目也放进attacker合约中，因此bytecode很长
    bytes contractBytecode = BYTECODE;
    
    function deploy(bytes32 salt) public returns(address) {
        bytes memory bytecode = contractBytecode;
        address addr;
        
        assembly {
            addr := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
        }
        return addr;
    }

    function getHash()public view returns(bytes32){
        return keccak256(contractBytecode);
    }
}