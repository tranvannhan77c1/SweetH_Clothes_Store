package com.sweeth_clothes_store.mapper;

import com.sweeth_clothes_store.dto.CategoryDTO;
import com.sweeth_clothes_store.model.Category;

public class CategoryMapper {
    // Chuyển đổi từ Category entity sang CategoryDTO
    public static CategoryDTO toCategoryDTO(Category category) {
        if (category == null) {
            return null;
        }
        CategoryDTO dto = new CategoryDTO();
        dto.setId(category.getId());
        dto.setName(category.getName());
        dto.setItemName(category.getItem() != null ? category.getItem().getName() : null); // Lấy tên Item
        dto.setItemId(category.getItem() != null ? category.getItem().getId() : null); // Lưu ý cập nhật tại đây
        dto.setProductCount(category.getProducts() != null ? category.getProducts().size() : 0); // Đếm số lượng sản phẩm

        return dto;
    }

    // Chuyển đổi từ CategoryDTO sang Category entity
    public static Category toCategory(CategoryDTO dto) {
        if (dto == null) {
            return null;
        }
        Category category = new Category();
        category.setId(dto.getId());
        category.setName(dto.getName());
        // Item và Product count không được set vào entity vì chúng là giá trị tính toán
        return category;
    }
}

