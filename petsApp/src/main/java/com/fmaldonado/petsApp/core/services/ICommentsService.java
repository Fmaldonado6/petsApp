package com.fmaldonado.petsApp.core.services;

import java.util.List;
import com.fmaldonado.petsApp.core.domain.Comment;

public interface ICommentsService extends IService<Comment, String> {

    List<Comment> getCommentsByPictureId(final String id);
}
