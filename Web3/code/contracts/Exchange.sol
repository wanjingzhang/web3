// SPDX-License-Identifier: GPL-3.0
// 源码遵循协议，MIT ... c, python, typescript

pragma solidity >=0.4.16 <0.9.0; // 限定solidity编译器版本
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Exchange {
    using SafeMath for uint256; // 为了后面使用uint256，sub,add 方法

    // 收费账号地址
    address public feeAccount;
    // 费率
    uint256 feePercent;

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

    // 需要一个存储器
    mapping(address=>mapping(address=>uint256)) public tokens;

    // 构建时指定
    constructor(address _feeAccount, uint256 _feePercent) {
        feeAccount = _feeAccount;
        feePercent = _feePercent;
    }
}
