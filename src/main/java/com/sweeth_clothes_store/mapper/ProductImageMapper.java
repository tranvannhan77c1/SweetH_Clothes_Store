package com.sweeth_clothes_store.mapper;

import com.sweeth_clothes_store.dto.ProductImageDTO;
import com.sweeth_clothes_store.model.Product;
import com.sweeth_clothes_store.model.ProductImage;

public class ProductImageMapper {
    
    public static ProductImageDTO toProductImageDTO(ProductImage productImage) {
        if (productImage == null) {
            return null;
        }
        ProductImageDTO dto = new ProductImageDTO();
        dto.setId(productImage.getId());
        dto.setImageUrl(productImage.getImageUrl());
        return dto;
    }

    public static ProductImage toProductImage(ProductImageDTO dto) {
        if (dto == null) {
            return null;
        }
        ProductImage productImage = new ProductImage();
        productImage.setId(dto.getId());
        productImage.setImageUrl(dto.getImageUrl());
        return productImage;
    }
}
