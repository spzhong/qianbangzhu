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
import com.quqian.activity.index.ZhaiQuanZhuanRangActivity;
import com.quqian.activity.mine.TongZhiActivity;
import com.quqian.activity.mine.TongZhiInfoActivity;
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
import com.quqian.util.MyWebViewActivity;

public class YunYingShuJu extends BaseActivity implements OnClickListener,
		HttpResponseInterface {

	//
	private TextView anquanday = null;
	private TextView jiekuan = null;
	private TextView zhuce = null;

	// 累计成交
	private TextView leijichengjiao = null;
	// 投资人累计赚取收益
	private TextView leijizhuanquanshouyi = null;
	// 待还本金
	private TextView daihuanbenjin = null;
	// 投资人待赚取收益
	private TextView daizhuanqushouyi = null;

	private Button submit = null;

	// 加载框
	private Dialog juhua = null;

	// jsonObj
	private JSONObject json = null;

	private String ljcj = null; // 累计成交金额
	private String tzrljsy = null; // 投资人累计赚取收益
	private String dhbj = null; // 待还本金
	private String tzrdhsy = null; // 投资人待收收益

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_index_xin_yunyingshuju;
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
		setTitle("运营数据");
		showBack();

		juhua = new ProcessDialogUtil(YunYingShuJu.this);

		anquanday = (TextView) findViewById(R.id.yysj_anquanyunyingshijian);
		jiekuan = (TextView) findViewById(R.id.yysj_wanchengjiekuan);
		zhuce = (TextView) findViewById(R.id.yysj_zhucerenshu);

		leijichengjiao = (TextView) findViewById(R.id.yysjn_leijichengjiao);
		leijizhuanquanshouyi = (TextView) findViewById(R.id.yysjn_leijizhuanqushouyi);
		daihuanbenjin = (TextView) findViewById(R.id.yysjn_daihuanbenjin);
		daizhuanqushouyi = (TextView) findViewById(R.id.yysjn_leijizhuanqushouyi);

		loadHttp_yunyingInfo();
	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);
	}

	protected void doOther() {

	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub

		switch (arg0.getId()) {
		case R.id.title_bar_back:
			// 返回
			YunYingShuJu.this.finish();
			anim_right_out();
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
				try {
					anquanday.setText(json.get("yysj") + "天");
					jiekuan.setText(json.getString("jkbs") + "笔");
					zhuce.setText(json.getString("zcrs") + "人");

					leijichengjiao.setText(json.getString("zcrs") + "元");
					leijizhuanquanshouyi.setText(tzrljsy + "元");
					daihuanbenjin.setText(dhbj + "元");
					daizhuanqushouyi.setText(tzrdhsy + "元");
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				break;
			default:
				break;
			}
		}
	};

	// 网络请求
	private void loadHttp_yunyingInfo() {
		// TODO Auto-generated method stub

		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		RequestThreadAbstract thread = RequestFactory.createRequestThread(100,
				map, YunYingShuJu.this, mHandler);
		RequestPool.execute(thread);
	}

	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub
		// 运营数据
		if (map.get("urlTag").equals("1")) {

			JSONObject js = (JSONObject) jsonObj;
			try {
				json = js.getJSONObject("rvalue");
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
