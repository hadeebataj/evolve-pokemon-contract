// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import "@thirdweb-dev/contracts/base/ERC1155LazyMint.sol";

contract PokemonEvolveContract is ERC1155LazyMint {
    constructor(
        address _defaultAdmin,
        string memory _name,
        string memory _symbol
    ) ERC1155LazyMint(_defaultAdmin, _name, _symbol, msg.sender, 0) {}

    function verifyClaim(
        address _claimer,
        uint256 _tokenId,
        uint256 _quantity
    ) public view override {
        require(
            _tokenId == 0 || _tokenId == 2,
            "Only Charmander and Bulbasaur are claimable"
        );
        require(_quantity == 1, "Only 1 Pokemon can be claimed!");
    }

    function evolve(uint256 _tokenId) public {
        // _burn(msg.sender, 0, 2);
        // _mint(msg.sender, 1, 1, "");

        require(_tokenId < 1, "Invalid token ID");
        _burn(msg.sender, _tokenId, 2); // 2 Charmanders => 1 Charmeleon

        // Charmander evolves to Charmeleon and Bulbasaur evolves to Ivysaur
        uint256 nextTokenId = _tokenId + 1;
        _mint(msg.sender, nextTokenId, 1, "");
    }
}
