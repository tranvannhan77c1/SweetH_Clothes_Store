package com.sweeth_clothes_store.service;

import com.sweeth_clothes_store.model.Account;
import com.sweeth_clothes_store.repository.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class AccountServicev1 {
    @Autowired
    private AccountRepository accountRepository;

    private PasswordEncoder passwordEncoder;

    public AccountServicev1(AccountRepository accountRepository) {
        this.accountRepository = accountRepository;
        this.passwordEncoder = new BCryptPasswordEncoder();
    }

    public Account addAccount(Account data) {
        System.out.println("Adding new account: " + data);
        Account checkEmailDup = accountRepository.findByEmail(data.getEmail());
        Optional<Account> checkUsernameDup = accountRepository.findByUsername(data.getUsername());
        Account checkPhoneDup = accountRepository.findByPhone(data.getPhone());
        if (checkEmailDup == null && checkUsernameDup == null && checkPhoneDup == null) {
            return null;
        } else {
            data.setPassword(passwordEncoder.encode(data.getPassword()));
            return accountRepository.save(data);
        }
    }
}

