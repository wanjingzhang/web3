/**
 * CelineZhang
 */

const CelineToken = artifacts.require("CelineToken.sol");

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
  // 默认位
  let res1 = await celinetoken.balanceOf(
    "0x10c4519D46F598F656C6cf49aB5b70aA3079b74A"
  );

  console.log(`第一个账号的值：${fromWei(res1)}`); // 100，0000

  // 转账10000Token币
  await celinetoken.transfer(
    "0x4d0bbA09a808B2a5511594267dfBb630fC706787",
    toWei(10000),
    {
      from: "0x10c4519D46F598F656C6cf49aB5b70aA3079b74A",
    }
  );

  let res3 = await celinetoken.balanceOf(
    "0x4d0bbA09a808B2a5511594267dfBb630fC706787"
  );
  console.log(`第二个账号的值：${fromWei(res3)}`); // 1，0000

  let res2 = await celinetoken.balanceOf(
    "0x10c4519D46F598F656C6cf49aB5b70aA3079b74A"
  );
  console.log(`转账完成后，第一个账号的值：${fromWei(res2)}`); // 99，0000

  callback();
};
