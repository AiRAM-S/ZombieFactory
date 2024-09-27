pragma solidity ^0.4.19;

import "./ownable.sol";

contract ZombieFactory is Ownable{
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie{
        uint   dna;
        uint32 level;   // 1 default
        uint32 readyTime;
        string name;
    }

    Zombie[] public zombies;

    uint cooldownTime = 60; // seconds

    event NewZombie(uint zombieId, string name, uint dna);

    function _createZombie(string _name, uint _dna) internal {
        uint _zombieId = zombies.push(Zombie(_dna,1, uint32(now), _name)) - 1; // corrected in lab3, index as id
        zombieToOwner[_zombieId] = msg.sender;
        ownerZombieCount[msg.sender]++;
        NewZombie(_zombieId, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        return uint(keccak256(_str)) % dnaModulus;
    }

    function createRandomZombie(string _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

    mapping(uint => address) public zombieToOwner;
    mapping(address => uint) public ownerZombieCount;

}