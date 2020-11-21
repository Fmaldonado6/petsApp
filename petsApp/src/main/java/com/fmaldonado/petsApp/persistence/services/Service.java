package com.fmaldonado.petsApp.persistence.services;

import org.springframework.data.repository.CrudRepository;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import com.fmaldonado.petsApp.core.services.IService;
import java.io.Serializable;

public abstract class Service<T, ID extends Serializable> implements IService<T, ID> {

    @Override
    public T save(final T entity) {
        return (T) this.getDao().save(entity);
    }


    @Override
    public void delete(final ID id) {
        this.getDao().deleteById(id);
    }

    @Override
    public T get(final ID id) {
        final Optional<T> obj = (Optional<T>) this.getDao().findById(id);
        if (obj.isPresent()) {
            return obj.get();
        }
        return null;
    }

    @Override
    public List<T> getAll() {
        final List<T> returnList = new ArrayList<T>();
        this.getDao().findAll().forEach(obj -> returnList.add(obj));
        return returnList;
    }

    public abstract CrudRepository<T, ID> getDao();
}
