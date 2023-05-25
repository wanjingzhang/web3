// SPDX-License-Identifier: GPL-3.0
// 源码遵循协议，MIT ... c, python, typescript

pragma solidity >=0.4.16 <0.9.0; // 限定solidity编译器版本
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./CelineToken.sol";

contract Exchange {
    using SafeMath for uint256; // 为了后面使用uint256，sub,add 方法

    // 收费账号地址
    address public feeAccount;
    // 费率
    uint256 feePercent;
    // 以太坊的地址，随便写个地址0，这个人所持有的以太币
    address constant ETHER = address(0);
    // 需要一个存储器，tokens最核心的数据库
    mapping(address => mapping(address => uint256)) public tokens;

    // {
    //     "比特币的地址":{
    //         "A用户"：100,
    //         "B用户"：200,
    //     },
    //     "CLT的地址":{
    //         "A用户"：200,
    //         "B用户"：300,
    //     },
    //     "以太币":{
    //         "A用户"：200,
    //         "B用户"：500,
    //     }
    // }

    // 构建时指定
    constructor(address _feeAccount, uint256 _feePercent) {
        feeAccount = _feeAccount;
        feePercent = _feePercent;
    }

    // 存款(当前存入货币的账户地址，当前账号的地址，存入多少钱，还有多少钱)
    event Deposit(address token, address user, uint256 amount, uint256 balance);

    // 交易所存款 存以太币，方法特殊,部署成在共有链上的数据库，需要足够村好多信息
    function depositEther() public payable {
        // msg.sender
        // msg.value
        tokens[ETHER][msg.sender] = tokens[ETHER][msg.sender].add(msg.value);
        emit Deposit(ETHER, msg.sender, msg.value, tokens[ETHER][msg.sender]);
    }

    // 交易所存款 存其他货币
    function depositToken(address _token, uint256 _amount) public {
        require(_token != ETHER);
        // 调用某个方法，强行从你账号往当前交易所账户转钱
        CelineToken(_token).transferFrom(msg.sender, address(this), _amount);
        // 在系统中记录
        tokens[_token][msg.sender] = tokens[_token][msg.sender].add(_amount);
        // 记录
        emit Deposit(_token, msg.sender, _amount, tokens[_token][msg.sender]);
    }
}
