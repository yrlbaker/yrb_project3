pragma solidity ^0.5.0;

// The links below are taken from OpenZepplin. One of many links from the website,
// this site is an open-source "testing ground" by community developers to test 
// and create secure smart contracts.

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";

// Initialize EduToken contract. EduToken inherits properties from ERC20, ERC20Detailed contracts.
contract TheEduToken is ERC20, ERC20Detailed {
    address payable owner;

    // The modifier only allows the contract owner to mint, and this is enforced via 
    // the require statement. 
    modifier onlyOwner {
        require(msg.sender == owner, "You do not have permission to mint these tokens!");
        _;
    }
    // Constructor function is called only once in the contract. It initializes the supply of
    // the EduToken. Value supplied to the constructor function: 123,456,789,012,345 EDU tokens.
    constructor(uint initial_supply) ERC20Detailed("TheEduToken", "EduToken", 18) public {
        owner = msg.sender;
        _mint(owner, initial_supply);
    }

    // Instantiates only the contract owner to mint the EduTokens.
    function mint(address recipient, uint amount) public onlyOwner {
        _mint(recipient, amount);
    }

}
