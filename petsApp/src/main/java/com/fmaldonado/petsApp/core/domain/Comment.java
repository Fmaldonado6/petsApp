package com.fmaldonado.petsApp.core.domain;

import javax.persistence.Transient;
import com.fasterxml.jackson.annotation.JsonInclude;
import javax.persistence.Column;
import org.hibernate.annotations.GenericGenerator;
import javax.persistence.GenerationType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Entity;

@Entity
public class Comment
{
    @Id
    @GeneratedValue(generator = "system-uuid", strategy = GenerationType.AUTO)
    @GenericGenerator(name = "system-uuid", strategy = "uuid")
    private String id;
    @Column
    private String userId;
    @Column
    private String pictureId;
    @JsonInclude
    @Transient
    private User user;
    @JsonInclude
    @Transient
    private Picture picture;
    
    public Picture getPicture() {
        return this.picture;
    }
    
    public void setPicture(final Picture picture) {
        this.picture = picture;
    }
    
    public String getId() {
        return this.id;
    }
    
    public void setId(final String id) {
        this.id = id;
    }
    
    public String getPictureId() {
        return this.pictureId;
    }
    
    public void setPictureId(final String pictureId) {
        this.pictureId = pictureId;
    }
    
    public String getUserId() {
        return this.userId;
    }
    
    public void setUserId(final String userId) {
        this.userId = userId;
    }
    
    public User getUser() {
        return this.user;
    }
    
    public void setUser(final User user) {
        this.user = user;
    }
}