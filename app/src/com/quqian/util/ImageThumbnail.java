package com.quqian.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Bitmap.CompressFormat;
import android.graphics.Matrix;
import android.os.Environment;

public class ImageThumbnail {

	public static int reckonThumbnail(int oldWidth, int oldHeight,
			int newWidth, int newHeight) {
		if ((oldHeight > newHeight && oldWidth > newWidth)
				|| (oldHeight <= newHeight && oldWidth > newWidth)) {
			int be = (int) (oldWidth / (float) newWidth);
			if (be <= 1)
				be = 1;
			return be;
		} else if (oldHeight > newHeight && oldWidth <= newWidth) {
			int be = (int) (oldHeight / (float) newHeight);
			if (be <= 1)
				be = 1;
			return be;
		}
		return 1;
	}

	public static Bitmap PicZoom(Bitmap bmp, int width, int height) {
		int bmpWidth = bmp.getWidth();
		int bmpHeght = bmp.getHeight();
		Matrix matrix = new Matrix();
		matrix.postScale((float) width / bmpWidth, (float) height / bmpHeght);

		return Bitmap.createBitmap(bmp, 0, 0, bmpWidth, bmpHeght, matrix, true);
	}

	public static String savaPhotoToLocal(Intent data, Bitmap btp) {
		// 如果文件夹不存在则创建文件夹，并将bitmap图像文件保存
		File rootdir = Environment.getExternalStorageDirectory();
		String imagerDir = rootdir.getPath() + "/qianbangzhu";
		File dirpath = new File(imagerDir);
		String filename = System.currentTimeMillis() + ".png";
		File tempFile = new File(dirpath, filename);
		String filePath = tempFile.getAbsolutePath();
		try {
			// 将bitmap转为jpg文件保存
			FileOutputStream fileOut = new FileOutputStream(tempFile);
			btp.compress(CompressFormat.PNG, 100, fileOut);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		return filePath;
	}

}
