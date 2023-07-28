// SPDX-License-Identifier: GPL-3.0-only
pragma solidity 0.6.12;

import "./interface.sol";
import "./Masterchef.sol";

contract Governance {
    bool public Flag;
    address public  ValidatorOwner;
    mapping (address => uint256) public validatorVotes;
    mapping (address => bool) public VotingStatus;
    MasterChef public masterChef = new MasterChef();
    string greeting;

    event Sendflag(bool Flag);  

    constructor (string memory _greeting) public {
        greeting = _greeting;
    }

    modifier onlyValidatorOwner() {
        require(msg.sender == ValidatorOwner, "Governance: only validator owner");
        _;
    }

    // 投票
    function vote(address validator) public {
        // 只有owner才可以投票
        require(masterChef.owner() == msg.sender);
        // owner之前没用投票过
        require(!VotingStatus[msg.sender]);
        VotingStatus[msg.sender] = true;
        // 获取自己的代币余额
        uint balances = masterChef.balanceOf(msg.sender);
        // 然后给提案进行权重投票
        validatorVotes[validator] += balances;
    }

    // 成为Validator：至少需要代币总发行量的2/3
    function setValidator() public {
        uint256 votingSupply = masterChef.totalSupply() * 2 / 3;
        require(validatorVotes[msg.sender] >= votingSupply);
        ValidatorOwner = msg.sender;
    }

    // 任务：成为Validator
    function setflag() public onlyValidatorOwner {
        Flag = true;
        emit Sendflag(Flag);
    }
}