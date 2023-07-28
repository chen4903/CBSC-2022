pragma solidity 0.6.12;

import "./interface.sol";

abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this;
        return msg.data;
    }
}

contract Ownable is Context {
    address public _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor () internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    function owner() public view returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }
    
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract ERC20 is Context, IERC20 {
    using SafeMath for uint256;
    using Address for address;

    mapping (address => uint256) private _balances;

    mapping (address => mapping (address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    uint8 private _decimals;

    constructor (string memory name, string memory symbol) public {
        _name = name;
        _symbol = symbol;
        _decimals = 1;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) internal virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(sender, recipient, amount);

        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _setupDecimals(uint8 decimals_) internal {
        _decimals = decimals_;
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual { }
}

// 质押：只要用户质押了，就根据规则进行分红
contract MasterChef is Ownable, ERC20 {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    // 用户信息
    struct UserInfo {
        uint256 amount;
        uint256 rewardDebt;  // 偿还债务
    }

    // 池子信息
    struct PoolInfo {    
        uint256 allocPoint; // 分配分数
        uint256 lastRewardBlock;  // 上一个奖励区块
        uint256 accSushiPerShare;  // 什么B玩意？
        uint256 totalstake; // 总共质押数量
    }

    uint256 public sushiPerBlock; // 什么B玩意？
    PoolInfo[] public poolInfo; // 存放所有池子信息
    mapping (uint256 => mapping (address => UserInfo)) public userInfo; // ID=>用户地址=>用户信息
    uint256 public totalAllocPoint = 0; // 什么B玩意？
    uint256 public startBlock; // 开始的区块
    uint256 public aridorplimit; // 空投限制

    event Deposit(address indexed user, uint256 indexed pid, uint256 amount);
    event Withdraw(address indexed user, uint256 indexed pid, uint256 amount);
    event EmergencyWithdraw(address indexed user, uint256 indexed pid, uint256 amount);

    // 本身就是一个ERC20代币
    constructor() ERC20("test","test") public {
        // 预挖的行为使得totalSupply为：10000000+100000000=110000000
        _mint(address(this),10000000); // 预挖给本合约
        _mint(msg.sender,100000000); // 预挖给msg.sender
        sushiPerBlock = 1; // 什么B玩意？
        startBlock = block.number;
        uint256 lastRewardBlock = block.number > startBlock ? block.number : startBlock;
        // 总共可分配的分数为100
        uint256 _allocPoint = 100;
        totalAllocPoint = totalAllocPoint.add(_allocPoint);
        // 初始化第一个池子
        poolInfo.push(PoolInfo({
            allocPoint: _allocPoint,
            lastRewardBlock: lastRewardBlock,
            accSushiPerShare: 0,
            totalstake: 0
        }));
    }

    // 有了足够的代币即可成为owner
    function transferOwnership(address newOwner) public override{
        require(balanceOf(msg.sender) >= 1000000, "");
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }

    // 空投：最多1000
    function airdorp() public {
        require(aridorplimit < 1000,"");
        _mint(msg.sender,1);
        aridorplimit = aridorplimit + 1;
    }

    function poolLength() external view returns (uint256) {
        return poolInfo.length;
    }

    // 其实就只是减法：后减前
    function getMultiplier(uint256 _from, uint256 _to) public view returns (uint256) {
        return _to.sub(_from);
    }

    function pendingSushi(uint256 _pid, address _user) external view returns (uint256) {
        PoolInfo storage pool = poolInfo[_pid]; // 获取到某个池子信息
        UserInfo storage user = userInfo[_pid][_user]; // 获取到某个用户的信息
        uint256 accSushiPerShare = pool.accSushiPerShare; // 获取到池子的accSushiPerShare
        uint256 lpSupply = pool.totalstake; // 获取总质押的金额
        // 至少超过上一次奖励的区块 && 如果质押了一定数量的金额
        if (block.number > pool.lastRewardBlock && lpSupply != 0) {
            uint256 multiplier = getMultiplier(pool.lastRewardBlock, block.number);
            // 计算：根据一定的规则计算可以得到的回报
            uint256 sushiReward = multiplier.mul(sushiPerBlock).mul(pool.allocPoint).div(totalAllocPoint);
            // 跟新accSushiPerShare
            accSushiPerShare = accSushiPerShare.add(sushiReward.mul(1e12).div(lpSupply));
        }
        // 更新用户的存款信息
        return user.amount.mul(accSushiPerShare).div(1e12).sub(user.rewardDebt);
    }

    // 更新所有池子的信息
    function massUpdatePools() public {
        uint256 length = poolInfo.length;
        for (uint256 pid = 0; pid < length; ++pid) {
            updatePool(pid);
        }
    }

    // 更新池子的信息
    function updatePool(uint256 _pid) public {
        // 根据ID获得对应的池子
        PoolInfo storage pool = poolInfo[_pid];
        // 必须超过上一次奖励的区块
        if (block.number <= pool.lastRewardBlock) {
            return;
        }
        // 获取池子中总质押的金额
        uint256 lpSupply = pool.totalstake;
        // 如果质押金额为0，则只是更新一下区块
        if (lpSupply == 0) {
            pool.lastRewardBlock = block.number;
            return;
        }
        // 否则更新池子中奖励的信息
        uint256 multiplier = getMultiplier(pool.lastRewardBlock, block.number);
        uint256 sushiReward = multiplier.mul(sushiPerBlock).mul(pool.allocPoint).div(totalAllocPoint);
        pool.accSushiPerShare = pool.accSushiPerShare.add(sushiReward.mul(1e12).div(lpSupply));
        pool.lastRewardBlock = block.number;
    }

    // 存款
    function deposit(uint256 _pid, uint256 _amount) public {
        // 获取池子
        PoolInfo storage pool = poolInfo[_pid];
        // 获取个人信息
        UserInfo storage user = userInfo[_pid][msg.sender];
        // 更新池子信息
        updatePool(_pid);
        // 如果个人信息中有金额，则根据计算规则在本合约中存取一定量的资产
        if (user.amount > 0) {
            uint256 pending = user.amount.mul(pool.accSushiPerShare).div(1e12).sub(user.rewardDebt);
            safeTokenTransfer(msg.sender, pending);
        }
        // msg.sender将自己的代币转到此合约，然后更新个人信息
        this.transferFrom(address(msg.sender), address(this), _amount);
        user.amount = user.amount.add(_amount);
        user.rewardDebt = user.amount.mul(pool.accSushiPerShare).div(1e12);
        // 池子总的质押数量增加
        pool.totalstake += _amount; 
        emit Deposit(msg.sender, _pid, _amount);
    }

    // 取款
    function withdraw(uint256 _pid, uint256 _amount) public {
        // 获取池子
        PoolInfo storage pool = poolInfo[_pid];
        // 获取个人信息
        UserInfo storage user = userInfo[_pid][msg.sender];
        // 需要有足够的钱才能取款
        require(user.amount >= _amount, "withdraw: not good");
        // 更新池子信息
        updatePool(_pid);
        // 根据规则计算出用户可以得到的pending金额
        uint256 pending = user.amount.mul(pool.accSushiPerShare).div(1e12).sub(user.rewardDebt);
        safeTokenTransfer(msg.sender, pending);
        // 更新个人信息
        user.amount = user.amount.sub(_amount);
        user.rewardDebt = user.amount.mul(pool.accSushiPerShare).div(1e12);
        // 更新池子的质押数量
        pool.totalstake -= _amount; 
        // 用户取款
        this.transfer(address(msg.sender), _amount);
        emit Withdraw(msg.sender, _pid, _amount);
    }

    // 紧急取款
    function emergencyWithdraw(uint256 _pid) public {
        // memory意味着不会修改任何storage数据
        PoolInfo memory pool = poolInfo[_pid];
        UserInfo memory user = userInfo[_pid][msg.sender];
        // 用户拿到了取款
        this.transfer(address(msg.sender), user.amount);
        emit EmergencyWithdraw(msg.sender, _pid, user.amount);
        // 更新用户个人资产信息
        pool.totalstake -= user.amount; 
        user.amount = 0;
        user.rewardDebt = 0;
    }
    
    // 转账：本合约的资产转给转给其他用户
    function safeTokenTransfer(address _to, uint256 _amount) internal {
        uint256 TokenBal = balanceOf(address(this));
        if (_amount > TokenBal) {
            this.transfer(_to, TokenBal);
        } else {
           this.transfer(_to, _amount);
        }
    }
}