package com.quqian.activity.index;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

import android.R.integer;
import android.app.AlertDialog;
import android.app.Dialog;
import android.app.ActionBar.LayoutParams;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.Display;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.index.IndexActivity;
import com.quqian.activity.mine.ZiJinGuanLiActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.UserMode;
import com.quqian.been.ZhaiQuanProject;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.Tool;
import com.yintong.secure.c.k;

public class LiJiGouMaiActivity extends BaseActivity implements
		OnClickListener, HttpResponseInterface {

	private TextView shengyu = null;
	private TextView keyong = null;
	private TextView goumai = null;
	private TextView jian = null;
	private EditText shuru = null;
	private TextView jia = null;
	private TextView yujishouyi = null;

	private Button button = null;

	private int fenshu = 1;

	// pid
	private String pId = "";

	private String shengyuStr = "0";
	private String goumaiStr = "0";
	private String daishouStr = "";
	private String zhuanrangStr = "";

	private String keyongjiner = "";

	private Dialog juhua = null;

	ZhaiQuanProject allZhai = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_index_lijigoumai;
	}

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
		if (getIntent().getStringExtra("pId") != null) {
			pId = getIntent().getStringExtra("pId");

		}
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("立即购买");
		showBack();

		juhua = new ProcessDialogUtil(LiJiGouMaiActivity.this);

		shengyu = (TextView) findViewById(R.id.main_index_lijigoumai_shengyu);
		keyong = (TextView) findViewById(R.id.main_index_lijigoumai_keyong);
		goumai = (TextView) findViewById(R.id.main_index_lijigoumai_goumai);

		jian = (TextView) findViewById(R.id.main_index_lijigoumai_jian);
		shuru = (EditText) findViewById(R.id.main_index_lijigoumai_shuru);
		jia = (TextView) findViewById(R.id.main_index_lijigoumai_jia);
		yujishouyi = (TextView) findViewById(R.id.main_index_lijigoumai_yujishouyi);

		button = (Button) findViewById(R.id.main_index_lijigoumai_lijigoumai);

		// 填充数据
		// shengyu.setText(shengyuStr);
		UserMode user = Tool.getUser(LiJiGouMaiActivity.this);
		keyongjiner = user.getKyye();
		keyong.setText(keyongjiner);
		// goumai.setText(goumaiStr);
		// suanfa();

		loadHttp_info();

		shuru.addTextChangedListener(new TextWatcher() {
			@Override
			public void onTextChanged(CharSequence s, int start, int before,
					int count) {

			}

			@Override
			public void beforeTextChanged(CharSequence s, int start, int count,
					int after) {
			}

			@Override
			public void afterTextChanged(Editable s) {
				String newString = shuru.getText().toString();

				if (newString.length() == 0) {
					yujishouyi.setText("预计收益" + "0.00" + "元+奖" + "0.00" + "元");
					fenshu = 1;
					shuru.setText("1");
					return;
				}
				fenshu = Integer.valueOf(newString.trim());
				suanfa();

			}
		});
	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);

		jian.setOnClickListener(this);
		jia.setOnClickListener(this);
		button.setOnClickListener(this);

	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_back:
			LiJiGouMaiActivity.this.finish();
			anim_right_out();
			break;
		case R.id.main_index_lijigoumai_jian:
			jian();
			break;
		case R.id.main_index_lijigoumai_jia:
			jia();
			break;
		case R.id.main_index_lijigoumai_lijigoumai:

			lijigoumaidialog();

			// // 判断余额
			// double keyong1 = Double.valueOf(Tool.getUser(
			// LiJiGouMaiActivity.this).getKyye());
			// if (Double.valueOf(goumai.getText().toString()) < (fenshu *
			// Double.valueOf(allZhai.getZqjg())) && (fenshu *
			// Double.valueOf(allZhai.getZqjg())) > keyong1) {
			// Toast.makeText(LiJiGouMaiActivity.this, "您的账户余额不足，请充值",
			// Toast.LENGTH_SHORT).show();
			// // 进入账户管理的页面
			// startActivity(new Intent(LiJiGouMaiActivity.this,
			// ZiJinGuanLiActivity.class));
			// anim_right_in();
			// return;
			// }
			//
			//
			//
			// if (fenshu >= 1
			// && fenshu <= Integer.valueOf(shengyu.getText().toString())
			// && !"".equals(shuru.getText())) {
			// //
			// // // 判断余额
			// // double keyong = Double.valueOf(Tool.getUser(
			// // LiJiGouMaiActivity.this).getKyye());
			// // if (keyong < fenshu * 100) {
			// // Toast.makeText(LiJiGouMaiActivity.this, "您的账户余额不足，请充值",
			// // Toast.LENGTH_SHORT).show();
			// // // 进入账户管理的页面
			// // startActivity(new Intent(LiJiGouMaiActivity.this,
			// // ZiJinGuanLiActivity.class));
			// // anim_right_in();
			// // return;
			// // }
			//
			// lijigoumaidialog();
			// } else {
			// Toast.makeText(LiJiGouMaiActivity.this, "你的购买份数大于剩余份数",
			// Toast.LENGTH_SHORT).show();
			// }
			break;

		default:
			break;
		}
	}

	// 减
	private void jian() {
		if (fenshu - 10 < 0) {
			fenshu = 1;
			shuru.setText(fenshu + "");
		} else {
			fenshu = fenshu - 10;
			shuru.setText(fenshu + "");
		}
		suanfa();
	}

	// 加
	private void jia() {
//		if (fenshu + 10 > Double.valueOf(shengyu.getText().toString())) {
//			Toast.makeText(LiJiGouMaiActivity.this,
//					"最多" + shengyu.getText().toString() + "份", 1000).show();
//		} else {
//			fenshu = fenshu + 10;
//			shuru.setText(fenshu + "");
//		}
		
		fenshu = fenshu + 10;
		shuru.setText(fenshu + "");
		suanfa();
	}

	private void suanfa() {
		double aa = Double.valueOf(allZhai.getDsbx()) - 100;
		double value = 0.0;
		if (!"".equals(shuru.getText().toString())) {
			value = aa * Double.valueOf(shuru.getText().toString());
			BigDecimal b = new BigDecimal(value);
			value = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
		}
		yujishouyi.setText("预计收益" + value + "元");
	}

	// 立即投标对话框
	private Dialog dialog = null;

	private void lijigoumaidialog() {

		View view = LayoutInflater.from(LiJiGouMaiActivity.this).inflate(
				R.layout.dialog_goumai, null);

		TextView fenshu = (TextView) view
				.findViewById(R.id.dialog_goumai_content);
		TextView xieyi = (TextView) view.findViewById(R.id.goumai_xieyi);
		xieyi.setText("《债权转让及受让协议》");

		fenshu.setText(shuru.getText().toString());

		Button quxiao = (Button) view.findViewById(R.id.dialog_goumai_cancel);
		Button queding = (Button) view.findViewById(R.id.dialog_goumai_submit);
		final CheckBox cb = (CheckBox) view.findViewById(R.id.goumai_cb);

		quxiao.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View arg0) {
				// TODO Auto-generated method stub
				dialog.dismiss();
			}
		});

		queding.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View arg0) {
				// TODO Auto-generated method stub
				if (cb.isChecked()) {

					loadHttp();

				} else {
					Toast.makeText(LiJiGouMaiActivity.this, "请同意《债权转让及受让协议》",
							1000).show();
				}
				dialog.dismiss();
			}
		});

		dialog = new AlertDialog.Builder(LiJiGouMaiActivity.this).setView(view)
				.create();
		dialog.show();
	}

	private void loadHttp_info() {

		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "3");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("id", pId);// 0不锁，1是锁

		RequestThreadAbstract thread = RequestFactory.createRequestThread(17,
				map, LiJiGouMaiActivity.this, mHandler);
		RequestPool.execute(thread);

	}

	// 提交网络请求
	private void loadHttp() {

		juhua.show();

		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁

		// 必要传的参数
		map.put("id", pId);// 标的id
		map.put("fs", shuru.getText().toString());// 份数
		// 必要传的参数

		RequestThreadAbstract thread = RequestFactory.createRequestThread(18,
				map, LiJiGouMaiActivity.this, mHandler);
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

				Toast.makeText(LiJiGouMaiActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:

				Toast.makeText(LiJiGouMaiActivity.this, "购买成功", 1000).show();

				Intent intent = new Intent();
				intent.setAction("zhaiquan_reloadata");
				sendBroadcast(intent);

				// 停止菊花 --- 要将本地的可用余额的值改变一下。
				finish();
				anim_down_out();
				break;

			case 3:

				// 剩余分数
				shengyu.setText(allZhai.getSyfs());
				goumai.setText(Double.valueOf(allZhai.getSyfs())
						* Double.valueOf(allZhai.getZqjg()) + "");
				
				UserMode user = Tool.getUser(LiJiGouMaiActivity.this);
				keyong.setText(user.getKyye()); 
                 
                 
				suanfa();

				break;

			case 2:

				if ("你的账户余额不足进行本次购买 ，请充值"
						.equals(msg.getData().getString("msg"))) {
					// 进入账户管理的页面
					startActivity(new Intent(LiJiGouMaiActivity.this,
							ZiJinGuanLiActivity.class));
					anim_right_in();
				}

				Toast.makeText(LiJiGouMaiActivity.this,
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

		if (map.get("urlTag").equals("1")) {
			// TODO Auto-generated method stub
			JSONObject json = (JSONObject) jsonObj;
			Message msg1 = new Message();
			msg1.what = 1;
			Bundle bundle = new Bundle();
			try {
				UserMode user = Tool.getUser(LiJiGouMaiActivity.this);
				user.setKyye(json.getJSONObject("rvalue").getString("amount"));
				user.saveUserToDB(LiJiGouMaiActivity.this);
				bundle.putString("msg", json.getString("msg"));
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			msg1.setData(bundle);
			mHandler.sendMessage(msg1);
		} else if (map.get("urlTag").equals("3")) {
			if (list.size() == 1) {
				JSONObject json = (JSONObject) jsonObj;
				UserMode user = Tool.getUser(LiJiGouMaiActivity.this);
				try {
					user.setKyye(json.getJSONObject("rvalue").getString("amount"));
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				user.saveUserToDB(LiJiGouMaiActivity.this);
				allZhai = (ZhaiQuanProject) list.get(0);
				Message msg1 = new Message();
				msg1.what = 3;
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
