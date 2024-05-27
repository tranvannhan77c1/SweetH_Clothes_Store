package com.sweeth_clothes_store.repository;

import com.sweeth_clothes_store.model.OrderDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, Integer> {
    // Các phương thức tùy chỉnh có thể được thêm vào đây nếu cần
}
