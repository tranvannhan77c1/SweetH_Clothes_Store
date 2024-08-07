package com.sweeth_clothes_store.mapper;

import com.sweeth_clothes_store.dto.OrderDetailDTO;
import com.sweeth_clothes_store.model.OrderDetail;
import com.sweeth_clothes_store.payload.OrderRequest;
import com.sweeth_clothes_store.repository.OrderDetailRepository;
import com.sweeth_clothes_store.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


public class OrderDetailMapper {

    public static OrderDetailDTO toOrderDetailDTO(OrderDetail orderDetail) {
        if (orderDetail == null) {
            return null;
        }

        OrderDetailDTO dto = new OrderDetailDTO();
        dto.setId(orderDetail.getId());
        dto.setQuantity(orderDetail.getQuantity());
        dto.setPrice(orderDetail.getPrice());
        dto.setSize(orderDetail.getSize());
        dto.setProductId(orderDetail.getProduct().getId());
        dto.setProductName(orderDetail.getProduct().getName());
        dto.setProductImage(orderDetail.getProduct().getThumbnailImage());
        dto.setOrderId(orderDetail.getOrder().getId());
        return dto;
    }

    public static OrderDetail toOrderDetail(OrderDetailDTO dto) {
        if (dto == null) {
            return null;
        }

        OrderDetail orderDetail = new OrderDetail();
        orderDetail.setId(dto.getId());
        orderDetail.setQuantity(dto.getQuantity());
        orderDetail.setPrice(dto.getPrice());
        orderDetail.setSize(dto.getSize());
        // Để đơn giản, chúng ta không thiết lập các thực thể Product và Order ở đây.
        // Điều này thường yêu cầu truy xuất các thực thể liên quan từ cơ sở dữ liệu.

        return orderDetail;
    }
}

