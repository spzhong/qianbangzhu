package com.quqian.util;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import android.content.Context;
import android.content.res.AssetManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Environment;


public class FileUtil {
	public static File updateDir = null;
	public static File updateFile = null;
	public static final String FILE_DIR  =  android.os.Environment.getExternalStorageDirectory().getPath()
			+ File.separator + "quqian";
	/***
	 * create file
	 */
	public static void createFile(String name) {
		if (android.os.Environment.MEDIA_MOUNTED.equals(android.os.Environment
				.getExternalStorageState())) {
			updateDir = new File(FILE_DIR);
			updateFile = new File(updateDir + "/" + name + ".apk");

			if (!updateDir.exists()) {
				updateDir.mkdirs();
			}
			if (!updateFile.exists()) {
				try {
					updateFile.createNewFile();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

		}
	}

	/**
	 * 递归删除目录下的所有文件及子目录下所有文件
	 * 
	 * @param dir
	 *            将要删除的文件目录 （/storage/sdcard1/test）
	 * @return boolean Returns "true" if all deletions were successful. If a
	 *         deletion fails, the method stops attempting to delete and returns
	 *         "false".
	 */
	private static boolean deleteDir(File dir) {
		if (dir.isDirectory()) {
			String[] children = dir.list();
			// 递归删除目录中的子目录下
			for (int i = 0; i < children.length; i++) {
				boolean success = deleteDir(new File(dir, children[i]));
				if (!success) {
					return false;
				}
			}
		}
		// 目录此时为空，可以删除
		return dir.delete();
	}
	/**
	 * 
	 * 方法描述 : 判断文件是否存在
	 * @param fileName
	 * @return
	 */
	public static boolean existFile(String fileName){
		String filePath = getFilePath(fileName);
		File f = new File(filePath);
		return f.exists();
	}
	
	/**
	 * 
	 * 方法描述 : 缓存文件到本地
	 * @param is
	 * @param fileName
	 */
	public static void saveFile(InputStream is,String fileName){
		String filePath = getFilePath(fileName);
		File filesDir = new File(FILE_DIR);
		if(!filesDir.exists()){
			filesDir.mkdirs();
		}
		//文件
		File file=new File(filePath); 
		if(!file.exists()){
			try {
				file.createNewFile();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		/* 将文件写入SdCard */
		BufferedOutputStream os = null;
		try {
			os = new BufferedOutputStream(new FileOutputStream(file));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} 
		byte[] buff = new byte[1024 * 20];
		int len;
		try {
			while ((len = is.read(buff)) != -1) {
				os.write(buff, 0, len);
				os.flush();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			if(os!=null)
				os.close();
		} catch (IOException e) {
			e.printStackTrace();
		} 
	}
	
	
	/**
	 * 
	 * 方法描述 : 加载本地文件
	 * @param fileName
	 * @return
	 */
	public static InputStream  loadFile(String fileName){
		String filePath = getFilePath(fileName);
		InputStream is = null;
		try {
			is = new FileInputStream(filePath);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		return is;
	}
	
	/**
	 * 
	 * 方法描述 : 获取文件路径
	 * @param fileName
	 * @return
	 */
	private static String getFilePath(String fileName){
		fileName = fileName.substring(fileName.lastIndexOf("/")+1,fileName.length());
		return FILE_DIR + "/" + fileName;
	}
	/**
	 * 测试
	 */
	public static void main(String[] args) {
		String newDir = "/storage/sdcard1/test";
		boolean success = deleteDir(new File(newDir));
		if (success) {
			//System.out.println("Successfully deleted populated directory: "
			//		+ newDir);
		} else {
			//System.out.println("Failed to delete populated directory: "
			//		+ newDir);
		}
	}
	
	/**
     * 读取Assets文件夹中的图片资源
     * @param context
     * @param fileName
     * @return
     */
    public static Bitmap getImageFromAssetsFile(Context context, String fileName) {
        //获取应用的包名
        String packageName = context.getPackageName();
        //定义存放这些图片的内存路径
        String path="/data/data/"+packageName;
        //如果这个路径不存在则新建
        File file = new File(path);
        Bitmap image = null;
        boolean isExist = file.exists();
        if(!isExist){
            file.mkdirs();
        }
        //获取assets下的资源
        AssetManager am = context.getAssets();
        try {
            //图片放在img文件夹下
            InputStream is = am.open("img/"+fileName);
            image = BitmapFactory.decodeStream(is);
            FileOutputStream out = new FileOutputStream(path+"/"+fileName);
            //这个方法非常赞
            image.compress(Bitmap.CompressFormat.PNG,100,out);
            out.flush();
            out.close();
            is.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return image;
    }


	/**
	 * 获取网络图片文件夹路径
	 * 
	 * @return
	 */
	public static String getImagesPath(Context context) {
		String path = "";
		try {
			path = context.getCacheDir().toString()+"/image";
			File file = new File(path);
			if (!(file.exists()) && !(file.isDirectory())) {
				file.mkdir();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return path;
	}

	/**
	 * InputStream to String
	 * 
	 * @param is
	 * @return
	 */
	public static String convertStreamToString(InputStream is) {
		BufferedReader reader = new BufferedReader(new InputStreamReader(is));
		StringBuilder sb = new StringBuilder();
		String line = null;
		try {
			while ((line = reader.readLine()) != null) {
				sb.append(line + "/n");
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				is.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return sb.toString();
	}

	/**
	 * 写文件
	 * 
	 * @param filePath
	 * @return
	 * @throws IOException
	 */
	public static byte[] toBytes(File file) {
		FileInputStream in = null;
		ByteArrayOutputStream out = null;
		byte buffer[] = null;
		try {
			in = new FileInputStream(file);
			out = new ByteArrayOutputStream();
			int ch;
			while ((ch = in.read()) != -1) {
				out.write(ch);
			}
			buffer = out.toByteArray();
		} catch (FileNotFoundException e) {
		} catch (IOException e) {
		} finally {
			try {
				if (in != null)
					in.close();
				if (out != null)
					out.close();
			} catch (IOException e) {
			}
		}
		return buffer;
	}

	/**
	 * 获取文件大小
	 * 
	 * @param filePath
	 * @return
	 */
	public static long getFileSize(String filePath) {
		long size = 0;
		File file = new File(filePath);
		if (file != null && file.exists()) {
			size = file.length();
		}
		return size;
	}

}
