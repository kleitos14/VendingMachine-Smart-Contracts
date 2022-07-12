// SPDX License-Identifier: MIT
pragma solidity ^0.8.0;

contract VentingMachine {
    address public owner;
    mapping (address => uint) public cokeBalances;

    constructor(){
        owner = msg.sender;
        cokeBalances[address(this)] = 100;
    }

    function getVendingMachineBalance() public view returns (uint){
        return cokeBalances[address(this)];
    }

    function restock(uint amount) public {
        require(msg.sender == owner, "Only the Owner can restock this machine.");
        cokeBalances[address(this)] += amount;
    }

    function purchase(uint amount) public payable {
        //checking if the balance has money. 1 is the price of the coke
        require(msg.value>=amount * 1 ether, "You must pay at least 1 ether per coke cola" );
        //checking if the machine has enough coke colas for the order
        require(cokeBalances[address(this)]>=amount, "The machine is out of cokes, we are so sorry");
        cokeBalances[address(this)] -= amount;
        cokeBalances[msg.sender] += amount;
    }
}