package com.quqian.activity.mine.xin;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.Parcelable;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.LoginActivity;
import com.quqian.activity.MainActivity;
import com.quqian.activity.index.LiJiShenQingActivity;
import com.quqian.activity.mine.BangDingYinHangKaActivity;
import com.quqian.activity.mine.ChongZhiActivity;
import com.quqian.activity.mine.KjChongZhiActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.TiYanProject;
import com.quqian.been.UserMode;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.lockq.GestureEditActivity;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.MyWebViewActivity;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.StaticVariable;
import com.quqian.util.Tool;

public class ZhangHuZongLan extends BaseActivity implements OnClickListener,
		HttpResponseInterface {

	// radioGroup
	private RadioGroup rg = null;
	private RadioButton rb1 = null;
	private RadioButton rb2 = null;
	// 单选按钮下面的选中条
	private TextView tvrb1 = null;
	private TextView tvrb2 = null;

	// 账户总览数据
	private TextView keyongyue = null;
	private TextView dongjiejine = null;
	private TextView zhanghuzonge = null;

	private TextView yizhuangshouyi = null;
	private TextView daishoubenjin = null;
	private TextView daishoulixi = null;
	private TextView leijitouzi = null;

	private TextView leijijiekuan = null;
	private TextView daihuanbenjin = null;
	private TextView daihuanlixi = null;
	private TextView daihuanguanlifei = null;

	// 当前选中的radio button
	private String myrb = "1";

	// 网络加载中
	ProcessDialogUtil juhua = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.mine_new_zhanghuzonglan;
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
		setTitle("账户总览");
		showBack();

		juhua = new ProcessDialogUtil(ZhangHuZongLan.this);

		rg = (RadioGroup) findViewById(R.id.zhzl_rg);
		rb1 = (RadioButton) findViewById(R.id.zhzl_rb1);
		rb2 = (RadioButton) findViewById(R.id.zhzl_rb2);
		// 单选按钮下面的选中条
		tvrb1 = (TextView) findViewById(R.id.zhzl_tvrb1);
		tvrb2 = (TextView) findViewById(R.id.zhzl_tvrb2);

		//账户总览
		keyongyue = (TextView) findViewById(R.id.zhzl_keyongyue);
		dongjiejine = (TextView) findViewById(R.id.zhzl_dongjieyue);
		zhanghuzonge = (TextView) findViewById(R.id.zhzl_zhanghuzonge);
		
		yizhuangshouyi = (TextView) findViewById(R.id.zhzl_yizhuanshouyi);
		daishoubenjin = (TextView) findViewById(R.id.zhzl_daishoubenjin);
		daishoulixi = (TextView) findViewById(R.id.zhzl_daishoulixi);
		leijitouzi = (TextView) findViewById(R.id.zhzl_leijitouzi);

		leijijiekuan = (TextView) findViewById(R.id.zhzl_leijijiekuan);
		daihuanbenjin = (TextView) findViewById(R.id.zhzl_daihuanbenjin);
		daihuanlixi = (TextView) findViewById(R.id.zhzl_daihuanlixi);
		daihuanguanlifei = (TextView) findViewById(R.id.zhzl_daihuanguanlifei);
		
		// 调用接口 获取充值信息，然后加载页面
		loadHttp();
	}

	@Override
	protected void onResume() {
		// TODO Auto-generated method stub
		super.onResume();
	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);
		rb1.setOnClickListener(this);
		rb2.setOnClickListener(this);

	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub

		switch (arg0.getId()) {
		case R.id.title_bar_back:
			ZhangHuZongLan.this.finish();
			anim_right_out();
			break;
		case R.id.zhzl_rb1:
			// 存管充值选项 点击该按钮，选中状态条
			tvrb1.setBackgroundColor(getResources().getColor(
					R.color.main_radio_blue));
			tvrb2.setBackgroundColor(getResources().getColor(R.color.white));

			// 将当前的选中按钮设置为1，
			myrb = "1";

			break;
		case R.id.zhzl_rb2:
			// 普通充值选项
			// 存管充值选项 点击该按钮，选中状态条
			tvrb1.setBackgroundColor(getResources().getColor(R.color.white));
			tvrb2.setBackgroundColor(getResources().getColor(
					R.color.main_radio_blue));

			// 将当前的选中按钮设置为1，
			myrb = "2";

			break;
		default:
			break;
		}
	}

	private Handler mHandler = new Handler() {

		@Override
		public void handleMessage(Message msg) {
			// TODO Auto-generated method stub
			super.handleMessage(msg);

			juhua.cancel();

			switch (msg.what) {
			case 0:
				Toast.makeText(ZhangHuZongLan.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:
				break;
			case 2:
				Toast.makeText(ZhangHuZongLan.this,
						msg.getData().getString("msg"), 1000).show();
				break;
			default:
				break;
			}
		}
	};

	private void loadHttp() {

		juhua.show();

		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁

		// 请求的参数如下
		RequestThreadAbstract thread = RequestFactory.createRequestThread(38,
				map, ZhangHuZongLan.this, mHandler);
		RequestPool.execute(thread);
	}

	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub
		JSONObject json = (JSONObject) jsonObj;
		try {
			JSONObject cg = json.getJSONObject("rvalue").getJSONObject("cg");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
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
