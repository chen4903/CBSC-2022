pragma solidity 0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {IERC20Permit, ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

// 普通的ERC20代币
contract MockWETH is ERC20("Wrapped ETH", "WETH") {
    event Deposit(address indexed dst, uint256 wad);
    event Withdrawal(address indexed src, uint256 wad);

    /// @dev Original WETH9 implements `fallback` function instead of `receive` function due to a earlier solidity version
    fallback() external payable {
        deposit();
    }

    function deposit() public payable {
        _mint(msg.sender, msg.value);
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 wad) public {
        require(balanceOf(msg.sender) >= wad, "weth: insufficient balance");

        _burn(msg.sender, wad);
        (bool success, ) = msg.sender.call{value: wad}("");
        require(success, "weth: failed");

        emit Withdrawal(msg.sender, wad);
    }
}

// 本身也是一个ERC20代币，并且拥有Permit功能
// 并且添加了一个普通的ERC20代币作为underlyingToken
contract MocksWETH is ERC20Permit {
    using SafeERC20 for IERC20;

    address underlying;

    constructor(address _underlying) ERC20("WrappedERC20", "WERC20") ERC20Permit("WrappedERC20"){
        underlying = _underlying;
    }

    // 将资产从WETH换成sWETH
    function deposit() external returns (uint256) {
        uint256 _amount = IERC20(underlying).balanceOf(msg.sender);
        IERC20(underlying).safeTransferFrom(msg.sender, address(this), _amount);
        return _deposit(_amount, msg.sender);
    }

    function deposit(uint256 amount) external returns (uint256) {
        IERC20(underlying).safeTransferFrom(msg.sender, address(this), amount);
        return _deposit(amount, msg.sender);
    }

    // 链下签名： 将资产从WETH换成sWETH
    function depositWithPermit(
        address target,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s,
        address to
    ) external returns (uint256) {
        // underlying即WETH，没有这个方法，因此去到fallback()而不会检验，相当于啥也没写
        IERC20Permit(underlying).permit(target,address(this),value,deadline, v,r,s);
        // 因为有个已经执行过的操作：      WETH资产：LostAssets 授权给 sWETH合约
        // 因此sWETH合约可以用transferFrom()来操作 LostAssets 的WETH资产
        // 因为上面的代码形同虚设，因此任何人都可以使用此方法
        IERC20(underlying).safeTransferFrom(target, address(this), value);
        return _deposit(value, to);
    }

    function _deposit(uint256 value, address to) internal returns (uint256) {
        _mint(to, value);
        return value;
    }

    // 烧掉sWETH，换成WETH
    function withdraw() external returns (uint256) {
        return _withdraw(msg.sender, balanceOf(msg.sender), msg.sender);
    }

    function withdraw(uint256 amount) external returns (uint256) {
        return _withdraw(msg.sender, amount, msg.sender);
    }

    function _withdraw(address from,uint256 amount,address to) internal returns (uint256) {
        _burn(from, amount);
        IERC20(underlying).safeTransfer(to, amount);
        return amount;
    }
}

contract LostAssets {
    MockWETH public WETH;
    MocksWETH public sWETH;

    constructor() payable {
        require(msg.value >= 1 ether, "At least 1 ether");

        WETH = new MockWETH();
        sWETH = new MocksWETH(address(WETH));

        // WETH资产：LostAssets获得msg.value的WETH
        WETH.deposit{value: msg.value}();
        // WETH资产：LostAssets 授权给 sWETH合约
        WETH.approve(address(sWETH), type(uint256).max);
        // sWETH: LostAssets 将资产从WETH换成sWETH
        // 因为msg.sender是 LostAssets ，因此可以操作成功
        // 这里已经操作了一半的资产，因此还有0.5ether可以操作
        sWETH.deposit(msg.value / 2);
    }

    // 将LostAssets合约的WETH设置为0
    function isComplete() public view returns (bool) {
        require(WETH.balanceOf(address(this)) == 0);
        return true;
    }
}
