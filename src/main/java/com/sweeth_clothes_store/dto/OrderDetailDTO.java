package com.sweeth_clothes_store.dto;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderDetailDTO {
    private Integer id;
    private Integer quantity;
    private BigDecimal price;
    private String size;
    private Integer productId;
    private String productName;
    private String productImage;
    private Integer orderId;  // Thay vì sử dụng `Order order`
}
