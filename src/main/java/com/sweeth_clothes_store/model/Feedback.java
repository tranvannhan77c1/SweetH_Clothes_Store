package com.sweeth_clothes_store.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.persistence.*;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Feedbacks")
public class Feedback {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;

	@Column(name = "rate", nullable = false)
	private Integer rate;

	@Column(name = "content", nullable = false, length = 300)
	private String content;

	@Column(name = "create_date", nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date createDate;

	@Column(name = "status")
	private boolean status = true;

	@ManyToOne
	@JoinColumn(name = "account_id", nullable = false)
	private Account account;

	@ManyToOne
	@JoinColumn(name = "product_id", nullable = false)
	private Product product;
}

