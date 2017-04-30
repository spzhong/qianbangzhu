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
import android.text.Editable;
import android.text.InputFilter;
import android.text.InputType;
import android.text.Spanned;
import android.text.TextWatcher;
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
import com.quqian.activity.index.LiJiShenQingActivity;
import com.quqian.activity.invert.LiJiTouBiaoActivity;
import com.quqian.activity.mine.KjChongZhiActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.TiYanProject;
import com.quqian.been.UserMode;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.Tool;

public class NewTiXian extends BaseActivity implements OnClickListener,
		HttpResponseInterface {

	// radioGroup
	private RadioGroup rg = null;
	private RadioButton rb1 = null;
	private RadioButton rb2 = null;
	// 单选按钮下面的选中条
	private TextView tvrb1 = null;
	private TextView tvrb2 = null;

	// 尚未开通布局
	private LinearLayout layout_weikaitong = null;
	// 尚未开通 文本组件，按钮组件
	private TextView tv_weikaitong = null;
	private Button btn_weikaitong = null;

	// 存管提现界面，普通提现界面，用来切换隐藏整个布局
	private LinearLayout layout_cg = null;
	private LinearLayout layout_pu = null;

	// 存管提现界面 组件
	private TextView cg_tv_keyong = null;
	private TextView cg_tv_zhanghu = null;
	private EditText cg_et_chongzhi = null;
	private Button cg_btn = null;

	// 普通提现界面 组件
	private TextView tx_keyongyue = null;
	private EditText tx_tixianjine = null;
	private TextView tx_yinhangkaweihao = null;
	private TextView tx_tixianfeiyong = null;
	private TextView tx_shijikouchujine = null;
	private Button pu_btn = null;

	// 判断是否开通存管提现，
	private String cgzt = "";
	private String cgkyye = "";
	private String cgzh = "";

	// 判断是否开通普通提现，
	private String ptzt = "";
	private String ptkyye = "";
	private String yhkh = "";
	private String txfy = "";

	// 当前选中的radio button
	private String myrb = "1";

	private String zhlx = "";
	
	// 网络加载中
	ProcessDialogUtil juhua = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.mine_new_tixian;
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
		setTitle("提现");
		showBack();
		setMenu("提现记录");
		showMenu();

		juhua = new ProcessDialogUtil(NewTiXian.this);

		rg = (RadioGroup) findViewById(R.id.tx_rg);
		rb1 = (RadioButton) findViewById(R.id.tx_rb1);
		rb2 = (RadioButton) findViewById(R.id.tx_rb2);
		// 单选按钮下面的选中条
		tvrb1 = (TextView) findViewById(R.id.tx_tvrb1);
		tvrb2 = (TextView) findViewById(R.id.tx_tvrb2);

		// 尚未开通布局 及组件
		layout_weikaitong = (LinearLayout) findViewById(R.id.tx_layout_weikaitong);
		tv_weikaitong = (TextView) findViewById(R.id.tx_layout_weikaitongtip);
		btn_weikaitong = (Button) findViewById(R.id.tx_layout_weikaitongbtn);

		// 存管充值布局 及组件
		layout_cg = (LinearLayout) findViewById(R.id.tx_layout_cg);
		cg_tv_keyong = (TextView) findViewById(R.id.tx_layout_cg_keyong);
		cg_tv_zhanghu = (TextView) findViewById(R.id.tx_layout_cg_zhanghu);
		cg_et_chongzhi = (EditText) findViewById(R.id.tx_layout_cg_chongzhi);
		cg_btn = (Button) findViewById(R.id.tx_layout_cg_btn);

		// 普通充值布局 及组件
		layout_pu = (LinearLayout) findViewById(R.id.tx_layout_pu);
		tx_keyongyue = (TextView) findViewById(R.id.tx_keyongyue);
		tx_tixianjine = (EditText) findViewById(R.id.tx_tixianjiner);
		tx_yinhangkaweihao = (TextView) findViewById(R.id.tx_yinhangkaweihao);
		tx_tixianfeiyong = (TextView) findViewById(R.id.tx_tixianfeiyong);
		tx_shijikouchujine = (TextView) findViewById(R.id.tx_shijikouchujine);

		pu_btn = (Button) findViewById(R.id.tx_layout_pu_btn);

		// 调用接口
		loadHttp();
		// 存管提现
		cg_et_chongzhi.addTextChangedListener(new TextWatcher() {

			@Override
			public void onTextChanged(CharSequence s, int arg1, int arg2,
					int arg3) {
				// TODO Auto-generated method stub
				if (s.toString().contains(".")) {
					if (s.length() - 1 - s.toString().indexOf(".") > 2) {
						s = s.toString().subSequence(0,
								s.toString().indexOf(".") + 3);
						cg_et_chongzhi.setText(s);
						cg_et_chongzhi.setSelection(s.length());
					}
				}
				if (s.toString().trim().substring(0).equals(".")) {
					s = "0" + s;
					cg_et_chongzhi.setText(s);
					cg_et_chongzhi.setSelection(2);
				}
				if (s.toString().startsWith("0")
						&& s.toString().trim().length() > 1) {
					if (!s.toString().substring(1, 2).equals(".")) {
						cg_et_chongzhi.setText(s.subSequence(0, 1));
						cg_et_chongzhi.setSelection(1);
						return;
					}
				}
			}

			@Override
			public void beforeTextChanged(CharSequence arg0, int arg1,
					int arg2, int arg3) {
				// TODO Auto-generated method stub

			}

			@Override
			public void afterTextChanged(Editable arg0) {
				// TODO Auto-generated method stub

			}
		});

		// 普通提现金额
		tx_tixianjine.addTextChangedListener(new TextWatcher() {
			@Override
			public void onTextChanged(CharSequence s, int arg1, int arg2,
					int arg3) {
				// TODO Auto-generated method stub
				if (s.toString().contains(".")) {
					if (s.length() - 1 - s.toString().indexOf(".") > 2) {
						s = s.toString().subSequence(0,
								s.toString().indexOf(".") + 3);
						tx_tixianjine.setText(s);
						tx_tixianjine.setSelection(s.length());
					}
				}
				if (s.toString().trim().substring(0).equals(".")) {
					s = "0" + s;
					tx_tixianjine.setText(s);
					tx_tixianjine.setSelection(2);
				}
				if (s.toString().startsWith("0")
						&& s.toString().trim().length() > 1) {
					if (!s.toString().substring(1, 2).equals(".")) {
						tx_tixianjine.setText(s.subSequence(0, 1));
						tx_tixianjine.setSelection(1);
						return;
					}
				}
			}

			@Override
			public void beforeTextChanged(CharSequence arg0, int arg1,
					int arg2, int arg3) {
				// TODO Auto-generated method stub

			}

			@Override
			public void afterTextChanged(Editable edit) {
				// TODO Auto-generated method stub
				// 扣除金额=提现费用+提现金额
				if ("".equals(txfy)) {
					txfy = "0.00";
				}
				String medit = tx_tixianjine.getText().toString();
				if ("".equals(medit)) {
					medit = "0.00";
				}
				double f = Double.valueOf(txfy);
				double t = Double.valueOf(medit);
				if (t == 0) {
					tx_shijikouchujine.setText("0.0");
				} else {
					double k = f + t;
					tx_shijikouchujine.setText(k+"");
				}
			}
		});
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
		titleBarMenu.setOnClickListener(this);
		rb1.setOnClickListener(this);
		rb2.setOnClickListener(this);
		// 尚未开通
		btn_weikaitong.setOnClickListener(this);
		// 存管提现
		cg_btn.setOnClickListener(this);
		// 普通提现
		pu_btn.setOnClickListener(this);
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub

		switch (arg0.getId()) {
		case R.id.title_bar_back:
			NewTiXian.this.finish();
			anim_right_out();
			break;
		case R.id.title_bar_menu:
			// 跳转到提现记录
			Intent intentjl = new Intent();
			intentjl.setClass(NewTiXian.this, TiXianJILu.class);
			startActivity(intentjl);
			break;
		case R.id.tx_rb1:
			// 存管提现选项 点击该按钮，选中状态条
			tvrb1.setBackgroundColor(getResources().getColor(
					R.color.main_radio_blue));
			tvrb2.setBackgroundColor(getResources().getColor(R.color.white));

			// 将当前的选中按钮设置为1，
			myrb = "1";

			if (cgzt.equals("S")) {
				// 如果开通，则隐藏'未开通'布局，显示存管提现界面
				layout_weikaitong.setVisibility(View.GONE);
				layout_cg.setVisibility(View.VISIBLE);
				layout_pu.setVisibility(View.GONE);

				// 设置开通存管账户数据 ,可用余额，华兴E账户
				cg_tv_keyong.setText(cgkyye + "元");
				cg_tv_zhanghu.setText(cgzh);

			} else {
				// 如果未开通，则隐藏存管充值界面，显示'未开通'布局
				layout_weikaitong.setVisibility(View.VISIBLE);
				layout_cg.setVisibility(View.GONE);
				layout_pu.setVisibility(View.GONE);
				tv_weikaitong.setText("您尚未开通存管账户，现在去开通？");
				btn_weikaitong.setText("前往开通");
			}

			break;
		case R.id.tx_rb2:
			// 普通充值选项
			// 存管充值选项 点击该按钮，选中状态条
			tvrb1.setBackgroundColor(getResources().getColor(R.color.white));
			tvrb2.setBackgroundColor(getResources().getColor(
					R.color.main_radio_blue));

			// 将当前的选中按钮设置为1，
			myrb = "2";

			if (ptzt.equals("S")) {
				// 如果开通，则隐藏'未开通'布局，显示普通提现界面
				layout_weikaitong.setVisibility(View.GONE);
				layout_cg.setVisibility(View.GONE);
				layout_pu.setVisibility(View.VISIBLE);

				// 设置开通存管账户数据 ,可用余额，华兴E账户
				tx_keyongyue.setText(ptkyye + "元");
				tx_yinhangkaweihao.setText("银行卡尾号：" + yhkh);
				tx_tixianfeiyong.setText("提现费用：" + txfy + "元/笔");

			} else {
				// 如果未开通，则隐藏存管充值界面，显示'未开通'布局
				layout_weikaitong.setVisibility(View.VISIBLE);
				layout_cg.setVisibility(View.GONE);
				layout_pu.setVisibility(View.GONE);
				tv_weikaitong.setText("您尚未完成普通账户绑卡，现在去绑定？");
				btn_weikaitong.setText("立即绑定");
			}

			break;
		case R.id.tx_layout_weikaitongbtn:
			// 尚未开通按钮
			if (myrb == "1") {
				// 前往开通 存管账户
				Intent intent = new Intent(NewTiXian.this,
						KaiTongCunGuanActivity.class);
				startActivity(intent);
				anim_right_in();
			} else {
 
				// 前去绑定 普通账户 个人：GRKH 企业：QYKH
				if (zhlx.equals("GRKH")) {
					// 跳转到个人
					startActivity(new Intent(NewTiXian.this,BangDingYinHangKaActivity.class));
				} else {
					// 跳转到企业
					startActivity(new Intent(NewTiXian.this,
							QiYeBangDingYinHangKaActivity.class));
				}
			}

			break;
		case R.id.tx_layout_cg_btn:

			// 存管提现按钮
			if (Double.parseDouble(cg_et_chongzhi.getText().toString()) <= 100) {
				Toast.makeText(NewTiXian.this, "提现金额不能少于100元", 1000).show();
			} else {
				loadHttp_cg_tixian();
			}

			break;

		case R.id.tx_layout_pu_btn:
			// 普通提现 【暂时注释掉】
			// if (Double.parseDouble(tx_shijikouchujine.getText().toString())
			// <= 100) {
			// Toast.makeText(NewTiXian.this, "提现金额不能少于100元", 1000).show();
			// } else {
			// loadHttp_pt_tixian();
			// }

			loadHttp_pt_tixian();

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
				Toast.makeText(NewTiXian.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:

				if (cgzt.equals("S")) {
					// 如果开通，则隐藏'未开通'布局，显示存管充值界面
					layout_weikaitong.setVisibility(View.GONE);
					layout_cg.setVisibility(View.VISIBLE);
					layout_pu.setVisibility(View.GONE);

					// 设置开通存管账户数据 ,可用余额，华兴E账户
					cg_tv_keyong.setText(cgkyye + "元");
					cg_tv_zhanghu.setText(cgzh);

				} else {
					// 如果未开通，则隐藏存管充值界面，显示'未开通'布局
					layout_weikaitong.setVisibility(View.VISIBLE);
					layout_cg.setVisibility(View.GONE);
					layout_pu.setVisibility(View.GONE);
					tv_weikaitong.setText("您尚未开通存管账户，现在去开通？");
					btn_weikaitong.setText("前往开通");
				}
				break;
			case 2:
				Toast.makeText(NewTiXian.this, msg.getData().getString("msg"),
						1000).show();

				break;
			case 3: // 存管充值【跳转到存管的页面】
				Bundle bundle = msg.getData();
				String sendUrl = (String) bundle.get("sendUrl");
				String sendStr = (String) bundle.get("sendStr");
				String transCode = (String) bundle.get("transCode");
				if (sendUrl == null) {
					Toast.makeText(NewTiXian.this, "操作失败", 1000).show();
					return;
				}
				Intent intent2 = new Intent(NewTiXian.this, CGWebView.class);
				intent2.putExtra("sendUrl", sendUrl);
				intent2.putExtra("sendStr", sendStr);
				intent2.putExtra("transCode", transCode);
				intent2.putExtra("title", "提现");
				startActivity(intent2);
				anim_right_in();
				break;
			case 4:// 普通提现【跳转的富有的页面】
				Bundle bundle2 = msg.getData();
				String mchnt_cd = (String) bundle2.get("mchnt_cd");
				String mchnt_txn_ssn = (String) bundle2.get("mchnt_txn_ssn");
				String amt = (String) bundle2.get("amt");
				String login_id = (String) bundle2.get("login_id");
				String page_notify_url = (String) bundle2
						.get("page_notify_url");
				String back_notify_url = (String) bundle2
						.get("back_notify_url");
				String signatureStr = (String) bundle2.get("signatureStr");
				String fyUrl = (String) bundle2.get("fyUrl");
				// 跳转的提现的页面
				Intent intent = new Intent();
				intent.putExtra("mchnt_cd", mchnt_cd);
				intent.putExtra("mchnt_txn_ssn", mchnt_txn_ssn);
				intent.putExtra("amt", amt);
				intent.putExtra("login_id", login_id);
				intent.putExtra("page_notify_url", page_notify_url);
				intent.putExtra("back_notify_url", back_notify_url);
				intent.putExtra("signatureStr", signatureStr);
				intent.putExtra("fyUrl", fyUrl);
				intent.putExtra("title", "提现");
				intent.setClass(NewTiXian.this, KjChongZhiActivity.class);
				startActivity(intent);

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
		RequestThreadAbstract thread = RequestFactory.createRequestThread(40,
				map, NewTiXian.this, mHandler);
		RequestPool.execute(thread);

	}

	private void loadHttp_cg_tixian() {

		juhua.show();

		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "3");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("amount", tx_shijikouchujine.getText().toString());
		//map.put("amount", "129");
		map.put("type", "CGTX");
		// 请求的参数如下
		RequestThreadAbstract thread = RequestFactory.createRequestThread(105,
				map, NewTiXian.this, mHandler);
		RequestPool.execute(thread);

	}

	private void loadHttp_pt_tixian() {

		juhua.show();

		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "4");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("amount", "120");
		map.put("type", "PTTX");
		// 请求的参数如下
		RequestThreadAbstract thread = RequestFactory.createRequestThread(105,
				map, NewTiXian.this, mHandler);
		RequestPool.execute(thread);

	}

	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub
		if (map.get("urlTag").equals("1")) {
			JSONObject json = (JSONObject) jsonObj;
			try {
				JSONObject cg = json.getJSONObject("rvalue")
						.getJSONObject("cg");
				cgzh = cg.getString("cgzh");
				cgzt = cg.getString("cgzt");
				cgkyye = cg.getString("cgkyye");
				JSONObject pt = json.getJSONObject("rvalue")
						.getJSONObject("pt");
				ptzt = pt.getString("ptzt");
				ptkyye = pt.getString("ptkyye");
				yhkh = pt.getString("yhkh");
				txfy = pt.getString("txfy");
				zhlx = pt.getString("zhlx");
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			Message msg1 = new Message();
			msg1.what = 1;
			mHandler.sendMessage(msg1);
		} else if (map.get("urlTag").equals("3")) {

			JSONObject json = (JSONObject) jsonObj;
			Message msg1 = new Message();
			msg1.what = 3;
			Bundle bundle = new Bundle();
			try {
				JSONArray jsonArray = json.getJSONArray("rvalue");
				json = (JSONObject) jsonArray.get(0);
				bundle.putString("transCode", json.getJSONObject("asydata")
						.getString("transCode"));
				bundle.putString("sendUrl", json.getJSONObject("asydata")
						.getString("sendUrl"));
				bundle.putString("sendStr", json.getJSONObject("asydata")
						.getString("sendStr"));
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			msg1.setData(bundle);
			mHandler.sendMessage(msg1);

		} else if (map.get("urlTag").endsWith("4")) {

			JSONObject json = (JSONObject) jsonObj;

			Message msg1 = new Message();
			msg1.what = 4;
			Bundle bundle = new Bundle();
			try {

				bundle.putString("mchnt_cd", json.getJSONObject("rvalue")
						.getString("mchnt_cd"));
				bundle.putString("mchnt_txn_ssn", json.getJSONObject("rvalue")
						.getString("mchnt_txn_ssn"));
				bundle.putString("login_id", json.getJSONObject("rvalue")
						.getString("login_id"));
				bundle.putString("amt",
						json.getJSONObject("rvalue").getString("amt"));
				bundle.putString("page_notify_url", json
						.getJSONObject("rvalue").getString("page_notify_url"));
				bundle.putString("back_notify_url", json
						.getJSONObject("rvalue").getString("back_notify_url"));
				bundle.putString("signatureStr", json.getJSONObject("rvalue")
						.getString("signature"));
				bundle.putString("fyUrl", json.getJSONObject("rvalue")
						.getString("fyUrl"));
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			msg1.setData(bundle);
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
