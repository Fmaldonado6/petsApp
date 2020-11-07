package com.fmaldonado.petsApp.webApi;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fmaldonado.petsApp.webApi.utils.JWTAuthorizationFilter;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@SpringBootApplication
@ComponentScan({"com.fmaldonado.petsApp.persistence", "com.fmaldonado.petsApp.core", "com.fmaldonado.petsApp.webApi"})
@EnableJpaRepositories({"com.fmaldonado.petsApp.persistence", "com.fmaldonado.petsApp.core", "com.fmaldonado.petsApp.webApi"})
@EntityScan({"com.fmaldonado.petsApp.core", "com.fmaldonado.petsApp.webApi"})
public class PetsAppApplication {

    public static void main(final String[] args) {
        SpringApplication.run((Class) PetsAppApplication.class, args);
    }

    @Bean
    public PasswordEncoder encoder() {
        return (PasswordEncoder) new BCryptPasswordEncoder();
    }

    @Bean
    public ObjectMapper jsonMapper() {
        return new ObjectMapper();
    }

    @EnableWebSecurity
    @Configuration
    class WebSecurityConfig extends WebSecurityConfigurerAdapter {

        protected void configure(final HttpSecurity http) throws Exception {
            http.cors();
            http.csrf().disable()
                    .addFilterAfter(new JWTAuthorizationFilter(), UsernamePasswordAuthenticationFilter.class)
                    .authorizeRequests()
                    .antMatchers(HttpMethod.POST, "/api/v1/auth").permitAll()
                    .antMatchers(HttpMethod.POST, "/api/v1/users").permitAll()
                    .anyRequest().authenticated();

        }
    }
}
