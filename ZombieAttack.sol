// SPDX-License-Identifier: MIT
pragma solidity  ^0.4.19;

import "./ZombieHelper.sol";

contract ZombieAttack is ZombieHelper {
    uint randNounce = 0;

    function doAttack(uint attackerId, uint defenderId) {
        require(zombieToOwner[attackerId] == msg.sender); // make sure zombie controlled by the lord
        // 我们允许心理变态选取自己的两只僵尸进行攻击
        uint random = uint(keccak256(now, msg.sender, randNounce)) % 100;
        randNounce++;
        if(random < 70) {
            // attacker win
            zombies[attackerId].winCount++;
            zombies[attackerId].level++;
            feedAndMultiply(attackerId, zombies[defenderId].dna);
            zombies[defenderId].lossCount++;
        }
        else{
            zombies[attackerId].lossCount++;
            zombies[defenderId].winCount++;
            _refreshZombie(attackerId);
        }
    }
}