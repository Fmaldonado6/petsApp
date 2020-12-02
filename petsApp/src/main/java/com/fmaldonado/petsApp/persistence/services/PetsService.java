package com.fmaldonado.petsApp.persistence.services;

import java.util.ArrayList;
import java.util.List;
import org.springframework.data.repository.CrudRepository;
import org.springframework.beans.factory.annotation.Autowired;
import com.fmaldonado.petsApp.persistence.dao.PetsDao;
import com.fmaldonado.petsApp.core.services.IPetsService;
import com.fmaldonado.petsApp.core.domain.Pet;

@org.springframework.stereotype.Service
public class PetsService extends Service<Pet, String> implements IPetsService {

    @Autowired
    private PetsDao petsDao;

    @Override
    public CrudRepository<Pet, String> getDao() {
        return this.petsDao;
    }
    @Override
    public List<Pet> getRandomPets(){
        return this.petsDao.getRandomPets();
    }


    @Override
    public List<Pet> getPetsByOwnerId(final String id) {
        return this.petsDao.findPetsByOwnerId(id);
    }
}
