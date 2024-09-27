pragma solidity ^0.4.19;

contract ZombieFactory{
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie{
        string name;
        uint   dna;
    }

    Zombie[] public zombies;

    event NewZombie(uint zombieId, string name, uint dna);

    function _createZombie(string _name, uint _dna) private {
        uint _zombieId = zombies.push(Zombie(_name, _dna));
        emit NewZombie(_zombieId, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        return uint(keccak256(_str)) % dnaModulus;
    }

    function createRandomZombie(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}