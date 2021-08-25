pragma solidity ^0.5.0;

// Importing links from OpenZeppelin to test and deploy the EduToken smart contracts.
// The standardized mint function on OpenZeppelin is superior than setting up our own 
// contract due to enhanced security features 
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Mintable.sol";

// Create EduToken, inheriting from ERC20, detailed, and mintable below. 
// Deploy EDU token, instantiate with the name, symbol, initial supply. 
// This will create the new ERC20Detailed. 
// The mint statement immediately mints using ERC20Mintable, and creates the correct 
// number of EDU tokens.  

contract EduToken is ERC20, ERC20Detailed, ERC20Mintable {
    constructor (

        string memory name, 
        string memory symbol, 
        uint initialsupply

        ) ERC20Detailed (name, symbol, 18) public
        
        {
        
        mint(msg.sender, initialsupply);

        }

}
