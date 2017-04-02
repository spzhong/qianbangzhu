package com.quqian.activity.mine;

import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.app.Dialog;
import android.app.ActionBar.LayoutParams;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.TypedValue;
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
import com.quqian.been.UserMode;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.Tool;

public class YanZhengXinShouJiActivity extends BaseActivity implements
		OnClickListener, HttpResponseInterface {

	//新手机号码
	private EditText shouji = null;
	//验证码输入
	private EditText yanzhengma = null;

	//完成按钮
	private Button next = null;
	//获取验证码按钮
	private Button huoqu = null;
	private String key;

	private Dialog juhua = null;
	
	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_mine_yanzhengxinshouji;
	}

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
		if (getIntent().getStringExtra("key") != null) {
			key  = getIntent().getStringExtra("key");
		}
		
	}
	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("验证新手机");
		showBack();

		juhua = new ProcessDialogUtil(YanZhengXinShouJiActivity.this);
		
		shouji = (EditText) findViewById(R.id.main_mine_yanzhengxinshouji_shouji);
		yanzhengma = (EditText) findViewById(R.id.main_mine_yanzhengxinshouji_et);
		next = (Button) findViewById(R.id.main_mine_yanzhengxinshouji_btn);
		huoqu = (Button) findViewById(R.id.main_mine_yanzhengxinshouji_huoqu);

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
			YanZhengXinShouJiActivity.this.finish();
			anim_right_out();
			break;
		case R.id.main_mine_yanzhengxinshouji_huoqu:
			loadHttp_mesgCode();
			break;
		case R.id.main_mine_yanzhengxinshouji_btn:
			loadHttp_finsh();
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
					huoqu.setTextSize(TypedValue.COMPLEX_UNIT_SP,16);
					huoqu.setEnabled(false);
				}
					break;
				case 1: {
					String text = (String) msg.obj;
					canclTimer();
					huoqu.setText(text);
					huoqu.setTextSize(TypedValue.COMPLEX_UNIT_SP,10);
					huoqu.setEnabled(true);
				}
					break;
				default:
					break;
				}
			};
		};

		//需要重写finish();停止线程
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

					Toast.makeText(YanZhengXinShouJiActivity.this,
							msg.getData().getString("errMsg"), 1000).show();

					break;
				case 1:// 获取短信验证码
					Toast.makeText(YanZhengXinShouJiActivity.this,
							msg.getData().getString("msg"), 1000).show();
					// 获取验证码
					startTimer();
					break;
				case 3:// 完成验证
					//本地保存
					UserMode user = Tool.getUser(YanZhengXinShouJiActivity.this);
					user.setSjh(shouji.getText().toString());
					user.saveUserToDB(YanZhengXinShouJiActivity.this);
					// 完成  验证新手机成功之后，应该调回安全信息页面，此时应该将手机号传递过去，或者调用usermode，刷新安全信息页面
					startActivity(new Intent(YanZhengXinShouJiActivity.this,AnQuanXinXiActivity
							.class));
					//发送通知
					Intent intent = new Intent();
					intent.setAction("wanchenghoudeshuaxin");
				    sendBroadcast(intent);
				    
					finish();
					anim_right_out();
					break;
				case 2:
					Toast.makeText(YanZhengXinShouJiActivity.this,
							msg.getData().getString("msg"), 1000).show();
					break;

				default:
					break;
				}
			}
		};

		// 获取短信验证码
		private void loadHttp_mesgCode() {
			// TODO Auto-generated method stub
			Map<String, String> map = new HashMap<String, String>();
			map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
			map.put("isLock", "0");// 0不锁，1是锁
			map.put("type", "3");//类型
			map.put("phone", shouji.getText().toString());//手机
			RequestThreadAbstract thread = RequestFactory.createRequestThread(5,
					map, YanZhengXinShouJiActivity.this, mHandler);
			RequestPool.execute(thread);
		}

		// 完成进行验证
		private void loadHttp_finsh() {
			
			juhua.show();
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("urlTag", "2");// 可不传（区分一个activity多个请求）
			map.put("isLock", "0");// 0不锁，1是锁
			map.put("type", "2");//类型
			map.put("sjh", shouji.getText().toString());//手机
			map.put("yzm",yanzhengma.getText().toString());//验证码	
			UserMode user = Tool.getUser(YanZhengXinShouJiActivity.this);
			map.put("lsj",user.getSjh());//老手机
			try {
				map.put("key",Tool.getMD5(user.getSjh()+"2"+key));//加密字符串
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
			RequestThreadAbstract thread = RequestFactory.createRequestThread(22,
					map, YanZhengXinShouJiActivity.this, mHandler);
			RequestPool.execute(thread);
		}

		@Override
		public void httpResponse_success(Map<String, String> map,
				List<Object> list, Object jsonObj) {
			// TODO Auto-generated method stub
			// 获取短信验证码
			if (map.get("urlTag").equals("1")) {
				Message msg1 = new Message();
				msg1.what = 1;
				Bundle bundle = new Bundle();
				bundle.putString("msg", "短信验证码已经发送到你的手机");
				msg1.setData(bundle);
				mHandler.sendMessage(msg1);
			} else if (map.get("urlTag").equals("2")) {//下一步验证
				Message msg1 = new Message();
				msg1.what = 3;
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
