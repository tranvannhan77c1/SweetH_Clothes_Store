package com.sweeth_clothes_store.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FeedbackDTOAdmin {
    private long id;
    private Integer rate;
    private String content;
    private Date createDate;
    private boolean status;
    private long accountId;
    private long productId;
}

