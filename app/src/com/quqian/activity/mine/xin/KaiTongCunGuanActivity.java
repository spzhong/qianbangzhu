package com.quqian.activity.mine.xin;

import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

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
import com.quqian.activity.invert.LiJiTouBiaoActivity;
import com.quqian.base.BaseActivity;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.Tool;

public class KaiTongCunGuanActivity extends BaseActivity implements
		OnClickListener, HttpResponseInterface {

	// 真实姓名
	private EditText name = null;
	// 身份证号
	private EditText cardID = null;
	// 开通存管账户
	private Button kaitong = null;

	private String shoujihao = "";
	private String key = "";

	private Dialog juhua = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.mine_new_kaitongchuguanzhanghu;
	}

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
		if (getIntent().getStringExtra("shouji") != null) {
			shoujihao = getIntent().getStringExtra("shouji");
		}
		if (getIntent().getStringExtra("key") != null) {
			key = getIntent().getStringExtra("key");
		}
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("开通存管账户");
		showBack();

		juhua = new ProcessDialogUtil(KaiTongCunGuanActivity.this);

		name = (EditText) findViewById(R.id.kt_xingming);
		cardID = (EditText) findViewById(R.id.kt_shenfenzhenghao);
		kaitong = (Button) findViewById(R.id.kt_kaitong);
	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);

		kaitong.setOnClickListener(this);
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_back:
			KaiTongCunGuanActivity.this.finish();
			anim_right_out();
			break;
		case R.id.kt_kaitong:

			http();

			break;

		default:
			break;
		}
	}

	private void http() {
		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁

		map.put("realname", name.getText().toString());// 类型
		map.put("idcard", cardID.getText().toString());// 手机号

		RequestThreadAbstract thread = RequestFactory.createRequestThread(106,
				map, KaiTongCunGuanActivity.this, mHandler);
		RequestPool.execute(thread);
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
				Toast.makeText(KaiTongCunGuanActivity.this,
						msg.getData().getString("msg"), 1000).show();

				break;
			case 3:// 跳转到开通存管账户的【H5页面】
				// 存管投资--进入h5页面
				Bundle bundle = msg.getData();
				String sendUrl = (String) bundle.get("sendUrl");
				String sendStr = (String) bundle.get("sendStr");
				String transCode = (String) bundle.get("transCode");
				if (sendUrl == null) {
					Toast.makeText(KaiTongCunGuanActivity.this, "操作失败", 1000)
							.show();
					return;
				}
				Intent intent2 = new Intent(KaiTongCunGuanActivity.this,
						CGWebView.class);
				intent2.putExtra("sendUrl", sendUrl);
				intent2.putExtra("sendStr", sendStr);
				intent2.putExtra("transCode", transCode);
				intent2.putExtra("title", "开通存管账户");
				startActivity(intent2);
				anim_right_in();

				break;
			case 2:
				Toast.makeText(KaiTongCunGuanActivity.this,
						msg.getData().getString("msg"), 1000).show();
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
		JSONObject json = (JSONObject) jsonObj;
		Message msg1 = new Message();
		msg1.what = 3;
		Bundle bundle = new Bundle();
		try {
			bundle.putString("transCode", json.getJSONObject("rvalue").getJSONObject("sdkParameter")
					.getString("transCode"));
			bundle.putString("sendUrl", json.getJSONObject("rvalue").getJSONObject("sdkParameter")
					.getString("url"));
			bundle.putString("sendStr", json.getJSONObject("rvalue").getJSONObject("sdkParameter")
					.getString("requestData"));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		msg1.setData(bundle);
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
