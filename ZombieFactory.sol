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
        Zombie newzombie = Zombie(_name, _dna);
        uint _zombieId = zombies.push(newzombie);
        NewZombie(_zombieId, _name, _dna)
    }

}