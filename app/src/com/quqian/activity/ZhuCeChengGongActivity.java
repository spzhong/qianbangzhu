package com.quqian.activity;

import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.quqian.util.Tool;

public class ZhuCeChengGongActivity extends BaseActivity implements
		OnClickListener, HttpResponseInterface {

	//真实姓名
	private EditText name = null;
	//身份证号
	private EditText cardID = null;
	//开通存管账户
	private Button kaitong = null;
	//不开通
	private Button bukai = null;
	
	private String shoujihao = "";
	private String key = "";

	private Dialog juhua = null;
	
	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.zhucechenggong;
	}

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
		if(getIntent().getStringExtra("shouji") !=null){
			shoujihao = getIntent().getStringExtra("shouji");
		}
		if(getIntent().getStringExtra("key") !=null){
			key = getIntent().getStringExtra("key");
		}
	}
	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("注册成功");
		showBack();

		juhua = new ProcessDialogUtil(ZhuCeChengGongActivity.this);
		
		name = (EditText) findViewById(R.id.r_xingming);
		cardID = (EditText) findViewById(R.id.r_shenfenzhenghao);
		kaitong = (Button) findViewById(R.id.r_kaitong);
		bukai = (Button) findViewById(R.id.r_bukaitong);
	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);

		kaitong.setOnClickListener(this);
		bukai.setOnClickListener(this);
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_back:
			ZhuCeChengGongActivity.this.finish();
			anim_right_out();
			break;
		case R.id.r_kaitong:
			// 完成  应该记录登录状态，跳转到相应的界面，或者应该判断是否需要设置手势密码，进入首页
			
			//loadHttp_chongzhimima();
	
			break;
		case R.id.r_bukaitong:
			// 完成  应该记录登录状态，跳转到相应的界面，或者应该判断是否需要设置手势密码，进入首页
			
			//loadHttp_chongzhimima();
	
			break;

		default:
			break;
		}
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

				Toast.makeText(ZhuCeChengGongActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:
				// 下一步
				
				Toast.makeText(ZhuCeChengGongActivity.this,"成功", 1000).show();
				anim_right_out();
				finish();
				
				break;
			case 2:
				Toast.makeText(ZhuCeChengGongActivity.this,
						msg.getData().getString("msg"), 1000).show();
				break;

			default:
				break;
			}
		}
	};

	// 找回密码
	private void loadHttp_chongzhimima() {
		// TODO Auto-generated method stub
	
		juhua.show();
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("type", "1");//类型
		map.put("phone",shoujihao);//手机号
		try {
			map.put("key",Tool.getMD5(shoujihao+"1" + key));
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}// key
		RequestThreadAbstract thread = RequestFactory.createRequestThread(34,
				map, ZhuCeChengGongActivity.this, mHandler);
		RequestPool.execute(thread);
	}

 
	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub
		Message msg1 = new Message();
		msg1.what = 1;
		mHandler.sendMessage(msg1);
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
