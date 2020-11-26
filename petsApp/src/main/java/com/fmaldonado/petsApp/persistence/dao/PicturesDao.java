package com.fmaldonado.petsApp.persistence.dao;

import java.util.List;

import com.fmaldonado.petsApp.core.domain.Picture;
import org.springframework.data.repository.CrudRepository;

public interface PicturesDao extends CrudRepository<Picture, String> {

    List<Picture> findPicturesByPetId(String petId);

}
