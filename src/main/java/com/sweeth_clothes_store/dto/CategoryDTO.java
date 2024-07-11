package com.sweeth_clothes_store.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CategoryDTO {
    private Integer id;
    private String name;
    private String itemName;
    private Integer itemId; // Thêm trường này để lưu trữ ID của Item
    private Integer productCount;
}
