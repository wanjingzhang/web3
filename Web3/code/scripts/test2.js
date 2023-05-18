/**
 * CelineZhang
 */

const StaffListStorage = artifacts.require("StaffListStorage.sol");

module.exports = async function (callback) {
  try {
    const staffList = await StaffListStorage.deployed();
    await staffList.addList("CelineZhang", 100);
    let res = await staffList.getList();
    console.log(res);
    console.log(await staffList.StaffList(0));

    callback();
  } catch (error) {
    console.log(error);
  }
};
