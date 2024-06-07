package com.sweeth_clothes_store.service;

import com.sweeth_clothes_store.model.Account;
import com.sweeth_clothes_store.repository.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AccountService {
    @Autowired
    private AccountRepository accountRepository;

    public Account addAccount(Account data) {
        System.out.println("Adding new account" + data);
        Account checkDup = accountRepository.findByEmail(data.getEmail());
        if (checkDup  == null) {
            return accountRepository.save(data);
        } else{
            return null;
        }
    }
}
