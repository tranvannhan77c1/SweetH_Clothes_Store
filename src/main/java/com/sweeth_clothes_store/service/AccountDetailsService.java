package com.sweeth_clothes_store.service;

import java.util.Optional;

import com.sweeth_clothes_store.dto.AccountDTO;
import com.sweeth_clothes_store.mapper.AccountMapper;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.sweeth_clothes_store.model.Account;
import com.sweeth_clothes_store.model.AccountDetail;
import com.sweeth_clothes_store.repository.AccountRepository;

import jakarta.transaction.Transactional;

@Service
public class AccountDetailsService implements UserDetailsService {

	@Autowired
	private AccountRepository accountRepository;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Account account = accountRepository.findByUsername(username)
				.orElseThrow(() -> new UsernameNotFoundException("User not found with username: " + username));

		AccountDTO accountDTO = AccountMapper.toAccountDTO(account);

		return new AccountDetail(accountDTO);
//		return accountRepository.findByUsername(username)
//				.map(AccountDetail::new)
//				.orElseThrow(() -> new UsernameNotFoundException("User not found with username: " + username));

//		Optional<Account> account = accountRepository.findByUsername(username);
//		if (account.isPresent()) {
//			var accountObject = account.get();
//			return User.builder()
//					.username(accountObject.getUsername())
//					.password(accountObject.getPassword())
//					.roles(accountObject.getRole())
//					.build();
//		} else {
//			throw new UsernameNotFoundException(username);
//		}

//		Account account = accountRepository.findByUsername(username)
//				.orElseThrow(() -> new UsernameNotFoundException("User not found with username: " + username));
//
//		// Initialize roles or other lazy collections
//		Hibernate.initialize(account.getRole());
//
//		return new AccountDetail(account);
	}

//	@Transactional
//	public AccountDetail loadUserById(Integer id) {
//		Account account = accountRepository.findById(id)
//				.orElseThrow(() -> new UsernameNotFoundException("User not found with ID: " + id));
//		return new AccountDetail(account);
//	}

	// Optional: Role-specific logic if needed in the future
	private String getRoles(Account account) {
		if ("admin".equalsIgnoreCase(account.getRole())) {
			return "ROLE_ADMIN";
		}
		return "ROLE_USER";
	}
}
