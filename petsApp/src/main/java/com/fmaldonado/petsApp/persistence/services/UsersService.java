package com.fmaldonado.petsApp.persistence.services;

import java.util.Iterator;
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
        final List<User> returnList = new ArrayList<User>();
        this.usersDao.findAll().forEach(user -> {
            if (user.getName().equals(name)) {
                returnList.add(user);
            }
            return;
        });
        return returnList;
    }

    @Override
    public User findByEmail(final String email) {
        User returnUser = null;
        final List<User> users = (List<User>) this.usersDao.findAll();
        for (final User user : users) {
            if (user.getEmail().equals(email)) {
                returnUser = user;
            }
        }
        return returnUser;
    }
}
