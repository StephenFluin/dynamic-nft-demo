# Setup
* Rinkeby
* Clear Remix
* my-nft.sol
* Deploy 0x3E77Fd1B4d4176CA9d54dB60f132FbB88BFA43CA,https://fluin.io/assets/speakers/0.json
* https://testnets.opensea.io/get-listed/step-two

# Dynamic
* Kovan
* `mapping(uint256 => uint64) private _counters;`
* `return string(abi.encodePacked(_tokenURIs[tokenId],Strings.toString(_counters[1]),".json"));`
* Deploy 0x3E77Fd1B4d4176CA9d54dB60f132FbB88BFA43CA,https://fluin.io/assets/speakers/


# Keeper
* `uint interval = 30 seconds;`
* `uint lastTimeStamp;`
* `import "@chainlink/contracts/src/v0.8/interfaces/KeeperCompatibleInterface.sol";`
* is `KeeperCompatibleInterface`
```solidity
function checkUpkeep(bytes calldata checkData) external view override returns (bool upkeepNeeded, bytes memory performData) {
    uint256 tokenId = 1;
    upkeepNeeded = (block.timestamp - lastTimeStamp) > interval && _counters[tokenId] < 4;
    performData = checkData;
}
```

```solidity
function performUpkeep(bytes calldata performData) external override {
    uint256 tokenId = 1;
    _counters[tokenId] += 1;
    lastTimeStamp = block.timestamp;
}
```
* Deploy 0x3E77Fd1B4d4176CA9d54dB60f132FbB88BFA43CA,https://fluin.io/assets/speakers/
* MINT
* Register Keeper