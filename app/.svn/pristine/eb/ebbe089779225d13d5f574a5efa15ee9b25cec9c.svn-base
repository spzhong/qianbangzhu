package com.quqian.activity.mine;

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
import android.util.Log;
import android.view.Display;
import android.view.Gravity;
import android.view.KeyEvent;
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
import com.quqian.been.Notification;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;

public class TongZhiInfoActivity extends BaseActivity implements
		OnClickListener, HttpResponseInterface {

	private TextView title = null;
	private TextView time = null;
	private TextView content = null;

	private String str1 = null;
	private String str2 = null;
	private String str3 = null;

	private String pId = null;

	private Dialog juhua = null;
	
	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_mine_tongzhiinfo;
	}

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
		if (getIntent().getStringExtra("title") != null) {
			str1 = getIntent().getStringExtra("title");
			str2 = getIntent().getStringExtra("time");
			str3 = getIntent().getStringExtra("content");
			pId = getIntent().getStringExtra("pid");
		}

	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("消息详情");
		showBack();
		
		juhua = new ProcessDialogUtil(TongZhiInfoActivity.this);

		title = (TextView) findViewById(R.id.main_mine_tongzhiinfo_title);
		time = (TextView) findViewById(R.id.main_mine_tongzhiinfo_time);
		content = (TextView) findViewById(R.id.main_mine_tongzhiinfo_content);

		title.setText(str1);
		time.setText(str2);
		content.setText(str3);

		loadHttp2(pId);

	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_back:
			startActivity(new Intent(TongZhiInfoActivity.this,
					TongZhiActivity.class));
			TongZhiInfoActivity.this.finish();
			anim_right_in();
			break;

		default:
			break;
		}
	}

	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		// TODO Auto-generated method stub

		if (keyCode == KeyEvent.KEYCODE_BACK && event.getRepeatCount() == 0) {
			startActivity(new Intent(TongZhiInfoActivity.this,
					TongZhiActivity.class));
			finish();
			anim_right_out();
		}
		return false;

	}

	private void loadHttp2(String pid) {

		juhua.show();

		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "2");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		// 请求的参数如下

		map.put("id", pid);

		RequestThreadAbstract thread = RequestFactory.createRequestThread(37,
				map, TongZhiInfoActivity.this, mHandler);
		RequestPool.execute(thread);

	}

	private Handler mHandler = new Handler() {

		@Override
		public void handleMessage(Message msg) {
			// TODO Auto-generated method stub
			super.handleMessage(msg);
			
			juhua.cancel();

			switch (msg.what) {
			case 0:
				Toast.makeText(TongZhiInfoActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:
				
				break;
			case 2:
				Toast.makeText(TongZhiInfoActivity.this,
						msg.getData().getString("msg"), 1000).show();
				break;
			default:
				break;
			}
		}
	};

	// 把所有的网络请求放到最下面
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
