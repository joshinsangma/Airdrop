//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

// token contract address --> 0xd9145CCE52D386f254917e481eB44e9943F39138
// Airdrop contract address --> 0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8

// Interface
interface IERC20 {
    function transfer(address _to, uint256 _value) external returns (bool);

    function balanceOf(address tokenOwner) external view returns (uint balance);
}

contract Airdrop {
    // Event to log successful token transfers
    event AirdropSuccess(address indexed recipient, uint256 amount);

    // Event to log unsuccessful token transfers
    event AirdropFailed(address indexed recipient, string message);

    // declared three state variables
    address public owner;
    IERC20 public token;
    uint256 public airdropQuantity;

    modifier onlyOwner() {
        // Modifier is used to changed the behavior of a function
        // Access Validation
        require(
            msg.sender == owner,
            "Only contract owner can call this function"
        );
        _;
    }

    // Initialized the token and owner
    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress);
        owner = msg.sender;
    }

    // Function to update the token for the airdrop
    function setAirdropToken(address _tokenAddress) external onlyOwner {
        token = IERC20(_tokenAddress);
    }

    // Function to set the quantity of tokens to be distributed
    // The require statement is used to check for valid conditions,
    // and to revert the transaction if the conditions are not met

    function setAirdropQuantity(uint256 _quantity) external onlyOwner {
        require(_quantity > 0, "Quantity should be greater than 0");
        airdropQuantity = _quantity;
    }

    // Function to execute airdrops to single or multiple recipients simultaneously
    function executeAirdrop(
        address[] memory _recipients,
        uint256[] memory _amounts
    ) external onlyOwner {
        require(
            _recipients.length == _amounts.length,
            "Array length is not in sync and mismatch"
        );

        for (uint256 i = 0; i < _recipients.length; i++) {
            address recipient = _recipients[i];
            uint256 amount = _amounts[i];

            require(recipient != address(0), "Invalid recipient address");
            require(amount > 0, "Invalid token amount");

            bool success = token.transfer(recipient, amount);

            // conditionals --> if and else method
            if (success) {
                emit AirdropSuccess(recipient, amount); // fire the event
            } else {
                emit AirdropFailed(recipient, "Token transfer failed"); // fire the event
            }
        }
    }
}
