// SPDX-License-Identifier: MIT
// Dòng này khai báo giấy phép mã nguồn mở MIT, cần thiết cho Solidity.

pragma solidity ^0.8.0;
// Chỉ định phiên bản Solidity từ 0.8.0 trở lên, đảm bảo tương thích với Monad Testnet (EVM-compatible).

contract Happy {
    // Khai báo hợp đồng với tên "Happy".

    address public creator; 
    // Biến công khai lưu địa chỉ của người tạo hợp đồng (bạn). 
    // "public" tự động tạo hàm getter để xem giá trị.

    uint256 public happinessCount; 
    // Biến công khai đếm số lần người dùng gửi thông điệp hạnh phúc. 
    // Bắt đầu từ 0, kiểu uint256 là số nguyên không âm lớn.

    mapping(address => string) public happinessMessages; 
    // Mapping (bảng băm) lưu thông điệp hạnh phúc của từng địa chỉ ví. 
    // Key là địa chỉ (address), value là chuỗi (string).

    event SpreadHappiness(address indexed sender, string message); 
    // Sự kiện (event) để ghi lại mỗi lần gửi thông điệp lên blockchain. 
    // "indexed" giúp lọc theo sender dễ hơn khi xem log.

    constructor() {
        // Hàm khởi tạo, chạy một lần khi deploy hợp đồng.
        creator = msg.sender; 
        // Gán địa chỉ của người deploy (bạn) vào biến creator.
        happinessCount = 0; 
        // Khởi tạo số đếm hạnh phúc bằng 0.
    }

    function spreadHappiness(string memory message) external {
        // Hàm cho phép người dùng gửi thông điệp hạnh phúc.
        // "string memory" lưu chuỗi tạm thời trong bộ nhớ khi gọi hàm.
        // "external" chỉ cho phép gọi từ bên ngoài hợp đồng, tiết kiệm gas.

        require(bytes(message).length > 0, "Message cannot be empty"); 
        // Kiểm tra thông điệp không được rỗng. 
        // bytes(message).length chuyển chuỗi thành mảng byte để đếm độ dài.

        happinessMessages[msg.sender] = message; 
        // Lưu thông điệp vào mapping, key là địa chỉ người gửi (msg.sender).

        happinessCount++; 
        // Tăng biến đếm hạnh phúc lên 1 sau mỗi lần gửi.

        emit SpreadHappiness(msg.sender, message); 
        // Phát ra sự kiện SpreadHappiness, ghi lại sender và message lên blockchain.
    }

    function getMessage(address user) external view returns (string memory) {
        // Hàm để xem thông điệp của một địa chỉ cụ thể.
        // "view" nghĩa là chỉ đọc, không thay đổi trạng thái blockchain.
        // "returns (string memory)" trả về chuỗi từ bộ nhớ.

        return happinessMessages[user]; 
        // Trả về thông điệp được lưu trong mapping cho địa chỉ "user".
    }
}
