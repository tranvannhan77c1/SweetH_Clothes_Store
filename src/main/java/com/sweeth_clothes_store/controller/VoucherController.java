package com.sweeth_clothes_store.controller;

import com.sweeth_clothes_store.dto.VoucherDTO;
import com.sweeth_clothes_store.service.VoucherService;
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
@RequestMapping("/api/vouchers")
public class VoucherController {

    @Autowired
    private VoucherService voucherService;

    @GetMapping
    public ResponseEntity<Page<VoucherDTO>> getAllVouchers(
            @PageableDefault(page = 0, size = 8, sort = "id", direction = Sort.Direction.ASC) Pageable pageable) {
        Page<VoucherDTO> vouchers = voucherService.getAllVouchers(pageable);
        return ResponseEntity.ok(vouchers);
    }

    @GetMapping("/{id}")
    public ResponseEntity<VoucherDTO> getVoucherById(@PathVariable Integer id) {
        VoucherDTO voucherDTO = voucherService.getVoucherById(id);
        if (voucherDTO == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(voucherDTO);
    }

    @GetMapping("/all")
    public List<VoucherDTO> getAllVouchers() {
        return voucherService.getAllVouchers();
    }

    @PostMapping
    public ResponseEntity<VoucherDTO> createVoucher(@RequestBody VoucherDTO voucherDTO) {
        VoucherDTO createdVoucher = voucherService.createVoucher(voucherDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdVoucher);
    }

    @PutMapping("/{id}")
    public ResponseEntity<VoucherDTO> updateVoucher(@PathVariable Integer id, @RequestBody VoucherDTO voucherDTO) {
        VoucherDTO updatedVoucher;
        try {
            updatedVoucher = voucherService.updateVoucher(id, voucherDTO);
        } catch (ResourceNotFoundException e) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(updatedVoucher);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteVoucher(@PathVariable Integer id) {
        try {
            voucherService.deleteVoucher(id);
        } catch (ResourceNotFoundException e) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/check-code")
    public ResponseEntity<Boolean> checkVoucherCode(
            @RequestParam("code") String code,
            @RequestParam(value = "excludeId", required = false) Long excludeId) {
        boolean exists = voucherService.existsByCode(code, excludeId);
        return ResponseEntity.ok(exists);
    }
}
