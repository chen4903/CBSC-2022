// SPDX-License-Identifier: GPL-3.0

// pragma solidity 0.4.24; //这是原来的版本，很奇怪不知道为啥无法在foundry编译，所以换成以下版本
pragma solidity ^0.8.13;

library MerkleProof {
   
    function verify( bytes32[] memory proof, bytes32 root, bytes32 leaf) internal pure returns (bool) {
        return processProof(proof, leaf) == root;
    }

    function processProof(bytes32[] memory proof, bytes32 leaf) internal pure returns (bytes32) {
        bytes32 computedHash = leaf;
        for (uint256 i = 0; i < proof.length; i++) {
            bytes32 proofElement = proof[i];
            if (computedHash <= proofElement) {
                // Hash(current computed hash + current element of the proof)
                computedHash = keccak256(abi.encodePacked(computedHash, proofElement));
            } else {
                // Hash(current element of the proof + current computed hash)
                computedHash = keccak256(abi.encodePacked(proofElement, computedHash));
            }
        }
        return computedHash;
    }
}

contract Merkle {
    
    uint public amount = 1;
    address public owner;
    bytes20 mask = hex"ff00000000000000000000000000000000000000";
    bytes32 public merkleRoot;
    
    // 一开始合约有1ether
    constructor(bytes32 root) payable {
        require(msg.value == 1 ether);
        owner =  msg.sender;
        merkleRoot = root;
    }

    // 只要调用者地址的第一个高字节和owner一样即可
    modifier onlyOwner() {
        require(mask & bytes20(msg.sender) == mask & bytes20(owner));
        _;
    }

    // 获取a，b两个值的大值
    function min(uint a,uint b) public view returns(uint){
        return a > b ? a : b;
    }
    
    // 取钱：需要通过merkle树验证，可以发给任何地址，一次最多取1wei
    function withdraw(bytes32[] memory proof,address to) public returns(bool){
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        require(MerkleProof.verify(proof, merkleRoot, leaf), "Merkle Proof Verification failed");
        uint balance = address(this).balance;
        // 这里的amount没啥用，因为balnace一定是大于amount的，将本合约中的所有钱给到to地址
        payable(to).transfer(min(amount,balance));
    }

    function balanceOf() public view returns(uint){
        return address(this).balance;
    }
    
    function setMerkleroot(bytes32 _merkleroot) external onlyOwner { 
        merkleRoot = _merkleroot;
    }

    // 任务是将合约中的余额归零
    function Complete() external {
        require(address(this).balance == 0);
    } 
}
