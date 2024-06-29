package com.sweeth_clothes_store.service;

import com.sweeth_clothes_store.dto.OrderDetailDTO;
import com.sweeth_clothes_store.mapper.OrderDetailMapper;
import com.sweeth_clothes_store.model.OrderDetail;
import com.sweeth_clothes_store.repository.OrderDetailRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class OrderDetailService {

    @Autowired
    private OrderDetailRepository orderDetailRepository;



    public OrderDetailDTO getOrderDetailById(Integer id) {
        OrderDetail orderDetail = orderDetailRepository.findById(id).orElse(null);
        return OrderDetailMapper.toOrderDetailDTO(orderDetail);
    }

    public List<OrderDetailDTO> getAllOrderDetails() {
        List<OrderDetail> orderDetails = orderDetailRepository.findAll();
        return orderDetails.stream()
                           .map(OrderDetailMapper::toOrderDetailDTO)
                           .collect(Collectors.toList());
    }

    public OrderDetailDTO createOrderDetail(OrderDetailDTO orderDetailDTO) {
        OrderDetail orderDetail = OrderDetailMapper.toOrderDetail(orderDetailDTO);
        orderDetail = orderDetailRepository.save(orderDetail);
        return OrderDetailMapper.toOrderDetailDTO(orderDetail);
    }

    public OrderDetailDTO updateOrderDetail(Integer id, OrderDetailDTO orderDetailDTO) {
        if (!orderDetailRepository.existsById(id)) {
            return null;
        }
        OrderDetail orderDetail = OrderDetailMapper.toOrderDetail(orderDetailDTO);
        orderDetail.setId(id);
        orderDetail = orderDetailRepository.save(orderDetail);
        return OrderDetailMapper.toOrderDetailDTO(orderDetail);
    }

    public void deleteOrderDetail(Integer id) {
        orderDetailRepository.deleteById(id);
    }
}
