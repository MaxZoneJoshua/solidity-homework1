// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    mapping(string => uint256) private votes;
    mapping(string => bool) private knownCandidate;
    string[] private candidates;

    function vote(string calldata candidate) external {
        if (!knownCandidate[candidate]) {
            knownCandidate[candidate] = true;
            candidates.push(candidate);
        }
        votes[candidate] += 1;
    }

    function getVotes(string calldata candidate) external view returns (uint256) {
        return votes[candidate];
    }

    function resetVotes() external {
        uint256 len = candidates.length;
        for (uint256 i = 0; i < len; i++) {
            votes[candidates[i]] = 0;
        }
    }
}

contract Homework1 {
    function reverseString(string memory input) external pure returns (string memory) {
        bytes memory data = bytes(input);
        bytes memory out = new bytes(data.length);
        for (uint256 i = 0; i < data.length; i++) {
            out[data.length - 1 - i] = data[i];
        }
        return string(out);
    }

    function intToRoman(uint256 num) external pure returns (string memory) {
        require(num > 0 && num <= 3999, "out of range");

        uint256[13] memory values = [
            uint256(1000),
            900,
            500,
            400,
            100,
            90,
            50,
            40,
            10,
            9,
            5,
            4,
            1
        ];

        string[13] memory symbols = [
            "M",
            "CM",
            "D",
            "CD",
            "C",
            "XC",
            "L",
            "XL",
            "X",
            "IX",
            "V",
            "IV",
            "I"
        ];

        bytes memory out;
        for (uint256 i = 0; i < values.length; i++) {
            while (num >= values[i]) {
                out = bytes.concat(out, bytes(symbols[i]));
                num -= values[i];
            }
        }
        return string(out);
    }

    function romanToInt(string memory input) external pure returns (uint256) {
        bytes memory data = bytes(input);
        uint256 total = 0;
        uint256 i = 0;
        while (i < data.length) {
            uint256 current = _romanValue(data[i]);
            if (i + 1 < data.length) {
                uint256 nextVal = _romanValue(data[i + 1]);
                if (current < nextVal) {
                    total += (nextVal - current);
                    i += 2;
                    continue;
                }
            }
            total += current;
            i += 1;
        }

        return total;
    }

    function mergeSorted(uint256[] memory a, uint256[] memory b)
        external
        pure
        returns (uint256[] memory)
    {
        uint256[] memory out = new uint256[](a.length + b.length);
        uint256 i = 0;
        uint256 j = 0;
        uint256 k = 0;

        while (i < a.length && j < b.length) {
            if (a[i] <= b[j]) {
                out[k] = a[i];
                i++;
            } else {
                out[k] = b[j];
                j++;
            }
            k++;
        }

        while (i < a.length) {
            out[k] = a[i];
            i++;
            k++;
        }

        while (j < b.length) {
            out[k] = b[j];
            j++;
            k++;
        }

        return out;
    }

    function binarySearch(uint256[] memory arr, uint256 target) external pure returns (int256) {
        uint256 low = 0;
        uint256 high = arr.length;

        while (low < high) {
            uint256 mid = low + (high - low) / 2;
            uint256 val = arr[mid];
            if (val == target) {
                return int256(mid);
            }
            if (val < target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }

        return -1;
    }

    function _romanValue(bytes1 c) private pure returns (uint256) {
        if (c == 'I') return 1;
        if (c == 'V') return 5;
        if (c == 'X') return 10;
        if (c == 'L') return 50;
        if (c == 'C') return 100;
        if (c == 'D') return 500;
        if (c == 'M') return 1000;
        revert("invalid roman");
    }
}
