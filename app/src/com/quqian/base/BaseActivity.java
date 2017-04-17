package com.quqian.base;

import java.util.Map;

import com.example.quqian.R;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.support.v4.app.FragmentActivity;
import android.support.v4.view.ViewPager;
import android.util.Log;
import android.view.KeyEvent;
import android.view.Window;
import android.widget.ImageView;
import android.widget.TextView;

public abstract class BaseActivity extends FragmentActivity{

	protected Context context;

	public ImageView titleBarBack = null;
	public TextView titleBarTitle = null;
	public TextView titleBarMenu = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		context = this;
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		AppManager.getAppManager().addActivity(this);

		setContentView(false);

		/**
		 * 获取从上个界面传递过来的数据.
		 */
		getIntentWord();

		/**
		 * 设置actionbar.
		 */
		allTitleBar();

		/**
		 * 初始化控件.
		 */
		initView();

		/**
		 * 设置监听器.
		 */
		initViewListener();

		/**
		 * doOtherThing.
		 */
		doOtherThing();
	}

	protected void allTitleBar() {
		// TODO Auto-generated method stub
		titleBarBack = (ImageView) findViewById(R.id.title_bar_back);
		titleBarTitle = (TextView) findViewById(R.id.titile_bar_title);
		titleBarMenu = (TextView) findViewById(R.id.title_bar_menu);
	}

	protected void setContentView(boolean needAnimation) {
		setContentView(layoutId());
	}

	/**
	 * 设置layout Id.
	 * 
	 * @return
	 */
	protected abstract int layoutId();

	protected void getIntentWord() {
		// TODO Auto-generated method stub

	}

	protected void initView() {
		// TODO Auto-generated method stub

	}

	protected void initViewListener() {
		// TODO Auto-generated method stub

	}

	protected void doOtherThing() {
		// TODO Auto-generated method stub

	}

	/**
	 * TitleBar的设置（根据子类的需要，重写）
	 */
	// 设置标题
	public void setTitle(String title) {
		titleBarTitle.setText(title);
	}

	// 设置actionbar右边按钮
	public void setMenu(String menu) {
		titleBarMenu.setText(menu);
	}

	// 显示actionbar左边按钮
	public void showBack() {
		titleBarBack.setVisibility(ViewPager.VISIBLE);
	}

	// 显示actionbar右边按钮
	public void showMenu() {
		titleBarMenu.setVisibility(ViewPager.VISIBLE);
	}

	/**
	 * 界面切换动画
	 */
	public void anim_right_in() {
		overridePendingTransition(R.anim.slide_right_in, R.anim.stay);
	}

	public void anim_right_out() {
		overridePendingTransition(R.anim.stay, R.anim.slide_right_out);
	}

	public void anim_down_in() {
		overridePendingTransition(R.anim.slide_down_in, R.anim.stay);
	}

	public void anim_stay() {
		overridePendingTransition(R.anim.stay, R.anim.stay);
	}

	public void anim_down_out() {
		overridePendingTransition(R.anim.stay, R.anim.slide_down_out);
	}

	/**
	 * 点击返回键
	 */

	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		// if (!needBack) {
		// return super.onKeyDown(keyCode, event);
		// }
		// 先判断是否是返回键
		if (keyCode == KeyEvent.KEYCODE_BACK && event.getRepeatCount() == 0) {
			finish();
			anim_right_out();
		}
		return false;
	}

	// /**
	// * 点击返回键退出程序，
	// */
	// public static boolean isOnKeyDown;
	// protected int BackKeyCount = 0;
	//
	// @Override
	// public boolean onKeyDown(int keyCode, KeyEvent event) {
	// // if (!needBack) {
	// // return super.onKeyDown(keyCode, event);
	// // }
	// // 先判断是否是返回键
	// if (keyCode == KeyEvent.KEYCODE_BACK && event.getRepeatCount() == 0) {
	//
	// BackKeyCount++;
	// if (BackKeyCount >= 2) {
	// isOnKeyDown = false;
	// AppManager.getAppManager().appExit(this);
	// finish();
	//
	// } else {
	// // if (AppConfig.SHOWTOAST) {
	// Toast.makeText(this, "再按一次退出程序", Toast.LENGTH_SHORT).show();
	// // }
	// new Thread(new Runnable() {
	// @Override
	// public void run() {
	// Timer timer = new Timer();
	// timer.schedule(new ExitTask1(), 3000);
	// }
	// }).start();
	//
	// }
	// }
	// return false;
	// }
	//
	// /**
	// * 指定时间后执行task任务
	// */
	// class ExitTask1 extends TimerTask {
	//
	// @Override
	// public void run() {
	// BackKeyCount = 0;
	// }
	//
	// }
	@Override
	protected void onResume() {
		super.onResume();
	}
	
	@Override
	protected void onStart() {
		super.onStart();
	}

	@Override
	protected void onPause() {
		super.onPause();
	}

	@Override
	protected void onStop() {
		super.onStop();
	}

	@Override
	protected void onDestroy() {
		super.onDestroy();
		AppManager.getAppManager().removeActivity(this);
		
	}
	
	
	//@Override
//	public void onBackPressed() { 
//	    //实现Home键效果 
//	    //super.onBackPressed();这句话一定要注掉,不然又去调用默认的back处理方式了 
//		Intent startMain = new Intent(Intent.ACTION_MAIN); 
//	    startMain.addCategory(Intent.CATEGORY_HOME); 
//	    startMain.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK); 
//	    startActivity(startMain); 
//	    android.os.Process.killProcess(android.os.Process.myPid()); 
//	}

	// public Handler baseHandler = new Handler() {
	// public void handleMessage(android.os.Message msg) {
	//
	// };
	// };
	//
	// /**
	// * xml数据返回
	// *
	// * @param request
	// * @return
	// */
	// protected synchronized boolean dataRequest(int i, Map<String, String>
	// map,
	// HttpResponseInterface context, boolean needDialog) {
	// // if (request == null) {
	// // return false;
	// // }
	// RequestThreadAbstract thread = RequestFactory.createRequestThread(i,
	// map, context, baseHandler);
	// RequestPool.execute(thread);
	//
	// return true;
	// }

}
