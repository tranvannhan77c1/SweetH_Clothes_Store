package com.sweeth_clothes_store.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.sweeth_clothes_store.dto.ProductDTO;
import com.sweeth_clothes_store.mapper.ProductMapper;
import com.sweeth_clothes_store.model.Product;
import com.sweeth_clothes_store.repository.ProductRepository;

@Service
public class ProductService {
	@Autowired
	private ProductRepository productRepository;
	
	public Page<ProductDTO> getLimitedProducts(Pageable pageable) {
		Page<Product> products = productRepository.findAll(pageable);
		return products.map(ProductMapper::toDTO);
	}
	
	public Optional<ProductDTO> getProductByID(int id) {
		Optional<Product> product = productRepository.findById(id);
        return product.map(ProductMapper::toDTO);
	}
}
