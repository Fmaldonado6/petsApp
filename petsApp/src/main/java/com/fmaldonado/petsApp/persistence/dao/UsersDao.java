package com.fmaldonado.petsApp.persistence.dao;

import com.fmaldonado.petsApp.core.domain.User;
import org.springframework.data.repository.CrudRepository;

public interface UsersDao extends CrudRepository<User, String> {
}
