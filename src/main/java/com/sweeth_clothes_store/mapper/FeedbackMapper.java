package com.sweeth_clothes_store.mapper;

import com.sweeth_clothes_store.dto.FeedbackDTO;
import com.sweeth_clothes_store.model.Account;
import com.sweeth_clothes_store.model.Feedback;
import com.sweeth_clothes_store.model.Product;

public class FeedbackMapper {
	public static FeedbackDTO toFeedbackDTO(Feedback feedback) {
		if (feedback == null) {
			return null;
		}
		FeedbackDTO dto = new FeedbackDTO();
		dto.setId(feedback.getId());
		dto.setRate(feedback.getRate());
		dto.setContent(feedback.getContent());
		dto.setCreateDate(feedback.getCreateDate());
		dto.setStatus(feedback.isStatus());
		dto.setAccountId(feedback.getAccount().getId());
		dto.setProductId(feedback.getProduct().getId());
		dto.setAccountName(feedback.getAccount().getFullName());
		dto.setProductName(feedback.getProduct().getName());
		return dto;
	}

	public static Feedback toFeedback(FeedbackDTO dto, Account account, Product product) {
		if (dto == null) {
			return null;
		}
		Feedback feedback = new Feedback();
		feedback.setId(dto.getId());
		feedback.setRate(dto.getRate());
		feedback.setContent(dto.getContent());
		feedback.setCreateDate(dto.getCreateDate());
		feedback.setStatus(dto.isStatus());
		feedback.setAccount(account);
		feedback.setProduct(product);
		return feedback;
	}
}
