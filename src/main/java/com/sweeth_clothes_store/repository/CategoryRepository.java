package com.sweeth_clothes_store.repository;

import com.sweeth_clothes_store.model.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Integer> {
    // Các phương thức tùy chỉnh có thể được thêm vào đây nếu cần
    boolean existsByName(String name);

    boolean existsByNameAndIdNot(String name, Long excludeId);

    List<Category> findByItemId(Integer itemId);
}
