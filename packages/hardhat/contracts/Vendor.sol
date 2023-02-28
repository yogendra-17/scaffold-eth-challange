pragma solidity 0.8.4;  //Do not change the solidity version as it negativly impacts submission grading
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {

  //event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

  YourToken public yourToken;

  uint256 public constant tokensPerEth = 100;

 event BuyTokens(address, uint256, uint256);

  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }

    //The buyTokens() function in Vendor.sol should use msg.value and tokensPerEth to calculate an amount of tokens to yourToken.transfer() to msg.sender.

    //📟 Emit event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens) when tokens are purchased.
      // ToDo: create a payable buyTokens() function:
  function buyTokens() public payable {
    uint256 amountOfTokens = msg.value * tokensPerEth;
    yourToken.transfer(msg.sender, amountOfTokens);
    emit BuyTokens(msg.sender, msg.value, amountOfTokens);  
  }

 




  // ToDo: create a withdraw() function that lets the owner withdraw ETH

    function withdraw() public onlyOwner {
        payable(msg.sender).transfer(address(this).balance); 
    }

  // ToDo: create a sellTokens(uint256 _amount) function:

    function sellTokens(uint256 _amount) public {
    uint256 amountOfETH = _amount / tokensPerEth;
    require(address(this).balance >= amountOfETH, "Not enough ETH in the reserve");
    yourToken.transferFrom(msg.sender, address(this), _amount);
    payable(msg.sender).transfer(amountOfETH);

}
}
