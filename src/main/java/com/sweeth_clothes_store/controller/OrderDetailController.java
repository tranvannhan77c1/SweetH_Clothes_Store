package com.sweeth_clothes_store.controller;

import com.sweeth_clothes_store.dto.OrderDetailDTO;
import com.sweeth_clothes_store.service.OrderDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/order-details")
public class OrderDetailController {

    @Autowired
    private OrderDetailService orderDetailService;

    @GetMapping("/{id}")
    public ResponseEntity<OrderDetailDTO> getOrderDetailById(@PathVariable Integer id) {
        OrderDetailDTO orderDetailDTO = orderDetailService.getOrderDetailById(id);
        if (orderDetailDTO == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(orderDetailDTO);
    }

    @GetMapping
    public List<OrderDetailDTO> getAllOrderDetails() {
        return orderDetailService.getAllOrderDetails();
    }

    @PostMapping
    public ResponseEntity<OrderDetailDTO> createOrderDetail(@RequestBody OrderDetailDTO orderDetailDTO) {
        OrderDetailDTO createdOrderDetail = orderDetailService.createOrderDetail(orderDetailDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdOrderDetail);
    }

    @PutMapping("/{id}")
    public ResponseEntity<OrderDetailDTO> updateOrderDetail(@PathVariable Integer id, @RequestBody OrderDetailDTO orderDetailDTO) {
        OrderDetailDTO updatedOrderDetail = orderDetailService.updateOrderDetail(id, orderDetailDTO);
        if (updatedOrderDetail == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(updatedOrderDetail);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteOrderDetail(@PathVariable Integer id) {
        orderDetailService.deleteOrderDetail(id);
        return ResponseEntity.noContent().build();
    }
}

