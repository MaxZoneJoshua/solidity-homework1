// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../src/Homework1.sol";

contract Voter {
    function vote(Voting voting, address candidate) external {
        voting.vote(candidate);
    }
}

contract Homework1Test {
    Voting private voting;
    Homework1 private hw;

    function setUp() public {
        voting = new Voting();
        hw = new Homework1();
    }

    function testVoting() public {
        Voter voter1 = new Voter();
        Voter voter2 = new Voter();
        address alice = address(0x1111);
        address bob = address(0x2222);

        voter1.vote(voting, alice);
        voter2.vote(voting, bob);

        assertEqUint(voting.getVotes(alice), 1);
        assertEqUint(voting.getVotes(bob), 1);

        try voter1.vote(voting, alice) {
            revert("expected revert");
        } catch {}

        voting.resetVotes();

        assertEqUint(voting.getVotes(alice), 0);
        assertEqUint(voting.getVotes(bob), 0);

        voter1.vote(voting, bob);
        assertEqUint(voting.getVotes(bob), 1);
    }

    function testReverseString() public {
        assertEqString(hw.reverseString("abcde"), "edcba");
        assertEqString(hw.reverseString(""), "");
        assertEqString(hw.reverseString("a"), "a");
    }

    function testIntToRoman() public {
        assertEqString(hw.intToRoman(1), "I");
        assertEqString(hw.intToRoman(4), "IV");
        assertEqString(hw.intToRoman(9), "IX");
        assertEqString(hw.intToRoman(58), "LVIII");
        assertEqString(hw.intToRoman(1994), "MCMXCIV");
    }

    function testRomanToInt() public {
        assertEqUint(hw.romanToInt("III"), 3);
        assertEqUint(hw.romanToInt("IV"), 4);
        assertEqUint(hw.romanToInt("IX"), 9);
        assertEqUint(hw.romanToInt("LVIII"), 58);
        assertEqUint(hw.romanToInt("MCMXCIV"), 1994);
    }

    function testMergeSorted() public {
        uint256[] memory a = new uint256[](3);
        a[0] = 1;
        a[1] = 3;
        a[2] = 5;

        uint256[] memory b = new uint256[](3);
        b[0] = 2;
        b[1] = 4;
        b[2] = 6;

        uint256[] memory out = hw.mergeSorted(a, b);
        uint256[] memory expected = new uint256[](6);
        expected[0] = 1;
        expected[1] = 2;
        expected[2] = 3;
        expected[3] = 4;
        expected[4] = 5;
        expected[5] = 6;
        assertEqArray(out, expected);

        uint256[] memory empty = new uint256[](0);
        out = hw.mergeSorted(a, empty);
        assertEqArray(out, a);
    }

    function testBinarySearch() public {
        uint256[] memory arr = new uint256[](5);
        arr[0] = 1;
        arr[1] = 3;
        arr[2] = 5;
        arr[3] = 7;
        arr[4] = 9;

        assertEqInt(hw.binarySearch(arr, 7), 3);
        assertEqInt(hw.binarySearch(arr, 1), 0);
        assertEqInt(hw.binarySearch(arr, 9), 4);
        assertEqInt(hw.binarySearch(arr, 2), -1);
    }

    function assertEqString(string memory a, string memory b) internal pure {
        require(keccak256(bytes(a)) == keccak256(bytes(b)), "string mismatch");
    }

    function assertEqUint(uint256 a, uint256 b) internal pure {
        require(a == b, "uint mismatch");
    }

    function assertEqInt(int256 a, int256 b) internal pure {
        require(a == b, "int mismatch");
    }

    function assertEqArray(uint256[] memory a, uint256[] memory b) internal pure {
        require(a.length == b.length, "length mismatch");
        for (uint256 i = 0; i < a.length; i++) {
            require(a[i] == b[i], "array mismatch");
        }
    }
}
