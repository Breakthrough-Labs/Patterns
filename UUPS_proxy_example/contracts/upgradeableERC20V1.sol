// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.12;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

/**
 * @title Simple Upgradeable ERC20 Token
 * @author Breakthrough Labs Inc.
 * @notice Token, ERC20, Fixed Supply
 * @custom:version 1.0.7
 * @custom:address 4
 * @custom:default-precision 18
 * @custom:simple-description Simple upgradeable Token. A fixed supply is minted on deployment, and
 * new tokens can never be created.
 * @dev ERC20 token with the following features:
 *
 *  - Premint your total supply.
 *  - No minting function. This allows users to comfortably know the future supply of the token.
 *
 */

contract FixedToken is ERC20Upgradeable, UUPSUpgradeable, OwnableUpgradeable {
    function initialize(
        string memory name_,
        string memory symbol_,
        uint256 _totalSupply,
        address _to
    ) public initializer onlyProxy {
        __ERC20_init(name_, symbol_);
        __Ownable_init();

        _mint(_to, _totalSupply);
    }

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}
}
