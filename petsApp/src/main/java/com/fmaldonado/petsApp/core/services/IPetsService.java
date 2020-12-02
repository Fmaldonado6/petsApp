package com.fmaldonado.petsApp.core.services;

import java.util.List;
import com.fmaldonado.petsApp.core.domain.Pet;

public interface IPetsService extends IService<Pet, String> {

    List<Pet> getPetsByOwnerId(final String id);

    List<Pet> getRandomPets();

}
