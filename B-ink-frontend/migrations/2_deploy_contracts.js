var MyContract = artifacts.require("Adoption");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(MyContract);
};