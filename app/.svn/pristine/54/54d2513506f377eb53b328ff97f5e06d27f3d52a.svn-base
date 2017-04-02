package com.quqian.base;

import java.util.Stack;

import android.app.Activity;
import android.app.ActivityManager;
import android.content.Context;
import android.util.Log;

public class AppManager {
	/**
	 * 将所有的activity放入到activity栈里，方便管理，可以统一销毁。
	 */
	
	private Stack<Activity> activityStack;
	private static AppManager instance;

	public static AppManager getAppManager() {
		if (instance == null) {
			instance = new AppManager();
		}
		return instance;
	}

	public void addActivity(Activity activity) {
		if (activityStack == null) {
			activityStack = new Stack<Activity>();
		}
		activityStack.add(activity);
		for(int i=0;i<activityStack.size();i++){
			Log.i("activityTest", activityStack.get(i).getClass().getName());
		}
	}

	public Activity currentActivity() {
		if (activityStack == null || activityStack.size() <= 0) {
			return null;
		}
		return activityStack.lastElement();
	}

	public void removeActivity(Activity activity) {
		if (activityStack == null || activity == null) {
			return;
		}
		activityStack.remove(activity);
	}

	public void finishActivity(Class<?> cls) {
		for (Activity a : activityStack) {
			if (a.getClass().equals(cls)) {
				a.finish();
				break;
			}
		}
	}

	public void finishAllActivity() {
		for (int i = 0, size = activityStack.size(); i < size; i++) {
			if (null != activityStack.get(i)) {
				activityStack.get(i).finish();
			}
		}
		activityStack.clear();
	}

	public void appExit(Context context) {
		try {
			//AppContext appContext = (AppContext) context.getApplicationContext();
			//appContext.addRecord(context,"退出app");
			finishAllActivity();
			ActivityManager activityMgr = (ActivityManager) context
					.getSystemService(Context.ACTIVITY_SERVICE);
			activityMgr.restartPackage(context.getPackageName());
			System.exit(0);
		} catch (Exception e) {
			
		}
	}

	public void finishToActivity(Class<?> cls) {
		if (activityStack != null) {
			Activity a = activityStack.lastElement();
			while (!a.getClass().equals(cls) && activityStack.size() > 1) {
				activityStack.remove(a);
				a.finish();
				a = activityStack.lastElement();
			}
		}
	}

	public Activity getExistActivity(Class<?> cls) {
		for (int i = 0; i < activityStack.size(); i++) {
			if(activityStack.get(i).getClass().equals(cls)){
				return activityStack.get(i);
			}
		}
		return null;
	}
}
