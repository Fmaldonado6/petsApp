package com.fmaldonado.petsApp.core.domain;

import java.util.List;
import javax.persistence.Transient;
import com.fasterxml.jackson.annotation.JsonInclude;
import javax.persistence.Column;
import org.hibernate.annotations.GenericGenerator;
import javax.persistence.GenerationType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Entity;

@Entity
public class User {

    @Id
    @GeneratedValue(generator = "system-uuid", strategy = GenerationType.AUTO)
    @GenericGenerator(name = "system-uuid", strategy = "uuid")
    private String id;
    @Column
    private String profilePictureId;
    @Column
    private String name;
    @Column
    private String email;
    @Column
    private String password;
    @Column
    private int age;
    @Column
    private int gender;
    @JsonInclude
    @Transient
    private Picture profilePicture;
    @JsonInclude
    @Transient
    private List<Pet> pets;

    public String getId() {
        return this.id;
    }

    public void setId(final String id) {
        this.id = id;
    }

    public String getProfilePictureId() {
        return this.profilePictureId;
    }

    public void setProfilePictureId(final String profilePictureId) {
        this.profilePictureId = profilePictureId;
    }

    public String getName() {
        return this.name;
    }

    public void setName(final String name) {
        this.name = name;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(final String email) {
        this.email = email;
    }

    public String getPassword() {
        return this.password;
    }

    public void setPassword(final String password) {
        this.password = password;
    }

    public int getAge() {
        return this.age;
    }

    public void setAge(final int age) {
        this.age = age;
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

    public List<Pet> getPets() {
        return this.pets;
    }

    public void setPets(final List<Pet> pets) {
        this.pets = pets;
    }
}

enum Genders {
    MALE,
    FEMALE;
}
