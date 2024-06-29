package com.sweeth_clothes_store.dto;

import java.util.Date;

import com.sweeth_clothes_store.model.Account;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FeedbackDTO {
	private long id;
	private Integer rate;
	private String content;
	private Date createDate;
	private Boolean status;
	private Account account;
}
