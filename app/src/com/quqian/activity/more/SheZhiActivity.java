package com.quqian.activity.more;

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
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.LoginActivity;
import com.quqian.activity.MainActivity;
import com.quqian.activity.index.IndexActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.UserMode;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.lockq.GestureVerifyActivity;
import com.quqian.util.CommonUtil;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.StaticVariable;
import com.quqian.util.Tool;

public class SheZhiActivity extends BaseActivity implements OnClickListener,
		HttpResponseInterface {

	// 修改手势密码
	private TextView xiugai = null;
	// 检查更新
	private TextView jiancha = null;
	// 退出按钮
	private Button btn = null;

	private Dialog juhua = null;
	
	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_more_shezhi;
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("设置");
		showBack();
		
		juhua = new ProcessDialogUtil(SheZhiActivity.this);

		xiugai = (TextView) findViewById(R.id.more_shezhi_tv1);
		jiancha = (TextView) findViewById(R.id.more_shezhi_tv2);
		btn = (Button) findViewById(R.id.more_shezhi_btn);

	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);
		xiugai.setOnClickListener(this);
		jiancha.setOnClickListener(this);
		btn.setOnClickListener(this);
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_back:
			// 返回按钮
			SheZhiActivity.this.finish();
			anim_right_out();
			break;
		case R.id.more_shezhi_tv1:
			// 修改手势密码
			UserMode user = Tool.getUser(this);
			if(user == null){
				//跳转到登录页面，
				startActivity(new Intent(SheZhiActivity.this,LoginActivity.class));
			}else{
				//跳转到校验手势
				Intent intent = new Intent(SheZhiActivity.this,GestureVerifyActivity.class);
				intent.putExtra("type", "jiaoyan");
				startActivity(intent);
			}
			break;
		case R.id.more_shezhi_tv2:
			
			loadHttp_banbengengxi();
			 
			break;
		case R.id.more_shezhi_btn:
			// 退出按钮.清除登录账户密码，回到首页
			clearLogin();
			Intent intent3 = new Intent(this, MainActivity.class);
			StaticVariable.put(StaticVariable.sv_toIndex, "1");
			startActivity(intent3);
			finish();
			anim_right_out();
			break;
		default:
			break;
		}
	}

 
	// 清除登录账户，仅仅是登录人的登录状态，
	private void clearLogin() {
		CommonUtil.clearByKey(SheZhiActivity.this, "loginState", "", "");
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

				Toast.makeText(SheZhiActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:
				// 停止菊花
				Toast.makeText(SheZhiActivity.this,"当前版本是最新版本", 1000).show();
				
				break;
			case 2:
				Toast.makeText(SheZhiActivity.this,
						msg.getData().getString("msg"), 1000).show();
				break;

			default:
				break;
			}
		}
	};

	// 检测版本更新
	private void loadHttp_banbengengxi() {
		
		juhua.show();
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "2");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("type", "android");// 类型
		RequestThreadAbstract thread = RequestFactory.createRequestThread(35,
				map, SheZhiActivity.this, mHandler);
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
