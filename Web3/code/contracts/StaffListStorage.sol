// 学生的智能合约程序
// 源码遵循协议，MIT ... c, python, typescript
pragma solidity >=0.4.16 <0.9.0; // 限定solidity编译器版本

contract StaffListStorage {
    // c语言结构体
    struct Staff {
        uint id;
        string name;
        uint age;
    }

    // 动态数组[不写长度]
    Staff[] public StaffList; // 自动生成getter()方法

    // memory 消费gas
    // public,private,internal,external 函数的类型
    function addList(string memory _name, uint _age) public returns (uint) {
        uint count = StaffList.length;
        uint index = count + 1;
        StaffList.push(Staff(index, _name, _age));
        return StaffList.length;
    }

    // view 视图函数，只访问不修改状态
    function getList() public view returns (Staff[] memory) {
        Staff[] memory list = StaffList;
        return list;
    }
}
