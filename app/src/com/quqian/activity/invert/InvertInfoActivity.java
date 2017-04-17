package com.quqian.activity.invert;

import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.app.Dialog;
import android.content.Intent;
import android.os.Bundle;
import android.os.CountDownTimer;
import android.os.Handler;
import android.os.Message;
import android.text.Html;
import android.util.Log;
import android.util.TypedValue;
import android.view.Display;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.index.LiJiShenQingActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.TiYanProject;
import com.quqian.been.ZhaiQuanProject;
import com.quqian.http.API;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.TimeUtil;
import com.quqian.util.Tool;
import com.quqian.util.WebViewActivity;
import com.yintong.secure.widget.Progress;

public class InvertInfoActivity extends BaseActivity implements
		OnClickListener, HttpResponseInterface {

	// 上个页面传递过来的item 的 Pid
	private String pId = "";
	private TiYanProject allLicai = null;;

	// 预期年化收益，借款金额,借款期限，剩余可投，进度显示,推荐公司，银行存管图标,
	private TextView textView1 = null;
	private TextView textView2 = null;
	private TextView textView3 = null;
	private TextView textView4 = null;
	private TextView textView5 = null;
	private TextView textView6 = null;
	private TextView textViewlogo = null;

	//进度条
	private LinearLayout huakuai = null;
	private ProgressBar progress = null;
	
	// 还款方式，月还本息，投标限额，起息时间，剩余时间，
	private TextView textViewhuan = null;
	private TextView textViewyue = null;
	private TextView textViewtou = null;
	private TextView textViewqi = null;
	private TextView textViewsheng = null;

	// 标的详情，审核材料，投标记录，还款记录，债券记录按钮，
	private LinearLayout layout1 = null;
	private LinearLayout layout2 = null;
	private LinearLayout layout3 = null;
	private LinearLayout layout4 = null;
	private LinearLayout layout5 = null;
	// 倒计时按钮
	private Button button = null;

	// 返回过来的list集合
	List<Map<String, String>> licaiInfo_1 = null;
	List<Map<String, String>> licaiInfo_2 = null;

	private Dialog juhua = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_invertinfo;
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

		// 设置标题，从上个页面传过来
		setTitle("上市能源公司资金周转");
		showBack();

		juhua = new ProcessDialogUtil(InvertInfoActivity.this);

		textView1 = (TextView) findViewById(R.id.inert_info_tv1);
		textView2 = (TextView) findViewById(R.id.inert_info_tv2);
		textView3 = (TextView) findViewById(R.id.inert_info_tv3);
		textView4 = (TextView) findViewById(R.id.inert_info_tv4);
		textView5 = (TextView) findViewById(R.id.inert_info_tv5);
		textView5.measure(0, 0);
		textView6 = (TextView) findViewById(R.id.inert_info_tv6);
		textViewlogo = (TextView) findViewById(R.id.inert_info_img);

		huakuai = (LinearLayout) findViewById(R.id.inert_layout_huakuan);
		progress = (ProgressBar) findViewById(R.id.inert_info_progress);
		
		textViewhuan = (TextView) findViewById(R.id.inert_info_tvhuan);
		textViewyue = (TextView) findViewById(R.id.inert_info_tvyue);
		textViewtou = (TextView) findViewById(R.id.inert_info_tvtou);
		textViewqi = (TextView) findViewById(R.id.inert_info_tvqi);
		textViewsheng = (TextView) findViewById(R.id.inert_info_tvsheng);

		layout1 = (LinearLayout) findViewById(R.id.invert_layout_biao);
		layout2 = (LinearLayout) findViewById(R.id.invert_layout_shen);
		layout3 = (LinearLayout) findViewById(R.id.invert_layout_tou);
		layout4 = (LinearLayout) findViewById(R.id.invert_layout_huan);
		layout5 = (LinearLayout) findViewById(R.id.invert_layout_zhai);

		button = (Button) findViewById(R.id.invert_info_btn);

		//设置进度滑块，进图条，最大为100，
		showProgress(80);
		textView5.setText("80%");
		progress.setProgress(80);
		
		if (!"".equals(pId)) {
			// 调接口
			loadHttp();
		}
	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);

		layout1.setOnClickListener(this);
		layout2.setOnClickListener(this);
		layout3.setOnClickListener(this);
		layout4.setOnClickListener(this);
		layout5.setOnClickListener(this);

		button.setOnClickListener(this);

	}

	private void showProgress(int jindu) {
		// 屏幕的高度和宽度
		WindowManager m = getWindowManager();
		Display d = m.getDefaultDisplay();
		int width = d.getWidth();//获取当前屏幕宽度
		int a = width/100*jindu;
		int b = textView5.getMeasuredWidth()/2;
		
		//进度，滑块
		if(a>b && a<(width-b)){
			huakuai.setPadding(a-b, 0, 0, 0);
		}else if(a>(width-20)){
			huakuai.setPadding(width-b, 0, 0, 0);
		}
		
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_back:
			if (mc != null) {
				mc.cancel();
			}
			InvertInfoActivity.this.finish();
			anim_right_out();
			break;
		//立即申请界面
		case R.id.invert_info_btn:
			Intent intent = new Intent(InvertInfoActivity.this,
					LiJiShenQingActivity.class);
			intent.putExtra("pId", allLicai.getpId());
			intent.putExtra("joinlimit", allLicai.getJoinLimit());
			Log.v("quqian", "-----pid----" + allLicai.getpId());
			if (mc != null) {
				mc.cancel();
			}
			startActivity(intent);
			anim_right_in();
			break;

		//跳转到web页面，标的详情
		case R.id.invert_layout_biao:

			anim_right_in();
			break;
		//审核材料
		case R.id.invert_layout_shen:

			anim_right_in();
			break;
		//投标记录
		case R.id.invert_layout_tou:

			anim_right_in();
			break;
		//还款记录
		case R.id.invert_layout_huan:

			anim_right_in();
			break;
		//债券记录
		case R.id.invert_layout_zhai:

			anim_right_in();
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

				Toast.makeText(InvertInfoActivity.this,
						msg.getData().getString("errMsg"), 1000).show();
				button.setVisibility(View.GONE);
				break;
			case 1:
				// 停止菊花

				Map<String, String> map = juade();
				button.setText(map.get("name"));
				if (map.get("isTouch").equals("yes")) {
					button.setEnabled(true);
					// button.setBackgroundColor(getResources().getColor(
					// R.color.main_blue));
				} else {
					button.setEnabled(false);
					// button.setBackgroundColor(getResources().getColor(
					// R.color.main_gray));
				}
				if (map.get("isQidong").equals("yes")) {
					// 倒计时启动
					if (!"".equals(allLicai.getFbsj())
							&& allLicai.getFbsj() != null) {
						Log.v("--是否启动倒计时--", allLicai.getFbsj());
						try {
							mc = new MyCountDownTimer(TimeUtil.stringToLong(
									allLicai.getFbsj(), "yyyy-MM-dd HH:mm:ss")
									- System.currentTimeMillis(), 1000);
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						mc.start();
					}
				}

				break;
			case 2:
				Toast.makeText(InvertInfoActivity.this,
						msg.getData().getString("msg"), 1000).show();
				button.setVisibility(View.GONE);
				break;

			default:
				break;
			}
		}
	};

	// 备注－－标的倒计时是否显示，且是否可以点击进入
	/* 定义一个倒计时的内部类 */
	private MyCountDownTimer mc;

	class MyCountDownTimer extends CountDownTimer {

		public MyCountDownTimer(long millisInFuture, long countDownInterval) {
			super(millisInFuture, countDownInterval);
		}

		@Override
		public void onFinish() {
			button.setEnabled(true);
			mc.cancel();
		}

		@Override
		public void onTick(long millisUntilFinished) {
			button.setText(TimeUtil.strTime(millisUntilFinished));
		}
	}

	private void loadHttp() {

		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("id", pId);// 0不锁，1是锁

		RequestThreadAbstract thread = RequestFactory.createRequestThread(12,
				map, InvertInfoActivity.this, mHandler);
		RequestPool.execute(thread);

	}

	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub
		if (list.size() == 1) {
			allLicai = (TiYanProject) list.get(0);
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

	// 备注－－标的倒计时是否显示，且是否可以点击进入
	public Map<String, String> juade() {
		Map<String, String> map = new HashMap<String, String>();
		if (allLicai.getZt().equals("0")) {
			map.put("name", "");
			map.put("isTouch", "no");
			map.put("isQidong", "yes");
		} else if (allLicai.getZt().equals("1")) {
			map.put("name", "立即申请");
			map.put("isTouch", "yes");
			map.put("isQidong", "no");
		} else if (allLicai.getZt().equals("2")) {
			map.put("name", "已满额");
			map.put("isTouch", "no");
			map.put("isQidong", "no");
		} else if (allLicai.getZt().equals("3")) {
			map.put("name", "已截止");
			map.put("isTouch", "no");
			map.put("isQidong", "no");
		}
		return map;
	}

}
