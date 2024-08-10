package com.sweeth_clothes_store.service;

import com.sweeth_clothes_store.dto.ItemDTO;
import com.sweeth_clothes_store.mapper.ItemMapper;
import com.sweeth_clothes_store.model.Item;
import com.sweeth_clothes_store.repository.ItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ItemService {
    @Autowired
    private ItemRepository itemRepository;

    public Page<ItemDTO> getAllItems(Pageable pageable) {
        Page<Item> itemPage = itemRepository.findAll(pageable);
        return itemPage.map(ItemMapper::toItemDTO);
    }

    public ItemDTO getItemById(Integer id) {
        Item item = itemRepository.findById(id).orElse(null);
        return ItemMapper.toItemDTO(item);
    }

    public ItemDTO createItem(ItemDTO itemDTO) {
        Item item = ItemMapper.toItem(itemDTO);
        item = itemRepository.save(item);
        return ItemMapper.toItemDTO(item);
    }

    public ItemDTO updateItem(Integer id, ItemDTO itemDTO) {
        if (!itemRepository.existsById(id)) {
            return null;
        }
        Item item = ItemMapper.toItem(itemDTO);
        item.setId(id);
        item = itemRepository.save(item);
        return ItemMapper.toItemDTO(item);
    }

    public void deleteItem(Integer id) {
        itemRepository.deleteById(id);
    }

    public List<ItemDTO> getAllItems() {
        List<Item> items = itemRepository.findAll();
        return items.stream()
                .map(ItemMapper::toItemDTO)
                .collect(Collectors.toList());
    }

    public boolean existsByName(String name) {
        return itemRepository.existsByName(name);
    }
}
