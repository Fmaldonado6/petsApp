package com.fmaldonado.petsApp.persistence.services;

import java.util.ArrayList;
import java.util.List;
import org.springframework.data.repository.CrudRepository;
import org.springframework.beans.factory.annotation.Autowired;
import com.fmaldonado.petsApp.persistence.dao.CommentsDao;
import com.fmaldonado.petsApp.core.services.ICommentsService;
import com.fmaldonado.petsApp.core.domain.Comment;

@org.springframework.stereotype.Service
public class CommentsService extends Service<Comment, String> implements ICommentsService {

    @Autowired
    private CommentsDao commentsDao;

    @Override
    public CrudRepository<Comment, String> getDao() {
        return (CrudRepository<Comment, String>) this.commentsDao;
    }

    @Override
    public List<Comment> getCommentsByPictureId(final String id) {
        final List<Comment> returnList = new ArrayList<Comment>();
        this.commentsDao.findAll().forEach(obj -> {
            if (obj.getPictureId().equals(id)) {
                returnList.add(obj);
            }
            return;
        });
        return returnList;
    }
}
