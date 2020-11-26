package com.fmaldonado.petsApp.persistence.services;

import java.util.ArrayList;
import java.util.List;
import org.springframework.data.repository.CrudRepository;
import org.springframework.beans.factory.annotation.Autowired;
import com.fmaldonado.petsApp.persistence.dao.PicturesDao;
import com.fmaldonado.petsApp.core.services.IPicturesService;
import com.fmaldonado.petsApp.core.domain.Picture;

@org.springframework.stereotype.Service
public class PicturesService extends Service<Picture, String> implements IPicturesService {

    @Autowired
    private PicturesDao picturesDao;

    @Override
    public CrudRepository<Picture, String> getDao() {
        return (CrudRepository<Picture, String>) this.picturesDao;
    }

    @Override
    public List<Picture> getPicturesByPetId(final String id) {
        return picturesDao.findPicturesByPetId(id);
    }
}
