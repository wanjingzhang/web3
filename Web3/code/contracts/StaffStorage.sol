// 学生的智能合约程序
// 源码遵循协议，MIT ... c, python, typescript
pragma solidity >=0.4.16 <0.9.0; // 限定solidity编译器版本

contract StaffStorage {
    // 创建两个变量 username, age
    uint age;
    string name;

    // public,private,internal,external 函数的类型
    function setData(string memory _name, uint _age) public {
        name = _name;
        age = _age;
    }

    function test(uint x, uint y) public pure returns (uint) {
        return x + y;
    }

    function getData() public view returns (string memory, uint) {
        return (name, age);
    }
}
