// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.18;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

/**
 * @title Simple Token
 * @author Breakthrough Labs Inc.
 * @notice Token, ERC20, Fixed Supply
 * @custom:version 1.0.7
 * @custom:address 4
 * @custom:default-precision 18
 * @custom:simple-description Simple Token. A fixed supply is minted on deployment, and
 * new tokens can never be created.
 * @dev ERC20 token with the following features:
 *
 *  - Premint your total supply.
 *  - No minting function. This allows users to comfortably know the future supply of the token.
 *
 */

contract FixedToken is ERC20Upgradeable {
    /**
     * @param _name Token Name
     * @param _symbol Token Symbol
     * @param _totalSupply Token Supply
     */
    function initialize(
        string memory _name,
        string memory _symbol,
        uint256 _totalSupply
    ) public initializer {
        __ERC20_init(_name, _symbol);
        _mint(msg.sender, _totalSupply);
    }
}
