package com.fmaldonado.petsApp.webApi.controllers;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.http.HttpStatus;
import com.fmaldonado.petsApp.core.domain.Pet;
import com.fmaldonado.petsApp.core.domain.Picture;
import com.fmaldonado.petsApp.core.domain.Report;
import com.fmaldonado.petsApp.core.domain.User;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.beans.factory.annotation.Autowired;
import com.fmaldonado.petsApp.core.IUnitOfWork;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping({ "/api/v1/pets" })
@CrossOrigin
public class PetsController {

    @Autowired
    private IUnitOfWork unitOfWork;

    @GetMapping({ "/{id}" })
    public ResponseEntity<Pet> getPet(@PathVariable final String id) {
        try {
            final Pet pet = this.unitOfWork.getPets().get(id);
            return new ResponseEntity<>(pet, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @DeleteMapping({ "/{id}" })
    public ResponseEntity<Object> deletePet(@PathVariable final String id) {
        try {
            final Pet pet = this.unitOfWork.getPets().get(id);

            try {
                final List<Picture> pictures = this.unitOfWork.getPictures().getPicturesByPetId(pet.getId());

                for (Picture picture : pictures) {
                    this.unitOfWork.getFiles().deleteFile(picture.getPicture());
                    this.unitOfWork.getPictures().delete(picture.getId());

                }
            } catch (Exception e) {
                System.out.println("File not found");
            }
            unitOfWork.getPets().delete(id);

            return new ResponseEntity<>(null, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping({ "" })
    public ResponseEntity<List<Pet>> getPets() {
        try {
            final List<Pet> petsList = this.unitOfWork.getPets().getRandomPets();
            final List<Pet> returnList = new ArrayList<>();
            for (Pet pet : petsList) {

                List<Report> reports = this.unitOfWork.getReports().findReportByPetId(pet.getId());

                if (!reports.isEmpty())
                    continue;

                User user = this.unitOfWork.getUsers().get(pet.getOwnerId());

                pet.setOwner(user);

                if (pet.getProfilePictureId() == null) {
                    returnList.add(pet);
                    continue;
                }

                Picture profilePic = this.unitOfWork.getPictures().get(pet.getProfilePictureId());

                pet.setProfilePicture(profilePic);

                returnList.add(pet);

            }

            Collections.shuffle(returnList);

            return new ResponseEntity<>(returnList, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping({ "" })
    public ResponseEntity<Pet> addPet(@RequestBody final Pet pet) {
        try {
            final Pet obj = this.unitOfWork.getPets().save(pet);
            return new ResponseEntity<>(obj, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping({ "/{id}" })
    public ResponseEntity<Pet> updatePet(@RequestBody final Pet pet) {
        try {

            Pet oldPet = unitOfWork.getPets().get(pet.getId());

            if (pet.getLikes() < oldPet.getLikes()) {
                pet.setLikes(oldPet.getLikes() + 1);
            }

            if (pet.getDislikes() < oldPet.getDislikes()) {
                pet.setLikes(oldPet.getDislikes() + 1);

            }

            Pet obj = unitOfWork.getPets().save(pet);

            return new ResponseEntity<>(obj, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
