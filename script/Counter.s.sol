// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {Counter} from "../src/Counter.sol";

contract CounterScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        // 部署一个新的AdderUpgradeable合约
        Counter implementation = new Counter();

        // 获取初始化函数的选择器
        bytes memory initializeData = abi.encodeWithSelector(Counter.initialize.selector);

        // 部署一个新的ERC1967Proxy，指向AdderUpgradeable合约 并初始化AdderUpgradeable的initialize函数
        ERC1967Proxy proxy = new ERC1967Proxy(address(implementation), initializeData);

        // 打印代理合约的地址
        console.log("Counter Proxy deployed at:", address(proxy));
        // 打印实现合约的地址
        console.log("Implementation deployed at:", address(implementation)); // 0xA70cfb2eeD700B419751079484568a73c125108B

        vm.stopBroadcast();
    }
}
