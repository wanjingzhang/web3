/**
 * CelineZhang
 */

const Contacts = artifacts.require("StaffStorage.sol");

module.exports = async function (callback) {
  const staffStorage = await Contacts.deployed();
  await staffStorage.setData("CelineZhang", 100);

  let res = await staffStorage.getData();
  console.log(res);
  console.log(await staffStorage.name());
  console.log(await staffStorage.age());
  callback();
};
