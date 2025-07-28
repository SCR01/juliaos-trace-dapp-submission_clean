// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TraceContract {
    struct Transaction {
        address from;
        address to;
        uint256 amount;
        uint256 timestamp;
        string chainId;
        string txHash;
    }

    mapping(string => Transaction) public transactions;
    string[] public transactionHashes;

    event TransactionRecorded(string indexed txHash, address from, address to, uint256 amount);

    function recordTransaction(
        address _from,
        address _to,
        uint256 _amount,
        string memory _chainId,
        string memory _txHash
    ) public {
        require(bytes(_txHash).length > 0, "Transaction hash cannot be empty");
        require(transactions[_txHash].from == address(0), "Transaction already recorded");

        transactions[_txHash] = Transaction({
            from: _from,
            to: _to,
            amount: _amount,
            timestamp: block.timestamp,
            chainId: _chainId,
            txHash: _txHash
        });
        transactionHashes.push(_txHash);

        emit TransactionRecorded(_txHash, _from, _to, _amount);
    }

    function getTransaction(string memory _txHash)
        public
        view
        returns (
            address,
            address,
            uint256,
            uint256,
            string memory,
            string memory
        )
    {
        Transaction storage tx = transactions[_txHash];
        return (
            tx.from,
            tx.to,
            tx.amount,
            tx.timestamp,
            tx.chainId,
            tx.txHash
        );
    }

    function getTotalTransactions() public view returns (uint256) {
        return transactionHashes.length;
    }
}


