package com.quqian.activity.mine.xin;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.quqian.activity.index.IndexActivity;
import com.quqian.activity.index.LiCaiInfoActivity;
import com.quqian.activity.index.LiJiShenQingActivity;
import com.quqian.activity.mine.ChongZhiActivity;
import com.quqian.activity.mine.KjChongZhiActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.TiYanProject;
import com.quqian.been.UserMode;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.MyWebViewActivity;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.Tool;

public class NewChongQianYuKuaiJie extends BaseActivity implements
		OnClickListener, HttpResponseInterface {

	// 普通提现界面 组件
	private TextView qk_keyongyue = null;
	private EditText qk_chongzhijine = null;
	private TextView qk_yinhangkaweihao = null;
	private Button qk_btn = null;

	// 温馨提示，
	private TextView tv1 = null;
	private TextView tv2 = null;
	private TextView tvbtn = null;
	private TextView tv3 = null;
	private TextView tv4 = null;

	// 传递过来的表示，用来判断是签约充值还是快捷充值，
	private String chongzhifangshi = "1";
	private String ptkyye = "";
	private String yhkh = "";
	
	private String mchnt_cd = null;
	private String mchnt_txn_ssn = null;
	private String amt = null;
	private String login_id = null;
	private String page_notify_url = null;
	private String back_notify_url = null;
	private String signatureStr = null;
	private String fyUrl = null;

	// 网络加载中
	ProcessDialogUtil juhua = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.mine_new_chongzhi_qianyue_kuaijie;
	}

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
		if (getIntent().getStringExtra("chongzhifangshi") != null) {
			chongzhifangshi = getIntent().getStringExtra("chongzhifangshi");
			ptkyye = getIntent().getStringExtra("ptkyye");
			yhkh = getIntent().getStringExtra("yhkh");
		}

	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		if (chongzhifangshi.equals("1")) {
			setTitle("签约充值");
		} else {
			setTitle("快捷充值");
		}
		showBack();

		juhua = new ProcessDialogUtil(NewChongQianYuKuaiJie.this);

		qk_keyongyue = (TextView) findViewById(R.id.qianyuekuaijie_keyong);
		qk_chongzhijine = (EditText) findViewById(R.id.qianyuekuaijie_chongzhi);
		qk_yinhangkaweihao = (TextView) findViewById(R.id.qianyuekuaijie_yinhangkaweihao);

		qk_btn = (Button) findViewById(R.id.qianyuekuaijie_btn);

		tv1 = (TextView) findViewById(R.id.qianyuekuaijie_tv1);
		tv2 = (TextView) findViewById(R.id.qianyuekuaijie_tv2);
		tvbtn = (TextView) findViewById(R.id.qianyuekuaijie_tvbtn);
		tv3 = (TextView) findViewById(R.id.qianyuekuaijie_tv3);
		tv4 = (TextView) findViewById(R.id.qianyuekuaijie_tv4);

		// 刚进入页面，判断充值方式，来隐藏显示银行卡尾号，和温馨提示语句
		if (chongzhifangshi.equals("1")) {
			// qk_keyongyue.setText(ptkyye+"元");
			// 显示银行卡号
			qk_yinhangkaweihao.setVisibility(View.VISIBLE);
			qk_yinhangkaweihao.setText("银行卡尾号:" + yhkh);
			tv1.setVisibility(View.VISIBLE);
			tv1.setText("1.签约充值无需输入卡号及验证码。");
			tv2.setText("2.请注意您的银行卡充值限制，以免造成不便，具体银行卡限额");
			tvbtn.setText("《签约充值限额表》");
			tv3.setText("3.禁止洗钱、虚假交易等行为，一经发现并确认，将终止该账户的使用。");
			tv4.setText("4.如果充值金额没有及时到账，请联系客服，400-8535-666");
		} else {
			// qk_keyongyue.setText(ptkyye+"元");
			// 隐藏银行卡号
			qk_yinhangkaweihao.setVisibility(View.GONE);
			tv1.setVisibility(View.GONE);
			tv2.setText("1.请注意您的银行卡充值限制，以免造成不便，具体银行卡限额");
			tvbtn.setText("《快捷充值限额表》");
			tv3.setText("2.禁止洗钱、虚假交易等行为，一经发现并确认，将终止该账户的使用。");
			tv4.setText("3.如果充值金额没有及时到账，请联系客服，400-8535-666");
		}

		UserMode user = Tool.getUser(NewChongQianYuKuaiJie.this);
		qk_keyongyue.setText(user.getKyye() + "元");
		// 调用接口

	}

	private void http() {
 
		String JIN = qk_chongzhijine.getText().toString();
		if (JIN.length() == 0) {
			Toast.makeText(NewChongQianYuKuaiJie.this, "请输入充值金额", 1000).show();
			return;
		}
		double JINdd = Double.valueOf(JIN);
		if(JINdd>=100 && JINdd < 1000000){
		} else{
			Toast.makeText(NewChongQianYuKuaiJie.this, "充值金额必须大于100小于1000000", 1000).show();
			return;
		}
		
		juhua.show();
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("amount", JIN);
		map.put("type", "PTCZ");// 普通存管
		if (chongzhifangshi.equals("1")) {
			map.put("pttype", "FY-KS");// 签约充值
		} else {
			map.put("pttype", "FY-KJ");// 快捷充值
		}
		RequestThreadAbstract thread = RequestFactory.createRequestThread(104,
				map, NewChongQianYuKuaiJie.this, mHandler);
		RequestPool.execute(thread);
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
		// 立即充值
		qk_btn.setOnClickListener(this);
		tvbtn.setOnClickListener(this);
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub

		switch (arg0.getId()) {
		case R.id.title_bar_back:
			NewChongQianYuKuaiJie.this.finish();
			anim_right_out();
			break;
		case R.id.qianyuekuaijie_btn:
			// 立即充值
			http();
			break;
		case R.id.qianyuekuaijie_tvbtn:
			// 跳转不同限额表
			if (chongzhifangshi.equals("1")) {
				// 跳转到签约充值限额表
				Intent intent = new Intent(NewChongQianYuKuaiJie.this,
						MyWebViewActivity.class);
				intent.putExtra("title", "签约充值限额表");
				intent.putExtra("url", "");
				startActivity(intent);
				anim_right_in();
			} else {
				// 跳转到快捷充值限额表
				Intent intent = new Intent(NewChongQianYuKuaiJie.this,
						MyWebViewActivity.class);
				intent.putExtra("title", "快捷充值限额表");
				intent.putExtra("url", "");
				startActivity(intent);
				anim_right_in();
			}
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
			case 1:
				 
				Intent intent  = new Intent();
				intent.putExtra("mchnt_cd", mchnt_cd);
				intent.putExtra("mchnt_txn_ssn", mchnt_txn_ssn);
				intent.putExtra("amt", amt);
				intent.putExtra("login_id", login_id);
				intent.putExtra("page_notify_url", page_notify_url);
				intent.putExtra("back_notify_url", back_notify_url);
				intent.putExtra("signatureStr", signatureStr);
				intent.putExtra("fyUrl", fyUrl);
				intent.putExtra("title", "富有充值");
				//tartActivity(intent);
				intent.setClass(NewChongQianYuKuaiJie.this,KjChongZhiActivity.class);
			    startActivity(intent);
			    
				break;
			case 2:
				// 停止菊花
				Toast.makeText(NewChongQianYuKuaiJie.this,
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
		// 个人资料信息
		if (map.get("urlTag").equals("1")) {
			JSONObject json = (JSONObject) jsonObj;

			try {
				JSONObject sdkParameter = json.getJSONObject("rvalue");
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
			
			Message msg2 = new Message();
			msg2.what = 1;
			Bundle bundle = new Bundle();
			msg2.setData(bundle);
			mHandler.sendMessage(msg2);
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
