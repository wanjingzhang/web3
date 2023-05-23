// 学生的智能合约程序
// SPDX-License-Identifier: GPL-3.0
// 源码遵循协议，MIT ... c, python, typescript
pragma solidity >=0.4.16 <0.9.0; // 限定solidity编译器版本

contract StaffStorage {
    // 创建两个变量 username, age
    uint public age;
    string public name;

    // storage 高gas消费

    // memory 消费gas
    // public,private,internal,external 函数的类型
    function setData(string memory _name, uint _age) public {
        name = _name;
        age = _age;
    }

    // pure 纯函数，不访问，也不修改
    function test(uint x, uint y) public pure returns (uint) {
        return x + y;
    }

    // 节约gas
    // view 视图函数，只访问不修改状态
    function getData() public view returns (string memory, uint) {
        return (name, age);
    }
}
