package com.sweeth_clothes_store.mapper;

import com.sweeth_clothes_store.dto.FeedbackDTO;
import com.sweeth_clothes_store.model.Feedback;

public class FeedbackMapper {
	public static FeedbackDTO toFeedbackDTO(Feedback feedback) {
		if(feedback == null) {
			return null;
		}
		
		FeedbackDTO dto = new FeedbackDTO();
		dto.setId(feedback.getId());
		dto.setRate(feedback.getRate());
		dto.setContent(feedback.getContent());
		dto.setCreateDate(feedback.getCreateDate());
		dto.setStatus(feedback.isStatus());
		dto.setAccount(feedback.getAccount());
		return dto;
	}
}
