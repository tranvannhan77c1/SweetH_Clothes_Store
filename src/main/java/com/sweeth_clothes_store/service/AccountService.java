package com.sweeth_clothes_store.service;

import com.sweeth_clothes_store.dto.AccountDTO;
import com.sweeth_clothes_store.dto.OrderDTO;
import com.sweeth_clothes_store.mapper.AccountMapper;
import com.sweeth_clothes_store.model.Account;
import com.sweeth_clothes_store.repository.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class AccountService {

    @Autowired
    private AccountRepository accountRepository;

    private PasswordEncoder passwordEncoder;

    @Autowired
    public AccountService(AccountRepository accountRepository) {
        this.accountRepository = accountRepository;
        this.passwordEncoder = new BCryptPasswordEncoder();
    }

    public Page<AccountDTO> getAllAccounts(Pageable pageable) {
        Page<Account> accountPage = accountRepository.findAll(pageable);
        return accountPage.map(AccountMapper::toAccountDTO);
    }

    public AccountDTO getAccountById(Integer id) {
        Account account = accountRepository.findById(id).orElse(null);
        return AccountMapper.toAccountDTO(account);
    }

    public AccountDTO createAccount(AccountDTO accountDTO) {
        Account account = AccountMapper.toAccount(accountDTO);
        account.setPassword(passwordEncoder.encode(account.getPassword()));
        account = accountRepository.save(account);
        return AccountMapper.toAccountDTO(account);
    }

    public AccountDTO updateAccount(Integer id, AccountDTO accountDTO) {
        if (!accountRepository.existsById(id)) {
            return null;
        }
        Account account = AccountMapper.toAccount(accountDTO);
        account.setId(id);

        // Mã hóa mật khẩu mới nếu được cung cấp
        if (accountDTO.getPassword() != null && !accountDTO.getPassword().isEmpty()) {
            account.setPassword(passwordEncoder.encode(accountDTO.getPassword()));
        } else {
            account.setPassword(accountRepository.findById(id).get().getPassword());
        }

        account = accountRepository.save(account);
        return AccountMapper.toAccountDTO(account);
    }

    public boolean changePassword(Integer id, String oldPassword, String newPassword) {
        Optional<Account> account = accountRepository.findById(id);
        if(passwordEncoder.matches(oldPassword, account.get().getPassword())) {
            account.get().setPassword(passwordEncoder.encode(newPassword));
            accountRepository.save(account.get());
            return true;
        } else {
            return false;
        }
    }

    public void deleteAccount(Integer id) {
        accountRepository.deleteById(id);
    }

    public List<AccountDTO> getAllAccounts() {
        List<Account> accounts = accountRepository.findAll();
        return accounts.stream()
                .map(AccountMapper::toAccountDTO)
                .collect(Collectors.toList());
    }

    public boolean existsByUsername(String username) {
        return accountRepository.existsByUsername(username);
    }

    public boolean existsByEmail(String email) {
        return accountRepository.existsByEmail(email);
    }

    public boolean existsByPhone(String phone) {
        return accountRepository.existsByPhone(phone);
    }
}
