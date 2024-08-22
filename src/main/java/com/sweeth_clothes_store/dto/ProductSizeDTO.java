package com.sweeth_clothes_store.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductSizeDTO {
    private Integer id;
    private String size;
    private Integer quantity;
}
