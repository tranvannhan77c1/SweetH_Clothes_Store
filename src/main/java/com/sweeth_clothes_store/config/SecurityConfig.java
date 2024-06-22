package com.sweeth_clothes_store.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {
	
	@Autowired
	private AccountDetailsService accountDetailsService;
	
	@Bean
	protected SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http.csrf(AbstractHttpConfigurer::disable);

		http
		.csrf(AbstractHttpConfigurer::disable)
        .authorizeHttpRequests(authorizeHttpRequests ->
            authorizeHttpRequests
                .requestMatchers(
                		"/login",
                		"/css/**", 
                		"/img/**",
                		"/js/**",
                		"/scss/**",
                		"/vendors/**").permitAll()
                .requestMatchers("/admin").authenticated()
                .anyRequest().permitAll()//anonymous
        )
        .formLogin(formLogin ->
            formLogin
                .loginPage("/login")
                .successHandler(new AuthenticationSuccessHandler())
                .permitAll()
        )
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
						.allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS");
			}
		};
	}
	
	@Bean
	protected PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
}

