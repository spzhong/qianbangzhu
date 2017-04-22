package com.quqian.activity.more;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.UserManager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.MainActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.UserMode;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.Tool;

public class JianYiActivity extends BaseActivity implements OnClickListener,
		HttpResponseInterface {

	private EditText et1 = null;
	private EditText et2 = null;

	// 如果是未登录状态，填写建议的时候需要输入邮箱，否则不需要，
	private LinearLayout layout = null;

	private Button btn = null;
	
	private Dialog juhua = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_more_yijian;
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("意见反馈");
		showBack();

		juhua = new ProcessDialogUtil(JianYiActivity.this);

		et1 = (EditText) findViewById(R.id.more_yijian_et1);
		et2 = (EditText) findViewById(R.id.more_yijian_et2);
		
		btn = (Button) findViewById(R.id.more_yijianfankuai_tijiao);

		layout = (LinearLayout) findViewById(R.id.main_more_yijian_layout);

		UserMode user = Tool.getUser(JianYiActivity.this);
		if (user == null) {
			layout.setVisibility(View.VISIBLE);
		} else {
			layout.setVisibility(View.GONE);
		}

	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);
		btn.setOnClickListener(this);
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_back:
			// 返回按钮
			JianYiActivity.this.finish();
			anim_right_out();
			break;
		case R.id.more_yijianfankuai_tijiao:
			// 提交按钮
			// Toast.makeText(JianYiActivity.this, "tijiao", 1000).show();
			loadHttp_tijiao();
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

				Toast.makeText(JianYiActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:
				// 停止菊花
				Toast.makeText(JianYiActivity.this, "反馈成功", 1000).show();
				finish();
				anim_right_out();
				
				break;
			case 2:
				Toast.makeText(JianYiActivity.this,
						msg.getData().getString("msg"), 1000).show();
				break;

			default:
				break;
			}
		}
	};

	// 提交意见反馈
	private void loadHttp_tijiao() {
	
		//判断登录了吗
		UserMode user = Tool.getUser(JianYiActivity.this);
		if(user==null && et2.getText().toString().length()==0){
			Toast.makeText(JianYiActivity.this,"请输入联系方式", 1000).show();
			return;
		}
		
		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "2");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		
		try {
			map.put("yjnr", URLEncoder.encode(et1.getText().toString(), "UTF-8"));// 内容
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
		map.put("lxfs", et2.getText().toString());// 联系方式
		RequestThreadAbstract thread = RequestFactory.createRequestThread(7,
				map, JianYiActivity.this, mHandler);
		RequestPool.execute(thread);
	}

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
