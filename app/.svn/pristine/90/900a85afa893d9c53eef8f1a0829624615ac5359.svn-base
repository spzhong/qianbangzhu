package com.quqian.util;

import java.util.HashMap;

import android.os.Bundle;

/**
 * 用于SingleTask的类的参数传递
 */
public class StaticVariable {

	private static HashMap<String, String> variableMap = new HashMap<String, String>();

	/**
	 * 赋值
	 * @param key
	 * @param value
	 */
	public static void put(String key, String value) {
		variableMap.put(key, value);
	}

	/**
	 *  @param key
	 * 
	 * @return value
	 */
	public static String get(String key) {
		String val = variableMap.get(key);
		val = (val == null ? "" : val);
		variableMap.remove(key);
		return val;
	}

	/**
	 * 注释规范�?PolicyIndexActivity to IndexActivity.（用于哪里） 判断是否执行刷新。（作用�? *
	 * "":不执行；"1":执行。（值说明）
	 */
	public static String sv_example = "sv_example";

	/**
	 * To IndexActivity "1"表示跳转到IndexActivity
	 * */
	public static String sv_toIndex = "to_index";

	/**
	 * To MineIndexActivity "1"表示跳转到MineIndexActivity
	 * */
	public static String sv_toMine = "to_mine";
	public static String sv_toMore = "to_more";
	/**
	 * PolicyLoginActivity To PolicyIndexActivity
	 * */
	public static String xiaoxi = "";
	public static String sv_pl_pi_url = "pl_pi_url";

	/**
	 * AccountGuidActivity To WealthActvity
	 */
	public static Bundle bundleToWealth = null;

}
