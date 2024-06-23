package com.sweeth_clothes_store.service;

import com.sweeth_clothes_store.model.Account;
import com.sweeth_clothes_store.repository.AccountRepository;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AccountService {
    @Autowired
    private AccountRepository accountRepository;
    
    private PasswordEncoder passwordEncoder;
    
    public AccountService(AccountRepository accountRepository) {
        this.accountRepository = accountRepository;
        this.passwordEncoder = new BCryptPasswordEncoder();
    }

    public Account addAccount(Account data) {
        System.out.println("Adding new account: " + data);
        Account checkEmailDup = accountRepository.findByEmail(data.getEmail());
        Optional<Account> checkUsernameDup = accountRepository.findByUsername(data.getUsername());
        Account checkPhoneDup = accountRepository.findByPhone(data.getPhone());
        if (checkEmailDup == null && checkUsernameDup == null && checkPhoneDup == null) {
        	data.setPassword(passwordEncoder.encode(data.getPassword()));
            return accountRepository.save(data);
        } else {
            return null;
        }
    }
}

