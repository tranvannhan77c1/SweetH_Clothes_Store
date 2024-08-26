package com.sweeth_clothes_store.payload;

import com.sweeth_clothes_store.dto.AccountDTO;
import com.sweeth_clothes_store.model.Account;

import lombok.Data;

@Data
public class LoginResponse {
	private String accessToken;
    private String tokenType = "Bearer";
    private AccountDTO account;

    public LoginResponse(String accessToken, AccountDTO account) {
        this.accessToken = accessToken;
        this.account = account;
    }

}
