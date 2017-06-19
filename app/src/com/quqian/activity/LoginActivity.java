package com.quqian.activity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.app.Dialog;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.index.SanBiaoTouZiActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.TiYanProject;
import com.quqian.been.UserMode;
import com.quqian.http.API;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.lockq.GestureEditActivity;
import com.quqian.util.CommonUtil;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.StaticVariable;
import com.quqian.util.Tool;

public class LoginActivity extends BaseActivity implements OnClickListener,
		HttpResponseInterface {

	// 登录按钮
	private Button login = null;
	// 用户名
	private EditText et_name = null;
	// 密码
	private EditText et_pass = null;
	// 忘记密码
	private TextView tv_wang = null;
	// 忘记密码
	private TextView tv_zhuce = null;

	private Boolean fangxiang = false;

	// usermode
	private UserMode allUser = null;

	// list<object>集合
	private List<Object> allList = new ArrayList<Object>();

	private Dialog jindu = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.activity_login;
	}

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
		if ("main".equals(getIntent().getStringExtra("fangxiang"))) {
			fangxiang = true;
			Log.v("quqain", "-----LoginAcitvity------" + fangxiang);
		}
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("登录");
		showBack();
		// showMenu();
		// setMenu("注册");

		jindu = new ProcessDialogUtil(LoginActivity.this);

		login = (Button) findViewById(R.id.login_login);
		et_name = (EditText) findViewById(R.id.login_et_name);
		et_pass = (EditText) findViewById(R.id.login_et_pass);
		tv_wang = (TextView) findViewById(R.id.login_wangjimima);
		tv_zhuce = (TextView) findViewById(R.id.login_mianfeizhuce);
	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);
		login.setOnClickListener(this);
		tv_wang.setOnClickListener(this);
		tv_zhuce.setOnClickListener(this);
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_back:
			// 返回键
			backTo();
			break;
		case R.id.login_mianfeizhuce:
			// 注册键
			startActivity(new Intent(LoginActivity.this, RegisterActivity.class));
			anim_right_in();
			break;
		case R.id.login_login:
			// 登录键 调接口判断，返回成功，需要将 “该用户” 成功的标记存起来
			// if ("1".equals(et_name.getText().toString())) {
			// Intent intent3 = new Intent(this, MainActivity.class);
			// StaticVariable.put(StaticVariable.sv_toIndex, "1");
			// startActivity(intent3);
			// anim_right_out();
			// reviseLoginState();
			// finish();
			// } else {
			// Intent intent3 = new Intent(this, MainActivity.class);
			// StaticVariable.put(StaticVariable.sv_toIndex, "1");
			// startActivity(intent3);
			// anim_right_out();
			// finish();
			// }
			loadHttp();
			break;
		case R.id.login_wangjimima:
			// 忘记密码
			startActivity(new Intent(LoginActivity.this,
					ZhaoHuiMiMaNEWActivity.class));
			anim_right_in();
			break;
		default:
			break;
		}

	}

	// 修改登录状态
	private void reviseLoginState() {
		// CommonUtil.addConfigInfo(LoginActivity.this, "loginState", "login",
		// "",
		// "");
		// 将当前用户保存到文件中
		UserMode user = Tool.getUser(LoginActivity.this);
		Tool.writeData(LoginActivity.this, "loginState", "zhanghu",
				allUser.getYhzh());
	}

	// 返回键事件
	private void backTo() {
		if (fangxiang) {
			Intent intent3 = new Intent(this, MainActivity.class);
			StaticVariable.put(StaticVariable.sv_toIndex, "1");
			startActivity(intent3);
			// MainActivity parent = (MainActivity) this.getParent();
			// if(parent!=null){
			// parent.toTab(R.id.rbIndex,null,false);
			// }
			finish();
			anim_right_out();
		} else {
			LoginActivity.this.finish();
			anim_right_out();
		}
	}

	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		// TODO Auto-generated method stub
		if (keyCode == KeyEvent.KEYCODE_BACK && event.getRepeatCount() == 0) {
			backTo();
		}
		return false;
	}

	private Handler mHandler = new Handler() {

		@Override
		public void handleMessage(Message msg) {
			// TODO Auto-generated method stub
			super.handleMessage(msg);

			jindu.cancel();

			switch (msg.what) {
			case 0:
				Toast.makeText(LoginActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:

				// 登录成功之后，修改状态
				reviseLoginState();

				UserMode user = Tool.getUser(LoginActivity.this);

				if (user.getShoushiCode().equals("")
						|| user.getShoushiCode() == null) {
					// 设置手势
					Intent intent3 = new Intent(LoginActivity.this,
							GestureEditActivity.class);
					// StaticVariable.put(StaticVariable.sv_toIndex, "1");

					// type 0是设置手势密码，1是确认手势密码，3是验证手势密码
					// fromActivity 上层来源
					intent3.putExtra("type", "0");
					intent3.putExtra("from", "login");

					startActivity(intent3);

				} else {
					// 进入首页
					Intent intent3 = new Intent(LoginActivity.this,
							MainActivity.class);
					StaticVariable.put(StaticVariable.sv_toIndex, "1");
					startActivity(intent3);

				}

				// 发送通知
				Intent intent = new Intent();
				intent.setAction("dengluhoushuaxinshuju");
				sendBroadcast(intent);

				Toast.makeText(LoginActivity.this, "登录成功", 1000).show();

				anim_right_out();

				finish();

				break;
			case 2:
				Toast.makeText(LoginActivity.this,
						msg.getData().getString("msg"), 1000).show();

				break;
			default:
				break;
			}
		}
	};

	private void loadHttp() {

		jindu.show();

		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁

		map.put("userName", et_name.getText().toString());
		map.put("password", et_pass.getText().toString());

		// 请求的参数如下
		RequestThreadAbstract thread = RequestFactory.createRequestThread(1,
				map, LoginActivity.this, mHandler);
		RequestPool.execute(thread);

	}

	// 把所有的网络请求放到最下面
	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub

		if (list.size() == 1) {
			allUser = (UserMode) list.get(0);
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
