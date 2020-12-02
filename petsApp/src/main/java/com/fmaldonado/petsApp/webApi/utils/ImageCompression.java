package com.fmaldonado.petsApp.webApi.utils;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Iterator;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.metadata.IIOMetadata;
import javax.imageio.stream.ImageInputStream;
import javax.imageio.stream.ImageOutputStream;


public class ImageCompression {

    public void compressFile(String filename, String extension) throws IOException {

        File file = new File(filename);
        ImageInputStream imageInputStream = ImageIO.createImageInputStream(file);

        Iterator<ImageReader> reader = ImageIO.getImageReaders(imageInputStream);
        
        final ImageReader firstReader = reader.next();
        
        firstReader.setInput(imageInputStream);

        IIOMetadata metadata = firstReader.getImageMetadata(0);

        BufferedImage image = ImageIO.read(file);

        FileOutputStream os = new FileOutputStream(file, false);

        Iterator<ImageWriter> writers = ImageIO.getImageWritersByFormatName(extension);

        ImageWriter writer = writers.next();

        ImageOutputStream ios = ImageIO.createImageOutputStream(os);

        writer.setOutput(ios);

        ImageWriteParam param = writer.getDefaultWriteParam();

        param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);

        param.setCompressionQuality(0.5f);
        writer.write(null, new IIOImage(image, null, metadata), param);

        os.close();
        ios.close();
        writer.dispose();

    }

}
