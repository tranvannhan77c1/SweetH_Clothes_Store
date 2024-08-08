package com.sweeth_clothes_store.service;

import com.sweeth_clothes_store.dto.OrderDTO;
import com.sweeth_clothes_store.dto.OrderDetailDTO;
import com.sweeth_clothes_store.mapper.OrderDetailMapper;
import com.sweeth_clothes_store.mapper.OrderMapper;
import com.sweeth_clothes_store.model.*;
import com.sweeth_clothes_store.repository.*;
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
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class OrderService {
    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderDetailRepository orderDetailRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private AccountRepository accountRepository;

    @Autowired
    private VoucherRepository voucherRepository;

    public Page<OrderDTO> getAllOrders(Pageable pageable) {
        Page<Order> orderPage = orderRepository.findAll(pageable);
        return orderPage.map(OrderMapper::toOrderDTO);
    }

    public OrderDTO getOrderById(Integer id) {
        Order order = orderRepository.findById(id).orElse(null);
        return OrderMapper.toOrderDTO(order);
    }

    public List<Order> getOrdersByUserID(int userID) {
        List<Order> order = orderRepository.findByAccount_id(userID);
        return order;
    }

    public List<OrderDTO> getAllOrders() {
        List<Order> orders = orderRepository.findAll();
        return orders.stream()
                .map(OrderMapper::toOrderDTO)
                .collect(Collectors.toList());
    }

    @Transactional
    public Order createOrder(OrderDTO orderDto) {
        orderDto.setOrderDate(LocalDateTime.now());
        orderDto.setStatus("ĐÃ THANH TOÁN");

        //map orderDto to order
        Order order = OrderMapper.toOrder(orderDto);

        //set account
        Account acc = accountRepository.findById(orderDto.getAccountId()).isPresent() ?
                accountRepository.findById(orderDto.getAccountId()).get() : null;
        if(acc == null) {
            throw new NullPointerException();
        }
        order.setAccount(acc);

        //set voucher
        Voucher vch = voucherRepository.findById(orderDto.getVoucherId()).isPresent() ?
                voucherRepository.findById(orderDto.getVoucherId()).get() : null;
        if(vch == null) {
            throw new NullPointerException();
        }
        order.setVoucher(vch);

        //save order to db
        Order savedOrder = orderRepository.save(order);

        for (OrderDetailDTO oddto : orderDto.getOrderDetails()) {
            //map orderDetailDTO to orderDetail
            OrderDetail od = OrderDetailMapper.toOrderDetail(oddto);

            //set product
            Product prod = productRepository.findById(oddto.getProductId()).isPresent() ?
                    productRepository.findById(oddto.getProductId()).get() : null;
            if (prod == null) {
                throw new NullPointerException();
            }
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
