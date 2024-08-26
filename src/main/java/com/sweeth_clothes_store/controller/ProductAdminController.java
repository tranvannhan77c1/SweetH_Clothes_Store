package com.sweeth_clothes_store.controller;

import com.sweeth_clothes_store.dto.ProductAdminDTO;
import com.sweeth_clothes_store.service.ProductAdminService;
import com.sweeth_clothes_store.service.ProductService;
import com.sweeth_clothes_store.util.ResourceNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/products")
public class ProductAdminController {

    @Autowired
    private ProductAdminService productService;


    @GetMapping
    public ResponseEntity<Page<ProductAdminDTO>> getAllProducts(
            @PageableDefault(page = 0, size = 5, sort = "id", direction = Sort.Direction.ASC) Pageable pageable) {
        Page<ProductAdminDTO> products = productService.getAllProducts(pageable);
        return ResponseEntity.ok(products);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProductAdminDTO> getProductById(@PathVariable Integer id) {
        ProductAdminDTO productDTO = productService.getProductById(id);
        if (productDTO == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(productDTO);
    }

    @GetMapping("/all")
    public List<ProductAdminDTO> getAllProducts() {
        return productService.getAllProducts();
    }

    @PostMapping
    public ResponseEntity<ProductAdminDTO> createProduct(@RequestBody ProductAdminDTO productDTO) {
        ProductAdminDTO createdProduct = productService.createProduct(productDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdProduct);
    }

    @PutMapping("/{id}")
    public ResponseEntity<ProductAdminDTO> updateProduct(@PathVariable Integer id, @RequestBody ProductAdminDTO productDTO) {
        ProductAdminDTO updatedProduct = productService.updateProduct(id, productDTO);
        return ResponseEntity.ok(updatedProduct);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteProduct(@PathVariable Integer id) {
        try {
            productService.deleteProduct(id);
        } catch (ResourceNotFoundException e) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/check-name")
    public ResponseEntity<Boolean> checkProductName(
            @RequestParam("name") String name,
            @RequestParam(value = "excludeId", required = false) Long excludeId) {
        boolean exists = productService.existsByName(name, excludeId);
        return ResponseEntity.ok(exists);
    }
}

