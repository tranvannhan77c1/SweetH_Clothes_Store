package com.sweeth_clothes_store.mapper;

import com.sweeth_clothes_store.dto.AccountDTO;
import com.sweeth_clothes_store.model.Account;

public class AccountMapper {

    // Chuyển đổi từ Account entity sang AccountDTO
    public static AccountDTO toAccountDTO(Account account) {
        if (account == null) {
            return null;
        }

        AccountDTO dto = new AccountDTO();
        dto.setId(account.getId());
        dto.setUsername(account.getUsername());
        dto.setPassword(account.getPassword());
        dto.setEmail(account.getEmail());
        dto.setFullName(account.getFullName());
        dto.setPhone(account.getPhone());
        dto.setAddress(account.getAddress());
        dto.setRole(account.getRole());

        return dto;
    }

    // Chuyển đổi từ AccountDTO sang Account model
    public static Account toAccount(AccountDTO dto) {
        if (dto == null) {
            return null;
        }

        Account account = new Account();
        account.setId(dto.getId());
        account.setUsername(dto.getUsername());
        account.setPassword(dto.getPassword());
        account.setEmail(dto.getEmail());
        account.setFullName(dto.getFullName());
        account.setPhone(dto.getPhone());
        account.setAddress(dto.getAddress());
        account.setRole(dto.getRole());

        return account;
    }
}
