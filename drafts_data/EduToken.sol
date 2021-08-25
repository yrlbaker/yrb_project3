pragma solidity ^0.5.0;

import "github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/math/SafeMath.sol";
// Using SafeMath by OpenZeppelin, to make secure and strong Solidity contracts, 
// and also use for unsigned integers.
// The public token symbol is EDU, the exchange rate is 1 ETH for 100 wei.
contract EduToken {
    using SafeMath for uint;
    address payable owner = msg.sender;
    string public symbol = "EDU";
    uint public exchange_rate = 100;
    
    // Balances have set of unsigned integer values mapped by the address.
    mapping(address => uint) balances;

    //This is where you can see the balance of the account requested.
    function balance() public view returns(uint) {
        return balances[msg.sender];
    }

    // Transfer a certain amount of tokens from the balance of the original owner 
    // to a new account that is requesting tokens.
    function transfer(address recipient, uint value) public {
        balances[msg.sender] = balances[msg.sender].sub(value);
        balances[recipient] = balances[recipient].add(value);
    }

    function purchase() public payable {
        uint amountEduToken = msg.value.mul(exchange_rate);
        balances[msg.sender] = balances[msg.sender].add(amountEduToken);
        owner.transfer(msg.value);
    }

    // A request to mint the token can only come from the address payable owner.
    // Otherwise, the permission is denied. 
    function mint(address recipient, uint value) public {
        require(msg.sender == owner, "You do not have permission to mint tokens!");
        balances[recipient] = balances[recipient].add(value);
    }
}
 