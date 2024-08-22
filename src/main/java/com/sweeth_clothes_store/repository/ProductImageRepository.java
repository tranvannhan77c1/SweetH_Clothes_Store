package com.sweeth_clothes_store.repository;

import com.sweeth_clothes_store.model.ProductImage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductImageRepository extends JpaRepository<ProductImage, Integer> {
    void deleteByProductId(Integer id);
    // Các phương thức tùy chỉnh có thể được thêm vào đây nếu cần
}
