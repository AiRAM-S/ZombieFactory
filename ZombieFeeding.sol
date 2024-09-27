pragma solidity ^0.4.19;

import "./ZombieFactory.sol";

contract ZombieFeeding is ZombieFactory {
    function feedAndMultiply (uint _zombieId, uint _targetDna) internal  {
        require(zombieToOwner[_zombieId] == msg.sender);

        Zombie storage myZombie = zombies[_zombieId];

        require(myZombie.readyTime <= uint32(now));

        uint _targetSlice = _targetDna % dnaModulus;
        uint _newDna = (myZombie.dna + _targetSlice) / 2;
        uint _newZDna = (_newDna - _newDna % 100) + 99;
        _createZombie("No-one", _newZDna);
        myZombie.readyTime = uint32(now+cooldownTime);
    }

    function _catchAHuman(uint _name) internal pure returns (uint) {
        uint rand = uint(keccak256(_name));
        return rand;
    }

    function feedOnHuman(uint _zombieId, uint _humanId) public {
        uint _humanDna = _catchAHuman(_humanId);
        feedAndMultiply(_zombieId, _humanDna);
    }

}