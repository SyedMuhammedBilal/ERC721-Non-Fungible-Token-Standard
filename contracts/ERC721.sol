// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "./introspection/ERC165.sol";
import "./IERC721.sol";

contract ERC721 is ERC165, IERC721 {
    
    mapping(uint256 => address) private _tokenOwner;
    mapping(uint256 => address) private _tokenApprovals;

    function ownerOf(uint256 _tokenId) public override view returns (address) {
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0));
        return owner;
    }

    function getApproved(uint256 _tokenId) public override view returns (address) {
        return _tokenApprovals[_tokenId];
    }
}