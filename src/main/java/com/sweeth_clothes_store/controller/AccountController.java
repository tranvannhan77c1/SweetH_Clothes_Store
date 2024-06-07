package com.sweeth_clothes_store.controller;

import com.sweeth_clothes_store.model.Account;
import com.sweeth_clothes_store.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/account")
public class AccountController {
    @Autowired
    private AccountService accountService;

    @PostMapping
    public ResponseEntity<Account> signUp(@RequestBody Account account) {
        try {
            if (account == null || account.getUsername() == null || account.getPassword() == null) {
                return ResponseEntity.badRequest().body(null);
            }
            Account createdAccount = accountService.addAccount(account);
            if (createdAccount == null) {
                return ResponseEntity.badRequest().body(null);
            }else {
                return ResponseEntity.ok(createdAccount);
            }

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }
}
