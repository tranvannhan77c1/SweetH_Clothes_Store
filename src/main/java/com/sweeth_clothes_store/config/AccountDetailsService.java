package com.sweeth_clothes_store.config;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.sweeth_clothes_store.model.Account;
import com.sweeth_clothes_store.repository.AccountRepository;


@Service
public class AccountDetailsService implements UserDetailsService {
	
	@Autowired
	private AccountRepository accountRepository;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Optional<Account> account = accountRepository.findByUsername(username);
		if(account.isPresent()) {
			return User.builder()
					.username(account.get().getUsername())
					.password(account.get().getPassword())
					.roles(getRoles(account.get()))
					.build();
		} else {
			throw new UsernameNotFoundException(username);
		}
		
	}

	private String getRoles(Account account) {
		if(account.getRole().equalsIgnoreCase("admin")) {
			return "ADMIN";
		}
		return "USER";
	}

}
