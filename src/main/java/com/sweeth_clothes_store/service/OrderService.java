package com.sweeth_clothes_store.service;

import com.sweeth_clothes_store.dto.OrderDTO;
import com.sweeth_clothes_store.mapper.OrderMapper;
import com.sweeth_clothes_store.model.Order;
import com.sweeth_clothes_store.model.OrderDetail;
import com.sweeth_clothes_store.repository.OrderDetailRepository;
import com.sweeth_clothes_store.repository.OrderRepository;
import com.sweeth_clothes_store.service.OrderService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class OrderService {
    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderDetailRepository orderDetailRepository;

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

    @Transactional
    public Order createOrder(Order order, List<OrderDetail> orderDetails) {
        order.setOrderDate(LocalDateTime.now());
        order.setStatus("ĐÃ THANH TOÁN");

        if( orderDetails == null) {
            System.out.println(" null ");
            return null;
        }

        Order savedOrder = orderRepository.save(order);



        for (OrderDetail orderDetail : orderDetails) {
            orderDetail.setOrder(savedOrder);
            orderDetailRepository.save(orderDetail);
        }

        return savedOrder;

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
