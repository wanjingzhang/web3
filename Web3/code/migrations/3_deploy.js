/**
 * @auth: Celine
 */

const Contacts = artifacts.require("CelineToken.sol");
const Exchange = artifacts.require("Exchange.sol");

module.exports = async function (deployer) {
  const accounts = await web3.eth.getAccounts(); //获取区块链上所有的地址

  await deployer.deploy(Contacts);
  await deployer.deploy(Exchange, accounts[0], 10);
};
