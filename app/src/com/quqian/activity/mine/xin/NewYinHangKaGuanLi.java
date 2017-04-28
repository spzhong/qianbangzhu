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
import com.quqian.activity.LoginActivity;
import com.quqian.activity.MainActivity;
import com.quqian.activity.index.LiJiShenQingActivity;
import com.quqian.activity.mine.ChongZhiActivity;
import com.quqian.activity.mine.KjChongZhiActivity;
import com.quqian.activity.mine.MineActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.TiYanProject;
import com.quqian.been.UserMode;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.lockq.GestureEditActivity;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.StaticVariable;
import com.quqian.util.Tool;

public class NewYinHangKaGuanLi extends BaseActivity implements
		OnClickListener, HttpResponseInterface {

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
	private TextView btn_weikaitong = null;

	// 存管账户界面，普通账户界面，用来切换隐藏整个布局
	private LinearLayout layout_cg = null;
	private LinearLayout layout_pu = null;

	// 存管账户界面 组件
	private TextView cg_zhanghu = null;
	private TextView cg_kaihuren = null;
	private TextView cg_kaihuhang = null;
	private LinearLayout cg_weibangka = null;
	private LinearLayout cg_yibangka = null;

	// 普通账户
	private TextView pu_kaihuhang = null;
	private TextView pu_kaihuhangdiqu = null;
	private TextView pu_yinhangkahao = null;

	// 重要提示
	private TextView tip1 = null;
	private TextView tip2 = null;
	private TextView tip3 = null;
	private TextView tip4 = null;
	private TextView tip5 = null;
	// 接口返回的参数String
	// 判断是否开通存管账户，
	private String cgzt = "";
	// 华兴e账户,开户人姓名,开户支行
	private String hxzh = "";
	private String name = "";
	private String khzh = "";
	// 存管账户是否绑卡
	private String sfbk = "";

	// 判断是否开通普通账户
	private String ptzt = "";
	// 普通账户 银行卡开户行，开户行地区，银行卡号，账户类型，
	private String yhkhh = "";
	private String khhdq = "";
	private String yhkh = "";
	private String zhlx = "";

	// 当前选中的radio button
	private String myrb = "1";

	// 网络加载中
	ProcessDialogUtil juhua = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.mine_new_yinhangkaguanli;
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
		setTitle("银行卡管理");
		showBack();

		juhua = new ProcessDialogUtil(NewYinHangKaGuanLi.this);

		rg = (RadioGroup) findViewById(R.id.yhk_rg);
		rb1 = (RadioButton) findViewById(R.id.yhk_rb1);
		rb2 = (RadioButton) findViewById(R.id.yhk_rb2);
		// 单选按钮下面的选中条
		tvrb1 = (TextView) findViewById(R.id.yhk_tvrb1);
		tvrb2 = (TextView) findViewById(R.id.yhk_tvrb2);

		// 尚未开通布局 及组件
		layout_weikaitong = (LinearLayout) findViewById(R.id.yhk_layout_weikaitong);
		btn_weikaitong = (TextView) findViewById(R.id.yhk_layout_weikaitongtip);
		tv_weikaitong = (TextView) findViewById(R.id.yhk_layout_weikaitongbtn);

		// 存管账户布局 及组件
		layout_cg = (LinearLayout) findViewById(R.id.yhk_layout_cg);
		cg_zhanghu = (TextView) findViewById(R.id.yhk_layout_cg_zhanghu);
		cg_kaihuren = (TextView) findViewById(R.id.yhk_layout_cg_kaihurenxingming);
		cg_kaihuhang = (TextView) findViewById(R.id.yhk_layout_cg_kaihuzhihang);
		cg_weibangka = (LinearLayout) findViewById(R.id.yhk_layout_weikaitong2);
		cg_yibangka = (LinearLayout) findViewById(R.id.yhk_layout_weikaitong3);

		// 普通账户布局 及组件
		layout_pu = (LinearLayout) findViewById(R.id.yhk_layout_pu);
		pu_kaihuhang = (TextView) findViewById(R.id.yhk_layout_pu_yinhangkaihuhang);
		pu_kaihuhangdiqu = (TextView) findViewById(R.id.yhk_layout_pu_kaihuhangdiqu);
		pu_yinhangkahao = (TextView) findViewById(R.id.yhk_layout_pu_zhanghu);

		// 提示
		tip1 = (TextView) findViewById(R.id.yhkgl_tv1);
		tip2 = (TextView) findViewById(R.id.yhkgl_tv2);
		tip3 = (TextView) findViewById(R.id.yhkgl_tv3);
		tip4 = (TextView) findViewById(R.id.yhkgl_tv4);
		tip5 = (TextView) findViewById(R.id.yhkgl_tv5);

		// 调用接口 获取账户信息，然后加载页面
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
		rb1.setOnClickListener(this);
		rb2.setOnClickListener(this);
		// 尚未开通
		btn_weikaitong.setOnClickListener(this);
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub

		switch (arg0.getId()) {
		case R.id.title_bar_back:
			NewYinHangKaGuanLi.this.finish();
			anim_right_out();
			break;
		case R.id.yhk_rb1:
			// 存管账户选项 点击该按钮，选中状态条
			tvrb1.setBackgroundColor(getResources().getColor(
					R.color.main_radio_blue));
			tvrb2.setBackgroundColor(getResources().getColor(R.color.white));

			tip1.setText("1. 华兴银行E账户即华兴银行电子账户，是用户在华兴银行实名开立的、用于办理钱帮主资金业务的账户；");
			tip2.setText("2.一个用户只能开立一个E账户，且只能绑定一张银行卡；");
			tip3.setText("3.如需更换绑定银行卡，请按实际情况选择更换；");
			tip4.setVisibility(View.VISIBLE);
			tip4.setText("（1）E账户资产全部转出，登录华兴银行投融资平台进行更换；");
			tip5.setVisibility(View.VISIBLE);
			tip5.setText("（2）绑定银行卡挂失或销户销卡，通过投融资APP申请人工审批换卡。");

			// 将当前的选中按钮设置为1，
			myrb = "1";

			if (cgzt.equals("S")) {
				// 如果开通，则隐藏'未开通'布局，显示存管账户界面
				layout_weikaitong.setVisibility(View.GONE);
				layout_cg.setVisibility(View.VISIBLE);
				layout_pu.setVisibility(View.GONE);

				// 设置开通存管账户数据 ,可用余额，华兴E账户
				cg_zhanghu.setText(hxzh);
				cg_kaihuren.setText(name);
				cg_kaihuhang.setText(khzh);
				if (sfbk.equals("S")) {
					cg_weibangka.setVisibility(View.GONE);
					cg_yibangka.setVisibility(View.VISIBLE);
				} else {
					cg_weibangka.setVisibility(View.VISIBLE);
					cg_yibangka.setVisibility(View.GONE);
				}

			} else {
				// 如果未开通，则隐藏存管账户界面，显示'未开通'布局
				layout_weikaitong.setVisibility(View.VISIBLE);
				layout_cg.setVisibility(View.GONE);
				layout_pu.setVisibility(View.GONE);
				tv_weikaitong.setText("立即开通");
			}

			break;
		case R.id.yhk_rb2:
			// 普通账户选项
			// 存管账户选项 点击该按钮，选中状态条
			tvrb1.setBackgroundColor(getResources().getColor(R.color.white));
			tvrb2.setBackgroundColor(getResources().getColor(
					R.color.main_radio_blue));

			tip1.setText("1. 该提现银行卡仅作为普通账户资金提现使用；");
			tip2.setText("2.如需更换银行卡，请前往电脑版-银行卡管理页面更换；");
			tip3.setText("3.如有疑问，请致电客服400-8535-666。");
			tip4.setVisibility(View.GONE);
			tip5.setVisibility(View.GONE);

			// 将当前的选中按钮设置为1，
			myrb = "2";

			if (ptzt.equals("S")) {
				// 如果开通，则隐藏'未开通'布局，显示存管账户界面
				layout_weikaitong.setVisibility(View.GONE);
				layout_cg.setVisibility(View.GONE);
				layout_pu.setVisibility(View.VISIBLE);

				pu_kaihuhang.setText(yhkhh);
				pu_kaihuhangdiqu.setText(khhdq);
				pu_yinhangkahao.setText(yhkh);

			} else {
				// 如果未开通，则隐藏存管账户界面，显示'未开通'布局
				layout_weikaitong.setVisibility(View.VISIBLE);
				layout_cg.setVisibility(View.GONE);
				layout_pu.setVisibility(View.GONE);
				tv_weikaitong.setText("立即绑卡");
			}

			break;
		case R.id.yhk_layout_weikaitongtip:
			// 尚未开通按钮
			if (myrb.equals("1")) {
				// 前往开通 存管账户
				startActivity(new Intent(NewYinHangKaGuanLi.this,
						KaiTongCunGuanActivity.class));
			} else {
				// 前去绑定 普通账户 个人：GRKH 企业：QYKH
				if (zhlx.equals("GRKH")) {
					// 跳转到个人
				} else {
					// 跳转到企业
				}
			}
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
				Toast.makeText(NewYinHangKaGuanLi.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:
				if (cgzt.equals("S")) {
					// 如果开通，则隐藏'未开通'布局，显示存管账户界面
					layout_weikaitong.setVisibility(View.GONE);
					layout_cg.setVisibility(View.VISIBLE);
					layout_pu.setVisibility(View.GONE);

					cg_zhanghu.setText(hxzh);
					cg_kaihuren.setText(name);
					cg_kaihuhang.setText(khzh);
					if (sfbk.equals("S")) {
						cg_weibangka.setVisibility(View.GONE);
						cg_yibangka.setVisibility(View.VISIBLE);
					} else {
						cg_weibangka.setVisibility(View.VISIBLE);
						cg_yibangka.setVisibility(View.GONE);
					}

				} else {
					// 如果未开通，则隐藏存管账户界面，显示'未开通'布局
					layout_weikaitong.setVisibility(View.VISIBLE);
					layout_cg.setVisibility(View.GONE);
					layout_pu.setVisibility(View.GONE);
					tv_weikaitong.setText("立即开通");
				}
				break;
			case 2:
				Toast.makeText(NewYinHangKaGuanLi.this,
						msg.getData().getString("msg"), 1000).show();

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
		RequestThreadAbstract thread = RequestFactory.createRequestThread(103,
				map, NewYinHangKaGuanLi.this, mHandler);
		RequestPool.execute(thread);

	}

	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub
		if (map.get("urlTag").equals("1")) {
			JSONObject json = (JSONObject) jsonObj;
			try {
				JSONObject cg = json.getJSONObject("rvalue").getJSONObject(
						"cgzh");
				hxzh = cg.getString("hxzh");
				cgzt = json.getJSONObject("rvalue").getString("cgzt");
				name = cg.getString("name");
				khzh = cg.getString("khzh");
				sfbk = cg.getString("sfbk");
				JSONObject pt = json.getJSONObject("rvalue").getJSONObject(
						"ptzh");
				ptzt = json.getJSONObject("rvalue").getString("ptzt");
				yhkhh = pt.getString("yhkhh");
				khhdq = pt.getString("khhdq");
				zhlx = pt.getString("zhlx");
				yhkh = pt.getString("yhkh");
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

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
