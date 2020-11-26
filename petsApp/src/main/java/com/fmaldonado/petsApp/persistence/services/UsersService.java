package com.fmaldonado.petsApp.persistence.services;

import java.util.ArrayList;
import java.util.List;
import org.springframework.data.repository.CrudRepository;
import org.springframework.beans.factory.annotation.Autowired;
import com.fmaldonado.petsApp.persistence.dao.UsersDao;
import com.fmaldonado.petsApp.core.services.IUsersService;
import com.fmaldonado.petsApp.core.domain.User;

@org.springframework.stereotype.Service
public class UsersService extends Service<User, String> implements IUsersService {

    @Autowired
    private UsersDao usersDao;

    @Override
    public CrudRepository<User, String> getDao() {
        return (CrudRepository<User, String>) this.usersDao;
    }

    @Override
    public List<User> findByName(final String name) {
        return this.usersDao.findByName(name);
    }

    @Override
    public User findByEmail(final String email) {
        return this.usersDao.findByEmail(email);
    }
}
