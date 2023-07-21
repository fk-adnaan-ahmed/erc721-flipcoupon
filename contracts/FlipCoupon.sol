// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@thirdweb-dev/contracts/base/ERC721Base.sol";

contract FlipCoupon is ERC721Base {

    mapping(uint => string) internal couponMapping;

    constructor(address _royaltyRecipient, uint128 _royaltyBps) ERC721Base("FlipCoupon2", "FKCPN2", _royaltyRecipient, _royaltyBps){}

    function setCouponCode(uint tokenId, string memory coupon) public {
        require(msg.sender == owner(), 'coupon code can only be set by owner');
        couponMapping[tokenId] = coupon;
    }

    function getCouponCode(uint tokenId) public view returns(string memory){
        require(bytes(couponMapping[tokenId]).length > 0 , "no coupon created for this token");
        return couponMapping[tokenId];
    }

    function burn(uint256 tokenId) external override {
        bool approvalCheck = msg.sender != owner();
        _burn(tokenId, approvalCheck);
    }
}