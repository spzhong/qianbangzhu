package com.quqian.activity.mine;

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
import com.quqian.base.BaseActivity;
import com.quqian.been.Chongzhi;
import com.quqian.been.UserMode;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.Tool;

public class QueRenTiXianActivity extends BaseActivity implements
		OnClickListener, HttpResponseInterface {

	// 绑定银行卡
	private TextView bangding = null;
	// 提现金额
	private TextView tixianjiner = null;
	// 提现手续费
	private TextView tixianshouxufei = null;
	// 实际扣除金额
	private TextView shijikouchu = null;
	// 确认提现
	private Button next = null;

	private Chongzhi chongzhiModel = null;

	private ProcessDialogUtil juhua = null;
	
	private String mchnt_cd = null;
	private String mchnt_txn_ssn = null;
	private String amt = null;
	private String login_id = null;
	private String page_notify_url = null;
	private String back_notify_url = null;
	private String signatureStr = null;
	private String fyUrl = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_mine_qurentixian;
	}

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
		Intent intent = getIntent();
		chongzhiModel = (Chongzhi) intent.getSerializableExtra("chongzhiModel");

	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("确认提现");
		showBack();

		juhua = new ProcessDialogUtil(QueRenTiXianActivity.this);

		bangding = (TextView) findViewById(R.id.main_mine_querentixian_bangding);
		tixianjiner = (TextView) findViewById(R.id.main_mine_querentixian_jiner);
		tixianshouxufei = (TextView) findViewById(R.id.main_mine_querentixian_shouxufei);
		shijikouchu = (TextView) findViewById(R.id.main_mine_querentixian_kouchu);

		next = (Button) findViewById(R.id.main_mine_querentixian_next);

		bangding.setText(chongzhiModel.getBankName() + " "
				+ chongzhiModel.getBankNumber());
		tixianjiner.setText(chongzhiModel.getMoney());
		tixianshouxufei.setText(chongzhiModel.getShouxufei());
		shijikouchu.setText(chongzhiModel.getShjikouchu());
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
			QueRenTiXianActivity.this.finish();
			anim_right_out();
			break;
		case R.id.main_mine_querentixian_next:

			loadHttp_oktikuancode();

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

				Toast.makeText(QueRenTiXianActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:
				// 停止菊花

				Intent intent  = new Intent();
				intent.putExtra("mchnt_cd", mchnt_cd);
				intent.putExtra("mchnt_txn_ssn", mchnt_txn_ssn);
				intent.putExtra("amt", amt);
				intent.putExtra("login_id", login_id);
				intent.putExtra("page_notify_url", page_notify_url);
				intent.putExtra("back_notify_url", back_notify_url);
				intent.putExtra("signatureStr", signatureStr);
				intent.putExtra("fyUrl", fyUrl);
				intent.setClass(QueRenTiXianActivity.this,AppWithdrawActivity.class);
			    startActivity(intent);
				 
				break;
			case 2:
				Toast.makeText(QueRenTiXianActivity.this,
						msg.getData().getString("msg"), 1000).show();
				break;

			default:
				break;
			}
		}
	};

	// 判断提款密码的信息
	private void loadHttp_oktikuancode() {
		// TODO Auto-generated method stub

		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "2");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁

		map.put("amount", chongzhiModel.getMoney());
		map.put("password", chongzhiModel.getPassword());
		map.put("bankCardId", chongzhiModel.getBankCardId());

		RequestThreadAbstract thread = RequestFactory.createRequestThread(42,
				map, QueRenTiXianActivity.this, mHandler);
		RequestPool.execute(thread);
	}

	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub

		JSONObject json = (JSONObject) jsonObj;

		try {
			JSONObject sdkParameter = json.getJSONObject("rvalue").getJSONObject("sdkParameter");
			mchnt_cd = sdkParameter.getString("mchnt_cd");
			mchnt_txn_ssn = sdkParameter.getString("mchnt_txn_ssn");
			amt = sdkParameter.getString("amt");
			login_id = sdkParameter.getString("login_id");
			page_notify_url = sdkParameter.getString("page_notify_url");
			back_notify_url = sdkParameter.getString("back_notify_url");
			signatureStr = sdkParameter.getString("signatureStr");
			fyUrl = sdkParameter.getString("fyUrl");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// 设置账户余额
		/*UserMode user = Tool.getUser(QueRenTiXianActivity.this);
		user.setKyye(amount);
		user.saveUserToDB(QueRenTiXianActivity.this);*/
		// 保存数据

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
