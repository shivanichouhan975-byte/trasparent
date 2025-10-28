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

## Smart Contract Functions

### Core Functions

- **createTask(string _description)**: Create a new task with ETH reward (payable)
- **completeTask(uint256 _taskId, address _completer)**: Mark a task as completed and credit reward
- **claimReward()**: Withdraw accumulated rewards

### View Functions

- **getTask(uint256 _taskId)**: Retrieve task details
- **getBalance(address _user)**: Check claimable reward balance

---

## How to Deploy

1. Install dependencies (Hardhat/Truffle/Remix)
2. Compile the contract: `solc Project.sol --bin --abi`
3. Deploy to your preferred network (localhost, testnet, or mainnet)
4. Interact with the contract through Web3.js or Ethers.js

### Example Deployment with Hardhat

```bash
npm install --save-dev hardhat
npx hardhat init
# Place Project.sol in contracts/
npx hardhat compile
npx hardhat run scripts/deploy.js --network localhost
```

---

## Usage Example

```javascript
// Create a task with 0.1 ETH reward
await taskChain.createTask("Build a landing page", { value: ethers.utils.parseEther("0.1") });

// Complete task (by task creator)
await taskChain.completeTask(1, completerAddress);

// Claim reward (by completer)
await taskChain.claimReward();
```

---

## Security Features

- Funds locked in smart contract until task completion
- Only task creators can mark tasks as complete
- Re-entrancy protection on reward claims
- Validation checks on all critical functions
- Event logging for audit trail

---

## License

MIT License - Feel free to use and modify for your projects!

---

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Contact

For questions or suggestions, please open an issue in the repository.
contract address :0xd9145CCE52D386f254917e481eB44e9943F39138

<img width="1531" height="751" alt="image" src="https://github.com/user-attachments/assets/ad2b337c-e9a7-4a00-be2e-83da8036e66f" />



<img width="1531" height="751" alt="image" src="https://github.com/user-attachments/assets/8ddaed85-dbed-43bc-b635-0c78b2c31f52" />
