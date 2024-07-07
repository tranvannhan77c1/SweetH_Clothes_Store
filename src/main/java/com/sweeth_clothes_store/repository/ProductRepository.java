package com.sweeth_clothes_store.repository;

import com.sweeth_clothes_store.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {
    // Các phương thức tùy chỉnh có thể được thêm vào đây nếu cần
    List<Product> findByColor(String color);
    List<Product> findByCategory_Item_Id(int itemId);
    List<Product> findByColorAndCategory_Item_Id(String color, int itemId);

}
