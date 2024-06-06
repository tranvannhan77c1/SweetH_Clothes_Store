package com.sweeth_clothes_store.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
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
}
