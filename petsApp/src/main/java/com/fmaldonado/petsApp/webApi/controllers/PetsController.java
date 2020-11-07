package com.fmaldonado.petsApp.webApi.controllers;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.http.HttpStatus;
import com.fmaldonado.petsApp.core.domain.Pet;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.beans.factory.annotation.Autowired;
import com.fmaldonado.petsApp.core.IUnitOfWork;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping({ "/api/v1/pets" })
@CrossOrigin({ "http://localhost:4200" })
public class PetsController {

    @Autowired
    private IUnitOfWork unitOfWork;

    @GetMapping({ "/{id}" })
    public ResponseEntity<Pet> getPet(@PathVariable final String id) {
        try {
            final Pet pet = this.unitOfWork.getPets().get(id);
            return new ResponseEntity<Pet>(pet, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping({ "" })
    public ResponseEntity<List<Pet>> getPets() {
        try {
            final List<Pet> returnList = this.unitOfWork.getPets().getAll();
            return new ResponseEntity<List<Pet>>(returnList, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping({ "" })
    public ResponseEntity<Pet> addPet(@RequestBody final Pet pet) {
        try {
            final Pet obj = this.unitOfWork.getPets().save(pet);
            return new ResponseEntity<Pet>(obj, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
