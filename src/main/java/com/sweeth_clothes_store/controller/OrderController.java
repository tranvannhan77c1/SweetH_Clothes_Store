package com.sweeth_clothes_store.controller;

import com.sweeth_clothes_store.dto.OrderDTO;
import com.sweeth_clothes_store.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/orders")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping
    public ResponseEntity<Page<OrderDTO>> getAllOrders(
            @PageableDefault(page = 0, size = 8, sort = "id", direction = Sort.Direction.ASC) Pageable pageable) {

        Page<OrderDTO> orders = orderService.getAllOrders(pageable);

        return ResponseEntity.ok(orders);
    }

    @GetMapping("/{id}")
    public ResponseEntity<OrderDTO> getOrderById(@PathVariable Integer id) {
        OrderDTO orderDTO = orderService.getOrderById(id);
        if (orderDTO == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(orderDTO);
    }

//    @GetMapping
//    public List<OrderDTO> getAllOrders() {
//        return orderService.getAllOrders();
//    }

    @PostMapping
    public ResponseEntity<OrderDTO> createOrder(@RequestBody OrderDTO orderDTO) {
        OrderDTO createdOrder = orderService.createOrder(orderDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdOrder);
    }

    @PutMapping("/{id}")
    public ResponseEntity<OrderDTO> updateOrder(@PathVariable Integer id, @RequestBody OrderDTO orderDTO) {
        OrderDTO updatedOrder = orderService.updateOrder(id, orderDTO);
        if (updatedOrder == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(updatedOrder);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteOrder(@PathVariable Integer id) {
        orderService.deleteOrder(id);
        return ResponseEntity.noContent().build();
    }
}

