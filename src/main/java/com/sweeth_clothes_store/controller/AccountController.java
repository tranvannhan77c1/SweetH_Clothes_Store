package com.sweeth_clothes_store.controller;

import com.sweeth_clothes_store.dto.AccountDTO;
import com.sweeth_clothes_store.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/account")
@CrossOrigin(origins = "*")
public class AccountController {
    @Autowired
    private AccountService accountService;

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
    @GetMapping("/{id}")
    public ResponseEntity<AccountDTO> getAccountById(@PathVariable Integer id) {
        try {
            AccountDTO accountDTO = accountService.getAccountById(id);
            if (accountDTO != null) {
                return ResponseEntity.ok(accountDTO);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<AccountDTO> updateAccount(@PathVariable Integer id, @RequestBody AccountDTO accountDTO) {
        try {
            AccountDTO updatedAccount = accountService.updateAccount(id, accountDTO);
            if (updatedAccount != null) {
                return ResponseEntity.ok(updatedAccount);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteAccount(@PathVariable Integer id) {
        try {
            accountService.deleteAccount(id);
            return ResponseEntity.noContent().build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

//    @GetMapping
//    public ResponseEntity<List<AccountDTO>> getAllAccounts() {
//        try {
//            List<AccountDTO> accounts = accountService.getAllAccounts();
//            return ResponseEntity.ok(accounts);
//        } catch (Exception e) {
//            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
//        }
//    }

    @GetMapping
    public ResponseEntity<Page<AccountDTO>> getAllAccounts(
            @PageableDefault(page = 0, size = 8, sort = "id", direction = Sort.Direction.ASC) Pageable pageable) {
        Page<AccountDTO> accounts = accountService.getAllAccounts(pageable);
        return ResponseEntity.ok(accounts);
    }
}



