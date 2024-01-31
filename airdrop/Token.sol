// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DropToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("DropToken", "DTK") {
        _mint(msg.sender, initialSupply * 10 ** 18);
    }
}

// initial supply of erctokens = 100 * 1e18;
// token contract address = 0xd9145CCE52D386f254917e481eB44e9943F39138
