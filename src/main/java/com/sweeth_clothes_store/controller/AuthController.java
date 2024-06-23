package com.sweeth_clothes_store.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AuthController {
	
	@GetMapping("/login")
	public String login() {
		return "customer/pages/login";
	}
}
