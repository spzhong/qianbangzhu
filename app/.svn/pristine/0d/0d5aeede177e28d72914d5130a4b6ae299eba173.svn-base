package com.quqian.activity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import org.json.JSONException;
import org.json.JSONObject;

import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.app.Dialog;
import android.app.ActionBar.LayoutParams;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.Display;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.index.IndexActivity;
import com.quqian.base.BaseActivity;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;

public class YanZhengShouJiActivity extends BaseActivity implements
		OnClickListener, HttpResponseInterface {

	private TextView shouji = null;
	private EditText yanzhengma = null;

	private Button next = null;
	private Button huoqu = null;

	private String shoujihao = "";
	private String key = "";

	private Dialog juhua = null;
	
	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_wangjimima_yanzhengshouji;
	}

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
		if (getIntent().getStringExtra("shouji") != null) {
			shoujihao = getIntent().getStringExtra("shouji");
		}

	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("验证手机");
		showBack();

		juhua = new ProcessDialogUtil(YanZhengShouJiActivity.this);
		
		shouji = (TextView) findViewById(R.id.main_wangji_yanzhengshouji_shouji);
		shouji.setText(shoujihao);

		yanzhengma = (EditText) findViewById(R.id.main_wangji_yanzhengshouji_et);
		next = (Button) findViewById(R.id.main_wangji_yanzhengshouji_next);
		huoqu = (Button) findViewById(R.id.main_wangji_yanzhengshouji_huoqu);

		// 获取验证码
		startTimer();
	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);

		next.setOnClickListener(this);
		huoqu.setOnClickListener(this);
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_back:
			YanZhengShouJiActivity.this.finish();
			anim_right_out();
			break;
		case R.id.main_wangji_yanzhengshouji_huoqu:
			loadHttp_sendMesg();
			break;
		case R.id.main_wangji_yanzhengshouji_next:
			// 下一步
			loadHttp_verifyMsg();
			break;

		default:
			break;
		}
	}

	// 获取验证码的模块
	private Timer mTimer = null;
	private int time = 60;

	// 开启倒计时线程
	private void startTimer() {
		if (mTimer == null) {
			mTimer = new Timer();
		}
		mTimer.schedule(new TimerTask() {

			@Override
			public void run() {
				time--;
				String text = "";
				if (time <= 0) {
					time = 60;
					text = "重新获取";
					Message msg = handler.obtainMessage(1, text);
					handler.sendMessage(msg);
				} else {
					text = time + "";
					Message msg = handler.obtainMessage(0, text);
					handler.sendMessage(msg);
				}
			}
		}, 1000, 1000);
	}

	// 页面结束的时候，线程销毁，
	private void canclTimer() {
		if (mTimer != null) {
			mTimer.cancel();
			mTimer = null;
		}
	}

	// 线程交互，刷新倒计时
	@SuppressLint("HandlerLeak")
	private Handler handler = new Handler() {
		public void handleMessage(android.os.Message msg) {
			switch (msg.what) {
			case 0: {
				String text = (String) msg.obj;
				huoqu.setText(text);
				huoqu.setTextSize(16);
				huoqu.setEnabled(false);
			}
				break;
			case 1: {
				String text = (String) msg.obj;
				canclTimer();
				huoqu.setText(text);
				huoqu.setTextSize(10);
				huoqu.setEnabled(true);
			}
				break;
			default:
				break;
			}
		};
	};

	// 需要重写finish();停止线程
	@Override
	public void finish() {
		// TODO Auto-generated method stub
		super.finish();
		canclTimer();
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

				Toast.makeText(YanZhengShouJiActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:
				// 停止菊花
				// 下一步
				Intent intent = new Intent(YanZhengShouJiActivity.this,
						ChongZhiMiMaActivity.class);
				intent.putExtra("shouji", shoujihao);
				intent.putExtra("key", key);
				startActivity(intent);
				anim_right_in();
				finish();

				break;
			case 3:
				// 停止菊花
				startTimer();
				Toast.makeText(YanZhengShouJiActivity.this,
						msg.getData().getString("msg"), 1000).show();

				break;
			case 2:
				Toast.makeText(YanZhengShouJiActivity.this,
						msg.getData().getString("msg"), 1000).show();
				break;

			default:
				break;
			}
		}
	};

	// 找回密码－点击下一步－发送验证码
	private void loadHttp_verifyMsg() {
		// TODO Auto-generated method stub
		
		juhua.show();
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "2");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("type", "1");// 类型
		map.put("phone", shoujihao);// 手机号
		map.put("code", yanzhengma.getText().toString());// 验证码
		RequestThreadAbstract thread = RequestFactory.createRequestThread(6,
				map, YanZhengShouJiActivity.this, mHandler);
		RequestPool.execute(thread);
	}

	// 找回密码－点击下一步－发送验证码
	private void loadHttp_sendMesg() {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("type", "1");// 类型
		map.put("phone", shouji.getText().toString());// 手机号
		RequestThreadAbstract thread = RequestFactory.createRequestThread(5,
				map, YanZhengShouJiActivity.this, mHandler);
		RequestPool.execute(thread);
	}

	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub

		// 获取短信验证码
		if (map.get("urlTag").equals("1")) {

			Message msg1 = new Message();
			Bundle bundle = new Bundle();
			bundle.putString("msg", "短信验证码已经发送到你的手机");
			msg1.setData(bundle);
			msg1.what = 3;
			mHandler.sendMessage(msg1);
			
		} else if (map.get("urlTag").equals("2")) {// 下一步验证
			JSONObject json = (JSONObject) jsonObj;
			try {
				key = json.getString("rvalue");
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Message msg1 = new Message();
			msg1.what = 1;
			mHandler.sendMessage(msg1);
		}
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
