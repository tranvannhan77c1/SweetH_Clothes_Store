package com.sweeth_clothes_store.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sweeth_clothes_store.model.Account;
import com.sweeth_clothes_store.model.AccountDetail;
import com.sweeth_clothes_store.payload.LoginRequest;
import com.sweeth_clothes_store.payload.LoginResponse;
import com.sweeth_clothes_store.util.JwtTokenProvider;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
	
//	@GetMapping("/login")
//	public String login() {
//		return "customer/pages/login";
//	}
	@Autowired
	private AuthenticationManager authenticationManager;
	
	@Autowired
    private JwtTokenProvider tokenProvider;
	
	@PostMapping("/login")
	public LoginResponse login(@RequestBody LoginRequest login) {
		Authentication authentication = authenticationManager.authenticate(
				new UsernamePasswordAuthenticationToken(login.getUsername(), login.getPassword())
				);
		SecurityContextHolder.getContext().setAuthentication(authentication);
		
		AccountDetail accountDetail = (AccountDetail) authentication.getPrincipal();
        String jwt = tokenProvider.generateToken(accountDetail);
        Account account = accountDetail.getAccount();
        return new LoginResponse(jwt, account);

	}
}
