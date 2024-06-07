package com.sweeth_clothes_store.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.persistence.*;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Accounts")
public class Account {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "username", unique = true, nullable = false)
    private String username;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "email", nullable = false)
    private String email;

    @Column(name = "full_name")
    private String fullName;

    @Column(name = "phone")
    private String phone;

    @Column(name = "address")
    private String address;

    @Column(name = "role", nullable = false)
    private String role = "Customer"; // Giá trị mặc định

	@JsonIgnore
	@OneToMany(mappedBy = "account")
	private List<Favorite> favorites;

	@JsonIgnore
	@OneToMany(mappedBy = "account")
	private List<Feedback> feedbacks;

	@JsonIgnore
	@OneToMany(mappedBy = "account")
	private List<Order> orders;
}
