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
        return (CrudRepository<Pet, String>) this.petsDao;
    }

    @Override
    public List<Pet> getPetsByOwnerId(final String id) {
        final List<Pet> returnList = new ArrayList<Pet>();
        this.petsDao.findAll().forEach(obj -> {
            if (obj.getOwnerId().equals(id)) {
                returnList.add(obj);
            }
            return;
        });
        return returnList;
    }
}
