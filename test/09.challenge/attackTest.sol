// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../../src/09.challenge/EverytingIsArt.sol";

contract attackTest is Test {
    EverytingIsArt everytingIsArt;

    function setUp() public{
        everytingIsArt = new EverytingIsArt();
    }

    function test_isComplete() public{
        everytingIsArt.becomeAnArtist(288);
        assertEq(everytingIsArt.isCompleted(),true);
    }

    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data)public returns (bytes4){
        return this.onERC721Received.selector;
    }
}
