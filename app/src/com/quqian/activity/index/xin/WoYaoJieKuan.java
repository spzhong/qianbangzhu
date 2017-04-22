package com.quqian.activity.index.xin;

import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.R.integer;
import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;
import android.support.v4.view.ViewPager;
import android.support.v4.view.ViewPager.OnPageChangeListener;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.Toast;
import android.widget.LinearLayout.LayoutParams;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.example.quqian.R;
import com.loopj.android.image.SmartImageView;
import com.quqian.activity.LoginActivity;
import com.quqian.activity.MainActivity;
import com.quqian.activity.RegisterActivity;
import com.quqian.activity.YanZhengShouJiActivity;
import com.quqian.activity.index.IndexActivity;
import com.quqian.activity.mine.ChongZhiActivity;
import com.quqian.activity.mine.ZiJinGuanLiActivity;
import com.quqian.activity.more.MoreActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.TiYanProject;
import com.quqian.been.UserMode;
import com.quqian.http.API;
import com.quqian.http.Http;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.BitmapUtil;
import com.quqian.util.CommonUtil;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.TimeUtil;
import com.quqian.util.Tool;
import com.quqian.util.WebViewActivity;

public class WoYaoJieKuan extends BaseActivity implements OnClickListener,
		HttpResponseInterface {

	//
	private EditText name = null;
	private EditText phone = null;
	private EditText jine = null;
	private EditText qixian = null;
	private EditText city = null;
	private Spinner type = null;
	
	private Button submit = null;
	
	// 读取登录状态 ，loginState = login.
	private Boolean loginState = false;
	private UserMode user = null;

	private Dialog juhua = null;

	// jsonObj
	private JSONObject json = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_index_xin_woyaojiekuan;
	}

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
	}

	@Override
	protected void onResume() {
		// TODO Auto-generated method stub
		super.onResume();
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("我要借款");
		showBack();

		juhua = new ProcessDialogUtil(WoYaoJieKuan.this);

		name = (EditText)findViewById(R.id.wyjk_name);
		phone = (EditText)findViewById(R.id.wyjk_phone);
		jine = (EditText)findViewById(R.id.wyjk_jine);
		qixian = (EditText)findViewById(R.id.wyjk_chou);
		city = (EditText)findViewById(R.id.wyjk_city);
		type = (Spinner)findViewById(R.id.wyjk_type);
		submit = (Button)findViewById(R.id.wyjk_shenqing);

		// 判断用户
		user = Tool.getUser(WoYaoJieKuan.this);
		if (user == null) {
			loginState = false;
		} else {
			loginState = true;
		}
	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);
		submit.setOnClickListener(this);
	
	}

	protected void doOther() {
		
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub

		switch (arg0.getId()) {
		case R.id.title_bar_back:
			// 返回
			WoYaoJieKuan.this.finish();
			anim_right_out();
			break;
		case R.id.wyjk_shenqing:
			woyaojiekuan();
			// 立即申请
			
			break;
		default:
			break;
		}
	}

	// 网络请求处理
	private Handler mHandler = new Handler() {

		@Override
		public void handleMessage(Message msg) {
			// TODO Auto-generated method stub
			super.handleMessage(msg);

			juhua.cancel();
			switch (msg.what) {
			case 1:		
				Toast.makeText(WoYaoJieKuan.this,"借款成功", 1000).show();
				WoYaoJieKuan.this.finish();
				anim_right_out();
				break;
			default:
				break;
			}
		}
	};

	// 借款网络请求
	private void woyaojiekuan() {
		// TODO Auto-generated method stub
		UserMode user = Tool.getUser(WoYaoJieKuan.this);
		if(user==null){
			Toast.makeText(WoYaoJieKuan.this,"你还没有登录", 1000).show();
			return;
		}
		
		String names = name.getText().toString();
		String phones = phone.getText().toString();
		String jines = jine.getText().toString();
		String qixians = qixian.getText().toString();
		String citys = city.getText().toString(); 
		
		
		if (names.length()==0) {
			Toast.makeText(WoYaoJieKuan.this,"请输入姓名", 1000).show();
			return;
		} 
		if (!Tool.isMobileNO(phones)) {
			Toast.makeText(WoYaoJieKuan.this,"请输入正确的手机号", 1000).show();
			return;
		}
		if (jines.length()==0) {
			Toast.makeText(WoYaoJieKuan.this,"请输入借款金额", 1000).show();
			return;
		}  
		if (qixians.length()==0) {
			Toast.makeText(WoYaoJieKuan.this,"请输入预筹款期限", 1000).show();
			return;
		}		 
		if (citys.length()==0) {
			Toast.makeText(WoYaoJieKuan.this,"请输入所在城市", 1000).show();
			return;
		}
		
		String types = (String)type.getSelectedItem();
		if (types.length()==0) {
			Toast.makeText(WoYaoJieKuan.this,"请选择借款类型", 1000).show();
			return;
		}
		 
		juhua.show();
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("xm", names);
		map.put("sjh",phones);
		map.put("jkje",jines);
		map.put("ckqx",qixians);
		map.put("cs", citys);
		if (types.endsWith("个人借款")) {
			map.put("jklx", "GRKH");
		}else{
			map.put("jklx", "QYKH");
		}
		RequestThreadAbstract thread = RequestFactory.createRequestThread(101,
				map, WoYaoJieKuan.this, mHandler);
		RequestPool.execute(thread);
	}


	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub

		// 我要借款
		if (map.get("urlTag").equals("1")) {
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
