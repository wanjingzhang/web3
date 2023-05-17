/**
 * @auth: Celine
 */

const Contacts = artifacts.require("StaffStorage.sol");

module.exports = function (deployer) {
  deployer.deploy(Contacts);
};
