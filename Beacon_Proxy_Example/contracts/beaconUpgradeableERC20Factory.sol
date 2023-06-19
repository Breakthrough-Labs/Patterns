// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import "@openzeppelin/contracts/proxy/beacon/BeaconProxy.sol";
import "./beacon.sol";
import "./beaconUpgradeableERC20.sol";

// This contract will allow the owner to decide wheather to allow the Factory instances to be upgraded by passing a boolen value.

contract ERC20Factory {
    mapping(uint32 => address) private tokenImplementations;
    ERC20Beacon immutable beacon;
    address immutable ERC20implementation;

    constructor(address _initImplementation) {
        beacon = new ERC20Beacon(_initImplementation);
        ERC20implementation = _initImplementation;
    }

    function buildTokenInstance(
        string memory _name,
        string memory _symbol,
        uint256 _totalSupply,
        uint32 implId,
        bool upgradeable // if true, the ship will be upgradeable
    ) public {
        if (upgradeable) {
            createUpgradeableTokenInstance(
                _name,
                _symbol,
                _totalSupply,
                implId
            );
        } else {
            createNonUpgradeableShip(_name, _symbol, _totalSupply, implId);
        }
    }

    function getTokenInstanceAddress(
        uint32 implId
    ) external view returns (address) {
        return tokenImplementations[implId];
    }

    function getBeacon() public view returns (address) {
        return address(beacon);
    }

    function getImplementation() public view returns (address) {
        return beacon.implementation();
    }

    function createUpgradeableTokenInstance(
        string memory _name,
        string memory _symbol,
        uint256 _totalSupply,
        uint32 implId
    ) public {
        BeaconProxy tokenContract = new BeaconProxy(
            address(beacon),
            abi.encodeWithSelector(
                FixedToken(address(0)).initialize.selector,
                _name,
                _symbol,
                _totalSupply
            )
        );
        tokenImplementations[implId] = address(tokenContract);
    }

    function createNonUpgradeableTokenInstance(
        string memory _name,
        string memory _symbol,
        uint256 _totalSupply,
        uint32 implId
    ) public {
        FixedToken token = new FixedToken();
        token.initialize(_name, _symbol, _totalSupply);
        tokenImplementations[implId] = address(token);
    }
}
