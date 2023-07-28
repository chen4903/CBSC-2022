// pragma solidity 0.4.24; //这是原来的版本，很奇怪不知道为啥无法在foundry编译，所以换成以下版本
pragma solidity ^0.8.13;

contract SVip {
    // 一个地址记录一个分数
    mapping(address => uint) public points;
    // 查看某地址是不是超级VIP
    mapping(address => bool) public isSuperVip;
    uint256 public numOfFree;

    // 用户成为超级VIP需要999分数
    function promotionSVip() public {
        require(points[msg.sender] >= 999, "Sorry, you don't have enough points");
        isSuperVip[msg.sender] = true;
    }

    // 领取免费分数，所有人领取的分数加起来不得岛屿等于100
    function getPoint() public{
        require(numOfFree < 100);
        points[msg.sender] += 1;
        numOfFree++;
    }
    
    // 送分，明显是存在发给自己这种漏洞情况
    function transferPoints(address to, uint256 amount) public {
        uint256 tempSender = points[msg.sender];
        uint256 tempTo = points[to];
        require(tempSender > amount);
        require(tempTo + amount > amount);
        points[msg.sender] = tempSender - amount;
        points[to] = tempTo + amount;
    }

    // 任务是成为超级VIP
    function isComplete() public view  returns(bool) {
        require(isSuperVip[msg.sender]);
        return true;
    }

}