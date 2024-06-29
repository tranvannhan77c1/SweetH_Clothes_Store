package com.sweeth_clothes_store.mapper;

import com.sweeth_clothes_store.dto.FavoriteDTO;
import com.sweeth_clothes_store.model.Favorite;

public class FavoriteMapper {
	public static FavoriteDTO toFavoriteDTO(Favorite favorite) {
        if (favorite == null) {
            return null;
        }

        FavoriteDTO favoriteDTO = new FavoriteDTO();
        favoriteDTO.setId(favorite.getId());
        favoriteDTO.setAccount(favorite.getAccount().getEmail());

        return favoriteDTO;
    }
}
