package com.sweeth_clothes_store.repository;

import com.sweeth_clothes_store.model.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {
    // Các phương thức tùy chỉnh có thể được thêm vào đây nếu cần
    Page<Product> findByColor(String color, Pageable pageable);
    Page<Product> findByCategory_Item_Id(int itemId, Pageable pageable);
    Page<Product> findByColorAndCategory_Item_Id(String color, int itemId, Pageable pageable);
    // Thêm phương thức tìm kiếm theo tên sản phẩm
    @Query("SELECT p FROM Product p WHERE LOWER(p.name) LIKE LOWER(CONCAT('%', :name, '%'))")
    Page<Product> findByNameContainingIgnoreCase(@Param("name") String name, Pageable pageable);
    // Sắp xếp sản phẩm theo giá tăng dần
    Page<Product> findAllByOrderByPriceAsc(Pageable pageable);
    // Sắp xếp sản phẩm theo giá giảm dần
    Page<Product> findAllByOrderByPriceDesc(Pageable pageable);
    // Tìm sp theo khoảng giá(min,max)
    @Query("SELECT p FROM Product p WHERE p.price BETWEEN :minPrice AND :maxPrice")
    Page<Product> findByPriceBetween(@Param("minPrice") BigDecimal minPrice, @Param("maxPrice") BigDecimal maxPrice, Pageable pageable);
}
