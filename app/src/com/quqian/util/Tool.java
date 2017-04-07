package com.quqian.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.quqian.activity.LoginActivity;
import com.quqian.been.UserMode;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;

public class Tool {

	// 锟斤拷证锟街伙拷锟�
	public static boolean isMobileNO(String mobiles) {
		Pattern p = Pattern
				.compile("^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$");
		Matcher m = p.matcher(mobiles);
		return m.matches();
	}

	// 锟斤拷证锟斤拷锟斤拷
	public static boolean isEmail(String email) {
		if (null == email || "".equals(email))
			return false;
		// Pattern p = Pattern.compile("\\w+@(\\w+.)+[a-z]{2,3}"); //锟斤拷匹锟斤拷
		Pattern p = Pattern
				.compile("\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*");// 锟斤拷锟斤拷匹锟斤拷
		Matcher m = p.matcher(email);
		return m.matches();
	}

	// 锟斤拷证锟绞憋拷
	public static boolean isZipNO(String zipString) {
		String str = "^[1-9][0-9]{5}$";
		return Pattern.compile(str).matcher(zipString).matches();
	}

	// 保存为临时的文件
	public static void writeData(Context ctx, String name, String Key,
			String value) {
		SharedPreferences mySharedPreferences = ctx.getSharedPreferences(name,
				Activity.MODE_PRIVATE);
		SharedPreferences.Editor editor = mySharedPreferences.edit();
		editor.putString(Key, value);
		editor.commit();
	}

	// 读取数据
	public static String readData(Context ctx, String name, String Key) {
		SharedPreferences mySharedPreferences = ctx.getSharedPreferences(name,
				Activity.MODE_PRIVATE);
		// 使用getString方法获得value，注意第2个参数是value的默认值
		return mySharedPreferences.getString(Key, "");
	}

	// 获取用户的信息
	public static UserMode getUser(Context ctx) {
		// 判断当前的用户是否已经登录了
		String zhanghu = Tool.readData(ctx, "loginState", "zhanghu");
		if (zhanghu.length() == 0 || zhanghu == null) {
			return null;
		}
		UserMode oAuth_1 = new UserMode();
		oAuth_1.setYhzh(Tool.readData(ctx, "user", "yhzh"));
		oAuth_1.setKyye(Tool.readData(ctx, "user", "kyye"));
		oAuth_1.setDjje(Tool.readData(ctx, "user", "djje"));
		oAuth_1.setYzze(Tool.readData(ctx, "user", "yzze"));
		oAuth_1.setZhze(Tool.readData(ctx, "user", "zhze"));
		oAuth_1.setTyjze(Tool.readData(ctx, "user", "tyjze"));
		oAuth_1.setNc(Tool.readData(ctx, "user", "nc"));
		oAuth_1.setCsrq(Tool.readData(ctx, "user", "csrq"));
		oAuth_1.setXb(Tool.readData(ctx, "user", "xb"));
		oAuth_1.setWdfwm(Tool.readData(ctx, "user", "wdfwm"));
		oAuth_1.setSjh(Tool.readData(ctx, "user", "sjh"));
		oAuth_1.setSfzh(Tool.readData(ctx, "user", "sfzh"));
		oAuth_1.setXm(Tool.readData(ctx, "user", "xm"));
		oAuth_1.setCodeError(Tool.readData(ctx, "user", "codeError"));
		oAuth_1.setSjsfsz(Tool.readData(ctx, "user", "sjsfsz"));
		oAuth_1.setSfzsfrz(Tool.readData(ctx, "user", "sfzsfrz"));
		oAuth_1.setTxmmsfsz(Tool.readData(ctx, "user", "txmmsfsz"));
		oAuth_1.setYjsfsz(Tool.readData(ctx, "user", "yjsfsz"));
		oAuth_1.setShoushiCode(Tool.readData(ctx, "user", "shoushiCode"));
		oAuth_1.setFwmlj(Tool.readData(ctx, "user", "fwmlj"));
		oAuth_1.setZnxwdts(Tool.readData(ctx, "user", "znxwdts"));
		oAuth_1.setZnxwdts(Tool.readData(ctx, "user", "cgkyye"));
		oAuth_1.setZnxwdts(Tool.readData(ctx, "user", "cgdjje"));
		oAuth_1.setZnxwdts(Tool.readData(ctx, "user", "cgyzze"));
		oAuth_1.setZnxwdts(Tool.readData(ctx, "user", "cgzhze"));
		return oAuth_1;
	}

	// 获取用户的信息
	public static UserMode get_bendi_User(Context ctx) {

		UserMode oAuth_1 = new UserMode();
		oAuth_1.setYhzh(Tool.readData(ctx, "user", "yhzh"));
		oAuth_1.setKyye(Tool.readData(ctx, "user", "kyye"));
		oAuth_1.setDjje(Tool.readData(ctx, "user", "djje"));
		oAuth_1.setYzze(Tool.readData(ctx, "user", "yzze"));
		oAuth_1.setZhze(Tool.readData(ctx, "user", "zhze"));
		oAuth_1.setTyjze(Tool.readData(ctx, "user", "tyjze"));
		oAuth_1.setNc(Tool.readData(ctx, "user", "nc"));
		oAuth_1.setCsrq(Tool.readData(ctx, "user", "csrq"));
		oAuth_1.setXb(Tool.readData(ctx, "user", "xb"));
		oAuth_1.setWdfwm(Tool.readData(ctx, "user", "wdfwm"));
		oAuth_1.setSjh(Tool.readData(ctx, "user", "sjh"));
		oAuth_1.setSfzh(Tool.readData(ctx, "user", "sfzh"));
		oAuth_1.setXm(Tool.readData(ctx, "user", "xm"));
		oAuth_1.setCodeError(Tool.readData(ctx, "user", "codeError"));
		oAuth_1.setSjsfsz(Tool.readData(ctx, "user", "sjsfsz"));
		oAuth_1.setSfzsfrz(Tool.readData(ctx, "user", "sfzsfrz"));
		oAuth_1.setTxmmsfsz(Tool.readData(ctx, "user", "txmmsfsz"));
		oAuth_1.setYjsfsz(Tool.readData(ctx, "user", "yjsfsz"));
		oAuth_1.setShoushiCode(Tool.readData(ctx, "user", "shoushiCode"));
		oAuth_1.setFwmlj(Tool.readData(ctx, "user", "fwmlj"));
		oAuth_1.setZnxwdts(Tool.readData(ctx, "user", "znxwdts"));
		oAuth_1.setZnxwdts(Tool.readData(ctx, "user", "cgkyye"));
		oAuth_1.setZnxwdts(Tool.readData(ctx, "user", "cgdjje"));
		oAuth_1.setZnxwdts(Tool.readData(ctx, "user", "cgyzze"));
		oAuth_1.setZnxwdts(Tool.readData(ctx, "user", "cgzhze"));
		return oAuth_1;
	}

	public static String getMD5(String val) throws NoSuchAlgorithmException {

		MessageDigest bmd5 = MessageDigest.getInstance("MD5");
		bmd5.update(val.getBytes());
		int i;
		StringBuffer buf = new StringBuffer();
		byte[] b = bmd5.digest();
		for (int offset = 0; offset < b.length; offset++) {
			i = b[offset];
			if (i < 0)
				i += 256;
			if (i < 16)
				buf.append("0");
			buf.append(Integer.toHexString(i));
		}
		return buf.toString();

	}

	
	public static String timechuo(){
		int time = (int) (System.currentTimeMillis());
		Timestamp tsTemp = new Timestamp(time);
		String ts = tsTemp.toString();
		return ts;
	}
}
