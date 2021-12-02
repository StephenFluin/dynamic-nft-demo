pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TradingCard is ERC721, Ownable {
    uint256 private _tokenIds;
    mapping(uint256 => string) private _tokenURIs;


    constructor() ERC721("Stephen Fluin Trading Card", "SFTC") {}

    function mintItem(address to, string memory URI)
        public onlyOwner returns (uint256)
    {
        _tokenIds += 1;
        uint256 id = _tokenIds;
        
        _mint(to, id);
        _tokenURIs[id] = URI;

        return id;
    }

    function tokenURI(uint256 tokenId)
        public view virtual override returns (string memory)
    {
        require(_exists(tokenId),"ERC721Metadata: URI query for nonexistent token");
        return _tokenURIs[tokenId];
    }

}
