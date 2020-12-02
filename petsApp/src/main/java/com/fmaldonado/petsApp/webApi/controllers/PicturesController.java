package com.fmaldonado.petsApp.webApi.controllers;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;

import com.fmaldonado.petsApp.core.domain.Comment;
import com.fmaldonado.petsApp.core.domain.User;
import com.fmaldonado.petsApp.webApi.utils.ImageCompression;
import com.fmaldonado.petsApp.webApi.utils.JWTAuthorizationFilter;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.http.HttpStatus;
import com.fmaldonado.petsApp.core.domain.Picture;

import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.beans.factory.annotation.Autowired;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fmaldonado.petsApp.core.IUnitOfWork;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;

@RestController
@RequestMapping({ "/api/v1/pictures" })
@CrossOrigin
public class PicturesController {

    @Autowired
    private IUnitOfWork unitOfWork;
    
    @Autowired
    private ImageCompression imageCompression;
    
    @Autowired
    private ObjectMapper jsonMapper;

    @GetMapping({ "/pet/{id}" })
    public ResponseEntity<List<Picture>> getPicturesByPetId(@PathVariable final String id) {
        try {
            final List<Picture> pictures = this.unitOfWork.getPictures().getPicturesByPetId(id);
            return new ResponseEntity<>(pictures, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping({ "/{id}" })
    public ResponseEntity<Picture> getPictureInformation(@PathVariable final String id) {
        try {
            final Picture picture = this.unitOfWork.getPictures().get(id);
            final List<Comment> comments = this.unitOfWork.getComments().getCommentsByPictureId(id);
            final User owner = this.unitOfWork.getUsers().get(picture.getOwnerId());
            picture.setOwner(owner);
            picture.setComments(comments);
            return new ResponseEntity<>(picture, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @DeleteMapping({ "/{id}" })
    public ResponseEntity<Picture> deletePicture(@PathVariable final String id) {
        try {
            final Picture picture = this.unitOfWork.getPictures().get(id);

            unitOfWork.getPictures().delete(picture.getId());

            unitOfWork.getFiles().deleteFile(picture.getPicture());

            return new ResponseEntity<>(picture, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();

            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping({ "" })
    public ResponseEntity<Picture> addPicture(@RequestParam("extension") String extension,
            @RequestParam("petId") String petId, @RequestHeader("Authorization") String token,
            @RequestParam("file") MultipartFile file) {
        try {

            if(file.getSize() > 5e6)
                return  new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);

            token = token.split(" ")[1];

            Claims claims = (Claims) Jwts.parser().setSigningKey(JWTAuthorizationFilter.SECRET.getBytes()).parse(token)
                    .getBody();

            String subject = claims.getSubject();

            User userInfo = jsonMapper.readValue(subject, User.class);

            String name = unitOfWork.getFiles().saveFromBytes(file.getInputStream(), extension);

            imageCompression.compressFile(name, extension);

            Picture savedPicture = new Picture();

            if (petId != null && !petId.isEmpty())
                savedPicture.setPetId(petId);

            savedPicture.setOwnerId(userInfo.getId());

            savedPicture.setPicture(name);

            final Picture obj = this.unitOfWork.getPictures().save(savedPicture);

            return new ResponseEntity<>(obj, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
