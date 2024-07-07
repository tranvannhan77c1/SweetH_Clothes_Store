package com.sweeth_clothes_store.service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

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
	// Phương thức để lấy danh sách sản phẩm theo màu sắc
	public List<ProductDTO> getProductsByColor(String color) {
		List<Product> products = productRepository.findByColor(color);
		return products.stream().map(ProductMapper::toDTO).collect(Collectors.toList());
	}
	//lấy sp theo danh mục
	public List<ProductDTO> getProductsByItem(int itemId) {
		List<Product> products = productRepository.findByCategory_Item_Id(itemId);
		return products.stream().map(ProductMapper::toDTO).collect(Collectors.toList());
	}
	public List<ProductDTO> getProductsByColorAndItem(String color, int itemId) {
		List<Product> products = productRepository.findByColorAndCategory_Item_Id(color, itemId);
		return products.stream().map(ProductMapper::toDTO).collect(Collectors.toList());
	}

}
