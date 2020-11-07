package com.fmaldonado.petsApp.webApi.controllers;

import com.fmaldonado.petsApp.core.services.IService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import com.fmaldonado.petsApp.core.domain.Comment;
import com.fmaldonado.petsApp.core.domain.User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.util.MultiValueMap;
import org.springframework.http.HttpStatus;
import com.fmaldonado.petsApp.core.domain.Picture;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.beans.factory.annotation.Autowired;
import com.fmaldonado.petsApp.core.IUnitOfWork;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping({"/api/v1/pictures"})
@CrossOrigin({"http://localhost:4200"})
public class PicturesController {

    @Autowired
    private IUnitOfWork unitOfWork;

    @GetMapping({"/pet/{id}"})
    public ResponseEntity<List<Picture>> getPicturesByPetId(@PathVariable final String id) {
        try {
            final List<Picture> pictures = this.unitOfWork.getPictures().getPicturesByPetId(id);
            return (ResponseEntity<List<Picture>>) new ResponseEntity((Object) pictures, HttpStatus.OK);
        } catch (Exception e) {
            return (ResponseEntity<List<Picture>>) new ResponseEntity((MultiValueMap) null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping({"/{id}"})
    public ResponseEntity<Picture> getPictureInformation(@PathVariable final String id) {
        try {
            final Picture picture = this.unitOfWork.getPictures().get(id);
            final List<Comment> comments = this.unitOfWork.getComments().getCommentsByPictureId(id);
            final User owner = this.unitOfWork.getUsers().get(picture.getOwnerId());
            picture.setOwner(owner);
            picture.setComments(comments);
            return (ResponseEntity<Picture>) new ResponseEntity((Object) picture, HttpStatus.OK);
        } catch (Exception e) {
            return (ResponseEntity<Picture>) new ResponseEntity((MultiValueMap) null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping({""})
    public ResponseEntity<Picture> addPicture(@RequestBody final Picture picture) {
        try {
            final Picture obj = this.unitOfWork.getPictures().save(picture);
            return (ResponseEntity<Picture>) new ResponseEntity((Object) obj, HttpStatus.OK);
        } catch (Exception e) {
            return (ResponseEntity<Picture>) new ResponseEntity((MultiValueMap) null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
