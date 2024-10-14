// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FoodNFT is ERC721, Ownable {
    // Contador para los IDs de token
    uint256 private _nextTokenId;

    // Estructura para almacenar detalles del NFT
    struct NFTDetails {
        string description;  // Descripción o URL de la imagen del NFT
        uint256 discount;    // Porcentaje de descuento asociado
    }

    // Mapeo de tokenId a detalles del NFT
    mapping(uint256 => NFTDetails) private _nftDetails;

    constructor(address initialOwner)
        ERC721("FoodNFT", "FNT")
        Ownable(initialOwner){
            _nextTokenId = 0;
        } // Inicializar el contador de token ID}

    /**
     * @dev Acuña un nuevo NFT como recompensa.
     * @param to La dirección que recibe el nuevo token.
     * @param description Descripción o URL para el NFT.
     * @param discount Porcentaje de descuento asociado con este NFT.
     */
    function safeMint(address to, string memory description, uint256 discount) public onlyOwner {
        require(to != address(0), "Cannot mint to zero address");
        require(discount <= 100, "Discount must be between 0 and 100");

        uint256 tokenId = _nextTokenId;
        _nextTokenId++; // Incrementar el contador de token ID

        _safeMint(to, tokenId);

        // Almacenar los detalles del NFT
        _nftDetails[tokenId] = NFTDetails({
            description: description,
            discount: discount
        });
    }

}
