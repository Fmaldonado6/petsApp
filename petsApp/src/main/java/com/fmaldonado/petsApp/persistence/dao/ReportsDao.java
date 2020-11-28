package com.fmaldonado.petsApp.persistence.dao;

import java.util.List;

import com.fmaldonado.petsApp.core.domain.Report;

import org.springframework.data.repository.CrudRepository;

public interface ReportsDao extends CrudRepository<Report, String> {

    List<Report> findReportByPetId(String id);
}
