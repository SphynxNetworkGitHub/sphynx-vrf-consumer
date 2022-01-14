// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

/**
 * THIS IS AN EXAMPLE CONTRACT WHICH USES HARDCODED VALUES FOR CLARITY.
 * PLEASE DO NOT USE THIS CODE IN PRODUCTION.
 */

/**
 * Request testnet LINK and ETH here: https://faucets.chain.link/
 * Find information on LINK Token Contracts and get the latest ETH and LINK faucets here: https://docs.chain.link/docs/link-token-contracts/
 */
 
contract SphynxVRFConsumer is VRFConsumerBase, Ownable {
    
    bytes32 internal keyHash;
    uint256 internal fee;
    address public linkTokenAddress = 0x326C977E6efc84E512bB9C30f76E30c160eD06FB;
    
    uint256 public randomResult;
    bytes32 public reqId;
    
    /**
     * Constructor inherits VRFConsumerBase
     * 
     * Network: Kovan
     * Chainlink VRF Coordinator address: 0x8C7382F9D8f56b33781fE506E897a4F1e2d17255
     * LINK token address:                0x326C977E6efc84E512bB9C30f76E30c160eD06FB
     * Key Hash: 0x6c3699283bda56ad74f6b855546325b68d482e983852a7a82979cc4807b641f4
     */
    constructor() 
        VRFConsumerBase(
          0x8C7382F9D8f56b33781fE506E897a4F1e2d17255,
          0x326C977E6efc84E512bB9C30f76E30c160eD06FB
        )
    {
      keyHash = 0x6e75b569a01ef56d18cab6a8e71e6600d6ce853834d4a5748b720d06f878b3a4;
      fee = 0.0001 * 10 ** 18; // 0.1 LINK (Varies by network)
      randomResult = 0;
    }
    
    /** 
     * Requests randomness 
     */
    function getRandomNumber() public returns (bytes32 requestId) {
      require(LINK.balanceOf(address(this)) >= fee, "Not enough LINK - fill contract with faucet");
      return requestRandomness(keyHash, fee);
    }

    /**
     * Callback function used by VRF Coordinator
     */
    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
      reqId = requestId;
      randomResult = randomness;
    }

    function withdrawLink() external {
      bool success = LINK.transfer(address(owner()), LINK.balanceOf(address(this)));
      require(success);
    }
}