package com.fmaldonado.petsApp.core.services;

import java.util.List;
import java.io.Serializable;

public interface IService<T, ID extends Serializable> {

    T save(final T entity);


    void delete(final ID id);

    T get(final ID id);

    List<T> getAll();
}
