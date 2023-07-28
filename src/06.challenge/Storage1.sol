pragma solidity ^0.8.0;

import "./StorageSlot.sol";

contract Storage1 {
    uint256 public constant VERSION = 1;
    address public aaaaa;
    address public admin;
    bytes32 public constant OPERATOR_ROLE = keccak256("OPERATOR_ROLE");

    mapping(address => uint256) public gasDeposits;

    event SendFlag();
    event SetLogicContract(bytes32 key, address oldAddress, address newAddress);
    event DepositedGas(address account, uint256 amount);
    event WithdrewGas(address account, uint256 amount);

    error ZeroValue();
    error ZeroAmount();
    error NoAccess(bytes32 roleid, address account);


    constructor() {
        admin = address(0);
    }

    modifier onlyAdmin() {
        require(admin == msg.sender);
        _;
    }

    // 设置任意slot内容
    function setLogicContract(bytes32 key, address contractAddress) external {
        StorageSlot.AddressSlot storage slot = StorageSlot.getAddressSlot(key);
        emit SetLogicContract(key, slot.value, contractAddress);
        slot.value = contractAddress;
    }

    // 存款：给某个账户存款
    function depositGasFor(address account) external payable {
        depositGas(account, msg.value);
    }
    function depositGas(address account, uint256 amount) internal {
        if (amount == 0) revert ZeroValue();
        gasDeposits[account] = gasDeposits[account] + amount;
        emit DepositedGas(account, amount);
    }

    // 取款
    function withdrawGas(uint256 amount) external {
        if (amount == 0) revert ZeroAmount();

        uint256 withdrawAmount = amount > gasDeposits[msg.sender] ? gasDeposits[msg.sender]: amount;

        if (withdrawAmount == 0) return;

        gasDeposits[msg.sender] = gasDeposits[msg.sender] - withdrawAmount;
        payable(msg.sender).transfer(withdrawAmount);

        emit WithdrewGas(msg.sender, withdrawAmount);
    }

    function isComplete() public  {
        require(admin == msg.sender);
        require(gasDeposits[msg.sender] >= 9999999999999999999999999999999999);
        emit SendFlag();
    }

    receive() external payable {
        depositGas(msg.sender, msg.value);
    }
}
