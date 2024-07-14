package com.sweeth_clothes_store.controller;

import java.util.List;
import java.util.Optional;

import com.sweeth_clothes_store.model.Item;
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
	
	@GetMapping("/public/landing")
	public ResponseEntity<Page<ProductDTO>> getAllProducts(@RequestParam int page, @RequestParam int limit) {
		Pageable pageable = PageRequest.of(page, limit);
		return new ResponseEntity<Page<ProductDTO>>(productService.getProducts(pageable), HttpStatus.OK);
	}
	
	@GetMapping("/public/{id}")
	public ResponseEntity<Optional<ProductDTO>> getSingleProduct(@PathVariable int id) {
		return new ResponseEntity<Optional<ProductDTO>>(productService.getProductByID(id), HttpStatus.OK);
	}
	// Endpoint để lấy danh sách sản phẩm theo màu sắc
	@GetMapping("/public/color/{color}")
	public ResponseEntity<Page<ProductDTO>> getProductsByColor(@PathVariable String color, @RequestParam int page, @RequestParam int limit) {
		Pageable pageable = PageRequest.of(page, limit);
		return new ResponseEntity<Page<ProductDTO>>(productService.getProductsByColor(color, pageable), HttpStatus.OK);
	}
	// lấy sp theo danh mục
	@GetMapping("/public/item/{itemId}")
	public ResponseEntity<Page<ProductDTO>> getProductsByItem(@PathVariable int itemId, @RequestParam int page, @RequestParam int limit) {
		Pageable pageable = PageRequest.of(page, limit);
		return new ResponseEntity<Page<ProductDTO>>(productService.getProductsByItem(itemId, pageable), HttpStatus.OK);
	}
	@GetMapping("/public/color/{color}/item/{itemId}")
	public ResponseEntity<Page<ProductDTO>> getProductsByColorAndItem(@PathVariable String color, @PathVariable int itemId, @RequestParam int page, @RequestParam int limit) {
		Pageable pageable = PageRequest.of(page, limit);
		return new ResponseEntity<Page<ProductDTO>>(productService.getProductsByColorAndItem(color, itemId, pageable), HttpStatus.OK);
	}

	@GetMapping("/public/allColor")
	public ResponseEntity<List<String>> getAllColor() {
		return new ResponseEntity<List<String>>(productService.getAllColor(), HttpStatus.OK);
	}

	@GetMapping("/public/allItem")
	public ResponseEntity<List<Item>> getAllItems() {
		return new ResponseEntity<List<Item>>(productService.getAllItems(), HttpStatus.OK	);
	}
}
