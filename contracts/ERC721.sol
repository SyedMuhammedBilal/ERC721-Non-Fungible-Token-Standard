// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "./introspection/ERC165.sol";
import "./IERC721.sol";

contract ERC721 is IERC721 {
    
    mapping(uint256 => address) private _tokenOwner;
    mapping(uint256 => address) private _tokenApprovals;
    mapping(address => uint256) private _ownedTokenCount;
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    bytes4 private constant _INTERFACE_ID_ERC721 = 0x80ac58cd;
    bytes4 private constant _ERC721_RECEIVED = 0x150b7a02;

    function getApproved(uint256 _tokenId) public override view returns (address) {
        return _tokenApprovals[_tokenId];
    }

    function setApprovalForAll(address _to, bool _approved) public override {
        require(_to != msg.sender);
        _operatorApprovals[msg.sender][_to] = _approved;
        emit ApprovalForAll(msg.sender, _to, _approved);
    }

    function isApprovedForAll(address _owner, address _operator) public view returns (bool) {
        return _operatorApprovals[_owner][_operator];
    } 

    function balanceOf(address _owner) public view override returns (uint256) {
        require(_owner != address(0));
        return _ownedTokenCount[_owner];
    }

    function ownerOf(uint256 _tokenId) public view override returns (address) {
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0));
        return owner;
    }

    function approve(address _to, uint256 _tokenId) public override {
        address owner = ownerOf(_tokenId);
        require(_to != owner);
        require(msg.sender == owner || isApprovedForAll(owner, msg.sender));
        _tokenApprovals[_tokenId] = _to;
        emit Approval(owner, _to, _tokenId);
    }

    function safeTransfer(address _to, uint256 _tokenId) public {
        _tokenOwner[_tokenId] = _to;
    }

    function exists(uint256 _tokenId) internal view returns (address) {
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0));
    }
}