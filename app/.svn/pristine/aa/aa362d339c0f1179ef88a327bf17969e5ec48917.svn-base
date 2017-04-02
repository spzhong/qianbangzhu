package com.quqian.util;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.os.Build;
import android.util.Log;

public class CommonUtil {

	private static SharedPreferences mShareConfig;
	private static Editor conEdit;

	/**
	 * 键为： key+userForKey+extraInfoForKey
	 * 
	 * @param context
	 * @param key
	 *            基础键
	 * @param value
	 *            值
	 * @param userForKey
	 *            需要以用户区分的信息 此值不能为空
	 * @param extraInfoForKey
	 *            其他信息 可为空
	 * 
	 */
	public static void addConfigInfo(Context context, String key, String value,
			String userForKey, String extraInfoForKey) {
		String mKey = "";
		if (StringUtils.isNotEmpty(key)) {
			mKey += key;
		}
		if (StringUtils.isNotEmpty(userForKey)) {
			mKey += userForKey;
		}
		if (StringUtils.isNotEmpty(extraInfoForKey)) {
			mKey += extraInfoForKey;
		}

		if (StringUtils.isNotEmpty(mKey)) {
			mShareConfig = context.getSharedPreferences("QuQian",
					Activity.MODE_PRIVATE);
			conEdit = mShareConfig.edit();
			conEdit.putString(mKey, value);
			conEdit.commit();
		}

	}

	/**
	 * 键为： key+userForKey+extraInfoForKey
	 * 
	 * @param context
	 * @param key
	 *            基础键
	 * @param value
	 *            值
	 * @param userForKey
	 *            需要以用户区分的信息 此值不能为空
	 * @param extraInfoForKey
	 *            其他信息 可为空
	 * 
	 */
	public static void addConfigInfo(Context context, String key,
			boolean value, String userForKey, String extraInfoForKey) {
		String mKey = "";
		if (StringUtils.isNotEmpty(key)) {
			mKey += key;
		}
		if (StringUtils.isNotEmpty(userForKey)) {
			mKey += userForKey;
		}
		if (StringUtils.isNotEmpty(extraInfoForKey)) {
			mKey += extraInfoForKey;
		}
		if (StringUtils.isNotEmpty(mKey)) {
			mShareConfig = context.getSharedPreferences("QuQian",
					Activity.MODE_PRIVATE);
			conEdit = mShareConfig.edit();
			conEdit.putBoolean(mKey, value);
			conEdit.commit();

		}
	}

	/**
	 * 键为： key+userForKey+extraInfoForKey
	 * 
	 * @param context
	 * @param key
	 *            基础键
	 * @param value
	 *            值
	 * @param userForKey
	 *            需要以用户区分的信息 此值不能为空
	 * @param extraInfoForKey
	 *            其他信息 可为空
	 * 
	 */
	public static String getStringByKey(Context context, String key,
			String userForKey, String extraInfoForKey) {
		String mKey = "";
		if (StringUtils.isNotEmpty(key)) {
			mKey += key;
		}
		if (StringUtils.isNotEmpty(userForKey)) {
			mKey += userForKey;
		}
		if (StringUtils.isNotEmpty(extraInfoForKey)) {
			mKey += extraInfoForKey;
		}
		String value = null;
		if (StringUtils.isNotEmpty(mKey)) {
			mShareConfig = context.getSharedPreferences("QuQian",
					Activity.MODE_PRIVATE);
			if (null != mShareConfig) {
				value = mShareConfig.getString(mKey, "");
			}
		}
		return value;
	}

	/**
	 * 键为： key+userForKey+extraInfoForKey
	 * 
	 * @param context
	 * @param key
	 *            基础键
	 * @param value
	 *            值
	 * @param userForKey
	 *            需要以用户区分的信息 此值不能为空
	 * @param extraInfoForKey
	 *            其他信息 可为空
	 * 
	 */
	public static boolean getBooleanByKey(Context context, String key,
			String userForKey, String extraInfoForKey) {
		String mKey = "";
		if (StringUtils.isNotEmpty(key)) {
			mKey += key;
		}
		if (StringUtils.isNotEmpty(userForKey)) {
			mKey += userForKey;
		}
		if (StringUtils.isNotEmpty(extraInfoForKey)) {
			mKey += extraInfoForKey;
		}
		boolean value = false;
		if (StringUtils.isNotEmpty(mKey)) {
			mShareConfig = context.getSharedPreferences("QuQian",
					Activity.MODE_PRIVATE);
			if (null != mShareConfig) {
				value = ((Boolean) mShareConfig.getBoolean(mKey, false))
						.booleanValue();
			}
		}
		return value;
	}

	public static void clearByKey(Context context, String key,
			String userForKey, String extraInfoForKey) {
		String mKey = "";
		if (StringUtils.isNotEmpty(key)) {
			mKey += key;
		}
		if (StringUtils.isNotEmpty(userForKey)) {
			mKey += userForKey;
		}
		if (StringUtils.isNotEmpty(extraInfoForKey)) {
			mKey += extraInfoForKey;
		}

		if (StringUtils.isNotEmpty(mKey)) {
			mShareConfig = context.getSharedPreferences("QuQian",
					Activity.MODE_PRIVATE);
			conEdit = mShareConfig.edit();
			conEdit.remove(mKey);
			conEdit.commit();
		}
	}

}
