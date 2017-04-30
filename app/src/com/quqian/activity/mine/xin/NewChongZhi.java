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
import com.quqian.activity.LoginActivity;
import com.quqian.activity.MainActivity;
import com.quqian.activity.index.LiJiShenQingActivity;
import com.quqian.activity.mine.ChongZhiActivity;
import com.quqian.activity.mine.KjChongZhiActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.TiYanProject;
import com.quqian.been.UserMode;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.lockq.GestureEditActivity;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.MyWebViewActivity;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.StaticVariable;
import com.quqian.util.Tool;

public class NewChongZhi extends BaseActivity implements OnClickListener,
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

	// 存管充值界面，普通充值界面，用来切换隐藏整个布局
	private LinearLayout layout_cg = null;
	private LinearLayout layout_pu = null;

	// 存管充值界面 组件
	private TextView cg_tv_keyong = null;
	private TextView cg_tv_zhanghu = null;
	private EditText cg_et_chongzhi = null;
	private Button cg_btn = null;

	// 普通充值界面 组件
	private LinearLayout pu_layout_qianyue = null;
	private LinearLayout pu_layout_kuaijie = null;

	// 接口返回的参数String
	// 判断是否开通存管充值，
	private String cgzt = "";
	// 华兴e账户,存管可用余额
	private String cgzh = "";
	private String cgkyye = "";

	// 判断是否开通普通充值
	private String ptzt = "";
	// 普通账户可用余额，银行卡尾号
	private String ptkyye = "";
	private String yhkh = "";

	// 当前选中的radio button
	private String myrb = "1";

	private String zhlx = "";

	// 网络加载中
	ProcessDialogUtil juhua = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.mine_new_chongzhi;
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
		setTitle("充值");
		showBack();
		setMenu("充值记录");
		showMenu();

		juhua = new ProcessDialogUtil(NewChongZhi.this);

		rg = (RadioGroup) findViewById(R.id.cz_rg);
		rb1 = (RadioButton) findViewById(R.id.cz_rb1);
		rb2 = (RadioButton) findViewById(R.id.cz_rb2);
		// 单选按钮下面的选中条
		tvrb1 = (TextView) findViewById(R.id.cz_tvrb1);
		tvrb2 = (TextView) findViewById(R.id.cz_tvrb2);

		// 尚未开通布局 及组件
		layout_weikaitong = (LinearLayout) findViewById(R.id.cz_layout_weikaitong);
		tv_weikaitong = (TextView) findViewById(R.id.cz_layout_weikaitongtip);
		btn_weikaitong = (Button) findViewById(R.id.cz_layout_weikaitongbtn);

		// 存管充值布局 及组件
		layout_cg = (LinearLayout) findViewById(R.id.cz_layout_cg);
		cg_tv_keyong = (TextView) findViewById(R.id.cz_layout_cg_keyong);
		cg_tv_zhanghu = (TextView) findViewById(R.id.cz_layout_cg_zhanghu);
		cg_et_chongzhi = (EditText) findViewById(R.id.cz_layout_cg_chongzhi);
		cg_btn = (Button) findViewById(R.id.cz_layout_cg_btn);

		// 普通充值布局 及组件
		layout_pu = (LinearLayout) findViewById(R.id.cz_layout_pu);
		pu_layout_qianyue = (LinearLayout) findViewById(R.id.cz_layout_pu_qianyue);
		pu_layout_kuaijie = (LinearLayout) findViewById(R.id.cz_layout_pu_kuaijie);

		// 调用接口 获取充值信息，然后加载页面
		loadHttp();
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
		// 存管充值
		cg_btn.setOnClickListener(this);
		// 普通充值
		pu_layout_qianyue.setOnClickListener(this);
		pu_layout_kuaijie.setOnClickListener(this);

	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub

		switch (arg0.getId()) {
		case R.id.title_bar_back:
			NewChongZhi.this.finish();
			anim_right_out();
			break;
		case R.id.title_bar_menu:
			// 跳转到充值记录里面
			Intent intentjilu = new Intent();
			intentjilu.setClass(NewChongZhi.this, ChongZhiJILu.class);
			startActivity(intentjilu);
			break;
		case R.id.cz_rb1:
			// 存管充值选项 点击该按钮，选中状态条
			tvrb1.setBackgroundColor(getResources().getColor(
					R.color.main_radio_blue));
			tvrb2.setBackgroundColor(getResources().getColor(R.color.white));

			// 将当前的选中按钮设置为1，
			myrb = "1";

			if (cgzt.equals("S")) {
				// 如果开通，则隐藏'未开通'布局，显示存管充值界面
				layout_weikaitong.setVisibility(View.GONE);
				layout_cg.setVisibility(View.VISIBLE);
				layout_pu.setVisibility(View.GONE);

				// 设置开通存管账户数据 ,可用余额，华兴E账户
				cg_tv_keyong.setText(cgkyye);
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
		case R.id.cz_rb2:
			// 普通充值选项
			// 存管充值选项 点击该按钮，选中状态条
			tvrb1.setBackgroundColor(getResources().getColor(R.color.white));
			tvrb2.setBackgroundColor(getResources().getColor(
					R.color.main_radio_blue));

			// 将当前的选中按钮设置为1，
			myrb = "2";

			if (ptzt.equals("S")) {
				// 如果开通，则隐藏'未开通'布局，显示存管充值界面
				layout_weikaitong.setVisibility(View.GONE);
				layout_cg.setVisibility(View.GONE);
				layout_pu.setVisibility(View.VISIBLE);
			} else {
				// 如果未开通，则隐藏存管充值界面，显示'未开通'布局
				layout_weikaitong.setVisibility(View.VISIBLE);
				layout_cg.setVisibility(View.GONE);
				layout_pu.setVisibility(View.GONE);
				tv_weikaitong.setText("您尚未完成普通账户绑卡，现在去绑定？");
				btn_weikaitong.setText("立即绑定");
			}

			break;
		case R.id.cz_layout_weikaitongbtn:
			// 尚未开通按钮
			if (myrb.equals("1")) {
				// 前往开通 存管账户
				Intent intent = new Intent(NewChongZhi.this,
						KaiTongCunGuanActivity.class);
				startActivity(intent);
				anim_right_in();
			} else {
				// 前去绑定 普通账户 个人：GRKH 企业：QYKH
				if (zhlx.equals("GRKH")) {
					// 跳转到个人
					startActivity(new Intent(NewChongZhi.this,
							BangDingYinHangKaActivity.class));
				} else {
					// 跳转到企业
					startActivity(new Intent(NewChongZhi.this,
							QiYeBangDingYinHangKaActivity.class));
				}
			}

			break;
		case R.id.cz_layout_cg_btn:
			// 存管充值按钮
			String JIN = cg_et_chongzhi.getText().toString();
			if (JIN.length() == 0) {
				Toast.makeText(NewChongZhi.this, "请输入充值金额", 1000).show();
				return;
			}
			double JINdd = Double.valueOf(JIN);
			if (JINdd >= 100 && JINdd < 1000000) {
			} else {
				Toast.makeText(NewChongZhi.this, "充值金额必须大于100小于1000000", 1000)
						.show();
				return;
			}

			loadHttp_cg_chognzhi();

			break;
		case R.id.cz_layout_pu_qianyue:
			// 签约充值
			Intent intent1 = new Intent();
			intent1.putExtra("chongzhifangshi", "1");
			intent1.putExtra("ptkyye", ptkyye);
			intent1.putExtra("yhkh", yhkh);
			intent1.setClass(NewChongZhi.this, NewChongQianYuKuaiJie.class);
			startActivity(intent1);
			break;
		case R.id.cz_layout_pu_kuaijie:
			// 快捷充值
			Intent intent2 = new Intent();
			intent2.putExtra("chongzhifangshi", "2");
			intent2.putExtra("ptkyye", ptkyye);
			intent2.putExtra("yhkh", yhkh);
			intent2.setClass(NewChongZhi.this, NewChongQianYuKuaiJie.class);
			startActivity(intent2);
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
				Toast.makeText(NewChongZhi.this,
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
				Toast.makeText(NewChongZhi.this,
						msg.getData().getString("msg"), 1000).show();

				break;
			case 3:// 存管充值
				Bundle bundle = msg.getData();
				String sendUrl = (String) bundle.get("sendUrl");
				String sendStr = (String) bundle.get("sendStr");
				String transCode = (String) bundle.get("transCode");
				if (sendUrl == null) {
					Toast.makeText(NewChongZhi.this, "操作失败", 1000).show();
					return;
				}
				Intent intent2 = new Intent(NewChongZhi.this, CGWebView.class);
				intent2.putExtra("sendUrl", sendUrl);
				intent2.putExtra("sendStr", sendStr);
				intent2.putExtra("transCode", transCode);
				intent2.putExtra("title", "充值");
				startActivity(intent2);
				anim_right_in();
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
		RequestThreadAbstract thread = RequestFactory.createRequestThread(38,
				map, NewChongZhi.this, mHandler);
		RequestPool.execute(thread);
	}

	private void loadHttp_cg_chognzhi() {

		juhua.show();

		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "3");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("amount", cg_et_chongzhi.getText().toString());
		map.put("type", "CGCZ");
		// 请求的参数如下
		RequestThreadAbstract thread = RequestFactory.createRequestThread(104,
				map, NewChongZhi.this, mHandler);
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
				JSONArray rvalue = json.getJSONArray("rvalue");
				JSONObject asydataJson = (JSONObject) rvalue.get(0);

				bundle.putString(
						"transCode",
						asydataJson.getJSONObject("asydata").getString(
								"transCode"));
				bundle.putString("sendUrl", asydataJson
						.getJSONObject("asydata").getString("sendUrl"));
				bundle.putString("sendStr", asydataJson
						.getJSONObject("asydata").getString("sendStr"));
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
