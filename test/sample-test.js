// const { expect } = require("chai");
const { ethers } = require("hardhat");

// describe("Greeter", function () {
//   it("Should return the new greeting once it's changed", async function () {
//     const Greeter = await ethers.getContractFactory("Greeter");
//     const greeter = await Greeter.deploy("Hello, world!");
//     await greeter.deployed();

//     expect(await greeter.greet()).to.equal("Hello, world!");

//     const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

//     // wait until the transaction is mined
//     await setGreetingTx.wait();

//     expect(await greeter.greet()).to.equal("Hola, mundo!");
//   });
// });

const { assert } = require('chai')

describe('daisyNFT Contract', async () => {
	let nft
	let nftContractAddress
	let tokenId

	// Deploys the EternalNFT contract and the EternalMarket contract before each test
	beforeEach('Setup Contract', async () => {
		const daisyNFT = await ethers.getContractFactory('daisyNFT')
		nft = await daisyNFT.deploy()
		await nft.deployed()
		nftContractAddress = await nft.address
	})

	// Tests address for the EternalNFT contract
	it('Should have an address', async () => {
		assert.notEqual(nftContractAddress, 0x0)
		assert.notEqual(nftContractAddress, '')
		assert.notEqual(nftContractAddress, null)
		assert.notEqual(nftContractAddress, undefined)
	})

	// Tests name for the token of EternalNFT contract
	it('Should have a name', async () => {
		// Returns the name of the token
		const name = await nft.collectionName()

		assert.equal(name, 'daisyNFT')
	})

	// Tests symbol for the token of EternalNFT contract
	it('Should have a symbol', async () => {
		// Returns the symbol of the token
		const symbol = await nft.collectionSymbol()

		assert.equal(symbol, 'daisyNFT')
	})

	// Tests for NFT minting function of EternalNFT contract using tokenID of the minted NFT
	it('Should be able to mint NFT', async () => {
		// Mints a NFT
		let txn = await nft.createDaisyNFT()
		let tx = await txn.wait()

		// tokenID of the minted NFT
		let event = tx.events[0]
		let value = event.args[2]
		tokenId = value.toNumber()

		assert.equal(tokenId, 0)

		// Mints another NFT
		txn = await nft.createDaisyNFT()
		tx = await txn.wait()

		// tokenID of the minted NFT
		event = tx.events[0]
		value = event.args[2]
		tokenId = value.toNumber()

		assert.equal(tokenId, 1)
	})
})
