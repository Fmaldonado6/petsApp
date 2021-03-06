package com.fmaldonado.petsApp.persistence;

import com.fmaldonado.petsApp.core.services.IPetsService;
import com.fmaldonado.petsApp.core.services.IPicturesService;
import com.fmaldonado.petsApp.core.services.IReportsService;
import com.fmaldonado.petsApp.core.services.IUsersService;
import org.springframework.beans.factory.annotation.Autowired;
import com.fmaldonado.petsApp.core.services.ICommentsService;
import com.fmaldonado.petsApp.core.services.IFileService;

import org.springframework.stereotype.Service;
import com.fmaldonado.petsApp.core.IUnitOfWork;

@Service
public class UnitOfWork implements IUnitOfWork {

    @Autowired
    private ICommentsService commentsService;
    @Autowired
    private IUsersService usersService;
    @Autowired
    private IPicturesService picturesService;
    @Autowired
    private IPetsService petsService;

    @Autowired
    private IReportsService reportsService;

    @Autowired
    private IFileService fileService;

    @Override
    public ICommentsService getComments() {
        return this.commentsService;
    }

    @Override
    public IPetsService getPets() {
        return this.petsService;
    }

    @Override
    public IUsersService getUsers() {
        return this.usersService;
    }

    @Override
    public IPicturesService getPictures() {
        return this.picturesService;
    }

    @Override
    public IFileService getFiles() {
        return this.fileService;
    }

    @Override
    public IReportsService getReports() {
        return this.reportsService;
    }
}
