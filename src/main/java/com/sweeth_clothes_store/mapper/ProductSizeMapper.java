package com.sweeth_clothes_store.mapper;

import com.sweeth_clothes_store.dto.ProductSizeDTO;
import com.sweeth_clothes_store.model.Product;
import com.sweeth_clothes_store.model.ProductSize;

public class ProductSizeMapper {
    
    public static ProductSizeDTO toProductSizeDTO(ProductSize productSize) {
        if (productSize == null) {
            return null;
        }
        ProductSizeDTO dto = new ProductSizeDTO();
        dto.setId(productSize.getId());
        dto.setSize(productSize.getSize());
        dto.setQuantity(productSize.getQuantity());
        return dto;
    }

    public static ProductSize toProductSize(ProductSizeDTO dto) {
        if (dto == null) {
            return null;
        }
        ProductSize productSize = new ProductSize();
        productSize.setId(dto.getId());
        productSize.setSize(dto.getSize());
        productSize.setQuantity(dto.getQuantity());
        return productSize;
    }
}
