package com.fmaldonado.petsApp.core.services;

import java.io.InputStream;

public interface IFileService {
    public String saveFromBytes(InputStream bytes, String extension) throws Exception;

    public boolean deleteFile(String name) throws Exception;

}
