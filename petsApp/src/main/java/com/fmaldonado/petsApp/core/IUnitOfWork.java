package com.fmaldonado.petsApp.core;

import com.fmaldonado.petsApp.core.services.IPicturesService;
import com.fmaldonado.petsApp.core.services.IUsersService;
import com.fmaldonado.petsApp.core.services.IPetsService;
import com.fmaldonado.petsApp.core.services.ICommentsService;
import com.fmaldonado.petsApp.core.services.IFileService;

public interface IUnitOfWork {

    ICommentsService getComments();

    IPetsService getPets();

    IUsersService getUsers();

    IPicturesService getPictures();

    IFileService getFiles();

}
