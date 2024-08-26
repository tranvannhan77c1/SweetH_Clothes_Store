package com.sweeth_clothes_store.service;

import com.sweeth_clothes_store.dto.ProductAdminDTO;
import com.sweeth_clothes_store.dto.ProductImageDTO;
import com.sweeth_clothes_store.dto.ProductSizeDTO;
import com.sweeth_clothes_store.mapper.ProductAdminMapper;
import com.sweeth_clothes_store.mapper.ProductImageMapper;
import com.sweeth_clothes_store.mapper.ProductSizeMapper;
import com.sweeth_clothes_store.model.Category;
import com.sweeth_clothes_store.model.Product;
import com.sweeth_clothes_store.model.ProductImage;
import com.sweeth_clothes_store.model.ProductSize;
import com.sweeth_clothes_store.repository.CategoryRepository;
import com.sweeth_clothes_store.repository.ProductImageRepository;
import com.sweeth_clothes_store.repository.ProductRepository;
import com.sweeth_clothes_store.repository.ProductSizeRepository;
import com.sweeth_clothes_store.util.ResourceNotFoundException;
import jakarta.transaction.Transactional;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ProductAdminService {

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private ProductImageRepository productImageRepository;

    @Autowired
    private ProductSizeRepository productSizeRepository;

    public Page<ProductAdminDTO> getAllProducts(Pageable pageable) {
        Page<Product> productPage = productRepository.findAll(pageable);
        return productPage.map(ProductAdminMapper::toProductDTO);
    }

    public ProductAdminDTO getProductById(Integer id) {
        Product product = productRepository.findById(id).orElse(null);
        return ProductAdminMapper.toProductDTO(product);
    }


    @Transactional
    public ProductAdminDTO createProduct(ProductAdminDTO productDTO) {
        Product product = ProductAdminMapper.toProduct(productDTO);

        Category category = categoryRepository.findById(productDTO.getCategoryId())
                .orElseThrow(() -> new ResourceNotFoundException("Category not found with id: " + productDTO.getCategoryId()));
        product.setCategory(category);

        product = productRepository.save(product);

        List<ProductImage> images = new ArrayList<>();
        for (ProductImageDTO imageDTO : productDTO.getProductImages()) {
            ProductImage productImage = new ProductImage();
            productImage.setImageUrl(imageDTO.getImageUrl());
            productImage.setProduct(product);
            images.add(productImageRepository.save(productImage));
        }
        product.setProductImages(images);  // Cập nhật danh sách hình ảnh trong Product

        List<ProductSize> sizes = new ArrayList<>();
        for (ProductSizeDTO sizeDTO : productDTO.getProductSizes()) {
            ProductSize productSize = new ProductSize();
            productSize.setSize(sizeDTO.getSize());
            productSize.setQuantity(sizeDTO.getQuantity());
            productSize.setProduct(product);
            sizes.add(productSizeRepository.save(productSize));
        }
        product.setProductSizes(sizes);  // Cập nhật danh sách kích thước trong Product

        // Tải lại sản phẩm sau khi lưu để đảm bảo các liên kết được nạp đầy đủ
        product = productRepository.findById(product.getId()).orElseThrow(() -> new ResourceNotFoundException("Product not found"));

        System.out.println(product.getProductImages().size());
        System.out.println(product.getProductSizes().size());

        // Ánh xạ lại từ Product sang ProductAdminDTO
        return ProductAdminMapper.toProductDTO(product);
    }

    @Transactional
    public ProductAdminDTO updateProduct(Integer id, ProductAdminDTO productDTO) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Product not found with id: " + id));

        // Cập nhật các trường của Product
        product.setThumbnailImage(productDTO.getThumbnailImage());
        product.setName(productDTO.getName());
        product.setPrice(productDTO.getPrice());
        product.setQuantity(productDTO.getQuantity());
        product.setBrand(productDTO.getBrand());
        product.setMadeIn(productDTO.getMadeIn());
        product.setColor(productDTO.getColor());
        product.setMaterial(productDTO.getMaterial());
        product.setDescription(productDTO.getDescription());

        // Cập nhật Category nếu cần
        Category category = categoryRepository.findById(productDTO.getCategoryId())
                .orElseThrow(() -> new ResourceNotFoundException("Category not found with id: " + productDTO.getCategoryId()));
        product.setCategory(category);

        // Xóa các ProductImage cũ bằng cách làm trống danh sách trước
        product.getProductImages().clear();
        List<ProductImage> images = new ArrayList<>();
        for (ProductImageDTO imageDTO : productDTO.getProductImages()) {
            ProductImage productImage = new ProductImage();
            productImage.setImageUrl(imageDTO.getImageUrl());
            productImage.setProduct(product);
            images.add(productImage);
        }
        product.getProductImages().addAll(images);

        // Xóa các ProductSize cũ bằng cách làm trống danh sách trước
        product.getProductSizes().clear();
        List<ProductSize> sizes = new ArrayList<>();
        for (ProductSizeDTO sizeDTO : productDTO.getProductSizes()) {
            ProductSize productSize = new ProductSize();
            productSize.setSize(sizeDTO.getSize());
            productSize.setQuantity(sizeDTO.getQuantity());
            productSize.setProduct(product);
            sizes.add(productSize);
        }
        product.getProductSizes().addAll(sizes);

        // Lưu lại sản phẩm đã cập nhật
        product = productRepository.save(product);

        // Trả về DTO
        return ProductAdminMapper.toProductDTO(product);
    }

    @Transactional
    public void deleteProduct(Integer id) {
        if (!productRepository.existsById(id)) {
            throw new ResourceNotFoundException("Product not found");
        }

        productImageRepository.deleteByProductId(id);
        productSizeRepository.deleteByProductId(id);

        productRepository.deleteById(id);
    }


    public List<ProductAdminDTO> getAllProducts() {
        List<Product> products = productRepository.findAll();
        return products.stream()
                .map(ProductAdminMapper::toProductDTO)
                .collect(Collectors.toList());
    }

    public boolean existsByName(String name, Long excludeId) {
        if (excludeId == null) {
            return productRepository.existsByName(name);
        } else {
            return productRepository.existsByNameAndIdNot(name, excludeId);
        }
    }
}