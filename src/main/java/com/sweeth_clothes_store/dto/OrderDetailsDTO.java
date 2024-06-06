package com.sweeth_clothes_store.dto;

import java.math.BigDecimal;

import com.sweeth_clothes_store.model.Order;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderDetailsDTO {
	private Integer id;
    private Integer quantity;
    private BigDecimal price;
    private Order order;
}
