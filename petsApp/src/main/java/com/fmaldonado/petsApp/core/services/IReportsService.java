package com.fmaldonado.petsApp.core.services;

import java.util.List;

import com.fmaldonado.petsApp.core.domain.Report;

public interface IReportsService extends IService<Report, String> {
    List<Report> findReportByPetId(String id);
}
