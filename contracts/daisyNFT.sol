pragma solidity 0.8.4;

import '@openzeppelin/contracts/utils/Counters.sol';
import '@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol';

import { Base64 } from './libraries/Base64.sol';

contract daisyNFT is ERC721URIStorage {
  using Counters for Counters.Counter;
  Counters.Counter private _tokenId;

  string public collectionName;
  string public collectionSymbol;

  constructor() ERC721("daisyNFT", "daisyNFT") {
    collectionName = name();
    collectionSymbol = symbol();
  }

  function createDaisyNFT() public returns(uint256) {
    uint256 newItemId = _tokenId.current();
    // daisy with token # inside - daisy # changes each time
    string memory baseSvg = "<svg version='1.1' id='Layer_1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' x='0px' y='0px' viewBox='0 0 128 128' style='enable-background:new 0 0 128 128;' xml:space='preserve' fill='purple'> <path d='M98.3,68.4l-0.2,0l-16.5-4.4l15.6-3.6l1.1-0.1c0,0,16.7-3.5,14.3-16.3c-0.3-1.9-1.1-3.9-2.3-6.1c-10-18.1-25.3-1.1-25.3-1.1l-0.5,0.6L72.9,48.9l5-16.5c0,0,6.9-21.1-13.4-21.5c-0.1,0-0.2,0-0.3,0c-0.1,0-0.1,0-0.1,0c-20.7-0.4-13.5,21.3-13.5,21.3L55.1,49L43.6,36.7l-0.3-0.3c0,0-8.4-9.3-17-6.6c-2.9,0.9-5.8,3.1-8.4,7.4C7.3,54.9,29.7,59.6,29.7,59.6l0.2,0l16.5,4.4l-15.7,3.6l-1.1,0.1 c0,0-16.7,3.5-14.3,16.3c0.3,1.8,1.1,3.9,2.3,6.1c10,18.1,25.3,1.1,25.3,1.1l0.4-0.6l11.7-11.7l-5,16.4c0,0-6.9,21.1,13.4,21.5 c0.1,0,0.2,0,0.3,0c0,0,0.1,0,0.1,0c20.7,0.4,13.6-21.4,13.6-21.4L72.9,79l11.4,12.2l0.3,0.4c0,0,7.1,7.8,14.9,7.1c3.6-0.3,7.3-2.4,10.5-7.9C120.7,73.1,98.3,68.4,98.3,68.4'/><text x='50%' y='50%' class='base' fill='pink' dominant-baseline='middle' text-anchor='middle' font-size='5px' >Daisy #";
     
    string memory finalSvg = string(abi.encodePacked(baseSvg, Strings.toString(newItemId), "</text></svg>"));

    // metadata
    string memory json = Base64.encode(
        bytes(
            string(
                abi.encodePacked(
                '{"name": "',
                    Strings.toString(newItemId),
                    '", "description": "A highly acclaimed collection of daisies", "image": "data:image/svg+xml;base64,',
                    Base64.encode(bytes(finalSvg)),
                '"}'
                )
            )
        )
    );

    string memory finalTokenURI = string(abi.encodePacked(
        "data:application/json;base64,", json
    ));

    _safeMint(msg.sender, newItemId);
    _setTokenURI(newItemId, finalTokenURI);

    _tokenId.increment();

    return newItemId;

    }
}