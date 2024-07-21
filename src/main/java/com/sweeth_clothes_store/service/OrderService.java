package com.sweeth_clothes_store.service;

import com.sweeth_clothes_store.dto.OrderDTO;
import com.sweeth_clothes_store.dto.OrderDetailDTO;
import com.sweeth_clothes_store.mapper.OrderDetailMapper;
import com.sweeth_clothes_store.mapper.OrderMapper;
import com.sweeth_clothes_store.model.Order;
import com.sweeth_clothes_store.model.OrderDetail;
import com.sweeth_clothes_store.model.Product;
import com.sweeth_clothes_store.repository.OrderDetailRepository;
import com.sweeth_clothes_store.repository.OrderRepository;
import com.sweeth_clothes_store.repository.ProductRepository;
import com.sweeth_clothes_store.service.OrderService;
import jakarta.transaction.Transactional;
import org.hibernate.mapping.Map;
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


    @Autowired
    private ProductRepository productRepository;

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
    public Order createOrder(Order order, List<OrderDetailDTO> orderDetailDTOS) {
        order.setOrderDate(LocalDateTime.now());
        order.setStatus("ĐÃ THANH TOÁN");

        if( orderDetailDTOS == null) {
            System.out.println(" null ");
            return null;
        }

        Order savedOrder = orderRepository.save(order);

        for (OrderDetailDTO oddto : orderDetailDTOS) {
            OrderDetail od = OrderDetailMapper.toOrderDetail(oddto);
            Product prod = productRepository.findById(oddto.getProductId()).isPresent() ? productRepository.findById(oddto.getProductId()).get() : null;
            od.setProduct(prod);
            od.setOrder(savedOrder);
            orderDetailRepository.save(od);

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
