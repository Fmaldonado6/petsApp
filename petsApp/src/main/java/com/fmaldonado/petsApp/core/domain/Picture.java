package com.fmaldonado.petsApp.core.domain;

import java.util.List;
import javax.persistence.Transient;
import com.fasterxml.jackson.annotation.JsonInclude;
import javax.persistence.Column;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.GenerationType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Entity;

@Entity
public class Picture {

    @Id
    @GeneratedValue(generator = "system-uuid", strategy = GenerationType.AUTO)
    @GenericGenerator(name = "system-uuid", strategy = "uuid")
    private String id;
    @Column
    private String ownerId;
    @Column
    private String petId;
    @Column
    private String picture;
    @JsonInclude
    @Transient
    private User owner;
    @JsonInclude
    @Transient
    private Pet pet;
    @JsonInclude
    @Transient
    private List<Comment> comments;

    @JsonInclude
    @Transient
    private String pictureData;

    public String getId() {
        return this.id;
    }

    public void setId(final String id) {
        this.id = id;
    }

    public String getOwnerId() {
        return this.ownerId;
    }

    public void setOwnerId(final String ownerId) {
        this.ownerId = ownerId;
    }

    public String getPetId() {
        return this.petId;
    }

    public void setPetId(final String petId) {
        this.petId = petId;
    }

    public String getPicture() {
        return this.picture;
    }

    public void setPicture(final String picture) {
        this.picture = picture;
    }

    public User getOwner() {
        return this.owner;
    }

    public void setOwner(final User owner) {
        this.owner = owner;
    }

    public Pet getPet() {
        return this.pet;
    }

    public void setPet(final Pet pet) {
        this.pet = pet;
    }

    public List<Comment> getComments() {
        return this.comments;
    }

    public void setComments(final List<Comment> comments) {
        this.comments = comments;
    }
}
