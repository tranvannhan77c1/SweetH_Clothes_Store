package com.sweeth_clothes_store.controller;

import com.sweeth_clothes_store.dto.AccountDTO;
import com.sweeth_clothes_store.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
@RequestMapping("/api/v1/auth")
public class AuthController {

	@Autowired
	private AuthenticationManager authenticationManager;
	
	@Autowired
    private JwtTokenProvider tokenProvider;

	@Autowired
	private AccountService accountService;
	
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

	@PostMapping("/signup")
	public ResponseEntity<AccountDTO> signUp(@RequestBody AccountDTO accountDTO) {
		try {
			if (accountDTO == null || accountDTO.getUsername() == null || accountDTO.getPassword() == null || accountDTO.getEmail() == null) {
				return ResponseEntity.badRequest().body(null);
			}
			AccountDTO createdAccount = accountService.addAccount(accountDTO);
			if (createdAccount == null) {
				return ResponseEntity.status(HttpStatus.CONFLICT).body(null);
			} else {
				return ResponseEntity.ok(createdAccount);
			}
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		}
	}
}
