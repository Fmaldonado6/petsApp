package com.fmaldonado.petsApp.persistence.dao;

import com.fmaldonado.petsApp.core.domain.Pet;
import org.springframework.data.repository.CrudRepository;

public interface PetsDao extends CrudRepository<Pet, String> {
}
