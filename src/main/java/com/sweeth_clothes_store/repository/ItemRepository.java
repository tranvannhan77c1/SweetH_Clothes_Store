package com.sweeth_clothes_store.repository;

import com.sweeth_clothes_store.model.Item;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ItemRepository extends JpaRepository<Item, Integer> {
    boolean existsByName(String name);

    boolean existsByNameAndIdNot(String name, Long excludeId);
}
