// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Upgrades, Options} from "openzeppelin-foundry-upgrades/Upgrades.sol";
import {CounterV2} from "../src/CounterV2.sol";

contract CounterScriptV2 is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address proxyAddress = vm.envAddress("PROXY_ADDRESS");
        address deployerAddress = vm.addr(deployerPrivateKey);

        console.log("Deployer address:", deployerAddress);

        vm.startBroadcast(deployerPrivateKey);

        Options memory opts;

        opts.unsafeSkipAllChecks = true;
        opts.referenceContract = "Counter.sol";

        // 这里我使用UUPS的模式进行升级
        Upgrades.upgradeProxy(proxyAddress, "CounterV2.sol", "", opts, deployerAddress);

        vm.stopBroadcast();
    }
}
