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

public class SheZhiTiXianMiMaActivity extends BaseActivity implements
		OnClickListener, HttpResponseInterface {

	//提现密码输入
	private EditText tixian = null;
	//确认密码
	private EditText queren = null;
	//完成
	private Button next = null;

	private Dialog juhua = null;
	
	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_mine_shezhitixianmima;
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("设置提现密码");
		showBack();
		
		juhua = new ProcessDialogUtil(SheZhiTiXianMiMaActivity.this);

		tixian = (EditText) findViewById(R.id.main_mine_shezhitixianmima_xin);
		queren = (EditText) findViewById(R.id.main_mine_shezhitixianmima_queren);
		next = (Button) findViewById(R.id.main_mine_shezhitixianmima_btn);

	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);

		next.setOnClickListener(this);
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_back:
			SheZhiTiXianMiMaActivity.this.finish();
			anim_right_out();
			break;
		case R.id.main_mine_shezhitixianmima_btn:
			// 完成
			
			loadHttp_finsh();
			
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
				Toast.makeText(SheZhiTiXianMiMaActivity.this,
						msg.getData().getString("errMsg"), 1000).show();
				break;
			case 1:// 修改成功了

				
				UserMode user = Tool.getUser(SheZhiTiXianMiMaActivity.this);
				user.setTxmmsfsz("true");
				user.saveUserToDB(SheZhiTiXianMiMaActivity.this);
				
				Toast.makeText(SheZhiTiXianMiMaActivity.this,"成功", 1000).show();
				
				startActivity(new Intent(SheZhiTiXianMiMaActivity.this,AnQuanXinXiActivity.class));
				
				//发送通知
				Intent intent = new Intent();
				intent.setAction("wanchenghoudeshuaxin");
			    sendBroadcast(intent);
			    
			    
				finish();
				anim_right_out();
				
				break;
			case 2:
				Toast.makeText(SheZhiTiXianMiMaActivity.this,
						msg.getData().getString("msg"), 1000).show();
				break;

			default:
				break;
			}
		}
	};

 
	// 完成
	private void loadHttp_finsh() {

		juhua.show();
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		 
		map.put("mm", tixian.getText().toString());
		map.put("cmm", queren.getText().toString());
 
		RequestThreadAbstract thread = RequestFactory.createRequestThread(20,
				map, SheZhiTiXianMiMaActivity.this, mHandler);
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
