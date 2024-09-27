pragma solidity ^0.4.19;

import "./ZombieFeeding.sol";

contract ZombieHelper is ZombieFeeding {
    modifier aboveLevel(uint _level, uint _zombieId) {
        require(zombies[_zombieId].level >= _level);
        _;
    }

    uint levelUpFee = 0.001 ether;

    function changeName(uint _zombieId, string _newName) external aboveLevel(2,_zombieId) {
        require(zombieToOwner[_zombieId] == msg.sender);
        zombies[_zombieId].name = _newName;
    }

    function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
        require(zombieToOwner[_zombieId] == msg.sender);
        zombies[_zombieId].dna = _newDna;
    }

    function getZombiesByOwner(address _owner) external view returns(uint[]) {
        uint [] memory result = new uint[](ownerZombieCount[_owner]);
        uint index = 0;
        for(uint i = 0; i < zombies.length; i++){
            if(zombieToOwner[i] == _owner){
                result[index] = i;
                index++;
            }
        }
        return result;
    }

    function levelUp(uint _zombieId) external payable {
        require(msg.value == levelUpFee);
        zombies[_zombieId].level++;
    }

    function withdraw() external onlyOwner {
        owner.transfer(this.balance);
    }

    function setLevelUpFee(uint _fee) external onlyOwner {
        levelUpFee = _fee;
    }

}