package com.fmaldonado.petsApp.persistence.dao;

import java.util.List;

import com.fmaldonado.petsApp.core.domain.Pet;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

public interface PetsDao extends CrudRepository<Pet, String> {
    public List<Pet> findPetsByOwnerId(final String id);

    @Query(value = "SELECT * FROM Pet ORDER BY RAND() LIMIT 10",nativeQuery = true)
    public List<Pet> getRandomPets();

}
