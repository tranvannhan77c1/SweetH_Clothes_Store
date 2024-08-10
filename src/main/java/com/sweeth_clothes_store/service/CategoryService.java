package com.sweeth_clothes_store.service;

import com.sweeth_clothes_store.dto.CategoryDTO;
import com.sweeth_clothes_store.mapper.CategoryMapper;
import com.sweeth_clothes_store.model.Category;
import com.sweeth_clothes_store.model.Item;
import com.sweeth_clothes_store.repository.CategoryRepository;
import com.sweeth_clothes_store.repository.ItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private ItemRepository itemRepository;


    public Page<CategoryDTO> getAllCategories(Pageable pageable) {
        Page<Category> categoryPage = categoryRepository.findAll(pageable);
        return categoryPage.map(CategoryMapper::toCategoryDTO);
    }

    public CategoryDTO getCategoryById(Integer id) {
        Category category = categoryRepository.findById(id).orElse(null);
        return CategoryMapper.toCategoryDTO(category);
    }

    public CategoryDTO createCategory(CategoryDTO categoryDTO) {
        Category category = CategoryMapper.toCategory(categoryDTO);
        Item item = itemRepository.findById(categoryDTO.getItemId())
                .orElseThrow(() -> new RuntimeException("Item not found with id: " + categoryDTO.getItemId()));
        category.setItem(item);

        category = categoryRepository.save(category);
        return CategoryMapper.toCategoryDTO(category);
    }
    public CategoryDTO updateCategory(Integer id, CategoryDTO categoryDTO) {
        if (!categoryRepository.existsById(id)) {
            return null;
        }
        Category category = CategoryMapper.toCategory(categoryDTO);
        category.setId(id);
        Item item = itemRepository.findById(categoryDTO.getItemId())
                .orElseThrow(() -> new RuntimeException("Item not found with id: " + categoryDTO.getItemId()));
        category.setItem(item);
        category = categoryRepository.save(category);
        return CategoryMapper.toCategoryDTO(category);
    }

    public void deleteCategory(Integer id) {
        categoryRepository.deleteById(id);
    }

    public List<CategoryDTO> getAllCategories() {
        List<Category> categories = categoryRepository.findAll();
        return categories.stream()
                .map(CategoryMapper::toCategoryDTO)
                .collect(Collectors.toList());
    }

    public boolean existsByName(String name, Long excludeId) {
        if (excludeId == null) {
            return categoryRepository.existsByName(name);
        } else {
            return categoryRepository.existsByNameAndIdNot(name, excludeId);
        }
    }
}
