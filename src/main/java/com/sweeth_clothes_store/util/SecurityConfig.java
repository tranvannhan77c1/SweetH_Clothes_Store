package com.sweeth_clothes_store.util;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@EnableWebSecurity
public class SecurityConfig{
	@Bean
	protected SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
		http
	    .authorizeHttpRequests((authorize) -> authorize
	        .anyRequest().permitAll()
	    );
		return http.build();
	}
	
	@Bean
	protected WebMvcConfigurer corsConfigurer() {
		return new WebMvcConfigurer() {

			@Override
			public void addCorsMappings(CorsRegistry registry) {
				registry.addMapping("/**");
			}
			
		};
	}
}
