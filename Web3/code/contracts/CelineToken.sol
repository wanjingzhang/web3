// Celine的智能合约程序
// SPDX-License-Identifier: GPL-3.0
// 源码遵循协议，MIT ... c, python, typescript
pragma solidity >=0.4.16 <0.9.0; // 限定solidity编译器版本
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract CelineToken {
    using SafeMath for uint256; // 为了后面使用uint256，sub,add 方法

    string public name = "CelineToken";
    string public symbol = "CLT"; // 代币符号
    uint256 public decimals = 18; // 货币位数
    uint256 public totalSupply; //总供应量
    // 自动生成getter方法 余额
    mapping(address => uint256) public balanceOf; // mapping 返回某个账号对应的代币的数量
    mapping(address => mapping(address => uint256)) public allowance;

    constructor() {
        // 部署账号
        totalSupply = 1000000 * (10 ** decimals); // 10的18次幂**，货币总量 100万以太坊币，转换成位
        balanceOf[msg.sender] = totalSupply; // 创始人将拥有所有的初始代币
    }

    // 事件类型，在合约中一旦被触发，它就会被存储在交易的机制、日志中
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    // 转账
    function transfer(
        address _to,
        uint256 _value
    ) public returns (bool success) {
        // 判断地址是有效地址
        require(_to != address(0));
        // 转账发起人
        _transfer(msg.sender, _to, _value);
        return true;
    }

    // 提取内部函数
    function _transfer(address _from, address _to, uint256 _value) internal {
        // 发起者金额要比转账金额大
        require(balanceOf[_from] >= _value);
        // balanceOf通过地址获取余额， 账号发起调用者钱数要减少，
        balanceOf[_from] = balanceOf[_from].sub(_value);
        balanceOf[_to] = balanceOf[_to].add(_value);

        // 触发事件
        emit Transfer(_from, _to, _value);
    }

    // 授权给不同交易所的数额
    function approve(
        address _spender,
        uint256 _value
    ) public returns (bool success) {
        // msg.sender 是当前授权的账号
        // _spender 第三方交易所的账号地址
        // _value 授权得钱数,
        // require 如果这里出错了，那么我们消耗的gas值可以退回，后面的gas也都会退回
        require(_spender != address(0));

        allowance[msg.sender][_spender] = _value;
        // 证明
        emit Approval(msg.sender, _spender, _value);

        return true;
    }

    // 被授权的交易所调用
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        // _from 某个放款账号
        // _to 收款账号
        // msg.sender 交易所的账号地址

        // 账号钱数大于转账的钱数
        require(balanceOf[_from] >= _value);

        // 授权的需要这么多钱
        require(allowance[_from][msg.sender] >= _value);
        allowance[_from][msg.sender] = allowance[_from][msg.sender].sub(_value);
        _transfer(_from, _to, _value);
        return true;
    }
}
