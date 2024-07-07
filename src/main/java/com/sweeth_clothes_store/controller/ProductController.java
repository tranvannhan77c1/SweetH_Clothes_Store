package com.sweeth_clothes_store.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sweeth_clothes_store.dto.ProductDTO;
import com.sweeth_clothes_store.service.ProductService;

@RestController
@RequestMapping("/api/v1/product")
public class ProductController {
	@Autowired
	private ProductService productService;
	
	@GetMapping("/landing")
	public ResponseEntity<Page<ProductDTO>> getAllProducts(@RequestParam int page, @RequestParam int limit) {
		Pageable pageable = PageRequest.of(page, limit);
		return new ResponseEntity<Page<ProductDTO>>(productService.getLimitedProducts(pageable), HttpStatus.OK);
	}
	
	@GetMapping("/{id}")
	public ResponseEntity<Optional<ProductDTO>> getSingleProduct(@PathVariable int id) {
		return new ResponseEntity<Optional<ProductDTO>>(productService.getProductByID(id), HttpStatus.OK);
	}
	// Endpoint để lấy danh sách sản phẩm theo màu sắc
	@GetMapping("/color/{color}")
	public ResponseEntity<List<ProductDTO>> getProductsByColor(@PathVariable String color) {
		return new ResponseEntity<List<ProductDTO>>(productService.getProductsByColor(color), HttpStatus.OK);
	}
	// lấy sp theo danh mục
	@GetMapping("/item/{itemId}")
	public ResponseEntity<List<ProductDTO>> getProductsByItem(@PathVariable int itemId) {
		List<ProductDTO> products = productService.getProductsByItem(itemId);
		return new ResponseEntity<>(products, HttpStatus.OK);
	}
	@GetMapping("/color/{color}/item/{itemId}")
	public ResponseEntity<List<ProductDTO>> getProductsByColorAndItem(@PathVariable String color, @PathVariable int itemId) {
		List<ProductDTO> products = productService.getProductsByColorAndItem(color, itemId);
		return new ResponseEntity<>(products, HttpStatus.OK);
	}
}
