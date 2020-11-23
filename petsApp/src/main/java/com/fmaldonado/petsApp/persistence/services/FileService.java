package com.fmaldonado.petsApp.persistence.services;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.UUID;

import com.fmaldonado.petsApp.core.services.IFileService;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.stereotype.Service;

@Service
public class FileService implements IFileService {

    private final String path = "media/";

    private final String petPath = "media/pets/";

    public FileService() {
        File profilePath = new File(this.path);

        if (!profilePath.exists())
            profilePath.mkdirs();

    }

    public boolean deleteFile(String name) throws Exception{
        File file = new File(name);
        return file.delete();
    }

    public String saveFromBytes(InputStream bytes, String extension) throws Exception {

        File file = new File(this.path + UUID.randomUUID() + "." + extension);

        if (file.exists())
            return null;

        file.createNewFile();

        FileOutputStream out = new FileOutputStream(file);

        IOUtils.copy(bytes, out);

        IOUtils.closeQuietly(bytes);
        IOUtils.closeQuietly(out);

        return path + file.getName();
    }

}
