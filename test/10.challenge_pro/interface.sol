// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

interface IMdexFactory{
    function setInitCodeHash(bytes32) external;
    function getInitCodeHash() external pure returns (bytes32);
}

interface IWHT{

}

interface IMdexRouter{

}

interface IDeploy{
    function Step1() external;
    function step2() external;
    function airdrop() external;
    function balanceOf(address) external view returns(uint256);
    function pair() external returns(address);
    function approve(address, uint256) external returns (bool);
    function quintADDRESS() external view returns(address);
}

interface IMdexPair{
    function approve(address, uint256) external returns (bool);
}

interface IQuintConventionalPool{
    function stake(uint256 , uint256 ) external;
    function reStake(uint256) external;
    function captureFlag() external returns (bool) ;

    event flag(string,address);
}