package com.quqian.activity;

import java.util.HashMap;
import java.util.Map;

import com.example.quqian.R;
import com.quqian.activity.index.IndexActivity;
import com.quqian.activity.invert.Invert;
import com.quqian.activity.mine.MineActivity;
import com.quqian.activity.more.MoreActivity;
import com.quqian.base.AppManager;
import com.quqian.base.BaseActivity;
import com.quqian.been.UserMode;
import com.quqian.util.CommonUtil;
import com.quqian.util.StaticVariable;
import com.quqian.util.Tool;

import android.os.Bundle;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Timer;
import java.util.TimerTask;

import android.app.Activity;
import android.app.ActivityGroup;
import android.app.LocalActivityManager;
import android.content.Intent;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.Window;
import android.view.View.OnClickListener;
import android.view.WindowManager;
import android.widget.FrameLayout;
import android.widget.FrameLayout.LayoutParams;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Toast;

public class MainActivity extends ActivityGroup implements OnClickListener {

	private LocalActivityManager localActivityManager;
	private FrameLayout container;
	private RadioButton rbIndex, rbMine, rbMore,rbInvest;
	private String currentActivityName = "";
	private RadioGroup rg;
	private FrameLayout currentView;

	private Bundle bundle = new Bundle();
	private Bundle bundle1 = new Bundle();
	
	// 读取登录状态 ，loginState = login.
	private Boolean loginState = false;

	@SuppressWarnings("deprecation")
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		setContentView(R.layout.activity_main);
		
		initView();
		initViewListener();
		doOtherThing();
	}

	private void initView() {
		rg = (RadioGroup) findViewById(R.id.rg);
		container = (FrameLayout) findViewById(R.id.container);
		rbIndex = (RadioButton) findViewById(R.id.rbIndex);
		rbMine = (RadioButton) findViewById(R.id.rbMine);
		rbMore = (RadioButton) findViewById(R.id.rbMore);
		rbInvest = (RadioButton) findViewById(R.id.rbInvest);
	}

	private void initViewListener() {
		rbIndex.setOnClickListener(this);
		rbMine.setOnClickListener(this);
		rbMore.setOnClickListener(this);
		rbInvest.setOnClickListener(this);
	}

	private void doOtherThing() {
		localActivityManager = getLocalActivityManager();

		rbIndex.setSelected(true);
		rbIndex.setChecked(true);
		// 启动IndexActivity
		setContainerView("index", IndexActivity.class, null, false);
	}

	/**
	 * 为启动Activity初始化Intent信息
	 * 
	 * @param cls
	 * @return
	 */
	private Intent initIntent(Class<?> cls, Bundle b) {
		Intent ln = new Intent(this, cls);
		if (b != null) {
			ln.putExtras(b);
		}
		return ln.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
	}

	private HashMap<String, FrameLayout> lytMap = new HashMap<String, FrameLayout>();

	/**
	 * 供开发�?在实现类中调用，能将Activity容器内的Activity移除，再将指定的某个Activity加入
	 * 
	 * @param activityName
	 *            加载的Activity在localActivityManager中的名字
	 * @param activityClassTye
	 *            要加载Activity的类�?
	 */
	@SuppressWarnings("rawtypes")
	protected void setContainerView(String activityName,
			Class<?> activityClassTye, Bundle b, boolean needRestart) {

		FrameLayout lyt = null;

		if (lytMap.containsKey(activityName)) {
			if (needRestart) {
				destroy(activityName);
				container.removeView(lytMap.get(activityName));
				lytMap.remove(activityName);
			} else {
				BaseActivity bA = (BaseActivity) localActivityManager
						.getActivity(activityName);
				// bA.refresh(b);
			}
		}

		if (!lytMap.containsKey(activityName)) {
			lyt = new FrameLayout(this);

			Activity contentActivity = localActivityManager
					.getActivity(activityName);
			if (null == contentActivity) {
				localActivityManager.startActivity(activityName,
						initIntent(activityClassTye, b));
			}

			lyt.addView(localActivityManager.getActivity(activityName)
					.getWindow().getDecorView(), new LayoutParams(
					LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT));

			container.addView(lyt, new LayoutParams(LayoutParams.MATCH_PARENT,
					LayoutParams.MATCH_PARENT));

			lytMap.put(activityName, lyt);
		}

		Iterator iter = lytMap.entrySet().iterator();
		while (iter.hasNext()) {
			Map.Entry entry = (Map.Entry) iter.next();
			FrameLayout val = (FrameLayout) entry.getValue();
			if (val != null) {
				if (activityName.equals(entry.getKey())) {
					val.setVisibility(View.VISIBLE);
					currentActivityName = activityName;
					currentView = val;
				} else {
					val.setVisibility(View.GONE);
				}
			}
		}
	}

	@Override
	public void onClick(View v) {
		switch (v.getId()) {
		case R.id.rbIndex:
			setContainerView("index", IndexActivity.class, null, false);
			rbIndex.setChecked(true);
			BackKeyCount = 0;
			break;
		case R.id.rbMine:
			if (loginState) {
				setContainerView("mine", MineActivity.class, bundle, true);
				rbMine.setChecked(true);
				BackKeyCount = 0;
			} else {
				Intent intent = new Intent(MainActivity.this,
						LoginActivity.class);
				intent.putExtra("fangxiang", "main");
				startActivity(intent);
				overridePendingTransition(R.anim.slide_right_in, R.anim.stay);
				Log.v("quqain", "-----toLoginActivity------");
			}
			break;
		case R.id.rbMore:
			setContainerView("more", MoreActivity.class, null, false);
			rbMore.setChecked(true);
			BackKeyCount = 0;
			break;
		case R.id.rbInvest:
			setContainerView("invest", Invert.class, bundle1, false);
			rbInvest.setChecked(true);
			BackKeyCount = 0;
			break;
		}
	}

	public void toTab(int resId, Bundle b, boolean needRestart) {
		switch (resId) {
		case R.id.rbIndex:
			rbIndex.setChecked(true);
			setContainerView("index", IndexActivity.class, b, needRestart);

			break;
		case R.id.rbMine:
			if (loginState) {
				setContainerView("mine", MineActivity.class, b, needRestart);
				rbMine.setChecked(true);
			} else {
				Intent intent = new Intent(MainActivity.this,
						LoginActivity.class);
				intent.putExtra("fangxiang", "main");
				startActivity(intent);
				overridePendingTransition(R.anim.slide_right_in, R.anim.stay);
			}
			break;
		case R.id.rbMore:
			setContainerView("more", MoreActivity.class, b, needRestart);
			rbMore.setChecked(true);
			break;
		case R.id.rbInvest:
			setContainerView("invest", Invert.class, b, needRestart);
			rbInvest.setChecked(true);
			break;
		}
	}

	public boolean destroy(String id) {
		if (localActivityManager != null) {
			localActivityManager.destroyActivity(id, false);
			// http://code.google.com/p/android/issues/detail?id=12359
			// http://www.netmite.com/android/mydroid/frameworks/base/core/java/android/app/LocalActivityManager.java
			try {
				final Field mActivitiesField = LocalActivityManager.class
						.getDeclaredField("mActivities");
				if (mActivitiesField != null) {
					mActivitiesField.setAccessible(true);
					@SuppressWarnings("unchecked")
					final Map<String, Object> mActivities = (Map<String, Object>) mActivitiesField
							.get(localActivityManager);
					if (mActivities != null) {
						mActivities.remove(id);
					}
					final Field mActivityArrayField = LocalActivityManager.class
							.getDeclaredField("mActivityArray");
					if (mActivityArrayField != null) {
						mActivityArrayField.setAccessible(true);
						@SuppressWarnings("unchecked")
						final ArrayList<Object> mActivityArray = (ArrayList<Object>) mActivityArrayField
								.get(localActivityManager);
						if (mActivityArray != null) {
							for (Object record : mActivityArray) {
								final Field idField = record.getClass()
										.getDeclaredField("id");
								if (idField != null) {
									idField.setAccessible(true);
									final String _id = (String) idField
											.get(record);
									if (id.equals(_id)) {
										mActivityArray.remove(record);
										break;
									}
								}
							}
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return true;
		}
		return false;
	}

	@SuppressWarnings("deprecation")
	@Override
	protected void onResume() {
		
		UserMode user = Tool.getUser(MainActivity.this);
		if (user == null) {
			loginState = false;
		} else {
			loginState = true;
		}

		bundle.putString("xiaoxigeshu", StaticVariable.get(StaticVariable.xiaoxi));
		bundle1.putString("licaitab",  StaticVariable.get(StaticVariable.licaitab));
		
		String toIndex = StaticVariable.get(StaticVariable.sv_toIndex);
		String toMine = StaticVariable.get(StaticVariable.sv_toMine);
		String toMore = StaticVariable.get(StaticVariable.sv_toMore);
		String toInvest = StaticVariable.get(StaticVariable.sv_toInvest);
		if (toIndex.equals("1")) {
			toTab(R.id.rbIndex, null, true);
		}
		if (toMine.equals("2")) {
			toTab(R.id.rbMine, bundle, true);
		}
		if (toMore.equals("3")) {
			toTab(R.id.rbMore, null, false);
		}
		if (toInvest.equals("4")) {
			toTab(R.id.rbInvest, bundle1, true);
		}
		super.onResume();
	}

	/**
	 * 点击返回键退出程序，
	 */
	public static boolean isOnKeyDown;
	protected int BackKeyCount = 0;

	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {

		// 先判断是否是返回键
		if (keyCode == KeyEvent.KEYCODE_BACK && event.getRepeatCount() == 0) {

			BackKeyCount++;
			if (BackKeyCount >= 2) {
				isOnKeyDown = false;
				AppManager.getAppManager().appExit(this);
				finish();

			} else {
				// if (AppConfig.SHOWTOAST) {
				Toast.makeText(this, "再按一次退出程序", Toast.LENGTH_SHORT).show();
				// }
				new Thread(new Runnable() {
					@Override
					public void run() {
						Timer timer = new Timer();
						timer.schedule(new ExitTask1(), 3000);
					}
				}).start();

			}
		}
		return false;
	}

	/**
	 * 指定时间后执行task任务
	 */
	class ExitTask1 extends TimerTask {

		@Override
		public void run() {
			BackKeyCount = 0;
		}

	}

}
