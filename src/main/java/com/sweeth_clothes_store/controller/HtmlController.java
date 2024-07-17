package com.sweeth_clothes_store.controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HtmlController {

    @GetMapping("/otp-form")
    public String otpForm() {
        return "customer/otp_form"; // This will resolve to otp_form.html
    }
}
