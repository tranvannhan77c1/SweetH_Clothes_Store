package com.sweeth_clothes_store.mapper;

import com.sweeth_clothes_store.dto.ItemDTO;
import com.sweeth_clothes_store.model.Item;

public class ItemMapper {
    // Chuyển đổi từ Item entity sang ItemDTO
    public static ItemDTO toItemDTO(Item item) {
        if (item == null) {
            return null;
        }
        ItemDTO dto = new ItemDTO();
        dto.setId(item.getId());
        dto.setName(item.getName());
        dto.setCategoryCount(item.getCategories() != null ? item.getCategories().size() : 0); // Đếm số lượng category
        // Đếm số lượng sản phẩm trong tất cả các danh mục của item
        int productCount = item.getCategories() != null ?
                item.getCategories().stream().mapToInt(category -> category.getProducts().size()).sum() : 0;
        dto.setProductCount(productCount);
        return dto;
    }

    public static Item toItem(ItemDTO dto) {
        if (dto == null) {
            return null;
        }
        Item item = new Item();
        item.setId(dto.getId());
        item.setName(dto.getName());
        // Category count is not set to the entity because it's a derived value
        return item;
    }
}
