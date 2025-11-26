// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

bytes32 constant STORAGE_SLOT = keccak256("diamond.standard.reentrancy.guard");

abstract contract ReentrancyGuard {
    modifier nonReentrant() {
        // constant must be converted to memory variable to use in assembly
        bytes32 slot = STORAGE_SLOT;
        bool entered;

        assembly {
            // Load current state of reentrancy guard
            entered := tload(slot)
            // Revert if entered is true
            if entered { revert(0, 0) }
            // Set entered to true if not entered
            tstore(slot, 1)
        }

        _;

        assembly {
            // Reset entered to false after function execution
            tstore(slot, 0)
        }
    }
}
