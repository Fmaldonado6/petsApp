package com.fmaldonado.petsApp.webApi.controllers;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
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
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping({ "/api/v1/users" })
@CrossOrigin
public class UsersController {

    @Autowired
    private IUnitOfWork unitOfWork;
    @Autowired
    private PasswordEncoder passwordEncoder;

    @GetMapping({ "" })
    public ResponseEntity<List<User>> getAll() {
        try {
            final List<User> list = this.unitOfWork.getUsers().getAll();
            return new ResponseEntity<>(list, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();

            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping({ "/{id}" })
    public ResponseEntity<User> getById(@PathVariable final String id) {
        try {
            final User obj = this.unitOfWork.getUsers().get(id);
            final List<Pet> pets = this.unitOfWork.getPets().getPetsByOwnerId(obj.getId());

            for (Pet pet : pets) {

                if (pet.getProfilePictureId() == null)
                    continue;

                Picture profilePic = this.unitOfWork.getPictures().get(pet.getProfilePictureId());
                pet.setProfilePicture(profilePic);
            }

            obj.setPets(pets);

            obj.setPassword("");

            if (obj.getProfilePictureId() == null)
                return new ResponseEntity<>(obj, HttpStatus.OK);

            final Picture profilePic = this.unitOfWork.getPictures().get(obj.getProfilePictureId());
            obj.setProfilePicture(profilePic);
            return new ResponseEntity<>(obj, HttpStatus.OK);

        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping({ "" })
    public ResponseEntity<User> add(@RequestBody final User user) {
        try {

            User exists = this.unitOfWork.getUsers().findByEmail(user.getEmail());

            if (exists != null)
                return new ResponseEntity<>(null, HttpStatus.CONFLICT);

            user.setPassword(this.passwordEncoder.encode((CharSequence) user.getPassword()));
            final User obj = this.unitOfWork.getUsers().save(user);
            obj.setPassword("");
            return new ResponseEntity<>(obj, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity delete(@PathVariable final String id) {

        try {

            User user = this.unitOfWork.getUsers().get(id);

            if (user == null)
                return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);

            List<Pet> pets = this.unitOfWork.getPets().getPetsByOwnerId(id);

            for (Pet pet : pets) {

                this.unitOfWork.getPets().delete(pet.getId());

            }

            this.unitOfWork.getPictures().delete(user.getProfilePictureId());

            this.unitOfWork.getUsers().delete(id);

            return new ResponseEntity<>(null, HttpStatus.OK);

        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @PutMapping({ "/{id}" })
    public ResponseEntity<User> update(@RequestBody final User user) {
        try {

            final User oldUser = this.unitOfWork.getUsers().get(user.getId());

            final User exists = this.unitOfWork.getUsers().findByEmail(user.getEmail());

            if (exists != null && exists.getId() != user.getId())
                return new ResponseEntity<>(null, HttpStatus.CONFLICT);

            if (user.getPassword() != null && !user.getPassword().isEmpty())
                user.setPassword(this.passwordEncoder.encode((CharSequence) user.getPassword()));
            else
                user.setPassword(oldUser.getPassword());

            if (oldUser.getProfilePictureId() != null
                    && !oldUser.getProfilePictureId().equals(user.getProfilePictureId())) {
                Picture pic = unitOfWork.getPictures().get(oldUser.getProfilePictureId());

                unitOfWork.getFiles().deleteFile(pic.getPicture());
                unitOfWork.getPictures().delete(oldUser.getProfilePictureId());

            }

            final User obj = this.unitOfWork.getUsers().save(user);
            obj.setPassword("");

            return new ResponseEntity<>(obj, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
