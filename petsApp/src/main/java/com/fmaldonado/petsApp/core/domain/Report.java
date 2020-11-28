package com.fmaldonado.petsApp.core.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import org.hibernate.annotations.GenericGenerator;

@Entity
public class Report {
    @Id
    @GeneratedValue(generator = "system-uuid", strategy = GenerationType.AUTO)
    @GenericGenerator(name = "system-uuid", strategy = "uuid")
    private String id;

    @Column
    private String userId;

    @Column
    private String username;

    @Column
    private String petId;

    @Column
    private String petname;

    @Column
    private String pictureId;

    @Column
    private String picture;

    public void setId(String id) {
        this.id = id;
    }

    public String getId() {
        return this.id;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserId() {
        return this.userId;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUsername() {
        return this.username;
    }

    public void setPetId(String petId) {
        this.petId = petId;
    }

    public String getPetId() {
        return this.petId;
    }

    public void setPetname(String petname) {
        this.petname = petname;
    }

    public String getPetname(){
        return this.petname;
    }

    public void setPictureId(String pictureId) {
        this.pictureId = pictureId;
    }

    public String getPictureId(){
        return this.pictureId;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public String getPicture(){
        return this.picture;
    }
}
