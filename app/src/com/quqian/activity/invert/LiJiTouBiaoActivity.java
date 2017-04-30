package com.quqian.activity.invert;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.R.integer;
import android.app.AlertDialog;
import android.app.Dialog;
import android.app.ActionBar.LayoutParams;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.Display;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.view.WindowManager;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.index.IndexActivity;
import com.quqian.activity.index.xin.YunYingShuJu;
import com.quqian.activity.index.xin.YunYingShuJuNext;
import com.quqian.activity.mine.MineActivity;
import com.quqian.activity.mine.ZiJinGuanLiActivity;
import com.quqian.activity.mine.xin.CGWebView;
import com.quqian.activity.mine.xin.JiaoYIJiLu;
import com.quqian.base.BaseActivity;
import com.quqian.been.SanProject;
import com.quqian.been.UserMode;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.Tool;
import android.view.MotionEvent;

public class LiJiTouBiaoActivity extends BaseActivity implements
		OnClickListener, HttpResponseInterface {

	private TextView shengyu = null;
	private TextView keyong = null;
	private TextView goumai = null;
	private TextView jian = null;
	private EditText shuru = null;
	private TextView jia = null;
	private TextView yujishouyi = null;

	private TextView chongzhi = null;

	private Button button = null;

	private int fenshu = 1;

	// ID
	private String pId = "";
	// 可用金额
	private String keyongjiner = "";
	// 剩余金额
	private String shengyuStr = "0";
	// 还款期限
	private String huankuanqixianStr = "";
	// 年利率
	private String nianlilvStr = "0";
	// 奖励利率
	private String jiangliStr = "0";
	// 借款方式
	private String jiekuanStr = "";
	// 还款方式
	private String huankuanfangshiStr = "";
	// 标的类型
	private String bdtype = "";

	// 加息卡
	private TextView jiaxika = null;

	private String jxkid;// 选中的加息卡id

	private Dialog juhua = null;

	private SanProject san_toubiao = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_index_lijitoubiao;
	}

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
		Bundle bundle = getIntent().getExtras();
		if (bundle != null) {
			pId = bundle.getString("pId");
			if ("".equals(bundle.getString("shengyu"))
					|| bundle.getString("shengyu") == null) {
				shengyuStr = "0";
			} else {
				shengyuStr = bundle.getString("shengyu");
			}

			if ("".equals(bundle.getString("nianlilv"))
					|| bundle.getString("nianlilv") == null) {
				nianlilvStr = "0";
			} else {
				nianlilvStr = bundle.getString("nianlilv");
			}

			if ("".equals(bundle.getString("jiangli"))
					|| bundle.getString("jiangli") == null) {
				jiangliStr = "0";
			} else {
				jiangliStr = bundle.getString("jiangli");
			}
			bdtype = bundle.getString("bdtype");
			huankuanqixianStr = bundle.getString("huankuanqixian");
			jiekuanStr = bundle.getString("jiekuan");
			huankuanfangshiStr = bundle.getString("huankuanfangshi");

			Log.v("---立即投标的参数---", pId + "------shengyuStr-" + shengyuStr
					+ "------huankuanqixianStr-" + huankuanqixianStr
					+ "-----nianlilvStr-" + nianlilvStr + "------jiangliStr-"
					+ jiangliStr + "-----jiekuanStr-" + jiekuanStr
					+ "-------huankuanfangshiStr-" + huankuanfangshiStr);
		}

	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("立即投标");
		showBack();

		juhua = new ProcessDialogUtil(LiJiTouBiaoActivity.this);

		shengyu = (TextView) findViewById(R.id.main_index_lijitoubiao_shengyu);
		keyong = (TextView) findViewById(R.id.main_index_lijitoubiao_keyong);
		goumai = (TextView) findViewById(R.id.main_index_lijitoubiao_goumai);
		jiaxika = (TextView) findViewById(R.id.main_index_lijitoubiao_jiaxika);
		chongzhi = (TextView) findViewById(R.id.main_mine_qianbanghzu_chongzhi);

		jian = (TextView) findViewById(R.id.main_index_lijitoubiao_jian);
		shuru = (EditText) findViewById(R.id.main_index_lijitoubiao_shuru);
		jia = (TextView) findViewById(R.id.main_index_lijitoubiao_jia);
		yujishouyi = (TextView) findViewById(R.id.main_index_lijitoubiao_yujishouyi);
		yujishouyi.setVisibility(View.GONE);

		button = (Button) findViewById(R.id.main_index_lijitoubiao_lijitoubiao);

		UserMode user = Tool.getUser(LiJiTouBiaoActivity.this);
		keyongjiner = user.getKyye();

		// shengyu.setText(shengyuStr);
		// keyong.setText(keyongjiner);
		// goumai.setText(Integer.valueOf(shengyuStr) / 100 + "");
		//
		// yujishouyi.setText("预计收益" + suanfa(fenshu, 0) + "元+奖"
		// + suanfa(fenshu, 1) + "元");
		keyong.setText(keyongjiner);

		// 获取标的详情
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
				yujishouyi.setText("预计收益" + suanfa(fenshu, 0) + "元+奖"
						+ suanfa(fenshu, 1) + "元");

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
		jiaxika.setOnClickListener(this);
		chongzhi.setOnClickListener(this);
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_back:
			LiJiTouBiaoActivity.this.finish();
			anim_right_out();
			break;
		case R.id.main_index_lijitoubiao_jian:
			jian();
			yujishouyi.setText("预计收益" + suanfa(fenshu, 0) + "元+奖"
					+ suanfa(fenshu, 1) + "元");
			break;
		case R.id.main_mine_qianbanghzu_chongzhi:// 充值

			break;
		case R.id.main_index_lijitoubiao_jiaxika:// 获取加息卡的信息
			showSpinnerActivity();

			// juhua.show();
			// // TODO Auto-generated method stub
			// Map<String, String> map = new HashMap<String, String>();
			// map.put("urlTag", "102");// 可不传（区分一个activity多个请求）
			// map.put("isLock", "0");// 0不锁，1是锁
			// // 请求的参数如下
			// RequestThreadAbstract thread =
			// RequestFactory.createRequestThread(
			// 102, map, LiJiTouBiaoActivity.this, mHandler);
			// RequestPool.execute(thread);
			break;
		case R.id.main_index_lijitoubiao_jia:
			jia();
			yujishouyi.setText("预计收益" + suanfa(fenshu, 0) + "元+奖"
					+ suanfa(fenshu, 1) + "元");
			break;
		case R.id.main_index_lijitoubiao_lijitoubiao:

			lijitoubiaodialog();

			// // 判断余额
			// double keyong1 = Double.valueOf(Tool.getUser(
			// LiJiTouBiaoActivity.this).getKyye());
			//
			// String sheyu = shengyu.getText().toString();
			//
			//
			// if (Double.valueOf(shengyu.getText().toString()) > fenshu * 100
			// && fenshu * 100 > keyong1) {
			// Toast.makeText(LiJiTouBiaoActivity.this, "您的账户余额不足，请充值",
			// Toast.LENGTH_SHORT).show();
			// // 进入账户管理的页面
			// startActivity(new Intent(LiJiTouBiaoActivity.this,
			// ZiJinGuanLiActivity.class));
			// anim_right_in();
			// return;
			// }
			//
			//
			//
			// if (fenshu >= 1
			// && fenshu <= Integer.valueOf(goumai.getText().toString())
			// && !"".equals(shuru.getText())) {
			// lijitoubiaodialog();
			// } else {
			// Toast.makeText(LiJiTouBiaoActivity.this, "您投标的份数大于可购买份数",
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
		yujishouyi.setText("预计收益" + suanfa(fenshu, 0) + "元+奖"
				+ suanfa(fenshu, 1) + "元");
	}

	// 加
	private void jia() {
		//
		// if (fenshu + 10 > Double.valueOf(goumai.getText().toString())) {
		// Toast.makeText(LiJiTouBiaoActivity.this,
		// "最多" + goumai.getText().toString() + "份", 1000).show();
		// } else {
		// fenshu = fenshu + 10;
		// shuru.setText(fenshu + "");
		// }

		fenshu = fenshu + 10;
		shuru.setText(fenshu + "");

		yujishouyi.setText("预计收益" + suanfa(fenshu, 0) + "元+奖"
				+ suanfa(fenshu, 1) + "元");
	}

	// 立即投标对话框
	private Dialog dialog = null;

	private void lijitoubiaodialog() {

		View view = LayoutInflater.from(LiJiTouBiaoActivity.this).inflate(
				R.layout.dialog_goumai, null);

		TextView fenshu = (TextView) view
				.findViewById(R.id.dialog_goumai_content);
		TextView xieyi = (TextView) view.findViewById(R.id.goumai_xieyi);

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
					Toast.makeText(LiJiTouBiaoActivity.this, "请同意《借款协议》", 1000)
							.show();
				}
				dialog.dismiss();
			}
		});

		dialog = new AlertDialog.Builder(LiJiTouBiaoActivity.this)
				.setView(view).create();
		dialog.show();
	}

	private void loadHttp_info() {

		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "3");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("id", pId);// 0不锁，1是锁

		RequestThreadAbstract thread = RequestFactory.createRequestThread(9,
				map, LiJiTouBiaoActivity.this, mHandler);
		RequestPool.execute(thread);

	}

	// 提交网络请求
	private void loadHttp() {

		juhua.show();

		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		if (bdtype.endsWith("1")) {// 存管
			map.put("tbtype", "CGTZ");
		} else {// 普通
			map.put("tbtype", "PTTZ");
		}
		if (jxkid != null) {
			map.put("jxkid", jxkid);
		}

		// 必要传的参数
		map.put("id", pId);// 标的id
		map.put("fs", shuru.getText().toString());// 份数
		// 必要传的参数

		RequestThreadAbstract thread = RequestFactory.createRequestThread(10,
				map, LiJiTouBiaoActivity.this, mHandler);
		RequestPool.execute(thread);

	}

	private Handler mHandler = new Handler() {

		@Override
		public void handleMessage(Message msg) {
			// TODO Auto-generated method stub
			super.handleMessage(msg);

			juhua.cancel();

			switch (msg.what) {
			case 102: // 获取加息卡
				showSpinnerActivity();
				break;
			case 0:

				Toast.makeText(LiJiTouBiaoActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:
				// 停止菊花

				Intent intent = new Intent();
				intent.setAction("sanbiao_reloadata");
				sendBroadcast(intent);
				// 存管投资--进入h5页面
				if (bdtype.endsWith("1")) {
					Bundle bundle = msg.getData();
					String sendUrl = (String) bundle.get("sendUrl");
					String sendStr = (String) bundle.get("sendStr");
					String transCode = (String) bundle.get("transCode");
					if (sendUrl == null) {
						Toast.makeText(LiJiTouBiaoActivity.this, "操作失败", 1000)
								.show();
						return;
					}
					Intent intent2 = new Intent(LiJiTouBiaoActivity.this,
							CGWebView.class);
					intent2.putExtra("sendUrl", sendUrl);
					intent2.putExtra("sendStr", sendStr);
					intent2.putExtra("transCode", transCode);
					intent2.putExtra("title", "投标确认");
					startActivity(intent2);
					anim_right_in();

				} else {
					Toast.makeText(LiJiTouBiaoActivity.this,
							msg.getData().getString("msg"), 1000).show();
					LiJiTouBiaoActivity.this.finish();
					anim_right_out();
				}

				break;
			case 3:
				// 标的详情信息

				double kegoumai = 0.0;
				// 判断最小的数据
				double syfsa = Double.valueOf(san_toubiao.getSyje());
				double keyongs = Double.valueOf(keyongjiner);

				double tbxe = 0.0;
				if (san_toubiao.getTbxe().equals("不限")) {

				} else {
					tbxe = Double.valueOf(san_toubiao.getTbxe());
				}

				if (syfsa < keyongs) {
					if (syfsa < tbxe) {
						kegoumai = syfsa / 100;
					} else {
						kegoumai = tbxe / 100;
					}
				} else {
					if (keyongs > tbxe) {
						kegoumai = tbxe / 100;
					} else {
						kegoumai = keyongs / 100;
					}
				}
				// 特殊的判断
				if (tbxe == 0.0) {
					if (syfsa < keyongs) {
						kegoumai = syfsa / 100;
					} else {
						kegoumai = keyongs / 100;
					}
				}

				goumai.setText((int) kegoumai + "");
				shengyu.setText(san_toubiao.getSyje());

				UserMode user = Tool.getUser(LiJiTouBiaoActivity.this);
				keyong.setText(user.getKyye());

				yujishouyi.setText("预计收益" + suanfa(fenshu, 0) + "元+奖"
						+ suanfa(fenshu, 1) + "元");

				break;

			case 2:

				if ("你的账户余额不足进行本次购买 ，请充值"
						.equals(msg.getData().getString("msg"))) {
					// 进入账户管理的页面
					startActivity(new Intent(LiJiTouBiaoActivity.this,
							ZiJinGuanLiActivity.class));
					anim_right_in();
				}
				Toast.makeText(LiJiTouBiaoActivity.this,
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

		if (map.get("urlTag").equals("1")) {
			JSONObject jsonO = (JSONObject) jsonObj;
			JSONArray jsonArray = null;
			try {
				jsonArray = jsonO.getJSONArray("rvalue");
			} catch (JSONException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

			Message msg1 = new Message();
			msg1.what = 1;
			Bundle bundle = new Bundle();
			try {

				JSONObject json = jsonArray.getJSONObject(0);

				UserMode user = Tool.getUser(LiJiTouBiaoActivity.this);
				user.setKyye(json.getString("amount"));
				user.saveUserToDB(LiJiTouBiaoActivity.this);
				bundle.putString("msg", jsonO.getString("msg"));

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

		} else if (map.get("urlTag").equals("3")) {
			// 获取标的详情
			if (list.size() == 1) {
				JSONObject json = (JSONObject) jsonObj;
				try {
					UserMode user = Tool.getUser(LiJiTouBiaoActivity.this);
					user.setKyye(json.getJSONObject("rvalue").getString(
							"amount"));
					user.saveUserToDB(LiJiTouBiaoActivity.this);
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				san_toubiao = (SanProject) list.get(0);
				Message msg1 = new Message();
				msg1.what = 3;
				mHandler.sendMessage(msg1);
			}
		} else if (map.get("urlTag").equals("102")) {
			JSONObject json = (JSONObject) jsonObj;
			// list 讲数据添加到☑列表中

			Message msg1 = new Message();
			msg1.what = 102;
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

	// type，0是预计收益，1是奖的收益
	public double suanfa(int fenshu, int type) {

		huankuanqixianStr = san_toubiao.getHkqx();
		nianlilvStr = san_toubiao.getNll();
		jiekuanStr = san_toubiao.getJkfs();
		huankuanfangshiStr = san_toubiao.getHkfs();

		double value = 0.00;
		double nian = 0.00;
		double yue = 0.00;
		double tian = 0.00;
		double hkqx = Double.valueOf(huankuanqixianStr);

		if (type == 0) {
			nian = Double.valueOf(nianlilvStr) / 100.00;
			yue = Double.valueOf(nianlilvStr) / 1200.00;
			tian = Double.valueOf(nianlilvStr) / 36000.00;
		} else if (type == 1) {
			jiangliStr = san_toubiao.getJlll();
			nian = Double.valueOf(jiangliStr) / 100.00;
			yue = Double.valueOf(jiangliStr) / 1200.00;
			tian = Double.valueOf(jiangliStr) / 36000.00;

		}

		if (nian <= 0.00) {
			return value;
		}

		// 月标
		if (jiekuanStr.equals("0")) {

			if (huankuanfangshiStr.equals("每月还息到期还本(不扣首期利息)")
					|| huankuanfangshiStr.equals("每月还息到期还本(扣首期利息)")) {
				value = fenshu * 100 * yue * hkqx;
				BigDecimal b = new BigDecimal(value);
				value = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			}

			if (huankuanfangshiStr.equals("等额本息")) {

				int newfenshu = 1;
				// 每份每月还款额
				double a1 = 100 * (yue * Math.pow(1 + yue, hkqx))
						/ (Math.pow((1 + yue), hkqx) - 1);
				// 每月还款额
				double a2 = newfenshu * (a1 * hkqx - 100);
				BigDecimal b = new BigDecimal(a2);
				double a3 = b.setScale(2, BigDecimal.ROUND_HALF_UP)
						.doubleValue();
				value = fenshu * a3;

				BigDecimal b1 = new BigDecimal(value);
				value = b1.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();

			}

		} else if (jiekuanStr.equals("1")) {// 天标
			value = fenshu * 100 * tian * hkqx;
			BigDecimal b = new BigDecimal(value);
			value = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
		} else if (jiekuanStr.equals("2")) {// 秒标
			value = fenshu * 100 * nian * hkqx;
			BigDecimal b = new BigDecimal(value);
			value = b.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
		}
		return value;
	}

	// private List<HashMap<String, String>> list = new
	// ArrayList<HashMap<String, String>>();
	private List<String> list = new ArrayList<String>();
	private Dialog dialog2 = null;

	public void showSpinnerActivity() {

		// HashMap<String, String> map1 = new HashMap<String, String>();
		// map1.put("id", "3");
		// map1.put("title", "JXK-b193654--1.00%     2017-03-29到期");
		// list.add(map1);
		// HashMap<String, String> map2 = new HashMap<String, String>();
		// map2.put("id", "4");
		// map2.put("title", "JXK-b193654--1.00%     2017-03-29到期");
		// list.add(map2);

		list.add("JXK-b193654--1.00%     2017-03-29到期");
		list.add("JXK-b193654--1.00%     2017-03-29到期");
		list.add("JXK-b193654--1.00%     2017-03-29到期");

		dialog2 = new AlertDialog.Builder(LiJiTouBiaoActivity.this)
				.setSingleChoiceItems(list.toArray(new String[list.size()]), 0,
						new DialogInterface.OnClickListener() {

							@Override
							public void onClick(DialogInterface arg0, int arg1) {
								// TODO Auto-generated method stub
								dialog2.cancel();
								// 调接口，查询相应的数据
							}
						}).create();
		dialog2.show();
		//
		// //mySpinner = (Spinner) findViewById(R.id.Spinner_city);
		// // 第二步：为下拉列表定义一个适配器，这里就用到里前面定义的list。
		// adapter = new ArrayAdapter<HashMap<String, String>>(this,
		// android.R.layout.simple_spinner_item, list);
		// // 第三步：为适配器设置下拉列表下拉时的菜单样式。
		// adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
		// // 第四步：将适配器添加到下拉列表上
		// mySpinner.setAdapter(adapter);
		//
		// // 第五步：为下拉列表设置各种事件的响应，这个事响应菜单被选中
		// mySpinner
		// .setOnItemSelectedListener(new Spinner.OnItemSelectedListener() {
		// public void onItemSelected(AdapterView<?> arg0, View arg1,
		// int arg2, long arg3) {
		// // TODO Auto-generated method stub
		// /* 将所选mySpinner 的值带入myTextView 中 */
		// HashMap<String, String> map = (HashMap<String, String>) mySpinner
		// .getSelectedItem();
		// jxkid = map.get("id").toString();
		//
		// /* 将mySpinner 显示 */
		// arg0.setVisibility(View.VISIBLE);
		// }
		//
		// public void onNothingSelected(AdapterView<?> arg0) {
		// // TODO Auto-generated method stub
		//
		// arg0.setVisibility(View.VISIBLE);
		// }
		// });

	}
}
