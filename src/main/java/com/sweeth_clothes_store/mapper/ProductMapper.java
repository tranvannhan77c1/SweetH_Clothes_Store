package com.sweeth_clothes_store.mapper;

import java.util.stream.Collectors;
	
import com.sweeth_clothes_store.dto.ProductDTO;
import com.sweeth_clothes_store.model.Product;
import com.sweeth_clothes_store.model.ProductImage;
import com.sweeth_clothes_store.model.ProductSize;

public class ProductMapper {
	public static ProductDTO toDTO(Product product) {
		if(product == null) {
			return null;
		}
		ProductDTO dto = new ProductDTO();
		dto.setId(product.getId());
		dto.setThumbnailImage(product.getThumbnailImage());
		dto.setName(product.getName());
		dto.setPrice(product.getPrice());
		dto.setQuantity(product.getQuantity());
		dto.setBrand(product.getBrand());
		dto.setMadeIn(product.getMadeIn());
		dto.setColor(product.getColor());
		dto.setMaterial(product.getMaterial());
		dto.setDescription(product.getDescription());
		dto.setCategory(product.getCategory());
		
		dto.setFavorites(
				product.getFavorites().stream()
				.map(FavoriteMapper::toFavoriteDTO)
				.collect(Collectors.toList()));
		dto.setFeedbacks(
				product.getFeedbacks().stream()
				.map(FeedbackMapper::toFeedbackDTO)
				.collect(Collectors.toList()));
		dto.setProductImages(product.getProductImages().stream()
				.map(ProductImage::getImageUrl)
				.collect(Collectors.toList()));
		dto.setProductSizes(product.getProductSizes().stream()
				.map(ProductSize::getSize)
				.collect(Collectors.toList()));
		dto.setOrderDetails(product.getOrderDetails().stream()
				.map(OrderDetailMapper::toOrderDetailDTO)
				.collect(Collectors.toList()));
		return dto;
	}
}
