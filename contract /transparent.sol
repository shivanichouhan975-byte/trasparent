# TaskChain - Decentralized Task Reward System

## Project Structure
```
TaskChain/
├── Project.sol
└── README.md
```

---

## Project.sol

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TaskChain {
    struct Task {
        uint256 id;
        address creator;
        string description;
        uint256 reward;
        address completer;
        bool isCompleted;
        bool isClaimed;
    }

    uint256 public taskCounter;
    mapping(uint256 => Task) public tasks;
    mapping(address => uint256) public userBalance;

    event TaskCreated(uint256 indexed taskId, address indexed creator, string description, uint256 reward);
    event TaskCompleted(uint256 indexed taskId, address indexed completer);
    event RewardClaimed(uint256 indexed taskId, address indexed completer, uint256 reward);

    modifier taskExists(uint256 _taskId) {
        require(_taskId > 0 && _taskId <= taskCounter, "Task does not exist");
        _;
    }

    modifier onlyCreator(uint256 _taskId) {
        require(tasks[_taskId].creator == msg.sender, "Only task creator can perform this action");
        _;
    }

    // Core Function 1: Create a new task with reward
    function createTask(string memory _description) public payable {
        require(msg.value > 0, "Reward must be greater than 0");
        require(bytes(_description).length > 0, "Description cannot be empty");

        taskCounter++;
        tasks[taskCounter] = Task({
            id: taskCounter,
            creator: msg.sender,
            description: _description,
            reward: msg.value,
            completer: address(0),
            isCompleted: false,
            isClaimed: false
        });

        emit TaskCreated(taskCounter, msg.sender, _description, msg.value);
    }

    // Core Function 2: Mark task as completed by task creator
    function completeTask(uint256 _taskId, address _completer) public taskExists(_taskId) onlyCreator(_taskId) {
        Task storage task = tasks[_taskId];
        require(!task.isCompleted, "Task already completed");
        require(_completer != address(0), "Invalid completer address");
        require(_completer != task.creator, "Creator cannot complete their own task");

        task.isCompleted = true;
        task.completer = _completer;
        userBalance[_completer] += task.reward;

        emit TaskCompleted(_taskId, _completer);
    }

    // Core Function 3: Claim reward for completed task
    function claimReward() public {
        uint256 balance = userBalance[msg.sender];
        require(balance > 0, "No rewards to claim");

        userBalance[msg.sender] = 0;
        (bool success, ) = payable(msg.sender).call{value: balance}("");
        require(success, "Transfer failed");

        emit RewardClaimed(0, msg.sender, balance);
    }

    // View function to get task details
    function getTask(uint256 _taskId) public view taskExists(_taskId) returns (Task memory) {
        return tasks[_taskId];
    }

    // View function to check user's claimable balance
    function getBalance(address _user) public view returns (uint256) {
        return userBalance[_user];
    }
}
```

---

## README.md

# TaskChain - Decentralized Task Reward System

## Project Description

TaskChain is a blockchain-based decentralized task management and reward distribution platform built on Ethereum. It enables users to create tasks with cryptocurrency rewards, have others complete them, and automatically distribute rewards through smart contracts. The platform eliminates intermediaries and ensures transparent, trustless task completion and payment.

## Project Vision

Our vision is to create a global, decentralized gig economy where anyone can post tasks and anyone can earn rewards by completing them. By leveraging blockchain technology, TaskChain ensures:
- **Transparency**: All tasks and rewards are visible on-chain
- **Trust**: Smart contracts guarantee payment upon task completion
- **Global Access**: Anyone with an Ethereum wallet can participate
- **No Middlemen**: Direct peer-to-peer task economy without platform fees

## Key Features

1. **Create Tasks with Rewards**: Users can create tasks by depositing ETH as a reward, ensuring funds are locked in the smart contract until completion.

2. **Task Completion Verification**: Task creators verify and mark tasks as completed, automatically crediting the reward to the completer's balance.

3. **Secure Reward Claims**: Completers can claim their accumulated rewards at any time through a secure withdrawal mechanism.

4. **Transparent Tracking**: All tasks, completions, and rewards are recorded on the blockchain with event logs for complete transparency.

5. **Balance Management**: Users can track their earned rewards and claim them when convenient.

## Future Scope

1. **Reputation System**: Implement a reputation score for both task creators and completers to build trust in the ecosystem.

2. **Dispute Resolution**: Add a decentralized arbitration mechanism for disputed task completions using a DAO voting system.

3. **Task Categories & Search**: Organize tasks into categories and implement search/filter functionality for easier discovery.

4. **Multi-Token Support**: Enable rewards in various ERC-20 tokens beyond ETH for more flexibility.

5. **Escrow & Milestones**: Add support for milestone-based payments for larger, complex tasks.

6. **NFT Certificates**: Issue NFT certificates for completed tasks as proof of work and skill verification.

7. **Mobile DApp**: Develop a mobile application for iOS and Android to access TaskChain on the go.

8. **Task Templates**: Create standardized templates for common task types to streamline task creation.

9. **Automated Completion**: Integrate with oracles for tasks that can be verified automatically (e.g., code submissions, API tasks).

10. **Social Features**: Add profiles, reviews, and a rating system to build a community-driven platform.

---

## How to Deploy

1. Install dependencies (Hardhat, Truffle, or Remix)
2. Compile the contract: `solc Project.sol`
3. Deploy to your preferred network (localhost, testnet, or mainnet)
4. Interact with the contract through Web3.js or Ethers.js

## License

MIT License - Feel free to use and modify for your projects!
