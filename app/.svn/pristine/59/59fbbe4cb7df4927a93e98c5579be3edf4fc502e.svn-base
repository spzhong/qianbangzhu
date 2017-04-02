package com.quqian.util.view;

import java.text.SimpleDateFormat;
import java.util.Date;

import android.content.Context;

public class ConvertUtil {
	public static String getString(Object o){
		String re = "";
		try{
			re = String.valueOf(o);
		}catch(Exception ex){
			re = "";
		}
		return re;
	}
	
	public static int getInt(Object o){
		int re = 0;
		try{
			re = Integer.parseInt(getString(o));
		}catch(Exception ex){
			re = 0;
		}
		return re;
	}
	
	public static int dip2px(Context context, float dpValue){
		float scale = context.getResources().getDisplayMetrics().density;
		return (int)(dpValue * scale + 0.5f);
	}

	public static int px2dip(Context context, float pxValue){
		float scale = context.getResources().getDisplayMetrics().density;
		return (int)(pxValue / scale + 0.5f);
	}
	

	public static float getFloat(Object o){
		float re = 0;
		try{
			re = Float.parseFloat(getString(o));
		}catch(Exception ex){
			re = 0;
		}
		return re;
	}
	
	public static String getDate(Date date,String format)
	{
		SimpleDateFormat sf = new SimpleDateFormat(format);
		return sf.format(date);
	}
}
