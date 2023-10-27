pragma solidity ^0.8.19;

contract UserAccount {
    event Deposit(
        address indexed user,
        uint256 value,
        uint256 timestamp
    );
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 amount,
        uint256 timestamp
    );

    struct Transaction {
        int256 amount;
        uint256 timestamp;
    }

    struct Account {
        address user;
        uint256 balance;
        Transaction[] transactions;
    }

    mapping(address => Account) public accounts;
    uint256 public nextTransactionId;

    function checkBalance() external view returns (uint256) {
        return accounts[msg.sender].balance;
    }

    function deposit() external payable {
        accounts[msg.sender].balance += msg.value;
        emit Deposit(msg.sender, msg.value, block.timestamp);
        addTransaction(int256(msg.value));
    }

    function transfer(address to, uint256 amount) external {
        require(accounts[msg.sender].balance >= amount, "Insufficient balance");
        accounts[msg.sender].balance -= amount;
        accounts[to].balance += amount;
        emit Transfer(msg.sender, to, amount, block.timestamp);
        addTransaction(-int256(amount));
    }

    function getTransactionDetails(uint256 transactionId) external view returns (int256, uint256) {
        require(transactionId < nextTransactionId, "Invalid transaction ID");
        Transaction memory transaction = accounts[msg.sender].transactions[transactionId];
        return (transaction.amount, transaction.timestamp);
    }

    function addTransaction(int256 amount) internal {
        Transaction memory newTransaction = Transaction(amount, block.timestamp);
        accounts[msg.sender].transactions.push(newTransaction);
        nextTransactionId++;
    }
}
