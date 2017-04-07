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

public class YunYingShuJu extends BaseActivity implements OnClickListener,
		HttpResponseInterface {

	//
	private TextView anquanday = null;
	private TextView jiekuan = null;
	private TextView zhuce = null;

	private Button submit = null;
	
	//加载框
	private Dialog juhua = null;

	// jsonObj
	private JSONObject json = null;

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

		anquanday = (TextView)findViewById(R.id.yysj_anquanyunyingshijian);
		jiekuan = (TextView)findViewById(R.id.yysj_wanchengjiekuan);
		zhuce = (TextView)findViewById(R.id.yysj_zhucerenshu);
		
		submit = (Button)findViewById(R.id.yysj_xia1);

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
			YunYingShuJu.this.finish();
			anim_right_out();
			break;
		case R.id.yysj_xia1:
			// 下一页运营数据
			startActivity(new Intent(YunYingShuJu.this,YunYingShuJuNext.class));
			anim_right_in();
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

				break;
			default:
				break;
			}
		}
	};

	// 网络请求
	private void loadHttp_bannerInfo() {
		// TODO Auto-generated method stub

		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		RequestThreadAbstract thread = RequestFactory.createRequestThread(33,
				map, YunYingShuJu.this, mHandler);
		RequestPool.execute(thread);
	}


	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub

		// 个人资料信息
		if (map.get("urlTag").equals("1")) {
			if (list.size() == 1) {
				Message msg1 = new Message();
				msg1.what = 1;
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
