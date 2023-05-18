/**
 * CelineZhang
 */

const StaffListStorage = artifacts.require("StaffListStorage.sol");

module.exports = async function (callback) {
  const staffList = await StaffListStorage.deployed();
  await staffList.addList("CelineZhang", 100);

  let res = await staffList.getList();
  console.log(res);
  callback();
};
