package com.sweeth_clothes_store.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class VoucherDTO {
    private Integer id;
    private String code;
    private BigDecimal discountAmount;
    private BigDecimal condition;
    private LocalDateTime validFrom;
    private LocalDateTime validTo;
    private LocalDateTime createDate;
}