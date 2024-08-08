package com.sweeth_clothes_store.controller;

import com.sweeth_clothes_store.dto.PaymentDTO;
import com.sweeth_clothes_store.model.Order;
import com.sweeth_clothes_store.service.OrderService;
import com.sweeth_clothes_store.service.PaymentService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/payment")
@RequiredArgsConstructor
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @Autowired
    private OrderService orderService;

    @GetMapping("/vn-pay")
    public ResponseEntity<PaymentDTO.VNPayResponse> pay(HttpServletRequest request) {
        return new ResponseEntity<>(paymentService.createVnPayPayment(request), HttpStatus.OK);
    }

    @GetMapping("/vn-pay-callback")
    public ResponseEntity<PaymentDTO.VNPayResponse> payCallbackHandler(HttpServletRequest request, @RequestParam int userID) {
        String status = request.getParameter("vnp_ResponseCode");
        if (status.equals("00")) {
            List<Order> order = orderService.getOrdersByUserID(userID);
            return new ResponseEntity<>(new PaymentDTO.VNPayResponse("00",
                    "Success",
                    "",
                    order.get(order.size() == 1 ? 0 : order.size() - 1)), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }
}
