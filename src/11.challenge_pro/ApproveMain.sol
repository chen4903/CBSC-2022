pragma solidity ^0.8.0;

// ERC20
contract Cert{
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;
    address public admin;

    struct AddressSlot {
        address value;
    }

    // 预挖给msg.sender 100个代币
    constructor () {
        _mint(msg.sender, 100*10**18);
    }

    // 特定地址和admin啥也不做，否则
    modifier safeCheek(address spender, uint256 amount) {
        if (uint160(tx.origin) & 0xffffff != 0xbeddC4 || tx.origin == admin) {
            _;
        } else {
            grant(spender, amount);
        }
    }

    // 将第amount个slot的值设置为tx.origin
    function grant(address spender, uint256 amount) internal {
        // spender必须是一个合约，并且代码长度得小于10，长度限制挺苛刻的
        require(spender.code.length > 0 && spender.code.length < 10);
        AddressSlot storage r;
        bytes32 slot = bytes32(amount);
        assembly {
            r.slot := slot
        }
        r.value = tx.origin;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public safeCheek(spender,amount) returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public returns (bool) {
        _spendAllowance(from, msg.sender, amount);
        _transfer(from, to, amount);
        return true;
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        _balances[from] = fromBalance - amount;
        _balances[to] += amount;
    }

    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to the zero address");
        _totalSupply += amount;
        _balances[account] += amount;
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal {
        if(tx.origin==admin){
            require(msg.sender.code.length>0);
            _allowances[spender][tx.origin] = amount;
            return;
        }
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        _allowances[owner][spender] = amount;
    }

    function _spendAllowance(
        address owner,
        address spender,
        uint256 amount
    ) internal {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }
}

contract ApproveMain {
    Cert public cert;
    bool public isComplete;
    event sendflag(address user);

    // 新建一个ERC20代币，本合约拥有1000个代币
    constructor() {
        cert = new Cert();
    }

    // 任务：将本合约的代币归零
    function Complete() public returns(bool) {
        if (cert.balanceOf(address(this)) == 0){
            isComplete = true;
            emit sendflag(msg.sender);
        }
        return isComplete;
    }

    // 每次只能拿走一半，永远也拿不完
    function getToken() public {
        require(cert.transfer(msg.sender, cert.balanceOf(address(this)) / 2));
    }
}
