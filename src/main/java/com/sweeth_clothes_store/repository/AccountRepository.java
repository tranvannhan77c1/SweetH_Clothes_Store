package com.sweeth_clothes_store.repository;

import com.sweeth_clothes_store.model.Account;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AccountRepository extends JpaRepository<Account, Integer> {
    // Các phương thức tùy chỉnh có thể được thêm vào đây nếu cần
    Account save(Account account);

    Account findByEmail(String email);

    Account findByUsername(String username);

    Account findByPhone(String phone);
}
