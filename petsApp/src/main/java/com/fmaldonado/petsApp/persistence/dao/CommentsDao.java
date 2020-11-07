package com.fmaldonado.petsApp.persistence.dao;

import com.fmaldonado.petsApp.core.domain.Comment;
import org.springframework.data.repository.CrudRepository;

public interface CommentsDao extends CrudRepository<Comment, String> {
}
