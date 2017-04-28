package com.quqian.activity.index;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.R.layout;
import android.annotation.SuppressLint;
import android.app.Dialog;
import android.content.Intent;
import android.graphics.Color;
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
import android.view.View.OnClickListener;
import android.view.ViewGroup.LayoutParams;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.invert.LiJiTouBiaoActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.SanProject;
import com.quqian.been.Test;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.TimeUtil;
import com.quqian.util.Tool;
import com.quqian.util.MyWebViewActivity;

public class SanInfoActivity extends BaseActivity implements OnClickListener,
		HttpResponseInterface {

	// 上个页面传递过来的item 的 Pid
	private String pId = "";
	private SanProject allSan = null;;

	// tv标的标题
	private TextView tv_bdbt = null;
	// 奖励类型
	private TextView tv_jllx = null;

	// TextView布局块，
	private LinearLayout tv_layout1 = null;
	private TextView tv_11 = null;
	private TextView tv_12 = null;

	private LinearLayout tv_layout2 = null;
	private TextView tv_21 = null;
	private TextView tv_22 = null;

	// 动态添加的布局块
	private LinearLayout layout1 = null;
	private LinearLayout layout2 = null;

	// 倒计时按钮
	private Button button = null;

	// 上半部分的布局加载隐藏
	private LinearLayout layout_mei = null;

	// 返回过来的list集合
	List<Map<String, String>> sanInfo_1 = new ArrayList<Map<String, String>>();
	List<Map<String, String>> sanInfo_2 = new ArrayList<Map<String, String>>();

	private Dialog juhua = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_index_sanbiaoinfo;
	}

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();

		Bundle bundle = getIntent().getExtras();
		if (bundle != null) {
			// allSan = (SanProject) bundle
			// .getSerializable("sanProject");
			pId = bundle.getString("pId");
		}

	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("借款详情");
		showBack();

		juhua = new ProcessDialogUtil(SanInfoActivity.this);

		tv_bdbt = (TextView) findViewById(R.id.sanbiaoinfo_tv1);
		tv_jllx = (TextView) findViewById(R.id.sanbiaoinfo_tv2);

		tv_layout1 = (LinearLayout) findViewById(R.id.sanbiaoinfo_l1);
		tv_11 = (TextView) findViewById(R.id.sanbiaoinfo_tv11);
		tv_12 = (TextView) findViewById(R.id.sanbiaoinfo_tv12);

		tv_layout2 = (LinearLayout) findViewById(R.id.sanbiaoinfo_l2);
		tv_21 = (TextView) findViewById(R.id.sanbiaoinfo_tv21);
		tv_22 = (TextView) findViewById(R.id.sanbiaoinfo_tv22);

		layout1 = (LinearLayout) findViewById(R.id.sanbiaoinfo_layout1);
		layout2 = (LinearLayout) findViewById(R.id.sanbiaoinfo_layout2);

		button = (Button) findViewById(R.id.sanbiaoinfo_btn);

		layout_mei = (LinearLayout) findViewById(R.id.sanbiao_mei_layout);

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
		button.setOnClickListener(this);

	}

	private void doThing() {

		layout_mei.setVisibility(View.VISIBLE);

		tv_bdbt.setText(allSan.getBdbt());
		tv_bdbt.setVisibility(View.VISIBLE);
		tv_jllx.setText(allSan.getJllx());
		tv_jllx.setVisibility(View.VISIBLE);

		List<Map<String, String>> listMap = allSan.tuBiaoList();
		if (listMap.size() == 0) {
			tv_layout1.setVisibility(View.GONE);
			tv_layout1.setVisibility(View.GONE);
		} else if (listMap.size() == 1) {
			Map<String, String> a = listMap.get(0);
			tv_11.setText(a.get("sx"));
			tv_12.setText(a.get("xq"));
			tv_layout1.setVisibility(View.VISIBLE);
			tv_layout2.setVisibility(View.GONE);
		} else if (listMap.size() == 2) {
			Map<String, String> a = listMap.get(0);
			Map<String, String> a1 = listMap.get(1);
			tv_11.setText(a.get("sx"));
			tv_12.setText(a.get("xq"));

			tv_21.setText(a1.get("sx"));
			tv_22.setText(a1.get("xq"));

			tv_layout1.setVisibility(View.VISIBLE);
			tv_layout2.setVisibility(View.VISIBLE);
		}

		// 屏幕的高度和宽度
		WindowManager m = getWindowManager();
		Display d = m.getDefaultDisplay();

		for (int i = 0; i < sanInfo_1.size(); i++) {

			LinearLayout layoutH = new LinearLayout(SanInfoActivity.this);
			layoutH.setOrientation(LinearLayout.HORIZONTAL);
			TextView textView1 = new TextView(SanInfoActivity.this);
			textView1.setText(sanInfo_1.get(i).get("left"));
			textView1.setWidth(d.getWidth() / 3);
			textView1.setHeight(TimeUtil.dip2px(SanInfoActivity.this, 30));
			textView1.setGravity(Gravity.CENTER_VERTICAL);
			textView1.setTextSize(TypedValue.COMPLEX_UNIT_SP, 12);
			textView1.setPadding(TimeUtil.dip2px(SanInfoActivity.this, 15), 0,
					0, 0);

			layoutH.addView(textView1);

			TextView textView2 = new TextView(SanInfoActivity.this);
			textView2.setHeight(TimeUtil.dip2px(SanInfoActivity.this, 30));
			textView2.setGravity(Gravity.CENTER);
			textView2.setPadding(0, 0,
					TimeUtil.dip2px(SanInfoActivity.this, 15), 0);

			ProgressBar pbar = new ProgressBar(SanInfoActivity.this, null,
					android.R.attr.progressBarStyleHorizontal);
			if ("投标进度".equals(sanInfo_1.get(i).get("left"))) {
				pbar.setProgress(Integer.valueOf(sanInfo_1.get(i).get("right")));
				textView2.setText(sanInfo_1.get(i).get("right") + "%");
				textView2.setPadding(TimeUtil.dip2px(SanInfoActivity.this, 15),
						0, TimeUtil.dip2px(SanInfoActivity.this, 15), 0);
				layoutH.addView(pbar, new LayoutParams(TimeUtil.dip2px(SanInfoActivity.this, 150),
						LayoutParams.WRAP_CONTENT));
				layoutH.setGravity(Gravity.CENTER_VERTICAL);
				layoutH.addView(textView2);
			} else {
				textView2.setText(Html.fromHtml(sanInfo_1.get(i).get("right")));
				textView2.setTextSize(TypedValue.COMPLEX_UNIT_SP, 12);
				layoutH.addView(textView2);
			}

			layout1.addView(layoutH);
		}

		layout2.setPadding(TimeUtil.dip2px(SanInfoActivity.this, 15), 0, 0, 0);
		for (int i = 0; i < sanInfo_2.size(); i++) {

			LinearLayout layoutH = new LinearLayout(SanInfoActivity.this);
			layoutH.setOrientation(LinearLayout.HORIZONTAL);
			TextView textView1 = new TextView(SanInfoActivity.this);
			textView1.setText(sanInfo_2.get(i).get("left"));
			textView1.setWidth(d.getWidth() / 3);
			textView1.setHeight(TimeUtil.dip2px(SanInfoActivity.this, 40));
			textView1.setGravity(Gravity.CENTER_VERTICAL);
			textView1.setTextSize(TypedValue.COMPLEX_UNIT_SP, 12);

			final String str1 = sanInfo_2.get(i).get("left");
			final String str2 = sanInfo_2.get(i).get("right");

			layoutH.setOnClickListener(new View.OnClickListener() {

				@Override
				public void onClick(View v) {
					// TODO Auto-generated method stub
					Intent intent = new Intent(SanInfoActivity.this,
							MyWebViewActivity.class);
					intent.putExtra("title", str1);
					intent.putExtra("url", str2+"&"+Tool.timechuo());
					startActivity(intent);
				}
			});
			layoutH.addView(textView1);
			layout2.addView(layoutH);

			View line = new View(SanInfoActivity.this);
			line.setBackgroundColor(getResources().getColor(
					R.color.main_line_gray));

			if (i < sanInfo_2.size() - 1) {
				layout2.addView(line, new LayoutParams(
						LayoutParams.MATCH_PARENT, 1));
			}
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
			finish();
			anim_right_out();
			break;

		case R.id.sanbiaoinfo_btn:
			Intent intent = new Intent(SanInfoActivity.this,
					LiJiTouBiaoActivity.class);
			Bundle bundle = new Bundle();
			// bundle.putSerializable("sanProject", allSan);
			bundle.putString("pId", pId);
			// bundle.putString("shengyu", allSan.getSyje());//剩余金额
			// bundle.putString("huankuanqixian", allSan.getHkqx());//还款期限
			// bundle.putString("nianlilv", allSan.getNll());//年利率
			// bundle.putString("jiangli", allSan.getJlll());//奖励利率
			// bundle.putString("jiekuan", allSan.getJkfs());//借款方式
			// bundle.putString("huankuanfangshi", allSan.getHkfs());//还款方式

			intent.putExtras(bundle);
			startActivity(intent);
			if (mc != null) {
				mc.cancel();
			}
			anim_right_in();
			break;

		default:
			break;
		}
	}

	private void loadHttp() {

		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("id", pId);// 0不锁，1是锁

		RequestThreadAbstract thread = RequestFactory.createRequestThread(9,
				map, SanInfoActivity.this, mHandler);
		RequestPool.execute(thread);

	}

	@SuppressLint("ResourceAsColor")
	private Handler mHandler = new Handler() {

		@SuppressLint("ResourceAsColor")
		@Override
		public void handleMessage(Message msg) {
			// TODO Auto-generated method stub
			super.handleMessage(msg);

			juhua.cancel();

			switch (msg.what) {
			case 0:

				Toast.makeText(SanInfoActivity.this,
						msg.getData().getString("errMsg"), 1000).show();
				button.setVisibility(View.GONE);
				break;
			case 1:
				// 停止菊花

				sanInfo_1 = allSan.make_sanInfo_1();
				sanInfo_2 = allSan.make_sanInfo_2();
				// 设置信息
				doThing();
				// 设置立即投标按钮
				Map<String, String> map = juade();
				button.setText(map.get("name"));
				if (map.get("isTouch").equals("yes")) {
					button.setEnabled(true);
					// button.setBackgroundColor(R.color.main_blue);
				} else {
					button.setEnabled(false);
					// button.setBackgroundColor(R.color.main_gray);
				}
				if (map.get("isQidong").equals("yes")) {
					// 启动倒计时
					if (!"".equals(allSan.getFbsj())
							&& allSan.getFbsj() != null) {
						Log.v("--是否启动倒计时--", allSan.getFbsj());
						try {
							mc = new MyCountDownTimer(TimeUtil.stringToLong(
									allSan.getFbsj(), "yyyy-MM-dd HH:mm:ss")
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
				Toast.makeText(SanInfoActivity.this,
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

	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub
		if (list.size() == 1) {
			allSan = (SanProject) list.get(0);
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
		if (allSan.getZt().equals("预售中")) {
			map.put("isTouch", "no");
			map.put("isQidong", "yes");
		} else if (allSan.getZt().equals("立即投标")) {
			map.put("isTouch", "yes");
			map.put("isQidong", "no");
		} else if (allSan.getZt().equals("敬请期待")) {
			map.put("isTouch", "no");
			map.put("isQidong", "yes");
		} else {
			map.put("isTouch", "no");
			map.put("isQidong", "no");
		}
		map.put("name", allSan.getZt());
		return map;
	}

}
