package com.sweeth_clothes_store.mapper;

import com.sweeth_clothes_store.dto.VoucherDTO;
import com.sweeth_clothes_store.model.Voucher;

import java.time.LocalDateTime;

public class VoucherMapper {
    public static VoucherDTO toVoucherDTO(Voucher voucher) {
        if (voucher == null) {
            return null;
        }
        VoucherDTO dto = new VoucherDTO();
        dto.setId(voucher.getId());
        dto.setCode(voucher.getCode());
        dto.setDiscountAmount(voucher.getDiscountAmount());
        dto.setCondition(voucher.getCondition());
        dto.setValidFrom(voucher.getValidFrom());
        dto.setValidTo(voucher.getValidTo());
        dto.setCreateDate(voucher.getCreateDate());
        return dto;
    }

    public static Voucher toVoucher(VoucherDTO dto) {
        if (dto == null) {
            return null;
        }
        Voucher voucher = new Voucher();
        voucher.setId(dto.getId());
        voucher.setCode(dto.getCode());
        voucher.setDiscountAmount(dto.getDiscountAmount());
        voucher.setCondition(dto.getCondition());
        voucher.setValidFrom(dto.getValidFrom());
        voucher.setValidTo(dto.getValidTo());
        voucher.setCreateDate(dto.getCreateDate());
        return voucher;
    }
}
