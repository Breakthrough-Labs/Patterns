// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "@openzeppelin/contracts/proxy/beacon/UpgradeableBeacon.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC20Beacon is Ownable {
    UpgradeableBeacon immutable beacon;

    address public ERC20implementation;

    constructor(address _initImplementation) {
        beacon = new UpgradeableBeacon(_initImplementation);
        ERC20implementation = _initImplementation;
        transferOwnership(tx.origin);
    }

    function update(address _newImplementation) public onlyOwner {
        beacon.upgradeTo(_newImplementation);
        ERC20implementation = _newImplementation;
    }

    function implementation() public view returns (address) {
        return beacon.implementation();
    }
}
