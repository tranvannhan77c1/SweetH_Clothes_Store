package com.sweeth_clothes_store.repository;

import com.sweeth_clothes_store.model.ProductImage;
import com.sweeth_clothes_store.model.ProductSize;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductSizeRepository extends JpaRepository<ProductSize, Integer> {
    void deleteByProductId(Integer id);
    // Các phương thức tùy chỉnh có thể được thêm vào đây nếu cần
}
