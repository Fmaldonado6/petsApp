package com.fmaldonado.petsApp.webApi.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.http.HttpStatus;
import com.fmaldonado.petsApp.core.domain.Comment;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.beans.factory.annotation.Autowired;
import com.fmaldonado.petsApp.core.IUnitOfWork;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping({ "/api/v1/comments" })
@CrossOrigin
public class CommentsController {
    @Autowired
    private IUnitOfWork unitOfWork;

    @GetMapping({ "/{id}" })
    public ResponseEntity<List<Comment>> getPictureComments(@PathVariable final String id) {
        try {
            final List<Comment> returnList = this.unitOfWork.getComments().getCommentsByPictureId(id);
            return new ResponseEntity<List<Comment>>(returnList, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}