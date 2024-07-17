package com.sweeth_clothes_store.controller;


import com.sweeth_clothes_store.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class OtpController {

    @Autowired
    private EmailService emailService;

    @GetMapping("/send-otp")
    public String sendOtp(@RequestParam String email) {
        String otp = emailService.generateOTP();
        emailService.sendOtpEmail(email, otp);
        return "Mã Xác Nhận Đã Gửi Qua Email:  " + email;
    }
}
