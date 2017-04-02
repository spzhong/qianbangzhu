package com.quqian.activity.index;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.app.AlertDialog;
import android.app.Dialog;
import android.app.ActionBar.LayoutParams;
import android.content.Intent;
import android.graphics.Shader.TileMode;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.TypedValue;
import android.view.Display;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.CompoundButton.OnCheckedChangeListener;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.index.IndexActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.TiYanProject;
import com.quqian.been.UserMode;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.TimeUtil;
import com.quqian.util.Tool;

public class LiJiShenQingActivity extends BaseActivity implements
		OnClickListener, HttpResponseInterface {

	private TextView shengyu = null;
	private TextView shangxian = null;
	private TextView huoqu = null;

	private LinearLayout layout = null;

	private TextView dangqian = null;

	private Button button = null;

	private String pId = "";

	// join
	private String joinLimit = "";

	// 剩余金额
	private String shengyuStr = "";

	private String ChuanCanQH = "";

	// jsonobj 对象
	private JSONObject jsonObj1 = null;
	private JSONObject jsonObj2 = null;
	private JSONObject jsonObj3 = null;

	private TiYanProject allLicai = null;

	// list 券号跟金额
	List<Map<String, String>> list_quan1 = new ArrayList<Map<String, String>>();

	private Dialog juhua = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_index_lijishenqing;
	}

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
		if (getIntent().getStringExtra("pId") != null) {
			pId = getIntent().getStringExtra("pId");
			// joinLimit = getIntent().getStringExtra("joinlimit");
		}
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("立即申请");
		showBack();

		juhua = new ProcessDialogUtil(LiJiShenQingActivity.this);

		jsonObj1 = new JSONObject();
		jsonObj2 = new JSONObject();
		jsonObj3 = new JSONObject();

		shengyu = (TextView) findViewById(R.id.main_index_lijishenqing_shengyu);
		shangxian = (TextView) findViewById(R.id.main_index_lijishenqing_shangxian);
		huoqu = (TextView) findViewById(R.id.main_index_lijishenqing_huoqu);

		layout = (LinearLayout) findViewById(R.id.lijishenqing_layout);

		dangqian = (TextView) findViewById(R.id.main_index_lijishenqing_dangqian);

		button = (Button) findViewById(R.id.main_index_lijishenqing_shenqing);

		// 设置数据
		UserMode user = Tool.getUser(LiJiShenQingActivity.this);
		shengyuStr = user.getTyjze();

		// shengyu.setText(shengyuStr);
		// shangxian.setText(joinLimit);

		// 获取体验详情
		loadHttp();
	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);

		huoqu.setOnClickListener(this);

		button.setOnClickListener(this);

	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_back:
			LiJiShenQingActivity.this.finish();
			anim_right_out();
			break;
		case R.id.main_index_lijishenqing_huoqu:
			lingqutiyanjin();
			break;
		case R.id.main_index_lijishenqing_shenqing:
			if ("0.0".equals(dangqian.getText().toString())) {
				Toast.makeText(LiJiShenQingActivity.this, "请选择体验券",
						Toast.LENGTH_SHORT).show();
			} else {
				lijishenqingdialog();
			}

			break;

		default:
			break;
		}
	}

	private Dialog dialog = null;

	// 领取体验金对话框
	private void lingqutiyanjin() {

		View view = LayoutInflater.from(LiJiShenQingActivity.this).inflate(
				R.layout.dialog_all, null);
		TextView tv_title = (TextView) view.findViewById(R.id.dialog_title);
		tv_title.setText("获取体验金");
		TextView tv_content = (TextView) view.findViewById(R.id.dialog_content);
		tv_content.setVisibility(View.GONE);
		final EditText et_content = (EditText) view
				.findViewById(R.id.dialog_et_content);
		et_content.setVisibility(View.VISIBLE);
		Button tv_cancel = (Button) view.findViewById(R.id.dialog_cancel);
		Button tv_submit = (Button) view.findViewById(R.id.dialog_submit);
		tv_cancel.setText("取消");
		tv_submit.setText("确定");
		tv_cancel.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View arg0) {
				// TODO Auto-generated method stub
				dialog.dismiss();
			}
		});
		tv_submit.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View arg0) {
				// TODO Auto-generated method stub
				if (et_content.getText().toString() != null) {
					loadHttp_ADDQH(et_content.getText().toString());
				}
				dialog.dismiss();
			}
		});

		dialog = new AlertDialog.Builder(LiJiShenQingActivity.this).setView(
				view).create();
		dialog.show();
	}

	// 立即申请对话框
	private void lijishenqingdialog() {

		View view = LayoutInflater.from(LiJiShenQingActivity.this).inflate(
				R.layout.dialog_all, null);
		TextView title = (TextView) view.findViewById(R.id.dialog_title);
		title.setText("购买确认");
		TextView content = (TextView) view.findViewById(R.id.dialog_content);
		content.setText("您此次申请理财体验需要使用" + dangqian.getText().toString()
				+ "元体验金");
		content.setTextSize(TypedValue.COMPLEX_UNIT_SP, 16);
		content.setGravity(Gravity.CENTER);
		Button quxiao = (Button) view.findViewById(R.id.dialog_cancel);
		Button queding = (Button) view.findViewById(R.id.dialog_submit);

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

				loadHttp_quren(ChuanCanQH);

				dialog.dismiss();
			}
		});

		dialog = new AlertDialog.Builder(LiJiShenQingActivity.this).setView(
				view).create();
		dialog.show();
	}

	private void loadHttp() {

		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "4");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("id", pId);// 0不锁，1是锁

		RequestThreadAbstract thread = RequestFactory.createRequestThread(12,
				map, LiJiShenQingActivity.this, mHandler);
		RequestPool.execute(thread);

	}

	// 获取体验券号
	private void loadHttp_getQH() {
		// TODO Auto-generated method stub

		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁

		RequestThreadAbstract thread = RequestFactory.createRequestThread(14,
				map, LiJiShenQingActivity.this, mHandler);
		RequestPool.execute(thread);

	}

	// 添加体验券号
	private void loadHttp_ADDQH(String quanhao) {
		// TODO Auto-generated method stub

		if (quanhao.length() == 0) {
			Toast.makeText(LiJiShenQingActivity.this, "请输入券号", 1000).show();
			return;
		}

		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "2");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁

		// 必要传的参数
		map.put("qh", quanhao); // 理财的体验金的券号
		// 必要传的参数

		RequestThreadAbstract thread = RequestFactory.createRequestThread(15,
				map, LiJiShenQingActivity.this, mHandler);
		RequestPool.execute(thread);

	}

	// 确认提交申请
	private void loadHttp_quren(String quanhao) {

		juhua.show();

		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "3");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁

		// 必要传的参数
		map.put("id", pId);// 标的id
		map.put("qh", quanhao); // 理财的体验金的券号
		map.put("amount", dangqian.getText().toString());
		// 必要传的参数

		RequestThreadAbstract thread = RequestFactory.createRequestThread(13,
				map, LiJiShenQingActivity.this, mHandler);
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

				Toast.makeText(LiJiShenQingActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:
				// 停止菊花-获取用户拥有的体验券
				// 每次获取用户的体验券号的时候，清空list_quan1
				list_quan1.clear();
				toHuoQuUser(jsonObj1);
				break;
			case 3:

				Toast.makeText(LiJiShenQingActivity.this, "成功", 1000).show();

				// 停止菊花-输入获取体验券
				loadHttp_getQH();
				break;

			case 4:

				Intent intent = new Intent();
				intent.setAction("licaitiyan_reloadata");
				sendBroadcast(intent);

				// 停止菊花-申请
				Toast.makeText(LiJiShenQingActivity.this, "申请成功", 1000).show();
				finish();
				anim_right_out();
				break;
			case 5:// 获取理财体验的详情

				shengyu.setText(allLicai.getSyje());
				shangxian.setText(allLicai.getJoinLimit());

				// 获取体验全号
				loadHttp_getQH();
				break;
			case 2:
				Toast.makeText(LiJiShenQingActivity.this,
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
		if ("1".equals(map.get("urlTag"))) {
			jsonObj1 = (JSONObject) jsonObj;
			Message msg1 = new Message();
			msg1.what = 1;
			Bundle bundle = new Bundle();
			try {
				bundle.putString("msg", jsonObj1.getString("msg"));
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			msg1.setData(bundle);
			mHandler.sendMessage(msg1);
		} else if ("2".equals(map.get("urlTag"))) {
			jsonObj2 = (JSONObject) jsonObj;
			Message msg1 = new Message();
			msg1.what = 3;
			Bundle bundle = new Bundle();
			try {
				bundle.putString("msg", jsonObj2.getString("msg"));
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			msg1.setData(bundle);
			mHandler.sendMessage(msg1);
		} else if ("3".equals(map.get("urlTag"))) {
			jsonObj3 = (JSONObject) jsonObj;
			Message msg1 = new Message();
			msg1.what = 4;
			Bundle bundle = new Bundle();
			try {
				bundle.putString("msg", jsonObj3.getString("msg"));
				UserMode user = Tool.getUser(LiJiShenQingActivity.this);
				user.setKyye(jsonObj3.getJSONObject("rvalue").getString(
						"experienceAmount"));
				user.saveUserToDB(LiJiShenQingActivity.this);
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			msg1.setData(bundle);
			mHandler.sendMessage(msg1);
		} else if ("4".equals(map.get("urlTag"))) {

			if (list.size() == 1) {
				allLicai = (TiYanProject) list.get(0);
				Message msg1 = new Message();
				msg1.what = 5;
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

	// 停止菊花-获取用户拥有的体验券
	private void toHuoQuUser(JSONObject json) {
		if (json != null) {
			try {
				JSONArray jsonarr = json.getJSONArray("rvalue");
				for (int i = 0; i < jsonarr.length(); i++) {
					JSONObject jsonobj1 = jsonarr.getJSONObject(i);
					Map<String, String> map = new HashMap<String, String>();
					map.put("quanhao", jsonobj1.getString("qh"));
					map.put("jiner", jsonobj1.getString("je"));
					map.put("state", "0");// 0未选中，1选中
					list_quan1.add(map);
				}

			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			return;
		}

		layout.removeAllViews();

		// 动态的添加
		for (int i = 0; i < list_quan1.size(); i++) {
			CheckBox cb = new CheckBox(LiJiShenQingActivity.this);
			cb.setButtonDrawable(getResources().getDrawable(
					R.drawable.register_wotongyi));
			cb.setText("    " + list_quan1.get(i).get("quanhao") + "  ("
					+ list_quan1.get(i).get("jiner") + "元)");
			cb.setPadding(TimeUtil.dip2px(LiJiShenQingActivity.this, 15),
					TimeUtil.dip2px(LiJiShenQingActivity.this, 5),
					TimeUtil.dip2px(LiJiShenQingActivity.this, 15),
					TimeUtil.dip2px(LiJiShenQingActivity.this, 5));
			cb.setGravity(Gravity.CENTER_VERTICAL);
			cb.setTextSize(TypedValue.COMPLEX_UNIT_SP, 12);
			cb.setId(i);
			layout.addView(cb);
			cb.setOnCheckedChangeListener(new OnCheckedChangeListener() {

				@Override
				public void onCheckedChanged(CompoundButton buttonView,
						boolean isChecked) {
					// TODO Auto-generated method stub
					Map<String, String> map = list_quan1.get(buttonView.getId());
					if (isChecked) {
						map.put("state", "1");
					} else {
						map.put("state", "0");
					}
					jisuan();
				}
			});
		}

	}

	private void jisuan() {
		ChuanCanQH = "";
		double all = 0.0;
		for (Map<String, String> map : list_quan1) {
			if (map.get("state").equals("1")) {
				all += Double.valueOf(map.get("jiner"));
				ChuanCanQH += map.get("quanhao") + ",";
			}
		}
		//
		dangqian.setText(all + "");
		if (ChuanCanQH.length() > 0) {
			ChuanCanQH = ChuanCanQH.substring(0, ChuanCanQH.length() - 1);
		}

		System.out.println("-----" + ChuanCanQH);
	}

}
