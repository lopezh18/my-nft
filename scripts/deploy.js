const main = async() => {
  // connect contract to blockchain
  const nftContractFactory = await ethers.getContractFactory('daisyNFT');
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log('Contract deployed to: ', nftContract.address);
}
const runMain = async() => {
  try {
    await main();
    process.exit(0);
  } catch(error) {
    console.log(error);
    process.exit(1);
  }
}
runMain();
