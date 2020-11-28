package com.fmaldonado.petsApp.webApi.controllers;

import java.util.List;

import com.fmaldonado.petsApp.core.IUnitOfWork;
import com.fmaldonado.petsApp.core.domain.Report;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping({ "/api/v1/reports" })
@CrossOrigin
public class ReportsController {

    @Autowired
    private IUnitOfWork unitOfWork;

    @PostMapping("")
    public ResponseEntity<Report> addReport(@RequestBody Report report) {

        try {

            Report newReport = this.unitOfWork.getReports().save(report);

            return new ResponseEntity<>(newReport, HttpStatus.OK);

        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

    @GetMapping("")
    public ResponseEntity<List<Report>> getReports() {
        try {

            List<Report> reports = this.unitOfWork.getReports().getAll();

            return new ResponseEntity<>(reports, HttpStatus.OK);

        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Object> getReports(@PathVariable String id) {
        try {

            this.unitOfWork.getReports().delete(id);

            return new ResponseEntity<>(null, HttpStatus.OK);

        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
