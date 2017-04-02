package com.quqian.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Bitmap.CompressFormat;
import android.graphics.Bitmap.Config;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.media.ExifInterface;
import android.util.Log;

public class BitmapUtil {
	/**
	 * 图片压缩
	 * 
	 * @param srcPath
	 *            图片路径
	 */
	public static Bitmap getimage(String srcPath) {
		if ("".equals(srcPath) || null == srcPath || srcPath.length() == 0) {
			return null;
		}
		BitmapFactory.Options newOpts = new BitmapFactory.Options();
		// 开始读入图片，此时把options.inJustDecodeBounds 设回true了
		newOpts.inJustDecodeBounds = true;
		newOpts.inInputShareable = true;
		newOpts.inPurgeable = true;// 设置图片可以被回收
		newOpts.inPreferredConfig = Config.RGB_565;
		Bitmap bitmap = BitmapFactory.decodeFile(srcPath, newOpts);// 此时返回bm为空

		newOpts.inJustDecodeBounds = false;
		// int w = newOpts.outWidth;
		// int h = newOpts.outHeight;
		float hh = 800f;// 这里设置高度为800f
		float ww = 600f;// 这里设置宽度为600f
		// 缩放比。由于是固定比例缩放，只用高或者宽其中一个数据进行计算即可
		int be = 1;// be=1表示不缩放
		int tempbe1 = 1;
		int tempbe2 = 1;
		// if (w > h && w > ww) {// 如果宽度大的话根据宽度固定大小缩放
		tempbe1 = (int) (newOpts.outWidth / ww);
		// }
		// if (w < h && h > hh) {// 如果高度高的话根据宽度固定大小缩放
		tempbe2 = (int) (newOpts.outHeight / hh);
		// }
		be = tempbe1 < tempbe2 ? tempbe1 : tempbe2;
		if (be <= 0)
			be = 1;
		newOpts.inSampleSize = be;// 设置缩放比例
		// 重新读入图片，注意此时已经把options.inJustDecodeBounds 设回false了
		try {
			bitmap = BitmapFactory.decodeFile(srcPath, newOpts);
		} catch (OutOfMemoryError e) {
			e.printStackTrace();
			if (null != bitmap) {
				return bitmap;
			}
		}
		if (null == bitmap) {
			return null;
		}
		bitmap = compressImage(bitmap, 100);
		return isRotaing(srcPath, bitmap);
	}

	public static Bitmap compressImageDeep(Bitmap image, int q) {
		if (null == image) {
			Log.e("compressImageDeep", "image = null");
			return null;
		}
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		image.compress(Bitmap.CompressFormat.JPEG, 100, baos);// 质量压缩方法，这里100表示不压缩，把压缩后的数据存放到baos中
		while (baos.toByteArray().length / 1024 > 100) { // 循环判断如果压缩后图片是否大于100kb,大于继续压缩
			image = compressImage(image, q);
			baos.reset();// 重置baos即清空baos
			image.compress(Bitmap.CompressFormat.JPEG, 100, baos);
		}
		return image;
	}

	public static Bitmap compressImage(Bitmap image, int q) {
		if (null == image) {
			Log.e("compressImage", "image = null");
			return null;
		}
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		image.compress(Bitmap.CompressFormat.JPEG, 100, baos);// 质量压缩方法，这里100表示不压缩，把压缩后的数据存放到baos中
		int compress = 100;
		while (baos.toByteArray().length / 1024 > q && compress >= 10) { // 循环判断如果压缩后图片是否大于100kb,大于继续压缩
			baos.reset();// 重置baos即清空baos
			if (compress == 10) {
				compress -= 9;
			} else {
				compress -= 10;// 每次都减少10
			}

			image.compress(Bitmap.CompressFormat.JPEG, compress, baos);// 这里压缩options%，把压缩后的数据存放到baos中

		}
		ByteArrayInputStream isBm = new ByteArrayInputStream(baos.toByteArray());// 把压缩后的数据baos存放到ByteArrayInputStream中
		final BitmapFactory.Options options = new BitmapFactory.Options();
		options.inInputShareable = true;
		options.inPurgeable = true;// 设置图片可以被回收
		options.inPreferredConfig = Config.RGB_565;
		try {
			image = BitmapFactory.decodeStream(isBm, null, options);// 把ByteArrayInputStream数据生成图片
		} catch (OutOfMemoryError e) {
			// TODO: handle exception
			if (null != image) {
				return image;
			}
		}
		baos.reset();// 重置baos即清空baos
		image.compress(Bitmap.CompressFormat.JPEG, 100, baos);
		
		if (baos != null) {
			try {
				baos.flush();
				baos.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return image;
	}

	public Bitmap revitionImageSize(Context context, String path, int size)
			throws IOException {
		// 取得图片
		InputStream temp = context.getAssets().open(path);
		BitmapFactory.Options options = new BitmapFactory.Options();
		// 这个参数代表，不为bitmap分配内存空间，只记录一些该图片的信息（例如图片大小），说白了就是为了内存优化
		options.inJustDecodeBounds = true;
		// 通过创建图片的方式，取得options的内容（这里就是利用了java的地址传递来赋值）
		BitmapFactory.decodeStream(temp, null, options);
		// 关闭流
		temp.close();

		// 生成压缩的图片
		int i = 0;
		Bitmap bitmap = null;
		while (true) {
			// 这一步是根据要设置的大小，使宽和高都能满足
			if ((options.outWidth >> i <= size)
					&& (options.outHeight >> i <= size)) {
				// 重新取得流，注意：这里一定要再次加载，不能二次使用之前的流！
				temp = context.getAssets().open(path);
				// 这个参数表示 新生成的图片为原始图片的几分之一。
				options.inSampleSize = (int) Math.pow(2.0D, i);
				// 这里之前设置为了true，所以要改为false，否则就创建不出图片
				options.inJustDecodeBounds = false;

				bitmap = BitmapFactory.decodeStream(temp, null, options);
				break;
			}
			i += 1;
		}
		return bitmap;
	}

	/**
	 * 
	 * @param bmp
	 *            位图
	 * @param outFilePath
	 *            输出文件路径
	 * @param quality
	 *            压缩率 (80表示压缩掉20%; 如果不压缩是100，表示压缩率为0)
	 * @return
	 */
	public static boolean saveBitmap2file(Bitmap bmp, String outFilePath,
			int quality) {
		CompressFormat format = Bitmap.CompressFormat.JPEG;
		OutputStream stream = null;
		try {
			stream = new FileOutputStream(outFilePath);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}

		return bmp.compress(format, quality, stream);
	}

	/**
	 * 从网络上获取图片转为位图bitmap(不能在ui主线程中运行，需要在子线程中运行)
	 * 
	 * @param context
	 * @param url
	 *            图片地址
	 * @throws IOException
	 */
	// public static Bitmap getNetImageTodBitmap(Context context, String url)
	// throws IOException {
	// Bitmap bitmap = null;
	// if (null != url && url.length() > 0) {
	// // RequestCreator creator = Picasso.with(context).load(url);
	// // bitmap = creator.get();
	// DisplayImageOptions options = new DisplayImageOptions.Builder()
	// .resetViewBeforeLoading(true).cacheOnDisc(true)
	// .imageScaleType(ImageScaleType.EXACTLY_STRETCHED)
	// .bitmapConfig(Bitmap.Config.RGB_565)
	// .considerExifParams(true).build();
	// ImageLoader.getInstance().loadImageSync(url, options);
	// }
	// return bitmap;
	// }

	/**
	 * 旋转图片
	 * 
	 * @param image
	 * @param angle2
	 *            旋转角度
	 * @return
	 */
	public static Bitmap rotaingImageView(Bitmap image, int angle2) {
		if (null == image) {
			Log.e("rotaingImageView", "image = null");
			return null;
		}
		// 旋转图片 动作
		Matrix matrix = new Matrix();
		matrix.postRotate(angle2);
		// 创建新的图片
		try {
			image = Bitmap.createBitmap(image, 0, 0, image.getWidth(),
					image.getHeight(), matrix, true);
		} catch (OutOfMemoryError e) {
			Log.e("---","rotaingImageView OutOfMemoryError");
			if (null != image) {
				return image;
			}
		}

		return image;
	}

	/**
	 * 识别图片方向并自动旋转角度
	 * 
	 * @param imgpath
	 * @param bm
	 * @return
	 */
	public static Bitmap isRotaing(String imgpath, Bitmap bm) {
		if (null == bm) {
			Log.e("isRotaing", "bm = null");
			return null;
		}
		int digree = 0;
		ExifInterface exif = null;
		try {
			exif = new ExifInterface(imgpath);
		} catch (IOException e) {
			e.printStackTrace();
			exif = null;
		}
		if (exif != null) {
			// 读取图片中相机方向信息
			int ori = exif.getAttributeInt(ExifInterface.TAG_ORIENTATION,
					ExifInterface.ORIENTATION_UNDEFINED);
			// 计算旋转角度
			switch (ori) {
			case ExifInterface.ORIENTATION_ROTATE_90:
				digree = 90;
				break;
			case ExifInterface.ORIENTATION_ROTATE_180:
				digree = 180;
				break;
			case ExifInterface.ORIENTATION_ROTATE_270:
				digree = 270;
				break;
			default:
				digree = 0;
				break;
			}
		}
		if (digree != 0) {
			try {
				// 旋转图片
				Matrix m = new Matrix();
				m.postRotate(digree);
				bm = Bitmap.createBitmap(bm, 0, 0, bm.getWidth(),
						bm.getHeight(), m, true);
				Log.d("isRotaing", "旋转图片" + digree + "度");
			} catch (OutOfMemoryError e) {
				e.printStackTrace();
				Log.e("isRotaing", "哎呦，就旋转个图片就溢出了。。。。");
				if (null != bm) {
					return bm;
				}
			}
		}
		return bm;
	}

	public static byte[] imageZoom(Bitmap bitMap) {
		if (null == bitMap) {
			Log.e("imageZoom", "bitMap = null");
			return null;
		}
		// 图片允许最大空间 单位：KB
		double maxSize = 100.00;
		// 将bitmap放至数组中，意在bitmap的大小（与实际读取的原文件要大）
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		bitMap.compress(Bitmap.CompressFormat.JPEG, 100, baos);
		byte[] b = baos.toByteArray();
		// 将字节换成KB
		double mid = b.length / 1024;
		// 判断bitmap占用空间是否大于允许最大空间 如果大于则压缩 小于则不压缩
		if (mid > maxSize) {
			// 获取bitmap大小 是允许最大大小的多少倍
			double i = mid / maxSize;
			// 开始压缩 此处用到平方根 将宽带和高度压缩掉对应的平方根倍
			// （1.保持刻度和高度和原bitmap比率一致，压缩后也达到了最大大小占用空间的大小）
			bitMap = zoomImage(bitMap, bitMap.getWidth() / Math.sqrt(i),
					bitMap.getHeight() / Math.sqrt(i));
			// 将bitmap放至数组中，意在bitmap的大小（与实际读取的原文件要大）
			baos = null;
			baos = new ByteArrayOutputStream();
			bitMap.compress(Bitmap.CompressFormat.JPEG, 100, baos);
			b = baos.toByteArray();
		}
		return b;
	}

	/***
	 * 图片的缩放方法
	 * 
	 * @param bgimage
	 *            ：源图片资源
	 * @param newWidth
	 *            ：缩放后宽度
	 * @param newHeight
	 *            ：缩放后高度
	 * @return
	 */
	public static Bitmap zoomImage(Bitmap bgimage, double newWidth,
			double newHeight) {
		if (null == bgimage) {
			Log.e("zoomImage", "bgimage = null");
			return null;
		}
		// 获取这个图片的宽和高
		float width = bgimage.getWidth();
		float height = bgimage.getHeight();
		// 创建操作图片用的matrix对象
		Matrix matrix = new Matrix();
		// 计算宽高缩放率
		float scaleWidth = ((float) newWidth) / width;
		float scaleHeight = ((float) newHeight) / height;
		// 缩放图片动作
		matrix.postScale(scaleWidth, scaleHeight);
		Bitmap bitmap = null;
		try {
			bitmap = Bitmap.createBitmap(bgimage, 0, 0, (int) width,
					(int) height, matrix, true);
		} catch (OutOfMemoryError e) {
			e.printStackTrace();
			Log.e("zoomImage", "啊啊啊啊啊啊啊啊啊啊啊啊啊，内存溢出了。。。");
			if (null != bitmap) {
				return bitmap;
			}
		}
		return bitmap;
	}
	
	
	  public static Bitmap readBitMap(Context context, int resId){
	    	BitmapFactory.Options opt = new BitmapFactory.Options();
	    	opt.inPreferredConfig = Bitmap.Config.RGB_565;
	    	opt.inPurgeable = true; 
	    	opt.inInputShareable = true;
	    	//获取资源图片 
	    	InputStream is = context.getResources().openRawResource(resId);
	    	return BitmapFactory.decodeStream(is,null,opt); 
	    }
	
}
