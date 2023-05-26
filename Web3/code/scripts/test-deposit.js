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
  // await exchange.depositEther({
  //   from: accounts[0],
  //   value: toWei(10),
  // });
  // let res = await exchange.tokens(ETHER_ADDRESS, accounts[0]);
  // console.log(fromWei(res));

  // 交易三次，批准三次，结构还有
  // 授权批准 
  await celinetoken.approve(exchange.address, toWei(1000000), {
    from: accounts[0],
  });
  // 存入10万
  await exchange.depositToken(celinetoken.address, toWei(100000), {
    from: accounts[0],
  });
  // 交易10万
  let res = await exchange.tokens(celinetoken.address, accounts[0]);
  console.log(fromWei(res));

  callback();
};
