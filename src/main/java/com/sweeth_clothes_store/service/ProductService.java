package com.sweeth_clothes_store.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import com.sweeth_clothes_store.model.Item;
import com.sweeth_clothes_store.repository.ItemRepository;
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

	@Autowired
	private ItemRepository itemRepository;
	
	public Page<ProductDTO> getProducts(Pageable pageable) {
		Page<Product> products = productRepository.findAll(pageable);
		return products.map(ProductMapper::toDTO);
	}
	
	public Optional<ProductDTO> getProductByID(int id) {
		Optional<Product> product = productRepository.findById(id);
        return product.map(ProductMapper::toDTO);
	}
	// Phương thức để lấy danh sách sản phẩm theo màu sắc
	public Page<ProductDTO> getProductsByColor(String color, Pageable pageable) {
		Page<Product> products = productRepository.findByColor(color, pageable);
		return products.map(ProductMapper::toDTO);
	}
	//lấy sp theo danh mục
	public Page<ProductDTO> getProductsByItem(int itemId, Pageable pageable) {
		Page<Product> products = productRepository.findByCategory_Item_Id(itemId, pageable);
		return products.map(ProductMapper::toDTO);
	}
	public Page<ProductDTO> getProductsByColorAndItem(String color, int itemId, Pageable pageable) {
		Page<Product> products = productRepository.findByColorAndCategory_Item_Id(color, itemId, pageable);
		return products.map(ProductMapper::toDTO);
	}

//	lay color san pham
	public List<String> getAllColor() {
		List<Product> product = productRepository.findAll();
		List<String> colors = new ArrayList<String>();
		for(Product color : product) {
			colors.add(color.getColor().trim());
		}

		return new ArrayList<String>(new HashSet<String>(colors));
	}

	public List<Item> getAllItems() {
		return itemRepository.findAll();
	}

}
