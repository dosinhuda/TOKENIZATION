pragma solidity 0.6.1;

import "https://github.com/dosinhuda/TOKENIZATION/blob/e9c90433f34d1bec66b38d016d038ee1f32b4850/Crowdsale.sol";
import "https://github.com/dosinhuda/TOKENIZATION/blob/6bee6cbc6fc390305e270a14533fb196f0b2df22/KycContract.sol";

contract MyTokenSale is Crowdsale {
    KycContract kyc;

    constructor(
        uint256 rate,    // rate in TKNbits
        address payable wallet,
        IERC20 token,
        KycContract _kyc
    )
        Crowdsale(rate, wallet, token)
        public
    {
        kyc = _kyc;

    }



    function _preValidatePurchase(address beneficiary, uint256 weiAmount) internal view override {
        super._preValidatePurchase(beneficiary, weiAmount);
        require(kyc.kycCompleted(msg.sender), "KYC Not completed, purchase not allowed");
    }
}
