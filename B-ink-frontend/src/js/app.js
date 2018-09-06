const AdoptionArtifact = require('../../build/contracts/Adoption.json');
const TruffleContract = require('truffle-contract')
export default {
  web3Provider: null,
  contracts: {},

  init: function () {
    return this.initWeb3();
  },

  initWeb3: function () {
    if (typeof web3 !== 'undefined') {
      this.web3Provider = web3.currentProvider;
    } else {
      this.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
    }
    web3 = new Web3(this.web3Provider);

    return this.initContract();
  },

  initContract: function () {
    this.contracts.Adoption = TruffleContract(AdoptionArtifact);
    this.contracts.Adoption.setProvider(this.web3Provider);
  },
  markAdopted: function (adopters, account) {
    console.log('markedAdopted')
  },
};
