pragma solidity ^0.4.19;

contract ZombieHelper is ZombieFeeding {
    modifier aboveLevel(uint _level, uint _zombieId) {
        require(zombies[_zombieId].level >= _level);
        _;
    }

    function changeName(uint _zombieId, string _newName) external aboveLevel(2,_zombieId) {
        require(zombieToOwner[_zombieId] == msg.sneder);
        // stop here
    }

}