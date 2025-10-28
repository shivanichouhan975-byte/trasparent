// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Project {
    struct Task {
        uint256 id;
        string description;
        uint256 reward;
        address creator;
        address assignee;
        bool isCompleted;
        bool isPaid;
    }

    uint256 public taskCounter;
    mapping(uint256 => Task) public tasks;
    mapping(address => uint256) public userBalances;

    event TaskCreated(uint256 indexed taskId, string description, uint256 reward, address indexed creator);
    event TaskAssigned(uint256 indexed taskId, address indexed assignee);
    event TaskCompleted(uint256 indexed taskId, address indexed assignee, uint256 reward);

    // Create a new task with reward
    function createTask(string memory _description, uint256 _reward) public payable {
        require(msg.value == _reward, "Sent value must match reward amount");
        require(_reward > 0, "Reward must be greater than 0");

        taskCounter++;
        tasks[taskCounter] = Task({
            id: taskCounter,
            description: _description,
            reward: _reward,
            creator: msg.sender,
            assignee: address(0),
            isCompleted: false,
            isPaid: false
        });

        emit TaskCreated(taskCounter, _description, _reward, msg.sender);
    }

    // Assign task to a worker
    function assignTask(uint256 _taskId, address _assignee) public {
        Task storage task = tasks[_taskId];
        require(task.id != 0, "Task does not exist");
        require(msg.sender == task.creator, "Only creator can assign task");
        require(task.assignee == address(0), "Task already assigned");
        require(!task.isCompleted, "Task already completed");

        task.assignee = _assignee;
        emit TaskAssigned(_taskId, _assignee);
    }

    // Complete task and claim reward
    function completeTask(uint256 _taskId) public {
        Task storage task = tasks[_taskId];
        require(task.id != 0, "Task does not exist");
        require(msg.sender == task.assignee, "Only assignee can complete task");
        require(!task.isCompleted, "Task already completed");
        require(!task.isPaid, "Reward already paid");

        task.isCompleted = true;
        task.isPaid = true;

        userBalances[msg.sender] += task.reward;
        payable(msg.sender).transfer(task.reward);

        emit TaskCompleted(_taskId, msg.sender, task.reward);
    }

    // Get task details
    function getTask(uint256 _taskId) public view returns (
        uint256 id,
        string memory description,
        uint256 reward,
        address creator,
        address assignee,
        bool isCompleted,
        bool isPaid
    ) {
        Task memory task = tasks[_taskId];
        return (
            task.id,
            task.description,
            task.reward,
            task.creator,
            task.assignee,
            task.isCompleted,
            task.isPaid
        );
    }
}
