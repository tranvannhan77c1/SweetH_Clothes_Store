package com.sweeth_clothes_store.mapper;

import com.sweeth_clothes_store.dto.OrderDTO;
import com.sweeth_clothes_store.dto.OrderDetailDTO;
import com.sweeth_clothes_store.model.Order;
import com.sweeth_clothes_store.model.OrderDetail;

import java.util.List;
import java.util.stream.Collectors;

public class OrderMapper {
    public static OrderDTO toOrderDTO(Order order) {
        if (order == null) {
            return null;
        }
        
        OrderDTO dto = new OrderDTO();
        dto.setId(order.getId());
        dto.setOrderDate(order.getOrderDate());
        dto.setTotalAmount(order.getTotalAmount());
        dto.setStatus(order.getStatus());
        dto.setPayment(order.getPayment());
        dto.setAddress(order.getAddress());
        dto.setPhone(order.getPhone());
        dto.setVoucherId(order.getVoucher() != null ? order.getVoucher().getId() : null);
        dto.setAccountId(order.getAccount() != null ? order.getAccount().getId() : null);
        dto.setFullNameAccount(order.getAccount() != null ? order.getAccount().getFullName() : null);
        List<OrderDetailDTO> orderDetailDTOs = order.getOrderDetails().stream()
                .map(OrderDetailMapper::toOrderDetailDTO)
                .collect(Collectors.toList());
        dto.setOrderDetails(orderDetailDTOs);
        
        return dto;
    }

    public static Order toOrder(OrderDTO dto) {
        if (dto == null) {
            return null;
        }
        
        Order order = new Order();
        order.setId(dto.getId());
        order.setOrderDate(dto.getOrderDate());
        order.setTotalAmount(dto.getTotalAmount());
        order.setStatus(dto.getStatus());
        order.setPayment(dto.getPayment());
        order.setAddress(dto.getAddress());
        order.setPhone(dto.getPhone());
        
        // Để đơn giản, chúng ta không thiết lập các thực thể Voucher và Account ở đây.
        // Điều này thường yêu cầu truy xuất các thực thể liên quan từ cơ sở dữ liệu.
        
//        List<OrderDetail> orderDetails = dto.getOrderDetails().stream()
//                .map(OrderDetailMapper::toOrderDetail)
//                .collect(Collectors.toList());
//        order.setOrderDetails(orderDetails);
        
        return order;
    }
}
