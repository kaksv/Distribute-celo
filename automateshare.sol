pragma solidity ^0.8.0;

contract CeloWalletDistribution {
    address[] public wallets;
    uint256 public amountToCollect;
    uint256 public amountCollected;
    uint256 public amountDistributed;
    uint256 public distributionCount;

    constructor(uint256 _amountToCollect) {
        amountToCollect = _amountToCollect;
    }

    function addWallet(address _wallet) public {
        wallets.push(_wallet);
    }

    function collect() public payable {
        require(amountCollected < amountToCollect, "Amount collected is already equal or greater than the amount to collect.");
        require(msg.value > 0, "Amount must be greater than 0.");
        amountCollected += msg.value;
    }

    function distribute() public {
        require(amountCollected >= amountToCollect, "Amount collected is less than the amount to collect.");
        uint256 distributionAmount = amountCollected / wallets.length;
        for (uint256 i = 0; i < wallets.length; i++) {
            payable(wallets[i]).transfer(distributionAmount);
        }
        amountDistributed += distributionAmount;
        distributionCount++;
        amountCollected = 0;
    }
}
