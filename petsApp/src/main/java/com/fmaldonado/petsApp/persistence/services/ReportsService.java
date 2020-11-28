package com.fmaldonado.petsApp.persistence.services;

import java.util.List;

import com.fmaldonado.petsApp.core.domain.Report;
import com.fmaldonado.petsApp.core.services.IReportsService;
import com.fmaldonado.petsApp.persistence.dao.ReportsDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.CrudRepository;

@org.springframework.stereotype.Service
public class ReportsService extends Service<Report, String> implements IReportsService {

    @Autowired
    private ReportsDao reportstDao;


    @Override
    public List<Report> findReportByPetId(String id) {

        return this.reportstDao.findReportByPetId(id);
    }

    @Override
    public CrudRepository<Report, String> getDao() {
        return reportstDao;
    }

}
