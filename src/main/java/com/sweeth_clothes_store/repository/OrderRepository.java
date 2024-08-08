package com.sweeth_clothes_store.repository;

import com.sweeth_clothes_store.model.Order;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Integer> {
    List<Order> findByAccount_id(int account_id);
    // Các phương thức tùy chỉnh có thể được thêm vào đây nếu cần
}
