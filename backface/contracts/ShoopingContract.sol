// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ShoppingCart {
    struct Item {
        uint id;
        string name;
        uint price;
    }

    mapping(address => Item[]) private carts;
    uint private nextItemId;

    event ItemAdded(address indexed user, uint itemId, string itemName, uint itemPrice);
    event ItemRemoved(address indexed user, uint itemId);

    function addItem(string memory name, uint price) public {
        carts[msg.sender].push(Item(nextItemId, name, price));
        emit ItemAdded(msg.sender, nextItemId, name, price);
        nextItemId++;
    }

    function removeItem(uint itemId) public {
        Item[] storage cart = carts[msg.sender];
        for (uint i = 0; i < cart.length; i++) {
            if (cart[i].id == itemId) {
                cart[i] = cart[cart.length - 1];
                cart.pop();
                emit ItemRemoved(msg.sender, itemId);
                return;
            }
        }
    }

    function getCart() public view returns (Item[] memory) {
        return carts[msg.sender];
    }
}
