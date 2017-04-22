package com.quqian.activity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import android.annotation.SuppressLint;
import android.app.Dialog;
import android.content.Intent;
import android.net.nsd.NsdManager.RegistrationListener;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.index.IndexActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.UserMode;
import com.quqian.http.API;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.lockq.GestureEditActivity;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.StaticVariable;
import com.quqian.util.Tool;
import com.quqian.util.WebViewActivity;

public class RegisterActivity extends BaseActivity implements OnClickListener,
		HttpResponseInterface {

	// 手机号
	private EditText et_phone = null;
	// 登陆密码
	private EditText et_pass = null;
	// 确认登录密码
	private EditText et_repass = null;
	// 验证码
	private EditText et_yanzhengma = null;
	// 推荐人服务码
	private EditText et_tuijian = null;
	// 获取验证码按钮
	private Button huoqu = null;
	// 注册按钮
	private Button register = null;

	private UserMode allUser = null;

	private Dialog juhua = null;
	
	private TextView xieyi = null;
	
	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.activity_regiseter;
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("注册");
		showBack();
		
		juhua = new ProcessDialogUtil(RegisterActivity.this);

		et_phone = (EditText) findViewById(R.id.register_et_phone);
		et_pass = (EditText) findViewById(R.id.register_et_pass);
		et_repass = (EditText) findViewById(R.id.register_et_repass);
		et_yanzhengma = (EditText) findViewById(R.id.register_et_yanzhengma);
		et_tuijian = (EditText) findViewById(R.id.register_et_tuijianren);
		huoqu = (Button) findViewById(R.id.register_tv_huoqu);
		register = (Button) findViewById(R.id.register_register);
		
		xieyi = (TextView)findViewById(R.id.register_xieyi);

	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);
		huoqu.setOnClickListener(this);
		register.setOnClickListener(this);
		
		xieyi.setOnClickListener(this);
		
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_back:
			RegisterActivity.this.finish();
			anim_right_out();
			break;
		case R.id.register_tv_huoqu:
			// 弹出对话框提示验证码发送到手机号码， -------------有问题
			if (!"".equals(et_phone) || !"".equals(et_pass)
					|| !"".equals(et_repass)) {
				loadHttp_duanxinma();
			}

			break;
		case R.id.register_register:
			// 注册成功直接登录，将 该用户的的信息标记为已登录，finish掉注册页面，加上动画 -----判断checkBox是否勾上
			// Toast.makeText(RegisterActivity.this, "注册成功", 1000).show();
			loadHttp_zhuce();
			break;
		case R.id.register_xieyi:
			Intent intent = new Intent(RegisterActivity.this,WebViewActivity.class);
			intent.putExtra("title", "趣钱注册协议");
			intent.putExtra("url", API.HTTP_WEB+"/term/ZCXY.html");
			startActivity(intent);
			
			break;
		default:
			break;
		}

	}

	// 修改登录状态
	private void reviseLoginState() {
		// CommonUtil.addConfigInfo(LoginActivity.this, "loginState", "login",
		// "",
		// "");
		// 将当前用户保存到文件中
		// UserMode user = Tool.getUser(RegisterActivity.this);
		Tool.writeData(RegisterActivity.this, "loginState", "zhanghu",
				allUser.getYhzh());
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

				Toast.makeText(RegisterActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:
				
				Toast.makeText(RegisterActivity.this,"恭喜您，短信发送成功，请您注意查收。", 1000).show();
				// 停止菊花
				startTimer();
				
				break;
			case 3:// 注册成功了，返回页面
					// 停止菊花
				Toast.makeText(RegisterActivity.this, "注册成功!", 1000).show();
				reviseLoginState();

				UserMode user = Tool.getUser(RegisterActivity.this);

				if (user.getShoushiCode().equals("")
						|| user.getShoushiCode() == null) {
					// 设置手势
					Intent intent3 = new Intent(RegisterActivity.this,
							GestureEditActivity.class);
					// StaticVariable.put(StaticVariable.sv_toIndex, "1");

					// type 0是设置手势密码，1是确认手势密码，3是验证手势密码
					// fromActivity 上层来源
					intent3.putExtra("type", "0");
					intent3.putExtra("from", "login");

					startActivity(intent3);

				} else {
					// 进入首页
					Intent intent3 = new Intent(RegisterActivity.this,
							MainActivity.class);
					StaticVariable.put(StaticVariable.sv_toIndex, "1");
					startActivity(intent3);
				}
				
				//发送通知
				Intent intent = new Intent();
				intent.setAction("dengluhoushuaxinshuju");
			    sendBroadcast(intent);
			    
				
				Toast.makeText(RegisterActivity.this, "登录成功", 1000).show();
				anim_right_out();
				finish();
				break;
			case 2:
				Toast.makeText(RegisterActivity.this,
						msg.getData().getString("msg"), 1000).show();
				break;
			default:
				break;
			}
		}
	};

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

	// 获取短信验证码
	private void loadHttp_duanxinma() {
		
		String password = et_pass.getText().toString();
		String newPassword = et_repass.getText().toString();
		
		if (password.length() < 6 || password.length() > 16) {
			Toast.makeText(RegisterActivity.this,"密码长度为6-16个字符", 1000).show();
			return;
		}
		if (!password.equals(newPassword)) {
			Toast.makeText(RegisterActivity.this,"你两次输入的密码不一致", 1000).show();
			return;
		}
		
		
		juhua.show();
		
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("type", "0");// 注册类型
		map.put("phone", et_phone.getText().toString());// 手机号码
		RequestThreadAbstract thread = RequestFactory.createRequestThread(5,
				map, RegisterActivity.this, mHandler);
		RequestPool.execute(thread);

	}

	// 进行注册
	private void loadHttp_zhuce() {
		// TODO Auto-generated method stub
		
		juhua.show();
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "3");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("phone", et_phone.getText().toString());// 手机号码
		map.put("password", et_pass.getText().toString());
		map.put("newPassword", et_repass.getText().toString());
		map.put("verifyCode", et_yanzhengma.getText().toString());
		map.put("code", et_tuijian.getText().toString());// 服务码

		RequestThreadAbstract thread = RequestFactory.createRequestThread(3,
				map, RegisterActivity.this, mHandler);
		RequestPool.execute(thread);
	}

	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub

		// 获取短信验证号码
		if (map.get("urlTag").equals("1")) {
			 
				Message msg1 = new Message();
				msg1.what = 1;
				mHandler.sendMessage(msg1);
			 
		} else if (map.get("urlTag").equals("3")) {// 进行注册

			if (list.size() == 1) {
				allUser = (UserMode) list.get(0);
				Message msg1 = new Message();
				msg1.what = 3;
				mHandler.sendMessage(msg1);
			}

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
