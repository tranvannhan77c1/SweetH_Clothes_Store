package com.sweeth_clothes_store.mapper;

import com.sweeth_clothes_store.dto.OrderDetailsDTO;
import com.sweeth_clothes_store.model.OrderDetail;

public class OrderDetailsMapper {
	public static OrderDetailsDTO toOrderDetailsDTO(OrderDetail orderDetail) {
		if(orderDetail == null) {
			return null;
		}
		
		OrderDetailsDTO dto = new OrderDetailsDTO();
		dto.setId(orderDetail.getId());
		dto.setQuantity(orderDetail.getQuantity());
		dto.setPrice(orderDetail.getPrice());
		dto.setOrder(orderDetail.getOrder());
		return dto;
	}
}
