package com.quqian.activity.index;

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
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.index.SanInfoActivity.MyCountDownTimer;
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
import com.quqian.util.MyWebViewActivity;

public class LiCaiInfoActivity extends BaseActivity implements OnClickListener,
		HttpResponseInterface {

	// 上个页面传递过来的item 的 Pid
	private String pId = "";
	private TiYanProject allLicai = null;;

	// tv标题
	private TextView tv_bdbt = null;

	// 动态添加的布局块
	private LinearLayout layout1 = null;
	private LinearLayout layout2 = null;

	// 倒计时按钮
	private Button button = null;

	// 返回过来的list集合
	List<Map<String, String>> licaiInfo_1 = null;
	List<Map<String, String>> licaiInfo_2 = null;

	// 加载隐藏
	private TextView meiyou_tv = null;
	private LinearLayout meiyou_layou = null;

	private Dialog juhua = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_index_licaiinfo;
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
		setTitle("理财体验详情");
		showBack();

		juhua = new ProcessDialogUtil(LiCaiInfoActivity.this);

		tv_bdbt = (TextView) findViewById(R.id.licaiinfo_tv1);

		layout1 = (LinearLayout) findViewById(R.id.licaiinfo_layout1);
		layout2 = (LinearLayout) findViewById(R.id.licaiinfo_layout2);

		button = (Button) findViewById(R.id.licaiinfo_btn);

		meiyou_tv = (TextView) findViewById(R.id.licai_meiyou_tv);
		meiyou_layou = (LinearLayout) findViewById(R.id.licai_meiyou_layout);

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

		meiyou_layou.setVisibility(View.VISIBLE);
		meiyou_tv.setVisibility(View.VISIBLE);

		tv_bdbt.setText(allLicai.getBt());

		// 屏幕的高度和宽度
		WindowManager m = getWindowManager();
		Display d = m.getDefaultDisplay();

		for (int i = 0; i < licaiInfo_1.size(); i++) {

			LinearLayout layoutH = new LinearLayout(LiCaiInfoActivity.this);
			layoutH.setOrientation(LinearLayout.HORIZONTAL);
			TextView textView1 = new TextView(LiCaiInfoActivity.this);
			textView1.setText(licaiInfo_1.get(i).get("left"));
			textView1.setWidth(d.getWidth() / 3);
			textView1.setHeight(TimeUtil.dip2px(LiCaiInfoActivity.this, 30));
			textView1.setGravity(Gravity.CENTER_VERTICAL);
			textView1.setTextSize(TypedValue.COMPLEX_UNIT_SP, 12);
			textView1.setPadding(TimeUtil.dip2px(LiCaiInfoActivity.this, 15),
					0, 0, 0);

			layoutH.addView(textView1);

			if ("理财说明".equals(licaiInfo_1.get(i).get("left"))) {
				TextView textView2 = new TextView(LiCaiInfoActivity.this);
				textView2.setHeight(TimeUtil.dip2px(LiCaiInfoActivity.this, 30));
				textView2.setGravity(Gravity.CENTER);
				textView2.setPadding(0, 0,
						TimeUtil.dip2px(LiCaiInfoActivity.this, 15), 0);
				textView2.setText(Html
						.fromHtml(licaiInfo_1.get(i).get("right")));
				textView2.setTextSize(TypedValue.COMPLEX_UNIT_SP, 12);
				textView2.setTextColor(getResources().getColor(
						R.color.main_orange));
				textView2.setOnClickListener(new OnClickListener() {

					@Override
					public void onClick(View v) {
						// TODO Auto-generated method stub
						Intent intent = new Intent(LiCaiInfoActivity.this,
								MyWebViewActivity.class);
						intent.putExtra("title", "理财体验说明书");
						intent.putExtra("url", allLicai.getLcsm_url()+"&"+Tool.timechuo());
						startActivity(intent);
					}
				});
				layoutH.addView(textView2);

			} else {
				TextView textView2 = new TextView(LiCaiInfoActivity.this);
				textView2.setHeight(TimeUtil.dip2px(LiCaiInfoActivity.this, 30));
				textView2.setGravity(Gravity.CENTER);
				textView2.setPadding(0, 0,
						TimeUtil.dip2px(LiCaiInfoActivity.this, 15), 0);
				textView2.setText(Html
						.fromHtml(licaiInfo_1.get(i).get("right")));
				textView2.setTextSize(TypedValue.COMPLEX_UNIT_SP, 12);
				textView2.setTextColor(getResources().getColor(
						R.color.main_text_black));
				layoutH.addView(textView2);

			}

			layout1.addView(layoutH);
		}
		for (int i = 0; i < licaiInfo_2.size(); i++) {

			LinearLayout layoutH = new LinearLayout(LiCaiInfoActivity.this);
			layoutH.setOrientation(LinearLayout.HORIZONTAL);
			TextView textView1 = new TextView(LiCaiInfoActivity.this);
			textView1.setText(licaiInfo_2.get(i).get("left"));
			textView1.setWidth(d.getWidth() / 3);
			
			textView1.setGravity(Gravity.CENTER_VERTICAL);
			textView1.setTextSize(TypedValue.COMPLEX_UNIT_SP, 12);
			textView1.setPadding(TimeUtil.dip2px(LiCaiInfoActivity.this, 15),
					TimeUtil.dip2px(LiCaiInfoActivity.this, 15), 0,
					TimeUtil.dip2px(LiCaiInfoActivity.this, 15));

			// layoutH.addView(textView1);

			TextView textView2 = new TextView(LiCaiInfoActivity.this);

			textView2.setGravity(Gravity.LEFT);
			textView2.setPadding(TimeUtil.dip2px(LiCaiInfoActivity.this, 15),
					TimeUtil.dip2px(LiCaiInfoActivity.this, 15),
					TimeUtil.dip2px(LiCaiInfoActivity.this, 15),
					TimeUtil.dip2px(LiCaiInfoActivity.this, 15));
			textView2.setText(Html.fromHtml(licaiInfo_2.get(i).get("right")));
			textView2.setTextSize(TypedValue.COMPLEX_UNIT_SP, 12);
			layoutH.addView(textView2);

			layout2.addView(layoutH);
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
			LiCaiInfoActivity.this.finish();
			anim_right_out();
			break;

		case R.id.licaiinfo_btn:
			Intent intent = new Intent(LiCaiInfoActivity.this,
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

				Toast.makeText(LiCaiInfoActivity.this,
						msg.getData().getString("errMsg"), 1000).show();
				button.setVisibility(View.GONE);
				break;
			case 1:
				// 停止菊花
				licaiInfo_1 = allLicai.make_sanInfo_1();
				licaiInfo_2 = allLicai.make_sanInfo_2();
				doThing();

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
				Toast.makeText(LiCaiInfoActivity.this,
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
				map, LiCaiInfoActivity.this, mHandler);
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
