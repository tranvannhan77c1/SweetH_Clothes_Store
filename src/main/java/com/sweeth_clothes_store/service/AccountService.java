package com.sweeth_clothes_store.service;

import com.sweeth_clothes_store.dto.AccountDTO;
import com.sweeth_clothes_store.dto.OrderDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface AccountService {
    AccountDTO addAccount(AccountDTO accountDTO);
    AccountDTO updateAccount(Integer id, AccountDTO accountDTO);
    void deleteAccount(Integer id);
    AccountDTO getAccountById(Integer id);
    Page<AccountDTO> getAllAccounts(Pageable pageable);
    List<AccountDTO> getAllAccounts();


}
