package com.fmaldonado.petsApp.persistence.dao;

import java.util.List;

import com.fmaldonado.petsApp.core.domain.User;
import org.springframework.data.repository.CrudRepository;

public interface UsersDao extends CrudRepository<User, String> {
    public User findByEmail(final String email);

    public List<User> findByName(final String name);

}
