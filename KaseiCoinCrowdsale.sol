pragma solidity ^0.5.0;

import "./KaseiCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";


// Have the KaseiCoinCrowdsale contract inherit the following OpenZeppelin:
// * Crowdsale
// * MintedCrowdsale
contract KaseiCoinCrowdsale is Crowdsale, MintedCrowdsale { // UPDATE THE CONTRACT SIGNATURE TO ADD INHERITANCE
    
    // Provide parameters for all of the features of your crowdsale, such as the `rate`, `wallet` for fundraising, and `token`.
    constructor(
        uint256 rate,
        address payable wallet,
        kasie_token token
    ) public Crowdsale(rate, wallet, token) {
        // constructor can stay empty
    }
}


contract KaseiCoinCrowdsaleDeployer {
    // Create an `address public` variable called `kasei_token_address`.
    address public kasie_token_address;
    // Create an `address public` variable called `kasei_crowdsale_address`.
    address public kasie_crowdsale_address;

    // Add the constructor.
    constructor(
        string memory name,
        string memory symbol,
        address payable wallet
    )public {
        // Create a new instance of the KaseiCoin contract.
        // Assign the token contract’s address to the `kasei_token_address` variable.
        kasie_token token = new kasie_token(name, symbol, 0);
        kasie_token_address = address(token);


        // Create a new instance of the `KaseiCoinCrowdsale` contract
        // Aassign the `KaseiCoinCrowdsale` contract’s address to the `kasei_crowdsale_address` variable.
        KaseiCoinCrowdsale kasie_crowdsale =
            new KaseiCoinCrowdsale(1, wallet, token);
        kasie_crowdsale_address = address(kasie_crowdsale);

        // Set the `KaseiCoinCrowdsale` contract as a minter
        // Have the `KaseiCoinCrowdsaleDeployer` renounce its minter role.

        token.addMinter(kasie_crowdsale_address);
        token.renounceMinter();
        
    }
}
