/* eslint-disable no-undef */

const SphynxVRFConsumer = artifacts.require("SphynxVRFConsumer");

module.exports = async function (deployer) {
  await deployer.deploy(SphynxVRFConsumer);
  await SphynxVRFConsumer.deployed();
};
