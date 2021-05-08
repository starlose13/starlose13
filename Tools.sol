// SPDX-License-Identifier: GPL-3.0
pragma experimental ABIEncoderV2;

pragma solidity >=0.6.0 <0.8.0;
library Tools{
    function isstringEQAL(string memory a, string memory b)internal pure returns(bool){
        if (uint(keccak256(abi.encode(a))) == uint(keccak256(abi.encode(b))))
            return(true);
        return(false);
    }
    

    function concatstring(string memory a , string memory b )internal pure returns(string memory){
        bytes memory sa = bytes(a);
        bytes memory sb = bytes(b);
        uint len = sa.length + sb.length;
        bytes memory sc = new bytes(len);
        uint i;
        for (i=0 ; i < sa.length ; i++)
            sc[i]= sa[i];
        for (i=0 ; i <sb.length ; i++)
            sc[i+sa.length] = sb[i];
        return(string(sc));

    }
    function uint2str(uint i) internal pure returns (string memory) {
    if (i == 0) return "0";
    uint j = i;
    uint length;
    while (j != 0) {
        length++;
        j /= 10;
    }
    bytes memory bstr = new bytes(length);
    uint k = length - 1;
    while (i != 0) {
        bstr[k--] = byte(uint8(48 + i % 10));
        i /= 10;
    }
    return string(bstr);
    }
function toAsciiString(address x) internal pure returns (string memory) {
    bytes memory s = new bytes(40);
    for (uint i = 0; i < 20; i++) {
        bytes1 b = bytes1(uint8(uint(uint160(x)) / (2**(8*(19 - i)))));
        bytes1 hi = bytes1(uint8(b) / 16);
        bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
        s[2*i] = char(hi);
        s[2*i+1] = char(lo);            
    }
    return string(s);
}

function char(bytes1 b) internal pure returns (bytes1 c) {
    if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
    else return bytes1(uint8(b) + 0x57);
}
    
}
