package com.sweeth_clothes_store.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.sweeth_clothes_store.service.AccountDetailsService;
import com.sweeth_clothes_store.util.JwtAuthenticationFilter;
@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {
	
	@Autowired
	private AccountDetailsService accountDetailsService;
	
	@Bean
	protected JwtAuthenticationFilter jwtAuthenticationFilter() {
		return new JwtAuthenticationFilter();
	}
		
	@Bean
	protected SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http.csrf(httpSecurityCsrfConfigurer -> httpSecurityCsrfConfigurer.disable());

		http
        .authorizeHttpRequests(authorizeHttpRequests -> {
        	authorizeHttpRequests.requestMatchers("/css/**",
            		"/img/**",
            		"/js/**",
            		"/scss/**",
            		"/vendors/**",
					"/api/v1/customer/orders/createOrder"
			).permitAll();
			//LỰC
			authorizeHttpRequests.requestMatchers("/api/v1/product/public/**").permitAll();
			authorizeHttpRequests.requestMatchers("/api/v1/auth/login").permitAll();
			authorizeHttpRequests.requestMatchers("/api/v1/auth/signup").permitAll();
			authorizeHttpRequests.requestMatchers("/api/v1/customer/**").hasAnyRole("CUSTOMER", "ADMIN");
			authorizeHttpRequests.requestMatchers("/api/orders/**").hasAnyRole("ADMIN", "CUSTOMER", "STAFF");
			authorizeHttpRequests.requestMatchers("/api/v1/payment/**").hasAnyRole("ADMIN", "CUSTOMER");
			authorizeHttpRequests.requestMatchers("/api/accounts/update/**").hasAnyRole("ADMIN", "CUSTOMER");
			//LỰC

			//NHÂN
			// ADMIN STAFF có thể GET từ /api/statistics/**
			authorizeHttpRequests.requestMatchers(HttpMethod.GET, "/api/statistics/**").hasAnyRole("ADMIN", "STAFF");

			// Chỉ STAFF mới có thể GET từ /api/items/**
			authorizeHttpRequests.requestMatchers(HttpMethod.GET, "/api/items/**").hasAnyRole("ADMIN", "STAFF");
			// Chỉ ADMIN mới có thể thực hiện POST, PUT, DELETE từ /api/items/**
			authorizeHttpRequests.requestMatchers(HttpMethod.POST, "/api/items/**").hasRole("ADMIN");
			authorizeHttpRequests.requestMatchers(HttpMethod.PUT, "/api/items/**").hasRole("ADMIN");
			authorizeHttpRequests.requestMatchers(HttpMethod.DELETE, "/api/items/**").hasRole("ADMIN");

			// Chỉ STAFF mới có thể GET từ /api/categories/**
			authorizeHttpRequests.requestMatchers(HttpMethod.GET, "/api/categories/**").hasAnyRole("ADMIN", "STAFF");
			// Chỉ ADMIN mới có thể thực hiện POST, PUT, DELETE từ /api/categories/**
			authorizeHttpRequests.requestMatchers(HttpMethod.POST, "/api/categories/**").hasRole("ADMIN");
			authorizeHttpRequests.requestMatchers(HttpMethod.PUT, "/api/categories/**").hasRole("ADMIN");
			authorizeHttpRequests.requestMatchers(HttpMethod.DELETE, "/api/categories/**").hasRole("ADMIN");

			// Chỉ STAFF mới có thể GET từ /api/products/**
			authorizeHttpRequests.requestMatchers(HttpMethod.GET, "/api/products/**").hasAnyRole("ADMIN", "STAFF");
			// Chỉ ADMIN mới có thể thực hiện POST, PUT, DELETE từ /api/products/**
			authorizeHttpRequests.requestMatchers(HttpMethod.POST, "/api/products/**").hasRole("ADMIN");
			authorizeHttpRequests.requestMatchers(HttpMethod.PUT, "/api/products/**").hasRole("ADMIN");
			authorizeHttpRequests.requestMatchers(HttpMethod.DELETE, "/api/products/**").hasRole("ADMIN");

			// Chỉ STAFF mới có thể GET từ /api/accounts/**
			authorizeHttpRequests.requestMatchers(HttpMethod.GET, "/api/accounts/**").hasAnyRole("ADMIN", "STAFF");
			// Chỉ ADMIN mới có thể thực hiện POST từ /api/accounts/**
			authorizeHttpRequests.requestMatchers(HttpMethod.POST, "/api/accounts/**").hasRole("ADMIN");

//			// ADMIN STAFF mới có thể GET từ /api/orders/**
//			authorizeHttpRequests.requestMatchers(HttpMethod.GET,"/api/orders/**").hasAnyRole("ADMIN", "STAFF");
//			// ADMIN STAFF mới có thể PUT từ /api/orders/**
//			authorizeHttpRequests.requestMatchers(HttpMethod.PUT,"/api/orders/**").hasAnyRole("ADMIN", "STAFF");

			// Chỉ STAFF mới có thể GET từ /api/vouchers/**
			authorizeHttpRequests.requestMatchers(HttpMethod.GET, "/api/vouchers/**").hasAnyRole("ADMIN", "STAFF");
			// Chỉ ADMIN mới có thể thực hiện POST, PUT, DELETE từ /api/vouchers/**
			authorizeHttpRequests.requestMatchers(HttpMethod.POST, "/api/vouchers/**").hasRole("ADMIN");
			authorizeHttpRequests.requestMatchers(HttpMethod.PUT, "/api/vouchers/**").hasRole("ADMIN");
			authorizeHttpRequests.requestMatchers(HttpMethod.DELETE, "/api/vouchers/**").hasRole("ADMIN");

			authorizeHttpRequests.requestMatchers("/api/feedbacks/**").hasAnyRole("ADMIN", "STAFF");
			// Chỉ STAFF mới có thể GET từ /api/feedbacks/**
			authorizeHttpRequests.requestMatchers(HttpMethod.GET, "/api/feedbacks/**").hasAnyRole("ADMIN", "STAFF");
			// Chỉ ADMIN mới có thể thực hiện PUT từ /api/feedbacks/**
			authorizeHttpRequests.requestMatchers(HttpMethod.PUT, "/api/feedbacks/**").hasRole("ADMIN");
			//NHÂN
        	authorizeHttpRequests.requestMatchers("/api/v1/product/public/**",
					"/api/v1/auth/**"
			).permitAll();
//			authorizeHttpRequests.anyRequest().authenticated();
        }  
        )
				.authenticationProvider(authenticationProvider())
        .addFilterBefore(jwtAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class)

//        .formLogin(formLogin ->
//            formLogin
//                .loginPage("/login")
//                .successHandler(new AuthenticationSuccessHandler())
//                .permitAll()
//        )
        .logout(logout ->
            logout
                .permitAll()
        );

		return http.build();
	}
	
	@Bean
	protected AuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(accountDetailsService);
        provider.setPasswordEncoder(passwordEncoder());
        return provider;
    }
	
	@Bean
	protected AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
	     return authenticationConfiguration.getAuthenticationManager();
	}
	
	@Bean
	protected UserDetailsService userDetailsService() {
		return accountDetailsService;
	}

	@Bean
	protected WebMvcConfigurer corsConfigurer() {
		return new WebMvcConfigurer() {
			@Override
			public void addCorsMappings(CorsRegistry registry) {
				registry.addMapping("/**")
						.allowedOrigins("*")
						.allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
						.allowedHeaders("*");
			}
		};
	}
	
	@Bean
	protected PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
}

