package com.sweeth_clothes_store.service;

import com.sweeth_clothes_store.dto.OrderDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface OrderService {

    Page<OrderDTO> getAllOrders(Pageable pageable);

    OrderDTO getOrderById(Integer id);

    List<OrderDTO> getAllOrders();

    OrderDTO createOrder(OrderDTO orderDTO);

    OrderDTO updateOrder(Integer id, OrderDTO orderDTO);

    void deleteOrder(Integer id);
}
