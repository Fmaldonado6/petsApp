package com.fmaldonado.petsApp.webApi.controllers;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import com.fmaldonado.petsApp.core.domain.Pet;
import com.fmaldonado.petsApp.core.domain.Picture;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.http.HttpStatus;
import com.fmaldonado.petsApp.core.domain.User;
import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import com.fmaldonado.petsApp.core.IUnitOfWork;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping({ "/api/v1/users" })
@CrossOrigin({ "http://localhost:4200" })
public class UsersController {

    @Autowired
    private IUnitOfWork unitOfWork;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping({ "" })
    public ResponseEntity<List<User>> getAll() {
        try {
            final List<User> list = this.unitOfWork.getUsers().getAll();
            return new ResponseEntity<List<User>>(list, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping({ "/{id}" })
    public ResponseEntity<User> getById(@PathVariable final String id) {
        try {
            final User obj = this.unitOfWork.getUsers().get(id);
            final Picture profilePic = this.unitOfWork.getPictures().get(obj.getProfilePictureId());
            final List<Pet> pets = this.unitOfWork.getPets().getPetsByOwnerId(obj.getId());
            obj.setPets(pets);
            obj.setProfilePicture(profilePic);
            return new ResponseEntity<User>(obj, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping({ "" })
    public ResponseEntity<User> add(@RequestBody final User user) {
        try {
            user.setPassword(this.passwordEncoder.encode((CharSequence) user.getPassword()));
            final User obj = this.unitOfWork.getUsers().save(user);
            return new ResponseEntity<User>(obj, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
