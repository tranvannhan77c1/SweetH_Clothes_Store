package com.sweeth_clothes_store.mapper;

import com.sweeth_clothes_store.dto.CategoryDTO;
import com.sweeth_clothes_store.model.Category;

public class CategoryMapper {
    public static CategoryDTO toCategoryDTO(Category category) {
        if (category == null) {
            return null;
        }
        CategoryDTO dto = new CategoryDTO();
        dto.setId(category.getId());
        dto.setName(category.getName());
        dto.setItemName(category.getItem() != null ? category.getItem().getName() : null);
        dto.setItemId(category.getItem() != null ? category.getItem().getId() : null);
        dto.setProductCount(category.getProducts() != null ? category.getProducts().size() : 0);

        return dto;
    }

    public static Category toCategory(CategoryDTO dto) {
        if (dto == null) {
            return null;
        }
        Category category = new Category();
        category.setId(dto.getId());
        category.setName(dto.getName());

        return category;
    }
}

