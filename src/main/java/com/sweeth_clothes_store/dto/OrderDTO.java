package com.sweeth_clothes_store.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderDTO {
    private Integer id;
    private LocalDateTime orderDate;
    private BigDecimal totalAmount;
    private String status;
    private String address;
    private String phone;
    private Integer voucherId;
    private Integer accountId;
    private List<OrderDetailDTO> orderDetails;
}
