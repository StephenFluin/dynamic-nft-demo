pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "@chainlink/contracts/src/v0.8/interfaces/KeeperCompatibleInterface.sol";

contract TradingCard is ERC721, Ownable, KeeperCompatibleInterface {
    uint256 private _tokenIds;
    mapping(uint256 => string) private _tokenURIs;
    mapping(uint256 => uint64) private _counters;
    uint interval = 30 seconds;
    uint lastTimeStamp;

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
        return string(abi.encodePacked(_tokenURIs[tokenId],Strings.toString(_counters[1]),".json"));
    }
    
    function checkUpkeep(bytes calldata checkData) external returns (bool upkeepNeeded, bytes memory performData) {
        upkeepNeeded = (block.timestamp - lastTimeStamp) > interval && _counters[1] < 4;
        performData = checkData;
    }
    function performUpkeep(bytes calldata performData) external {
        _counters[1] += 1;
        lastTimeStamp = block.timestamp;
    }
}
