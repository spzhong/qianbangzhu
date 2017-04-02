package com.quqian.util.view;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.example.quqian.R;


import android.annotation.SuppressLint;
import android.app.Dialog;
import android.content.Context;
import android.view.Display;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup.LayoutParams;
import android.view.Window;
import android.view.WindowManager;
import android.widget.LinearLayout;
import android.widget.TextView;

public class WheelViewDialog {

	/**
	 * 任意列选择
	 * 
	 * @param context
	 * @param title
	 *            标题
	 * @param callback
	 *            回调接口 callback.selected(String[] results) 与 datas顺序致对应返回
	 * @param datas
	 *            数据集String[]... datas,多少列就多少个数组
	 */
	@SuppressWarnings("deprecation")
	@SuppressLint({ "NewApi", "InflateParams" })
	public static void showSelectDialog(Context context, String title,
			int visibleItems, final WheelCallback callback,
			final String[]... datas) {
		final Dialog dialog = new Dialog(context, R.style.dialogw);
		// Dialog布局
		final View llContent = LayoutInflater.from(context).inflate(
				R.layout.wheelview_dialog, null);

		// 放置WheelView的容器控件
		LinearLayout container = (LinearLayout) llContent
				.findViewById(R.id.layout_container);

		LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
				LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT, 1.0f);
		params.gravity = Gravity.CENTER;

		int size = datas.length;
		for (int i = 0; i < size; i++) {
			final WheelView wheelView = new WheelView(context);
			wheelView.setVisibleItems(visibleItems);
			wheelView.setCyclic(false);
			wheelView.setTag(i);
			wheelView.setAdapter(new ArrayWheelAdapter<String>(datas[i]));
			wheelView.setCurrentItem(datas[i].length / 2);
			container.addView(wheelView, params);
		}

		TextView btnPositive = (TextView) llContent
				.findViewById(R.id.btn_positive);
		TextView btnNegative = (TextView) llContent
				.findViewById(R.id.btn_negative);
		TextView tvTitle = (TextView) llContent.findViewById(R.id.tv_title);
		tvTitle.setText(title);
		btnPositive.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				String[] results = new String[datas.length];
				for (int i = 0; i < datas.length; i++) {
					WheelView wheelView = (WheelView) llContent
							.findViewWithTag(i);
					String value = datas[i][wheelView.getCurrentItem()];
					results[i] = value;
				}
				if (callback != null) {
					callback.selected(results);
				}
				dialog.cancel();
			}
		});
		btnNegative.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				dialog.cancel();
			}
		});

		dialog.setContentView(llContent);

		Window dialogWindow = dialog.getWindow();
		WindowManager.LayoutParams lp = dialogWindow.getAttributes();
		dialogWindow.setGravity(Gravity.LEFT | Gravity.BOTTOM); // 对话框放在底部
		WindowManager wm = dialogWindow.getWindowManager();
		Display d = wm.getDefaultDisplay();
		lp.width = d.getWidth(); // 修改宽度
		lp.x = 0; // 如果居左，则相对左边距离
		lp.y = 0; // 如果居底部，则相对底部的距离
		dialogWindow.setAttributes(lp);
		dialogWindow.setWindowAnimations(R.style.AnimBottom); // 添加动画
		if (!dialog.isShowing()) {
			dialog.show();
		}
	}

	/**
	 * 任意列选择 返回所选项的序号
	 * 
	 * @param context
	 * @param title
	 *            标题
	 * @param callback
	 *            回调接口 callback.selected(int[] results) 与 datas顺序致对应返回序号
	 * @param datas
	 *            数据集String[]... datas,多少列就多少个数组
	 */
	@SuppressWarnings("deprecation")
	@SuppressLint({ "NewApi", "InflateParams" })
	public static void showSelectDialog(Context context, String title,
			int visibleItems, int currentItem,
			final WheelCallbackForIndex callback, final String[]... datas) {
		final Dialog dialog = new Dialog(context, R.style.dialogw);
		// Dialog布局
		final View llContent = LayoutInflater.from(context).inflate(
				R.layout.wheelview_dialog, null);

		// 放置WheelView的容器控件
		LinearLayout container = (LinearLayout) llContent
				.findViewById(R.id.layout_container);

		LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
				LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT, 1.0f);
		params.gravity = Gravity.CENTER;

		int size = datas.length;
		for (int i = 0; i < size; i++) {
			final WheelView wheelView = new WheelView(context);
			wheelView.setVisibleItems(visibleItems);
			wheelView.setCyclic(false);
			wheelView.setTag(i);
			wheelView.setAdapter(new ArrayWheelAdapter<String>(datas[i]));
			wheelView.setCurrentItem(currentItem);
			container.addView(wheelView, params);
		}

		TextView btnPositive = (TextView) llContent
				.findViewById(R.id.btn_positive);
		TextView btnNegative = (TextView) llContent
				.findViewById(R.id.btn_negative);
		TextView tvTitle = (TextView) llContent.findViewById(R.id.tv_title);
		tvTitle.setText(title);
		btnPositive.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				int[] results = new int[datas.length];
				for (int i = 0; i < datas.length; i++) {
					WheelView wheelView = (WheelView) llContent
							.findViewWithTag(i);
					results[i] = wheelView.getCurrentItem();
				}
				if (callback != null) {
					callback.selected(results);
				}
				dialog.cancel();
			}
		});
		btnNegative.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				dialog.cancel();
			}
		});

		dialog.setContentView(llContent);

		Window dialogWindow = dialog.getWindow();
		WindowManager.LayoutParams lp = dialogWindow.getAttributes();
		dialogWindow.setGravity(Gravity.LEFT | Gravity.BOTTOM); // 对话框放在底部
		WindowManager wm = dialogWindow.getWindowManager();
		Display d = wm.getDefaultDisplay();
		lp.width = d.getWidth(); // 修改宽度
		lp.x = 0; // 如果居左，则相对左边距离
		lp.y = 0; // 如果居底部，则相对底部的距离
		dialogWindow.setAttributes(lp);
		dialogWindow.setWindowAnimations(R.style.AnimBottom); // 添加动画
		if (!dialog.isShowing()) {
			dialog.show();
		}
	}

	/**
	 * 城市选择
	 * 
	 * @param context
	 * @param title
	 *            标题
	 * @param callback
	 *            回调接口 callback.selected(province, city);
	 * @param datas
	 *            数据集合 Map<String,List<String>> datas key为省份，Value为市的List集合
	 */
	@SuppressLint("InflateParams")
	@SuppressWarnings("deprecation")
	public static void showSelectCityDialog(Context context, String title,
			final WheelCallback callback, final Map<String, List<String>> datas) {
		final Dialog dialog = new Dialog(context, R.style.dialogw);
		final View llContent = LayoutInflater.from(context).inflate(
				R.layout.wheelview_dialog, null);
		LinearLayout container = (LinearLayout) llContent
				.findViewById(R.id.layout_container);

		LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
				LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT, 1.0f);
		params.gravity = Gravity.CENTER;
		final List<String> provinces = new ArrayList<String>();
		Set<String> set = datas.keySet();
		Iterator<String> iterator = set.iterator();
		while (iterator.hasNext()) {
			provinces.add(iterator.next());
		}

		final WheelView provinceWheel = new WheelView(context);
		// provinceWheel.setLabel("省");
		provinceWheel.setVisibleItems(5);
		provinceWheel.setCyclic(false);
		provinceWheel.setAdapter(new ListWheelAdapter<String>(provinces));
		provinceWheel.setCurrentItem(provinces.size() / 2);
		container.addView(provinceWheel, params);

		String key = provinces.get(provinces.size() / 2);
		List<String> citys = datas.get(key);
		final WheelView cityWheel = new WheelView(context);
		// cityWheel.setLabel("市");
		cityWheel.setVisibleItems(5);
		cityWheel.setCyclic(false);
		cityWheel.setAdapter(new ListWheelAdapter<String>(citys));
		cityWheel.setCurrentItem(citys.size() / 2);
		container.addView(cityWheel, params);

		provinceWheel.addChangingListener(new OnWheelChangedListener() {

			@Override
			public void onChanged(WheelView wheel, int oldValue, int newValue) {
				List<String> citys = datas.get(provinces.get(newValue));
				cityWheel.setAdapter(new ListWheelAdapter<String>(citys));
				cityWheel.setCurrentItem(citys.size() / 2, true);
			}
		});

		TextView btnPositive = (TextView) llContent
				.findViewById(R.id.btn_positive);
		TextView btnNegative = (TextView) llContent
				.findViewById(R.id.btn_negative);
		TextView tvTitle = (TextView) llContent.findViewById(R.id.tv_title);
		tvTitle.setText(title);
		btnPositive.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				String province = provinces.get(provinceWheel.getCurrentItem());
				List<String> citys = datas.get(province);
				String city = citys.get(cityWheel.getCurrentItem());
				if (callback != null) {
					callback.selected(province, city);
				}
				dialog.cancel();
			}
		});
		btnNegative.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				dialog.cancel();
			}
		});
		dialog.setContentView(llContent);

		Window dialogWindow = dialog.getWindow();
		WindowManager.LayoutParams lp = dialogWindow.getAttributes();
		dialogWindow.setGravity(Gravity.LEFT | Gravity.BOTTOM);
		WindowManager wm = dialogWindow.getWindowManager();
		Display d = wm.getDefaultDisplay();
		lp.width = d.getWidth();
		lp.x = 0;
		lp.y = 0;
		dialogWindow.setAttributes(lp);
		dialogWindow.setWindowAnimations(R.style.AnimBottom);
		if (!dialog.isShowing()) {
			dialog.show();
		}
	}

	/**
	 * 时间选择
	 * 
	 * @param context
	 * @param title
	 * @param callback
	 *            void selected(String hour,String minute)
	 */
	@SuppressLint("InflateParams")
	@SuppressWarnings("deprecation")
	public static void showSelectTimeDialog(Context context, String title,
			final WheelCallback callback) {
		final Dialog dialog = new Dialog(context, R.style.dialogw);
		final View llContent = LayoutInflater.from(context).inflate(
				R.layout.wheelview_dialog, null);
		LinearLayout container = (LinearLayout) llContent
				.findViewById(R.id.layout_container);

		LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
				LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT, 1.0f);
		params.gravity = Gravity.CENTER;

		Date date = new Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		final WheelView hourWheel = new WheelView(context);
		hourWheel.setLabel("时");
		hourWheel.setCyclic(false);
		hourWheel.setVisibleItems(5);
		hourWheel.setAdapter(new NumericWheelAdapter(0, 23, "%02d"));
		hourWheel.setCurrentItem(calendar.get(Calendar.HOUR_OF_DAY));
		container.addView(hourWheel, params);

		final WheelView minuteWheel = new WheelView(context);
		minuteWheel.setLabel("分");
		minuteWheel.setCyclic(false);
		minuteWheel.setVisibleItems(5);
		minuteWheel.setAdapter(new NumericWheelAdapter(0, 59, "%02d"));
		minuteWheel.setCurrentItem(calendar.get(Calendar.MINUTE));
		container.addView(minuteWheel, params);

		TextView btnPositive = (TextView) llContent
				.findViewById(R.id.btn_positive);
		TextView btnNegative = (TextView) llContent
				.findViewById(R.id.btn_negative);
		TextView tvTitle = (TextView) llContent.findViewById(R.id.tv_title);
		tvTitle.setText(title);
		btnPositive.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				if (callback != null) {
					int hour = hourWheel.getCurrentItem();
					int minute = minuteWheel.getCurrentItem();
					callback.selected(String.format("%02d", hour),
							String.format("%02d", minute));
				}
				dialog.cancel();
			}
		});
		btnNegative.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				dialog.cancel();
			}
		});
		dialog.setContentView(llContent);

		Window dialogWindow = dialog.getWindow();
		WindowManager.LayoutParams lp = dialogWindow.getAttributes();
		dialogWindow.setGravity(Gravity.LEFT | Gravity.BOTTOM);
		WindowManager wm = dialogWindow.getWindowManager();
		Display d = wm.getDefaultDisplay();
		lp.width = d.getWidth();
		lp.x = 0;
		lp.y = 0;
		dialogWindow.setAttributes(lp);
		dialogWindow.setWindowAnimations(R.style.AnimBottom);
		if (!dialog.isShowing()) {
			dialog.show();
		}
	}

	/**
	 * 日期选择
	 * 
	 * @param context
	 * @param title
	 *            标题
	 * @param callback
	 *            void selected(String year,String month,String day)
	 */
	@SuppressLint("InflateParams")
	@SuppressWarnings("deprecation")
	public static void showSelectDateDialog(Context context, String callBack,
			String title, final int minYear, final int minMonth,
			final int minDay, final int maxYear, final int maxMonth,
			final int maxDay, final WheelCallback callback) {
		final Dialog dialog = new Dialog(context, R.style.dialogw);
		final View llContent = LayoutInflater.from(context).inflate(
				R.layout.wheelview_dialog, null);
		LinearLayout container = (LinearLayout) llContent
				.findViewById(R.id.layout_container);
		// 获取当前时间
		Date date = new Date();
		final Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH);
		int day = calendar.get(Calendar.DAY_OF_MONTH);

		if(year > maxYear){
			year = maxYear;
			month = maxMonth - 1;
			day = maxDay;
		}else if(year < minYear){
			year = minYear;
    		month = minMonth - 1;
    		day = minDay;
		}else if(year == maxYear){
			if(month+1 > maxMonth){
				month = maxMonth - 1;
				day = maxDay;
			}else if(month+1 == maxMonth){
				if(year == minYear && month+1 == minMonth){
					if(day > maxDay){
						day = maxDay;
					}else if(day < minDay){
						day = minDay;
					}
				}else if (day >= maxDay) {
					day = maxDay;
				}
			}else if(year == minYear){
				if(month+1 == minMonth){
					if (day <= minDay) {
	            		day = minDay;
	            	}
				}else if(month+1 < minMonth){
					month = minMonth - 1;
	        		day = minDay;
				}
			}
		}else if(year == minYear){
			if (month+1 < minMonth) {
        		month = minMonth - 1;
        		day = minDay;
        	}else if(month+1 == minMonth){
        		if (day <= minDay) {
            		day = minDay;
            	}
        	}
		}

		// 设置控件宽高
		LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
				LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT, 1.0f);
		params.gravity = Gravity.CENTER;

		// 年份选择
		final WheelView yearWheel = new WheelView(context);
		yearWheel.setLabel("年");
		yearWheel.setCyclic(false);
		yearWheel.setVisibleItems(5);
		yearWheel.setAdapter(new NumericWheelAdapter(minYear, maxYear, "%04d"));
		container.addView(yearWheel, params);

		// 月份选择
		final WheelView monthWheel = new WheelView(context);
		monthWheel.setLabel("月");
		monthWheel.setCyclic(false);
		monthWheel.setVisibleItems(5);
//		monthWheel.setAdapter(new NumericWheelAdapter(minMonth, maxMonth,"%02d"));
		if(minYear != maxYear)
			//跨年
			monthWheel.setAdapter(new NumericWheelAdapter(minMonth, 12, "%02d"));
		else 
			monthWheel.setAdapter(new NumericWheelAdapter(minMonth, maxMonth, "%02d"));
		container.addView(monthWheel, params);

		// 日期选择
		final WheelView dayWheel = new WheelView(context);
		dayWheel.setLabel("日");
		dayWheel.setCyclic(false);
		dayWheel.setVisibleItems(5);
		if(minMonth != maxMonth) 
			//跨月
			dayWheel.setAdapter(new NumericWheelAdapter(minDay, getDaysOfMonth(year,month+1), "%02d"));
		else 
			dayWheel.setAdapter(new NumericWheelAdapter(minDay, maxDay, "%02d"));
//		dayWheel.setAdapter(new NumericWheelAdapter(minDay, maxDay, "%02d"));
		
		container.addView(dayWheel, params);

		yearWheel.addChangingListener(new OnWheelChangedListener() {

			@Override
			public void onChanged(WheelView wheel, int oldValue, int newValue) {
				int year = yearWheel.getCurrentItem() + yearWheel.getItem(0);
				int month = monthWheel.getCurrentItem() +monthWheel.getItem(0);
				int day = dayWheel.getCurrentItem() + dayWheel.getItem(0);
				int minMonthTmp = 1;
				int maxMonthTmp = 12;
				int currentMonthTmp = month;
				int minDayTmp = 1;
				int maxDayTmp = getDaysOfMonth(year, month);
				int currentDayTmp = day;

				if (year <= minYear) {
					minMonthTmp = minMonth;
					maxMonthTmp = 12;
					currentMonthTmp = month < minMonth ? minMonth : month;
					if (month <= minMonth) {
						minDayTmp = minDay;
						maxDayTmp = getDaysOfMonth(year, month);
						currentDayTmp = day < minDay ? minDay : day;
					}
				}
				if (year >= maxYear) {
					minMonthTmp = 1;
					maxMonthTmp = maxMonth;
					currentMonthTmp = month > maxMonth ? maxMonth : month;
					if (month >= maxMonth) {
						minDayTmp = 1;
						maxDayTmp = maxDay;
						currentDayTmp = day > maxDay ? maxDay : day;
					}
				}
				monthWheel.setAdapter(new NumericWheelAdapter(minMonthTmp,
						maxMonthTmp, "%02d"));

				dayWheel.setAdapter(new NumericWheelAdapter(minDayTmp,
						maxDayTmp, "%02d"));
				monthWheel.setCurrentItem(currentMonthTmp - minMonthTmp);
				dayWheel.setCurrentItem(currentDayTmp - minDayTmp);
			}
		});


		monthWheel.addChangingListener(new OnWheelChangedListener() {

			@Override
			public void onChanged(WheelView wheel, int oldValue, int newValue) {
				int year = yearWheel.getCurrentItem() + yearWheel.getItem(0);
				int month = monthWheel.getCurrentItem() +monthWheel.getItem(0);
				int day = dayWheel.getCurrentItem() + dayWheel.getItem(0);
				int minDayTmp = 1;
				int maxDayTmp = getDaysOfMonth(year, month);
				int currentDayTmp = day;
				if (year == minYear && month == minMonth) {
					minDayTmp = minDay;
					maxDayTmp = getDaysOfMonth(year, month);
					currentDayTmp = day < minDay ? minDay : day;
				}
				if (year == maxYear && month == maxMonth) {
					minDayTmp = 1;
					maxDayTmp = maxDay;
					currentDayTmp = day > maxDay ? maxDay : day;
				}
				dayWheel.setAdapter(new NumericWheelAdapter(minDayTmp,
						maxDayTmp, "%02d"));
				dayWheel.setCurrentItem(currentDayTmp- minDayTmp);
			}
		});
		
		yearWheel.setCurrentItem(year - minYear);
		monthWheel.setCurrentItem(month);
		dayWheel.setCurrentItem(day - 1);

		TextView btnPositive = (TextView) llContent
				.findViewById(R.id.btn_positive);
		TextView btnNegative = (TextView) llContent
				.findViewById(R.id.btn_negative);
		TextView tvTitle = (TextView) llContent.findViewById(R.id.tv_title);
		tvTitle.setText(title);
		btnPositive.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				if (callback != null) {
					int year = yearWheel.getCurrentItem() + yearWheel.getItem(0);
					int month = monthWheel.getCurrentItem() +monthWheel.getItem(0);
					int day = dayWheel.getCurrentItem() + dayWheel.getItem(0);
					callback.selected(String.format("%04d", year),
							String.format("%02d", month),
							String.format("%02d", day));
				}
				dialog.cancel();
			}
		});
		btnNegative.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				dialog.cancel();
			}
		});
		dialog.setContentView(llContent);

		Window dialogWindow = dialog.getWindow();
		WindowManager.LayoutParams lp = dialogWindow.getAttributes();
		dialogWindow.setGravity(Gravity.LEFT | Gravity.BOTTOM);
		WindowManager wm = dialogWindow.getWindowManager();
		Display d = wm.getDefaultDisplay();
		lp.width = d.getWidth();
		lp.x = 0;
		lp.y = 0;
		dialogWindow.setAttributes(lp);
		dialogWindow.setWindowAnimations(R.style.AnimBottom);
		if (!dialog.isShowing()) {
			dialog.show();
		}
	}

	/**
	 * 日期选择
	 * 
	 * @param context
	 * @param title
	 *            标题
	 * @param callback
	 *            void selected(String year,String month,String day)
	 */
	@SuppressLint("InflateParams")
	@SuppressWarnings("deprecation")
	public static void showSelectDateDialog(Context context, String callBack,
			String title, final int minYear, final int maxYear,
			final WheelCallback callback) {
		final Dialog dialog = new Dialog(context, R.style.dialogw);
		final View llContent = LayoutInflater.from(context).inflate(
				R.layout.wheelview_dialog, null);
		LinearLayout container = (LinearLayout) llContent
				.findViewById(R.id.layout_container);
		// 获取当前时间
		Date date = new Date();
		final Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);

		// 设置控件宽高
		LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
				LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT, 1.0f);
		params.gravity = Gravity.CENTER;

		// 年份选择
		final WheelView yearWheel = new WheelView(context);
		yearWheel.setLabel("年");
		yearWheel.setCyclic(true);
		yearWheel.setVisibleItems(5);
		yearWheel.setAdapter(new NumericWheelAdapter(minYear, maxYear, "%04d"));
		yearWheel.setCurrentItem(calendar.get(Calendar.YEAR) - minYear);
		container.addView(yearWheel, params);

		// 月份选择
		final WheelView monthWheel = new WheelView(context);
		monthWheel.setLabel("月");
		monthWheel.setCyclic(true);
		monthWheel.setVisibleItems(5);
		monthWheel.setAdapter(new NumericWheelAdapter(1, 12, "%02d"));
		monthWheel.setCurrentItem(calendar.get(Calendar.MONTH));
		container.addView(monthWheel, params);

		// 日期选择
		final WheelView dayWheel = new WheelView(context);
		dayWheel.setLabel("日");
		dayWheel.setCyclic(true);
		dayWheel.setVisibleItems(5);
		dayWheel.setAdapter(new NumericWheelAdapter(1, getDaysOfMonth(
				calendar.get(Calendar.YEAR), calendar.get(Calendar.MARCH)),
				"%02d"));
		dayWheel.setCurrentItem(calendar.get(Calendar.DAY_OF_MONTH) - 1);
		container.addView(dayWheel, params);

		monthWheel.addChangingListener(new OnWheelChangedListener() {

			@Override
			public void onChanged(WheelView wheel, int oldValue, int newValue) {
				int year = yearWheel.getCurrentItem() + minYear;
				int month = monthWheel.getCurrentItem() + 1;
				dayWheel.setAdapter(new NumericWheelAdapter(1, getDaysOfMonth(
						year, month), "%02d"));
			}
		});

		yearWheel.addChangingListener(new OnWheelChangedListener() {

			@Override
			public void onChanged(WheelView wheel, int oldValue, int newValue) {
				int year = yearWheel.getCurrentItem() + minYear;
				int month = monthWheel.getCurrentItem() + 1;
				dayWheel.setAdapter(new NumericWheelAdapter(1, getDaysOfMonth(
						year, month), "%02d"));
			}
		});

		TextView btnPositive = (TextView) llContent
				.findViewById(R.id.btn_positive);
		TextView btnNegative = (TextView) llContent
				.findViewById(R.id.btn_negative);
		TextView tvTitle = (TextView) llContent.findViewById(R.id.tv_title);
		tvTitle.setText(title);
		btnPositive.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				if (callback != null) {
					int year = yearWheel.getCurrentItem() + minYear;
					int month = monthWheel.getCurrentItem() + 1;
					int day = dayWheel.getCurrentItem() + 1;
					callback.selected(String.format("%04d", year),
							String.format("%02d", month),
							String.format("%02d", day));
				}
				dialog.cancel();
			}
		});
		btnNegative.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				dialog.cancel();
			}
		});
		dialog.setContentView(llContent);

		Window dialogWindow = dialog.getWindow();
		WindowManager.LayoutParams lp = dialogWindow.getAttributes();
		dialogWindow.setGravity(Gravity.LEFT | Gravity.BOTTOM);
		WindowManager wm = dialogWindow.getWindowManager();
		Display d = wm.getDefaultDisplay();
		lp.width = d.getWidth();
		lp.x = 0;
		lp.y = 0;
		dialogWindow.setAttributes(lp);
		dialogWindow.setWindowAnimations(R.style.AnimBottom);
		if (!dialog.isShowing()) {
			dialog.show();
		}
	}

	@SuppressLint("InflateParams")
	@SuppressWarnings("deprecation")
	public static void showSelectDateDialog(Context context, String title,
			final WheelCallback callback) {
		final int minYear = 1800;
		final int maxYear = 2200;
		final Dialog dialog = new Dialog(context, R.style.dialogw);
		final View llContent = LayoutInflater.from(context).inflate(
				R.layout.wheelview_dialog, null);
		LinearLayout container = (LinearLayout) llContent
				.findViewById(R.id.layout_container);
		// 获取当前时间
		Date date = new Date();
		final Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);

		// 设置控件宽高
		LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
				LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT, 1.0f);
		params.gravity = Gravity.CENTER;

		// 年份选择
		final WheelView yearWheel = new WheelView(context);
		yearWheel.setLabel("年");
		yearWheel.setCyclic(true);
		yearWheel.setVisibleItems(5);
		yearWheel.setAdapter(new NumericWheelAdapter(minYear, maxYear, "%04d"));
		yearWheel.setCurrentItem(calendar.get(Calendar.YEAR) - minYear);
		container.addView(yearWheel, params);

		// 月份选择
		final WheelView monthWheel = new WheelView(context);
		monthWheel.setLabel("月");
		monthWheel.setCyclic(true);
		monthWheel.setVisibleItems(5);
		monthWheel.setAdapter(new NumericWheelAdapter(1, 12, "%02d"));
		monthWheel.setCurrentItem(calendar.get(Calendar.MONTH));
		container.addView(monthWheel, params);

		// 日期选择
		final WheelView dayWheel = new WheelView(context);
		dayWheel.setLabel("日");
		dayWheel.setCyclic(true);
		dayWheel.setVisibleItems(5);
		dayWheel.setAdapter(new NumericWheelAdapter(1, getDaysOfMonth(
				calendar.get(Calendar.YEAR), calendar.get(Calendar.MARCH)),
				"%02d"));
		dayWheel.setCurrentItem(calendar.get(Calendar.DAY_OF_MONTH) - 1);
		container.addView(dayWheel, params);

		monthWheel.addChangingListener(new OnWheelChangedListener() {

			@Override
			public void onChanged(WheelView wheel, int oldValue, int newValue) {
				int year = yearWheel.getCurrentItem() + minYear;
				int month = monthWheel.getCurrentItem() + 1;
				dayWheel.setAdapter(new NumericWheelAdapter(1, getDaysOfMonth(
						year, month), "%02d"));
			}
		});

		yearWheel.addChangingListener(new OnWheelChangedListener() {

			@Override
			public void onChanged(WheelView wheel, int oldValue, int newValue) {
				int year = yearWheel.getCurrentItem() + minYear;
				int month = monthWheel.getCurrentItem() + 1;
				dayWheel.setAdapter(new NumericWheelAdapter(1, getDaysOfMonth(
						year, month), "%02d"));
			}
		});

		TextView btnPositive = (TextView) llContent
				.findViewById(R.id.btn_positive);
		TextView btnNegative = (TextView) llContent
				.findViewById(R.id.btn_negative);
		TextView tvTitle = (TextView) llContent.findViewById(R.id.tv_title);
		tvTitle.setText(title);
		btnPositive.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				if (callback != null) {
					int year = yearWheel.getCurrentItem() + minYear;
					int month = monthWheel.getCurrentItem() + 1;
					int day = dayWheel.getCurrentItem() + 1;
					callback.selected(String.format("%04d", year),
							String.format("%02d", month),
							String.format("%02d", day));
				}
				dialog.cancel();
			}
		});
		btnNegative.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				dialog.cancel();
			}
		});
		dialog.setContentView(llContent);

		Window dialogWindow = dialog.getWindow();
		WindowManager.LayoutParams lp = dialogWindow.getAttributes();
		dialogWindow.setGravity(Gravity.LEFT | Gravity.BOTTOM);
		WindowManager wm = dialogWindow.getWindowManager();
		Display d = wm.getDefaultDisplay();
		lp.width = d.getWidth();
		lp.x = 0;
		lp.y = 0;
		dialogWindow.setAttributes(lp);
		dialogWindow.setWindowAnimations(R.style.AnimBottom);
		if (!dialog.isShowing()) {
			dialog.show();
		}
	}

	/**
	 * 计算每个月的天数
	 * 
	 * @param year
	 *            年份
	 * @param month
	 *            月份
	 * @return days 每个月的天数
	 */
	public static int getDaysOfMonth(int year, int month) {
		int days = 0;
		if (month == 1 || month == 3 || month == 5 || month == 7 || month == 9
				|| month == 10 || month == 12) {
			days = 31;
		} else if (month == 4 || month == 6 || month == 8 || month == 11) {
			days = 30;
		} else { // 2月份，闰年29天、平年28天
			if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
				days = 29;
			} else {
				days = 28;
			}
		}
		return days;
	}

	public interface WheelCallback {
		public void selected(String... resulst);
	}

	public interface WheelCallbackForIndex {
		public void selected(int... resulstIntex);
	}
}
