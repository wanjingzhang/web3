/**
 * @auth: Celine
 */

const Contacts = artifacts.require("StaffListStorage.sol");

module.exports = function (deployer) {
  deployer.deploy(Contacts);
};
