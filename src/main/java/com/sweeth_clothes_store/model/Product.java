package com.sweeth_clothes_store.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Products")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "thumbnail_image")
    private String thumbnailImage;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "price", nullable = false)
    private BigDecimal price;

    @Column(name = "quantity", nullable = false)
    private Integer quantity;

    @Column(name = "brand")
    private String brand;

    @Column(name = "made_in")
    private String madeIn;

    @Column(name = "color")
    private String color;

    @Column(name = "material")
    private String material;

    @Column(name = "description", nullable = false)
    private String description;

	@ManyToOne
	@JoinColumn(name = "category_id", nullable = false)
	private Category category;

	@JsonIgnore
	@OneToMany(mappedBy = "product")
	private List<Favorite> favorites;

	@JsonIgnore
	@OneToMany(mappedBy = "product")
	private List<Feedback> feedbacks;

	@JsonIgnore
	@OneToMany(mappedBy = "product")
	private List<ProductImage> productImages;

    @JsonIgnore
    @OneToMany(mappedBy = "product")
    private List<ProductSize> productSizes;

	@JsonIgnore
	@OneToMany(mappedBy = "product")
	private List<OrderDetail> orderDetails;
}
