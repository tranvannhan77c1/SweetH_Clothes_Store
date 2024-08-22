package com.sweeth_clothes_store.service;

import com.sweeth_clothes_store.dto.ProductAdminDTO;
import com.sweeth_clothes_store.mapper.ProductAdminMapper;
import com.sweeth_clothes_store.model.Product;
import com.sweeth_clothes_store.model.ProductImage;
import com.sweeth_clothes_store.model.ProductSize;
import com.sweeth_clothes_store.repository.CategoryRepository;
import com.sweeth_clothes_store.repository.ProductImageRepository;
import com.sweeth_clothes_store.repository.ProductRepository;
import com.sweeth_clothes_store.repository.ProductSizeRepository;
import com.sweeth_clothes_store.util.ResourceNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

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

    public ProductAdminDTO createProduct(ProductAdminDTO productDTO) {
        Product product = ProductAdminMapper.toProduct(productDTO, categoryRepository);

        // Lưu Product
        product = productRepository.save(product);

        // Lưu ProductImages
//        for (ProductImage productImage : product.getProductImages()) {
//            productImage.setProduct(product);
//            productImageRepository.save(productImage);
//        }
//
//        // Lưu ProductSizes
//        for (ProductSize productSize : product.getProductSizes()) {
//            productSize.setProduct(product);
//            productSizeRepository.save(productSize);
//        }

        return ProductAdminMapper.toProductDTO(product);
    }

    public ProductAdminDTO updateProduct(Integer id, ProductAdminDTO productDTO) {
        if (!productRepository.existsById(id)) {
            throw new ResourceNotFoundException("Product not found");
        }
        Product product = ProductAdminMapper.toProduct(productDTO, categoryRepository);
        product.setId(id);

        // Cập nhật Product
        product = productRepository.save(product);

        // Cập nhật ProductImages
        productImageRepository.deleteByProductId(id);
        for (ProductImage productImage : product.getProductImages()) {
            productImage.setProduct(product);
            productImageRepository.save(productImage);
        }

        // Cập nhật ProductSizes
        productSizeRepository.deleteByProductId(id);
        for (ProductSize productSize : product.getProductSizes()) {
            productSize.setProduct(product);
            productSizeRepository.save(productSize);
        }

        return ProductAdminMapper.toProductDTO(product);
    }

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
}