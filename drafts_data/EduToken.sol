pragma solidity ^0.5.0;

import "github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/math/SafeMath.sol";

contract EduToken {
    using SafeMath for uint;
        // showing EDU token symbol
    address payable owner = msg.sender;
    string public symbol = "EDU";
    uint public exchange_rate = 1;

    mapping(address => uint) balances;

        //This is where you can see the balance of the account requested.
    function balance() public view returns(uint) {
        return balances[msg.sender];
    }

        // This takes the balance from the original owner of all tokens to 
        // a new account that is requesting tokens.
    function transfer(address recipient, uint value) public {
        balances[msg.sender] = balances[msg.sender].sub(value);
        balances[recipient] = balances[recipient].add(value);
    }

    function purchase() public payable {
        uint amountEduToken = msg.value.mul(exchange_rate);
        balances[msg.sender] = balances[msg.sender].add(amountEduToken);
        owner.transfer(msg.value);
    }

    function mint(address recipient, uint value) public {
        require(msg.sender == owner, "You do not have permission to mint tokens!");
        balances[recipient] = balances[recipient].add(value);
    }
}
 