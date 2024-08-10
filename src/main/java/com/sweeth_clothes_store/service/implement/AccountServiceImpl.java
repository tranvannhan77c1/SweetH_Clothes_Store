//package com.sweeth_clothes_store.service.implement;
//
//import com.sweeth_clothes_store.dto.AccountDTO;
//import com.sweeth_clothes_store.mapper.AccountMapper;
//import com.sweeth_clothes_store.model.Account;
//import com.sweeth_clothes_store.repository.AccountRepository;
//import com.sweeth_clothes_store.service.AccountService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.data.domain.Page;
//import org.springframework.data.domain.Pageable;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//import org.springframework.security.crypto.password.PasswordEncoder;
//import org.springframework.stereotype.Service;
//
//import java.util.List;
//import java.util.Optional;
//import java.util.stream.Collectors;
//
//@Service
//public class AccountServiceImpl implements AccountService {
//
//    private final AccountRepository accountRepository;
//    private final PasswordEncoder passwordEncoder;
//
//    @Autowired
//    public AccountServiceImpl(AccountRepository accountRepository) {
//        this.accountRepository = accountRepository;
//        this.passwordEncoder = new BCryptPasswordEncoder();
//    }
//
//    @Override
//    public Page<AccountDTO> getAllAccounts(Pageable pageable) {
//        Page<Account> accountPage = accountRepository.findAll(pageable);
//        return accountPage.map(AccountMapper::toAccountDTO);
//    }
//    @Override
//    public List<AccountDTO> getAllAccounts() {
//        List<Account> accounts = accountRepository.findAll();
//        return accounts.stream()
//                .map(AccountMapper::toAccountDTO)
//                .collect(Collectors.toList());
//    }
//
//    @Override
//    public AccountDTO getAccountById(Integer id) {
//        Account account = accountRepository.findById(id).orElse(null);
//        return AccountMapper.toAccountDTO(account);
//    }
//
//    @Override
//    public AccountDTO addAccount(AccountDTO accountDTO) {
//        Account data = AccountMapper.toAccount(accountDTO);
////        System.out.println("Adding new account: " + data);
//        Account checkEmailDup = accountRepository.findByEmail(data.getEmail());
//        Optional<Account> checkUsernameDup = accountRepository.findByUsername(data.getUsername());
//        Account checkPhoneDup = accountRepository.findByPhone(data.getPhone());
//        if (checkEmailDup != null || checkUsernameDup.isPresent() || checkPhoneDup != null) {
//            throw new RuntimeException("Duplicate email, username or phone");
//        } else {
//            data.setPassword(passwordEncoder.encode(data.getPassword()));
//            Account savedAccount = accountRepository.save(data);
//            return AccountMapper.toAccountDTO(savedAccount);
//        }
//    }
//
//    @Override
//    public AccountDTO updateAccount(Integer id, AccountDTO accountDTO) {
//        Account account = accountRepository.findById(id)
//                .orElseThrow(() -> new RuntimeException("Account not found"));
//        Account updatedAccount = AccountMapper.toAccount(accountDTO);
//        updatedAccount.setId(account.getId());
//        if (!updatedAccount.getPassword().equals(account.getPassword())) {
//            updatedAccount.setPassword(passwordEncoder.encode(updatedAccount.getPassword()));
//        }
//        updatedAccount = accountRepository.save(updatedAccount);
//        return AccountMapper.toAccountDTO(updatedAccount);
//    }
//
//    @Override
//    public void deleteAccount(Integer id) {
//        accountRepository.deleteById(id);
//    }
//}
