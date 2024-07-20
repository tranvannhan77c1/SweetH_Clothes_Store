package com.sweeth_clothes_store.payload;

import com.sweeth_clothes_store.dto.OrderDetailDTO;
import com.sweeth_clothes_store.model.Order;
import com.sweeth_clothes_store.model.OrderDetail;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderRequest {
    private Order order;
    private List<OrderDetailDTO> orderDetailDTOs;

}
