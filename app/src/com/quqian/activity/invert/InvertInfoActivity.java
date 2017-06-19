package com.quqian.activity.invert;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.R.integer;
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
import android.view.ViewGroup.LayoutParams;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.LoginActivity;
import com.quqian.activity.index.IndexActivity;
import com.quqian.activity.index.LiJiShenQingActivity;
import com.quqian.activity.index.SanInfoActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.SanProject;
import com.quqian.been.TiYanProject;
import com.quqian.been.UserMode;
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
import com.yintong.secure.widget.Progress;

public class InvertInfoActivity extends BaseActivity implements
		OnClickListener, HttpResponseInterface {

	// 上个页面传递过来的item 的 Pid
	private String pId = "";
	private SanProject allSan = null;;

	// 预期年化收益，借款金额,借款期限，剩余可投，进度显示,推荐公司，银行存管图标,
	private TextView textView1 = null;
	private TextView textView2 = null;
	private TextView textView3 = null;
	private TextView textView4 = null;
	private TextView textView5 = null;
	private TextView textView6 = null;
	private TextView textViewlogo = null;

	// 进度条
	private LinearLayout huakuai = null;
	private ProgressBar progress = null;

	private LinearLayout tuijian = null;

	// 还款方式，月还本息，投标限额，起息时间，剩余时间，
	private TextView textViewhuan = null;
	private TextView textViewhuan_left = null;
	private TextView textViewyue = null;
	private TextView textViewyue_left = null;
	private TextView textViewtou = null;
	private TextView textViewtou_left = null;
	private TextView textViewqi = null;
	private TextView textViewqi_left = null;
	private TextView textViewsheng = null;
	private TextView textViewsheng_left = null;

	// 标的详情，审核材料，投标记录，还款记录，债券记录按钮，
	private LinearLayout layout2 = null;

	// 倒计时按钮
	private Button button = null;

	// 返回过来的list集合
	// 返回过来的list集合
	List<Map<String, String>> sanInfo_1 = new ArrayList<Map<String, String>>();
	List<Map<String, String>> sanInfo_2 = new ArrayList<Map<String, String>>();

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
		setTitle(getIntent().getStringExtra("title"));
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

		tuijian = (LinearLayout) findViewById(R.id.tuijian);

		huakuai = (LinearLayout) findViewById(R.id.inert_layout_huakuan);
		progress = (ProgressBar) findViewById(R.id.inert_info_progress);

		// 1
		textViewhuan = (TextView) findViewById(R.id.inert_info_tvhuan);
		textViewhuan_left = (TextView) findViewById(R.id.inert_info_tvhuan_left);

		// 2
		textViewyue = (TextView) findViewById(R.id.inert_info_tvyue);
		textViewyue_left = (TextView) findViewById(R.id.inert_info_tvyue_left);

		// 3
		textViewtou = (TextView) findViewById(R.id.inert_info_tvtou);
		textViewtou_left = (TextView) findViewById(R.id.inert_info_tvtou_left);

		// 4-忽略
		textViewqi = (TextView) findViewById(R.id.inert_info_tvqi);
		textViewqi_left = (TextView) findViewById(R.id.inert_info_tvqi_left);

		// 5
		textViewsheng = (TextView) findViewById(R.id.inert_info_tvsheng);
		textViewsheng_left = (TextView) findViewById(R.id.inert_info_tvsheng_left);

		layout2 = (LinearLayout) findViewById(R.id.sanbiaoinfo_layout2);

		button = (Button) findViewById(R.id.invert_info_btn);

		// // 设置进度滑块，进图条，最大为100，
		// showProgress(80);
		// textView5.setText("80%");
		// progress.setProgress(80);

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
		//
		// layout1.setOnClickListener(this);
		// layout2.setOnClickListener(this);
		// layout3.setOnClickListener(this);
		// layout4.setOnClickListener(this);
		// layout5.setOnClickListener(this);

		button.setOnClickListener(this);

	}

	private void showProgress(int jindu) {
		// 屏幕的高度和宽度
		WindowManager m = getWindowManager();
		Display d = m.getDefaultDisplay();
		int width = d.getWidth();// 获取当前屏幕宽度
		int a = width / 100 * jindu;
		int b = textView5.getMeasuredWidth() / 2;

		// 进度，滑块
		if (a > b && a < (width - b)) {
			huakuai.setPadding(a - b, 0, 0, 0);
		} else if (a > (width - 20)) {
			huakuai.setPadding(width - b, 0, 0, 0);
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
		// 立即投标
		case R.id.invert_info_btn:
			// 进行跳转到投标的页面
			UserMode user = Tool.getUser(InvertInfoActivity.this);
			if (user == null) {
				startActivity(new Intent(InvertInfoActivity.this,
						LoginActivity.class));
			} else {
				Intent intent = new Intent(InvertInfoActivity.this,
						LiJiTouBiaoActivity.class);
				Bundle bundle = new Bundle();
				bundle.putString("pId", allSan.getpId());
				bundle.putString("shengyu", allSan.getSyje());// 剩余金额
				bundle.putString("huankuanqixian", allSan.getHkqx());// 还款期限
				bundle.putString("nianlilv", allSan.getNll());// 年利率
				bundle.putString("jiangli", allSan.getJlll());// 奖励利率
				bundle.putString("jiekuan", allSan.getJkfs());// 借款方式
				bundle.putString("huankuanfangshi", allSan.getHkfs());// 还款方式
				bundle.putString("bdtype", allSan.getBdtype());// 标的类型
				intent.putExtras(bundle);
				startActivity(intent);
			}
			// 执行跳转
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

				sanInfo_1 = allSan.make_sanInfo_1();
				sanInfo_2 = allSan.make_sanInfo_2();
				// 设置信息
				doThing();
				// 设置立即投标按钮
				Map<String, String> map = juade();
				button.setText(map.get("name"));
				if (map.get("isTouch").equals("yes")) {
					button.setEnabled(true);
				} else {
					button.setEnabled(false);
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
		RequestThreadAbstract thread = RequestFactory.createRequestThread(9,
				map, InvertInfoActivity.this, mHandler);
		RequestPool.execute(thread);
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

	// 设置数据
	private void doThing() {
		if (allSan.getBdtype().endsWith("1")) {// 存管
			textViewlogo.setVisibility(View.VISIBLE);
		}
		textView1.setText(allSan.getNll() + "%");
		textView2.setText(allSan.show_list_one());
		textView3.setText(allSan.getJkqx());
		textView4.setText(allSan.getSyje());// 剩余可投

		String sp = "0";
		if (!allSan.getTbjd().endsWith("")) {
		}else{
			sp = allSan.getTbjd();
		}

		showProgress(Integer.valueOf(sp));
		textView5.setText(sp + "%");
		progress.setProgress(Integer.valueOf(sp));
		// progress.setProgress(Integer.valueOf(allSan.getTbjd()));// 进度条
		if (allSan.getTjf().length() == 0) {
			tuijian.setVisibility(View.GONE);
		} else {
			textView6.setText(allSan.getTjf() + " 推荐");// 公司推荐
		}
		// 开始加载信息列表
		if (sanInfo_1.size() <= 3) {
			textViewhuan.setText(sanInfo_1.get(0).get("right"));
			textViewhuan_left.setText(sanInfo_1.get(0).get("left"));

			textViewyue.setText(sanInfo_1.get(1).get("right"));
			textViewyue_left.setText(sanInfo_1.get(1).get("left"));

			textViewtou.setText(sanInfo_1.get(2).get("right"));
			textViewtou_left.setText(sanInfo_1.get(2).get("left"));

			textViewqi.setVisibility(View.GONE);
			textViewqi_left.setVisibility(View.GONE);

			textViewsheng.setVisibility(View.GONE);
			textViewsheng_left.setVisibility(View.GONE);

		} else if (sanInfo_1.size() == 4) {
			textViewhuan.setText(sanInfo_1.get(0).get("right"));
			textViewhuan_left.setText(sanInfo_1.get(0).get("left"));

			textViewyue.setText(sanInfo_1.get(1).get("right"));
			textViewyue_left.setText(sanInfo_1.get(1).get("left"));

			textViewtou.setText(sanInfo_1.get(2).get("right"));
			textViewtou_left.setText(sanInfo_1.get(2).get("left"));

			textViewqi.setVisibility(View.VISIBLE);
			textViewqi_left.setVisibility(View.VISIBLE);

			textViewqi.setText(sanInfo_1.get(3).get("right"));
			textViewqi_left.setText(sanInfo_1.get(3).get("left"));

			textViewsheng.setVisibility(View.GONE);
			textViewsheng_left.setVisibility(View.GONE);
		} else if (sanInfo_1.size() == 5) {
			textViewhuan.setText(sanInfo_1.get(0).get("right"));
			textViewhuan_left.setText(sanInfo_1.get(0).get("left"));

			textViewyue.setText(sanInfo_1.get(1).get("right"));
			textViewyue_left.setText(sanInfo_1.get(1).get("left"));

			textViewtou.setText(sanInfo_1.get(2).get("right"));
			textViewtou_left.setText(sanInfo_1.get(2).get("left"));

			textViewqi.setVisibility(View.VISIBLE);
			textViewqi_left.setVisibility(View.VISIBLE);
			textViewqi.setText(sanInfo_1.get(3).get("right"));
			textViewqi_left.setText(sanInfo_1.get(3).get("left"));

			textViewsheng.setVisibility(View.VISIBLE);
			textViewqi_left.setVisibility(View.VISIBLE);
			 
			textViewsheng.setText(sanInfo_1.get(4).get("right"));
			textViewsheng_left.setText(sanInfo_1.get(4).get("left"));
		}

		// 开始加载跳转区域
		WindowManager m = getWindowManager();
		Display d = m.getDefaultDisplay();
		for (int i = 0; i < sanInfo_2.size(); i++) {
			LinearLayout layoutH = new LinearLayout(InvertInfoActivity.this);
			layoutH.setOrientation(LinearLayout.HORIZONTAL);
			TextView textView1 = new TextView(InvertInfoActivity.this);
			textView1.setText("	" + sanInfo_2.get(i).get("left"));
			textView1.setWidth(d.getWidth() / 3);
			textView1.setHeight(TimeUtil.dip2px(InvertInfoActivity.this, 40));
			textView1.setGravity(Gravity.CENTER_VERTICAL);
			textView1.setTextSize(TypedValue.COMPLEX_UNIT_SP, 13);

			final String str1 = sanInfo_2.get(i).get("left");
			final String str2 = sanInfo_2.get(i).get("right");

			layoutH.setOnClickListener(new View.OnClickListener() {
				@Override
				public void onClick(View v) {
					// TODO Auto-generated method stub
					Intent intent = new Intent(InvertInfoActivity.this,
							MyWebViewActivity.class);
					intent.putExtra("title", str1);
					intent.putExtra("url", str2 + "&" + Tool.timechuo());
					startActivity(intent);
				}
			});
			layoutH.addView(textView1);
			layout2.addView(layoutH);

			View line = new View(InvertInfoActivity.this);
			line.setBackgroundColor(getResources().getColor(
					R.color.main_line_gray));

			if (i < sanInfo_2.size() - 1) {
				layout2.addView(line, new LayoutParams(
						LayoutParams.MATCH_PARENT, 1));
			}
		}

	}

	// private void doThing() {
	//
	// layout_mei.setVisibility(View.VISIBLE);
	//
	// tv_bdbt.setText(allSan.getBdbt());
	// tv_bdbt.setVisibility(View.VISIBLE);
	// tv_jllx.setText(allSan.getJllx());
	// tv_jllx.setVisibility(View.VISIBLE);
	//
	// List<Map<String, String>> listMap = allSan.tuBiaoList();
	// if (listMap.size() == 0) {
	// tv_layout1.setVisibility(View.GONE);
	// tv_layout1.setVisibility(View.GONE);
	// } else if (listMap.size() == 1) {
	// Map<String, String> a = listMap.get(0);
	// tv_11.setText(a.get("sx"));
	// tv_12.setText(a.get("xq"));
	// tv_layout1.setVisibility(View.VISIBLE);
	// tv_layout2.setVisibility(View.GONE);
	// } else if (listMap.size() == 2) {
	// Map<String, String> a = listMap.get(0);
	// Map<String, String> a1 = listMap.get(1);
	// tv_11.setText(a.get("sx"));
	// tv_12.setText(a.get("xq"));
	//
	// tv_21.setText(a1.get("sx"));
	// tv_22.setText(a1.get("xq"));
	//
	// tv_layout1.setVisibility(View.VISIBLE);
	// tv_layout2.setVisibility(View.VISIBLE);
	// }
	//
	// // 屏幕的高度和宽度
	// WindowManager m = getWindowManager();
	// Display d = m.getDefaultDisplay();
	//
	// for (int i = 0; i < sanInfo_1.size(); i++) {
	//
	// LinearLayout layoutH = new LinearLayout(SanInfoActivity.this);
	// layoutH.setOrientation(LinearLayout.HORIZONTAL);
	// TextView textView1 = new TextView(SanInfoActivity.this);
	// textView1.setText(sanInfo_1.get(i).get("left"));
	// textView1.setWidth(d.getWidth() / 3);
	// textView1.setHeight(TimeUtil.dip2px(SanInfoActivity.this, 30));
	// textView1.setGravity(Gravity.CENTER_VERTICAL);
	// textView1.setTextSize(TypedValue.COMPLEX_UNIT_SP, 12);
	// textView1.setPadding(TimeUtil.dip2px(SanInfoActivity.this, 15), 0,
	// 0, 0);
	//
	// layoutH.addView(textView1);
	//
	// TextView textView2 = new TextView(SanInfoActivity.this);
	// textView2.setHeight(TimeUtil.dip2px(SanInfoActivity.this, 30));
	// textView2.setGravity(Gravity.CENTER);
	// textView2.setPadding(0, 0,
	// TimeUtil.dip2px(SanInfoActivity.this, 15), 0);
	//
	// ProgressBar pbar = new ProgressBar(SanInfoActivity.this, null,
	// android.R.attr.progressBarStyleHorizontal);
	// if ("投标进度".equals(sanInfo_1.get(i).get("left"))) {
	// pbar.setProgress(Integer.valueOf(sanInfo_1.get(i).get("right")));
	// textView2.setText(sanInfo_1.get(i).get("right") + "%");
	// textView2.setPadding(TimeUtil.dip2px(SanInfoActivity.this, 15),
	// 0, TimeUtil.dip2px(SanInfoActivity.this, 15), 0);
	// layoutH.addView(
	// pbar,
	// new LayoutParams(TimeUtil.dip2px(SanInfoActivity.this,
	// 150), LayoutParams.WRAP_CONTENT));
	// layoutH.setGravity(Gravity.CENTER_VERTICAL);
	// layoutH.addView(textView2);
	// } else {
	// textView2.setText(Html.fromHtml(sanInfo_1.get(i).get("right")));
	// textView2.setTextSize(TypedValue.COMPLEX_UNIT_SP, 12);
	// layoutH.addView(textView2);
	// }
	//
	// layout1.addView(layoutH);
	// }
	//
	// layout2.setPadding(TimeUtil.dip2px(SanInfoActivity.this, 15), 0, 0, 0);
	// for (int i = 0; i < sanInfo_2.size(); i++) {
	//
	// LinearLayout layoutH = new LinearLayout(SanInfoActivity.this);
	// layoutH.setOrientation(LinearLayout.HORIZONTAL);
	// TextView textView1 = new TextView(SanInfoActivity.this);
	// textView1.setText(sanInfo_2.get(i).get("left"));
	// textView1.setWidth(d.getWidth() / 3);
	// textView1.setHeight(TimeUtil.dip2px(SanInfoActivity.this, 40));
	// textView1.setGravity(Gravity.CENTER_VERTICAL);
	// textView1.setTextSize(TypedValue.COMPLEX_UNIT_SP, 12);
	//
	// final String str1 = sanInfo_2.get(i).get("left");
	// final String str2 = sanInfo_2.get(i).get("right");
	//
	// layoutH.setOnClickListener(new View.OnClickListener() {
	//
	// @Override
	// public void onClick(View v) {
	// // TODO Auto-generated method stub
	// Intent intent = new Intent(SanInfoActivity.this,
	// MyWebViewActivity.class);
	// intent.putExtra("title", str1);
	// intent.putExtra("url", str2 + "&" + Tool.timechuo());
	// startActivity(intent);
	// }
	// });
	// layoutH.addView(textView1);
	// layout2.addView(layoutH);
	//
	// View line = new View(SanInfoActivity.this);
	// line.setBackgroundColor(getResources().getColor(
	// R.color.main_line_gray));
	//
	// if (i < sanInfo_2.size() - 1) {
	// layout2.addView(line, new LayoutParams(
	// LayoutParams.MATCH_PARENT, 1));
	// }
	// }
	//
	// }

}
