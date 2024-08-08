package com.sweeth_clothes_store.dto;

import com.sweeth_clothes_store.model.Order;
import lombok.AllArgsConstructor;
import lombok.Builder;

public abstract class PaymentDTO {
    @Builder
    @AllArgsConstructor
    public static class VNPayResponse {
        public String code;
        public String message;
        public String paymentUrl;
        public Order orderInfo;
    }
}
