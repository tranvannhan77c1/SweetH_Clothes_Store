package com.sweeth_clothes_store.payload;

import com.sweeth_clothes_store.model.Account;

import lombok.Data;

@Data
public class LoginResponse {
	private String accessToken;
    private String tokenType = "Bearer";
    private Account account;

    public LoginResponse(String accessToken, Account account) {
        this.accessToken = accessToken;
        this.account = account;
    }

}
