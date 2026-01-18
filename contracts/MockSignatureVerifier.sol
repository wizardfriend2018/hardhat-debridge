//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.7;

import "@debridge-
    function submit(
        bytes32 /*_submissionId*/,
        bytes memory /*_signatures*/,
      
}[ ] enableAutoHarvest
[ ]
[ ] enableMultiProtocol
[ 
[ ] routeToAave
[ ] routeToYearn
[ ] skimProfits
[ ] // SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IAavePool {
    function supply(address asset, uint256 amount, address onBehalfOf, uint16 referralCode) external;
    function withdraw(address asset, uint256 amount, address to) external returns (uint256);
}

contract SafeYieldStrategy {
    address public owner;
    address public immutable USDC;
    IAavePool public immutable aavePool;

    uint256 public maxTargetAPY = 12e16; // 12% in 18 decimals

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor(address _usdc, address _aavePool) {
        owner = msg.sender;
        USDC = _usdc;
        aavePool = IAavePool(_aavePool);
    }

    function deposit(uint256 amount) external onlyOwner {
        IERC20(USDC).approve(address(aavePool), amount);
        aavePool.supply(USDC, amount, address(this), 0);
    }

    function withdraw(uint256 amount) external onlyOwner {
        aavePool.withdraw(USDC, amount, owner);
    }

    function emergencyWithdrawAll() external onlyOwner {
        aavePool.withdraw(USDC, type(uint256).max, owner);
    }
}

MetaMask EIP-7702 Delegator
        ↓
Strategy Contract
        ↓
Aave / Yearn / Holds USDC
   ↓
Delegates execution (EIP-7702)
   ↓
Deposits into Aave lending pool
   ↓
Earns real interest paid by borrowers

(MetaMask Smart Account (EIP-7702 Delegator)
        │
        ▼
Strategy Controller Contract
(Buttons + Permissions)
        │
        ├── Aave Module (Lending)
        ├── Yearn Module (Vaults)
        ├── Harvest Module (Rewards)
        ├── Profit Skimmer
        └── Automation Guard


If Aave APY < Yearn APY by X%
→ Route funds to Yearn
Else
→ Stay on Aave.  These are:
	•	Functions inside the smart contract
	•	Example: enableAutoHarvest(), disableRouting()
	•	They exist on Ethereum, not on your phone UI

([ ] enableAutoHarvest
[ ] disableAutoHarvest
[ ] enableMultiProtocol
[ ] 



✅ Routing On / Off

What it does
	•	Allows the contract to decide where funds 


✓ 



✓ Auto-harvest ON
✓ Routing ON
✓ Weekly automation
✓ Emergency exit always available



🔵 Advanced Mode (Only if comfortable)
✓ Auto-harvest ON
✓ Routing ON
✓ Weekly automation
✓ Emergency exit always available



Buttons + Permissions)
        │
        ├── Aave Module (Lending)
        ├── Yearn Module (Vaults)
        ├── Harvest Module (Rewards)
        ├── Profit Skimmer
        └── Automation Guard















