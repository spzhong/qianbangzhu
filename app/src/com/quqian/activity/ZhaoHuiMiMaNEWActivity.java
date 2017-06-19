package com.quqian.activity;

import java.security.NoSuchAlgorithmException;
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
import com.quqian.activity.mine.XiuGaiDengLuMiMaActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.UserMode;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.Code;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.Tool;

public class ZhaoHuiMiMaNEWActivity extends BaseActivity implements
		OnClickListener, HttpResponseInterface {

	private EditText shouji = null;
	private EditText yanzhengma = null;
	private ImageView yanzhengmaimg = null;
	private EditText shoujiyanzhengma = null;
	private Button huoqu = null;

	// 新密码输入
	private EditText xin = null;
	// 确认新密码
	private EditText queren = null;
	// 完成
	private Button next = null;

	// 产生的验证码
	private String realCode;

	private String shoujihao = "";
	private String key = "";

	private Dialog juhua = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_wangjimima_zhihuimima_new;
	}

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("找回密码");
		showBack();

		juhua = new ProcessDialogUtil(ZhaoHuiMiMaNEWActivity.this);

		shouji = (EditText) findViewById(R.id.main_zhmm_shoujihao);
		yanzhengma = (EditText) findViewById(R.id.main_zhmm_yanzhengma);
		yanzhengmaimg = (ImageView) findViewById(R.id.main_zhmm_yanzhenmaimg);
		shoujiyanzhengma = (EditText) findViewById(R.id.main_zhmm_etshoujiyanzhengma);
		huoqu = (Button) findViewById(R.id.main_zhmm_shoujiyanzhengma);

		yanzhengmaimg.setImageBitmap(Code.getInstance().createBitmap());
		realCode = Code.getInstance().getCode().toLowerCase();

		xin = (EditText) findViewById(R.id.main_zhaohuimima_newmima);
		queren = (EditText) findViewById(R.id.main_zhaohuimima_queren);
		next = (Button) findViewById(R.id.main_zhaohuimima_btn_n);

	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);
		yanzhengmaimg.setOnClickListener(this);
		huoqu.setOnClickListener(this);

		next.setOnClickListener(this);
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_back:
			ZhaoHuiMiMaNEWActivity.this.finish();
			anim_right_out();
			break;
		case R.id.main_zhmm_yanzhenmaimg:
			// 验证码生成新的
			yanzhengmaimg.setImageBitmap(Code.getInstance().createBitmap());
			realCode = Code.getInstance().getCode().toLowerCase();
			break;
		case R.id.main_zhmm_shoujiyanzhengma:
			// 获取手机
			loadHttp_duanxinma();

			break;
		case R.id.main_zhaohuimima_btn_n:
			// 完成 应该记录登录状态，跳转到相应的界面，或者应该判断是否需要设置手势密码，进入首页

			loadHttp_verifyMsg();

			break;

		default:
			break;
		}
	}

	// 获取短信验证码
	private void loadHttp_duanxinma() {

		if ("".equals(shouji.getText().toString())) {
			Toast.makeText(ZhaoHuiMiMaNEWActivity.this, "请输入手机号", 1000).show();
			return;
		}

		String yanzhengmatext = yanzhengma.getText().toString().toLowerCase();
		if (!yanzhengmatext.equals(realCode)) {
			Toast.makeText(ZhaoHuiMiMaNEWActivity.this, "验证码错误", 1000).show();
			return;
		}

		juhua.show();

		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("type", "1");// 注册类型
		map.put("phone", shouji.getText().toString());// 手机号码
		RequestThreadAbstract thread = RequestFactory.createRequestThread(5,
				map, ZhaoHuiMiMaNEWActivity.this, mHandler);
		RequestPool.execute(thread);

	}

	// 找回密码－验证验证码
	private void loadHttp_verifyMsg() {
		// TODO Auto-generated method stub

		if ("".equals(shoujiyanzhengma.getText().toString())) {
			Toast.makeText(ZhaoHuiMiMaNEWActivity.this, "请输入手机验证码", 1000)
					.show();
			return;
		}
		// 密码长度的判断
		if (xin.getText().toString().length() < 6
				|| xin.getText().toString().length() > 16) {
			Toast.makeText(ZhaoHuiMiMaNEWActivity.this, "密码长度为6-16个字符", 1000)
					.show();
			return;
		}
		if (queren.getText().toString().length() < 6
				|| queren.getText().toString().length() > 16) {
			Toast.makeText(ZhaoHuiMiMaNEWActivity.this, "密码长度为6-16个字符", 1000)
					.show();
			return;
		}
		if (!xin.getText().toString().equals(queren.getText().toString())) {
			Toast.makeText(ZhaoHuiMiMaNEWActivity.this, "你两次输入的密码不一致", 1000)
					.show();
			return;
		}

		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "2");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("type", "1");// 类型
		map.put("phone", shoujihao);// 手机号
		map.put("code", yanzhengma.getText().toString());// 验证码
		RequestThreadAbstract thread = RequestFactory.createRequestThread(6,
				map, ZhaoHuiMiMaNEWActivity.this, mHandler);
		RequestPool.execute(thread);
	}

	// 登录--网络请求
	private Handler mHandler = new Handler() {

		@Override
		public void handleMessage(Message msg) {
			// TODO Auto-generated method stub
			super.handleMessage(msg);

			switch (msg.what) {
			case 0:
				juhua.cancel();
				Toast.makeText(ZhaoHuiMiMaNEWActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:
				// 短信验证码
				juhua.cancel();
				yanzhengmaimg.setImageBitmap(Code.getInstance().createBitmap());
				realCode = Code.getInstance().getCode().toLowerCase();
				Toast.makeText(ZhaoHuiMiMaNEWActivity.this,
						"恭喜您，短信发送成功，请您注意查收。", 1000).show();
				// 停止菊花
				startTimer();
				break;
			case 4:
				// 验证短信验证码

				loadHttp_chongzhimima();

				break;
			case 3:
				// 重置密码
				juhua.cancel();
				Toast.makeText(ZhaoHuiMiMaNEWActivity.this, "密码重置成功", 1000)
						.show();
				anim_right_out();
				finish();

				break;
			case 2:
				juhua.cancel();
				Toast.makeText(ZhaoHuiMiMaNEWActivity.this,
						msg.getData().getString("msg"), 1000).show();
				break;

			default:
				break;
			}
		}
	};

	// 找回密码－重置密码
	private void loadHttp_chongzhimima() {
		// TODO Auto-generated method stub

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "3");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("type", "1");// 类型
		map.put("phone", shoujihao);// 手机号
		map.put("password", xin.getText().toString());// 密码
		map.put("cpassword", queren.getText().toString());// 密码
		try {
			map.put("key", Tool.getMD5(shoujihao + "1" + key));
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}// key
		RequestThreadAbstract thread = RequestFactory.createRequestThread(34,
				map, ZhaoHuiMiMaNEWActivity.this, mHandler);
		RequestPool.execute(thread);
	}

	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub
		if (map.get("urlTag").equals("1")) {

			Message msg1 = new Message();
			msg1.what = 1;
			mHandler.sendMessage(msg1);

		} else if (map.get("urlTag").equals("2")) {// 验证手机
			JSONObject json = (JSONObject) jsonObj;
			try {
				key = json.getString("rvalue");
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Message msg4 = new Message();
			msg4.what = 4;
			mHandler.sendMessage(msg4);

		} else if (map.get("urlTag").equals("3")) {// 设置重置密码
			Message msg3 = new Message();
			msg3.what = 1;
			mHandler.sendMessage(msg3);
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
			case 0:
				String text = (String) msg.obj;
				huoqu.setText(text);
				huoqu.setTextSize(16);
				huoqu.setEnabled(false);
				break;
			case 1:
				String text1 = (String) msg.obj;
				canclTimer();
				huoqu.setText(text1);
				huoqu.setTextSize(10);
				huoqu.setEnabled(true);
				break;
			case 3:

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

}
