package com.sweeth_clothes_store.dto;

import java.math.BigDecimal;
import java.util.List;

import com.sweeth_clothes_store.model.Category;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductDTO {
    private Integer id;
    private String thumbnailImage;
    private String name;
    private BigDecimal price;
    private Integer quantity;
    private String brand;
    private String madeIn;
    private String color;
    private String material;
    private String description;
	private Category category;
	private List<FavoriteDTO> favorites;
	private List<FeedbackDTO> feedbacks;
	private List<String> productImages;
    private List<String> productSizes;
	private List<OrderDetailDTO> orderDetails;
}
