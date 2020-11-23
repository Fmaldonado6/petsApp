package com.fmaldonado.petsApp.webApi.controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.security.core.GrantedAuthority;
import io.jsonwebtoken.Jwts;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import com.fmaldonado.petsApp.core.domain.User;
import org.springframework.security.crypto.password.PasswordEncoder;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import com.fmaldonado.petsApp.core.IUnitOfWork;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping({ "/api/v1/auth" })
@CrossOrigin
public class AuthController {

    @Autowired
    private IUnitOfWork unitOfWork;
    @Autowired
    private ObjectMapper jsonMapper;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostMapping({ "" })
    public ResponseEntity<String> login(@RequestBody final User user) {
        try {
            final User foundUser = this.unitOfWork.getUsers().findByEmail(user.getEmail());

            if (foundUser == null)
                return new ResponseEntity<>(null, HttpStatus.NOT_FOUND);

            if (!this.passwordEncoder.matches(user.getPassword(), foundUser.getPassword()))
                return new ResponseEntity<>(null, HttpStatus.FORBIDDEN);

            foundUser.setPassword("");
            final String token = this.getJWTToken(foundUser);
            return new ResponseEntity<>(token, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    private String getJWTToken(final User user) throws JsonProcessingException {
        final String content = this.jsonMapper.writeValueAsString((Object) user);
        final String secretKey = "ho-kago-tea-time-chunchunmaru-4-2-0-2";
        final List<GrantedAuthority> grantedAuthorities = (List<GrantedAuthority>) AuthorityUtils
                .commaSeparatedStringToAuthorityList("ROLE_USER");
        final String token = Jwts.builder().setId("token").setSubject(content)
                .claim("authorities",
                        grantedAuthorities.stream().map(GrantedAuthority::getAuthority).collect(Collectors.toList()))
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .signWith(SignatureAlgorithm.HS256, secretKey.getBytes()).compact();
        return "{\"token\":\"" + token + "\"}";
    }

}
