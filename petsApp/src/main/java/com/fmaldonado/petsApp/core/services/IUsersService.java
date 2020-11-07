package com.fmaldonado.petsApp.core.services;

import java.util.List;
import com.fmaldonado.petsApp.core.domain.User;

public interface IUsersService extends IService<User, String> {

    List<User> findByName(final String name);

    User findByEmail(final String email);
}
