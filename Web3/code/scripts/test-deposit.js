/**
 * CelineZhang
 */

const CelineToken = artifacts.require("CelineToken.sol");
const Exchange = artifacts.require("Exchange.sol");
// 0x 40个0
const ETHER_ADDRESS = "0x0000000000000000000000000000000000000000";

// big number 转成位
const fromWei = (bn) => {
  return web3.utils.fromWei(bn, "ether");
};

// number 转成位
const toWei = (number) => {
  return web3.utils.toWei(number.toString(), "ether");
};

module.exports = async function (callback) {
  const celinetoken = await CelineToken.deployed();
  const exchange = await Exchange.deployed();
  const accounts = await web3.eth.getAccounts();

  // 利用交易所去存钱
  await exchange.depositEther({
    from: accounts[0],
    value: toWei(10),
  });

  let res = await exchange.tokens(ETHER_ADDRESS, accounts[0]);
  console.log(fromWei(res));

  callback();
};
