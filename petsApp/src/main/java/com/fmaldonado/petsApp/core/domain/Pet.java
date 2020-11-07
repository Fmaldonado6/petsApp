package com.fmaldonado.petsApp.core.domain;

import javax.persistence.Transient;
import com.fasterxml.jackson.annotation.JsonInclude;
import java.util.List;
import javax.persistence.Column;
import org.hibernate.annotations.GenericGenerator;
import javax.persistence.GenerationType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Entity;

@Entity
public class Pet {

    @Id
    @GeneratedValue(generator = "system-uuid", strategy = GenerationType.AUTO)
    @GenericGenerator(name = "system-uuid", strategy = "uuid")
    private String id;
    @Column
    private String ownerId;
    @Column
    private String name;
    @Column
    private String profilePictureId;
    @Column
    private String breed;
    @Column
    private String type;
    @Column
    private String description;
    @Column
    private int age;
    @Column
    private long likes;
    @Column
    private long dislikes;
    @Column
    private int gender;
    @JsonInclude
    @Transient
    private List<Picture> pictures;
    @JsonInclude
    @Transient
    private Picture profilePicture;
    @JsonInclude
    @Transient
    private User owner;

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

    public String getName() {
        return this.name;
    }

    public void setName(final String name) {
        this.name = name;
    }

    public String getProfilePictureId() {
        return this.profilePictureId;
    }

    public void setProfilePictureId(final String profilePictureId) {
        this.profilePictureId = profilePictureId;
    }

    public List<Picture> getPictures() {
        return this.pictures;
    }

    public void setPictures(final List<Picture> pictures) {
        this.pictures = pictures;
    }

    public String getBreed() {
        return this.breed;
    }

    public void setBreed(final String breed) {
        this.breed = breed;
    }

    public String getType() {
        return this.type;
    }

    public void setType(final String type) {
        this.type = type;
    }

    public String getDescription() {
        return this.description;
    }

    public void setDescription(final String description) {
        this.description = description;
    }

    public int getAge() {
        return this.age;
    }

    public void setAge(final int age) {
        this.age = age;
    }

    public long getLikes() {
        return this.likes;
    }

    public void setLikes(final long likes) {
        this.likes = likes;
    }

    public long getDislikes() {
        return this.dislikes;
    }

    public void setDislikes(final long dislikes) {
        this.dislikes = dislikes;
    }

    public int getGender() {
        return this.gender;
    }

    public void setGender(final int gender) {
        this.gender = gender;
    }

    public Picture getProfilePicture() {
        return this.profilePicture;
    }

    public void setProfilePicture(final Picture profilePicture) {
        this.profilePicture = profilePicture;
    }

    public User getOwner() {
        return this.owner;
    }

    public void setOwner(final User owner) {
        this.owner = owner;
    }
}
