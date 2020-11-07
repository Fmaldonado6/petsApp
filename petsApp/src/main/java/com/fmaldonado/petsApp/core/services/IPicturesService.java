package com.fmaldonado.petsApp.core.services;

import java.util.List;
import com.fmaldonado.petsApp.core.domain.Picture;

public interface IPicturesService extends IService<Picture, String> {

    List<Picture> getPicturesByPetId(final String id);
}
