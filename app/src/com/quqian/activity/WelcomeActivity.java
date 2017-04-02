package com.quqian.activity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.app.Dialog;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.animation.AlphaAnimation;
import android.view.animation.Animation;
import android.view.animation.Animation.AnimationListener;
import android.widget.ImageView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.base.BaseActivity;
import com.quqian.been.UserMode;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.lockq.GestureVerifyActivity;
import com.quqian.util.CommonUtil;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.Tool;

public class WelcomeActivity extends BaseActivity implements
		HttpResponseInterface {

	private ImageView welcomeImg = null;

	// 进入引导页的标记
	private Boolean toGuide = true;

	private Dialog juhua = null;
	
	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.activity_welcome;
	}

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
		// 在此获取sharedPreferences的toGuide标记，firstUse
		if ("first".equals(CommonUtil.getStringByKey(WelcomeActivity.this,
				"firstUse", "", ""))) {
			toGuide = false;
		}
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		
		juhua = new ProcessDialogUtil(WelcomeActivity.this);
		
		welcomeImg = (ImageView) this.findViewById(R.id.welcome_img);
	}

	@Override
	protected void doOtherThing() {
		// TODO Auto-generated method stub
		super.doOtherThing();
		AlphaAnimation anima = new AlphaAnimation(0.3f, 1.0f);
		anima.setDuration(2000);// 设置动画显示时间
		welcomeImg.startAnimation(anima);
		anima.setAnimationListener(new AnimationImpl());
	}

	private class AnimationImpl implements AnimationListener {

		@Override
		public void onAnimationStart(Animation animation) {
			welcomeImg.setBackgroundResource(R.drawable.jiazaiye);
		}

		@Override
		public void onAnimationEnd(Animation animation) {
			skip(); // 动画结束后跳转到别的页面
		}

		@Override
		public void onAnimationRepeat(Animation animation) {

		}

	}

	// 在此判断缓存文件，是否是第一次登录，进入到引导页，否则判断是否登录，否则直接跳转到主页
	private void skip() {
		if (toGuide) {
			startActivity(new Intent(this, GuideActivity.class));
		} else {

			// 获取个人资料信息
			// TODO Auto-generated method stub
			
			UserMode user = Tool.getUser(WelcomeActivity.this);
			if (user == null) {
				startActivity(new Intent(WelcomeActivity.this, MainActivity.class));
				anim_right_in();
				finish();
			} else {
				
				juhua.show();
				
				Map<String, String> map = new HashMap<String, String>();
				map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
				map.put("isLock", "0");// 0不锁，1是锁
				RequestThreadAbstract thread = RequestFactory.createRequestThread(
						2, map, WelcomeActivity.this, mHandler);
				RequestPool.execute(thread);

			}
			
		}
	}
	//方法
	private void toIntent(){
		UserMode user = Tool.getUser(this);
		if (user == null) {
			startActivity(new Intent(this, MainActivity.class));
		} else {
			startActivity(new Intent(this, GestureVerifyActivity.class));
		}
		anim_right_in();
		finish();
	}

	// 登录--网络请求
	private Handler mHandler = new Handler() {

		@Override
		public void handleMessage(Message msg) {
			// TODO Auto-generated method stub
			super.handleMessage(msg);
			
			juhua.cancel();
			
			switch (msg.what) {
			case 0:

				Toast.makeText(WelcomeActivity.this,
						msg.getData().getString("errMsg"), 1000).show();
				WelcomeActivity.this.finish();
				break;
			case 1:
				// 停止菊花
				// 每次进入之后判断是否登录，如果登录就手势，否则的话就跳mainacitivity.
				toIntent();
				
				break;
			case 2:
				Toast.makeText(WelcomeActivity.this,
						msg.getData().getString("msg"), 1000).show();
				Tool.writeData(WelcomeActivity.this, "loginState", "zhanghu", "");
				
				Intent intent = new Intent(WelcomeActivity.this,LoginActivity.class);
				intent.putExtra("fangxiang", "main");
				startActivity(intent);
				WelcomeActivity.this.finish();
				anim_right_in();

				break;

			default:
				break;
			}
		}
	};

	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub
		Message msg2 = new Message();
		msg2.what = 1;
		mHandler.sendMessage(msg2);
	}

	@Override
	public void httpResponse_fail(Map<String, String> map, String msg,
			Object jsonObj) {
		// TODO Auto-generated method stub
		Message msg2 = new Message();
		msg2.what = 2;
		Bundle bundle = new Bundle();
		bundle.putString("msg", msg);
		msg2.setData(bundle);
		mHandler.sendMessage(msg2);
	}
}
