package com.sweeth_clothes_store.repository;

import com.sweeth_clothes_store.model.Account;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AccountRepository extends JpaRepository<Account, Integer> {
    // Các phương thức tùy chỉnh có thể được thêm vào đây nếu cần

    Account findByEmail(String email);

    Optional<Account> findByUsername(String username);

    Account findByPhone(String phone);

    boolean existsByUsername(String username);

    boolean existsByEmail(String email);

    boolean existsByPhone(String phone);
}
