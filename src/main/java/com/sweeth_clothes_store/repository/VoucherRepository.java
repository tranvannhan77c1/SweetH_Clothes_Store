package com.sweeth_clothes_store.repository;

import com.sweeth_clothes_store.model.Voucher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VoucherRepository extends JpaRepository<Voucher, Integer> {
    boolean existsByCode(String code);

    boolean existsByCodeAndIdNot(String name, Long excludeId);
}
