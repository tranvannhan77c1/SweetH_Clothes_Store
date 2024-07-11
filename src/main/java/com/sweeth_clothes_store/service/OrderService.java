package com.sweeth_clothes_store.service;

import com.sweeth_clothes_store.dto.OrderDTO;
import com.sweeth_clothes_store.mapper.OrderMapper;
import com.sweeth_clothes_store.model.Order;
import com.sweeth_clothes_store.repository.OrderRepository;
import com.sweeth_clothes_store.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class OrderService {
    @Autowired
    private OrderRepository orderRepository;

    public Page<OrderDTO> getAllOrders(Pageable pageable) {
        Page<Order> orderPage = orderRepository.findAll(pageable);
        return orderPage.map(OrderMapper::toOrderDTO);
    }

    public OrderDTO getOrderById(Integer id) {
        Order order = orderRepository.findById(id).orElse(null);
        return OrderMapper.toOrderDTO(order);
    }

    public List<OrderDTO> getAllOrders() {
        List<Order> orders = orderRepository.findAll();
        return orders.stream()
                .map(OrderMapper::toOrderDTO)
                .collect(Collectors.toList());
    }

    public OrderDTO createOrder(OrderDTO orderDTO) {
        Order order = OrderMapper.toOrder(orderDTO);
        order = orderRepository.save(order);
        return OrderMapper.toOrderDTO(order);
    }
    public OrderDTO updateOrder(Integer id, OrderDTO orderDTO) {
        if (!orderRepository.existsById(id)) {
            return null;
        }
        Order order = OrderMapper.toOrder(orderDTO);
        order.setId(id);
        order = orderRepository.save(order);
        return OrderMapper.toOrderDTO(order);
    }

    public void deleteOrder(Integer id) {
        orderRepository.deleteById(id);
    }
}
