package com.sweeth_clothes_store.service;

import com.sweeth_clothes_store.dto.VoucherDTO;
import com.sweeth_clothes_store.mapper.VoucherMapper;
import com.sweeth_clothes_store.model.Voucher;
import com.sweeth_clothes_store.repository.VoucherRepository;
import com.sweeth_clothes_store.util.ResourceNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class VoucherService {
    @Autowired
    private VoucherRepository voucherRepository;

    public Page<VoucherDTO> getAllVouchers(Pageable pageable) {
        Page<Voucher> voucherPage = voucherRepository.findAll(pageable);
        return voucherPage.map(VoucherMapper::toVoucherDTO);
    }

    public VoucherDTO getVoucherById(Integer id) {
        Voucher voucher = voucherRepository.findById(id).orElse(null);
        return VoucherMapper.toVoucherDTO(voucher);
    }

    public VoucherDTO createVoucher(VoucherDTO voucherDTO) {
        Voucher voucher = VoucherMapper.toVoucher(voucherDTO);
        voucher = voucherRepository.save(voucher);
        return VoucherMapper.toVoucherDTO(voucher);
    }

    public VoucherDTO updateVoucher(Integer id, VoucherDTO voucherDTO) {
        if (!voucherRepository.existsById(id)) {
            throw new ResourceNotFoundException("Voucher not found");
        }
        Voucher voucher = VoucherMapper.toVoucher(voucherDTO);
        voucher.setId(id);
        voucher = voucherRepository.save(voucher);
        return VoucherMapper.toVoucherDTO(voucher);
    }

    public void deleteVoucher(Integer id) {
        if (!voucherRepository.existsById(id)) {
            throw new ResourceNotFoundException("Voucher not found");
        }
        voucherRepository.deleteById(id);
    }

    public List<VoucherDTO> getAllVouchers() {
        List<Voucher> vouchers = voucherRepository.findAll();
        return vouchers.stream()
                .map(VoucherMapper::toVoucherDTO)
                .collect(Collectors.toList());
    }

    public boolean existsByCode(String code, Long excludeId) {
        if (excludeId == null) {
            return voucherRepository.existsByCode(code);
        } else {
            return voucherRepository.existsByCodeAndIdNot(code, excludeId);
        }
    }
}
