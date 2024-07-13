package com.sweeth_clothes_store.repository;

import com.sweeth_clothes_store.model.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {
    // Các phương thức tùy chỉnh có thể được thêm vào đây nếu cần
    Page<Product> findByColor(String color, Pageable pageable);
    Page<Product> findByCategory_Item_Id(int itemId, Pageable pageable);
    Page<Product> findByColorAndCategory_Item_Id(String color, int itemId, Pageable pageable);


}
