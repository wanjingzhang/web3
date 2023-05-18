/**
 * @auth: Celine
 */

const Contacts = artifacts.require("CelineToken.sol");

module.exports = function (deployer) {
  deployer.deploy(Contacts);
};
