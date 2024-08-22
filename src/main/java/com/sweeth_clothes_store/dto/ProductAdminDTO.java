package com.sweeth_clothes_store.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductAdminDTO {
    private Integer id;
    private String thumbnailImage;
    private String name;
    private BigDecimal price;
    private Integer quantity;
    private String brand;
    private String madeIn;
    private String color;
    private String material;
    private String description;
    private Integer categoryId;
    private Integer itemId;
    private List<ProductImageDTO> productImages;
    private List<ProductSizeDTO> productSizes;
}
