package com.sweeth_clothes_store.mapper;

import com.sweeth_clothes_store.dto.ProductAdminDTO;
import com.sweeth_clothes_store.model.Category;
import com.sweeth_clothes_store.model.Product;
import com.sweeth_clothes_store.repository.CategoryRepository;
import com.sweeth_clothes_store.util.ResourceNotFoundException;

import java.util.ArrayList;
import java.util.stream.Collectors;


public class ProductAdminMapper {

    public static ProductAdminDTO toProductDTO(Product product) {
        if (product == null) {
            return null;
        }
        ProductAdminDTO dto = new ProductAdminDTO();
        dto.setId(product.getId());
        dto.setThumbnailImage(product.getThumbnailImage());
        dto.setName(product.getName());
        dto.setPrice(product.getPrice());
        dto.setQuantity(product.getQuantity());
        dto.setBrand(product.getBrand());
        dto.setMadeIn(product.getMadeIn());
        dto.setColor(product.getColor());
        dto.setMaterial(product.getMaterial());
        dto.setDescription(product.getDescription());

        dto.setCategoryId(product.getCategory().getId());
        dto.setItemId(product.getCategory().getItem().getId());

        dto.setProductImages(product.getProductImages() != null ?
                product.getProductImages().stream()
                        .map(ProductImageMapper::toProductImageDTO)
                        .collect(Collectors.toList()) : new ArrayList<>());

        dto.setProductSizes(product.getProductSizes() != null ?
                product.getProductSizes().stream()
                        .map(ProductSizeMapper::toProductSizeDTO)
                        .collect(Collectors.toList()) : new ArrayList<>());

        return dto;
    }

    public static Product toProduct(ProductAdminDTO dto) {
        if (dto == null) {
            return null;
        }
        Product product = new Product();
        product.setId(dto.getId());
        product.setThumbnailImage(dto.getThumbnailImage());
        product.setName(dto.getName());
        product.setPrice(dto.getPrice());
        product.setQuantity(dto.getQuantity());
        product.setBrand(dto.getBrand());
        product.setMadeIn(dto.getMadeIn());
        product.setColor(dto.getColor());
        product.setMaterial(dto.getMaterial());
        product.setDescription(dto.getDescription());

        return product;
    }
}

