package com.quqian.activity.index;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.R.layout;
import android.app.Dialog;
import android.content.Intent;
import android.os.Bundle;
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
import com.quqian.base.BaseActivity;
import com.quqian.been.SanProject;
import com.quqian.been.ZhaiQuanProject;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.TimeUtil;
import com.quqian.util.Tool;
import com.quqian.util.MyWebViewActivity;

public class ZhaiInfoActivity extends BaseActivity implements OnClickListener,
		HttpResponseInterface {

	// 上个页面传递过来的item 的 Pid
	private String pId = "";
	private ZhaiQuanProject allZhai = null;;

	// tv标题
	private TextView tv_bdbt = null;
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
	private LinearLayout layout3 = null;

	// 倒计时按钮
	private Button button = null;

	// 加载的时候隐藏上半部分的布局
	private LinearLayout layout_shang = null;
	private TextView meiyou1 = null;
	private TextView meiyou2 = null;
	private TextView meiyou3 = null;

	// 返回过来的list集合
	List<Map<String, String>> zhaiInfo_1 = new ArrayList<Map<String, String>>();
	List<Map<String, String>> zhaiInfo_2 = new ArrayList<Map<String, String>>();
	List<Map<String, String>> zhaiInfo_3 = new ArrayList<Map<String, String>>();

	private Dialog juhua = null;
	
	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_index_zhaiquaninfo;
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
		setTitle("债权详情");
		showBack();

		juhua = new ProcessDialogUtil(ZhaiInfoActivity.this);
		
		tv_bdbt = (TextView) findViewById(R.id.zhaiinfo_tv1);
		tv_jllx = (TextView) findViewById(R.id.zhaiinfo_tv2);
		
		tv_layout1 = (LinearLayout) findViewById(R.id.zhaiinfo_l1);
		tv_11 = (TextView) findViewById(R.id.zhaiinfo_tv11);
		tv_12 = (TextView) findViewById(R.id.zhaiinfo_tv12);

		tv_layout2 = (LinearLayout) findViewById(R.id.zhaiinfo_l2);
		tv_21 = (TextView) findViewById(R.id.zhaiinfo_tv21);
		tv_22 = (TextView) findViewById(R.id.zhaiinfo_tv22);

		layout1 = (LinearLayout) findViewById(R.id.zhaiinfo_layout1);
		layout2 = (LinearLayout) findViewById(R.id.zhaiinfo_layout2);
		layout3 = (LinearLayout) findViewById(R.id.zhaiinfo_layout3);

		button = (Button) findViewById(R.id.zhaiinfo_btn);

		layout_shang = (LinearLayout) findViewById(R.id.zhaiquanzhuanrang_mei_layout);
		meiyou1 = (TextView) findViewById(R.id.zhaiquan_meiyou_tv1);
		meiyou2 = (TextView) findViewById(R.id.zhaiquan_meiyou_tv2);
		meiyou3 = (TextView) findViewById(R.id.zhaiquan_meiyou_tv3);
		
		// 调接口
		loadHttp();
	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);
		button.setOnClickListener(this);

	}

	protected void doThing() {

		layout_shang.setVisibility(View.VISIBLE);
		meiyou1.setVisibility(View.VISIBLE);
		meiyou2.setVisibility(View.VISIBLE);
		meiyou3.setVisibility(View.VISIBLE);
		
		tv_bdbt.setText(allZhai.bddx);
		tv_jllx.setText(allZhai.san_bddx.getJllx());

		List<Map<String, String>> listMap = allZhai.san_bddx.tuBiaoList();
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

		for (int i = 0; i < zhaiInfo_1.size(); i++) {

			LinearLayout layoutH = new LinearLayout(ZhaiInfoActivity.this);
			layoutH.setOrientation(LinearLayout.HORIZONTAL);
			TextView textView1 = new TextView(ZhaiInfoActivity.this);
			textView1.setText(zhaiInfo_1.get(i).get("left"));
			textView1.setWidth(d.getWidth() / 3);
			textView1.setHeight(TimeUtil.dip2px(ZhaiInfoActivity.this, 30));
			textView1.setGravity(Gravity.CENTER_VERTICAL);
			textView1.setTextSize(TypedValue.COMPLEX_UNIT_SP,12);
			textView1.setPadding(TimeUtil.dip2px(ZhaiInfoActivity.this, 15), 0, 0, 0);

			layoutH.addView(textView1);

			TextView textView2 = new TextView(ZhaiInfoActivity.this);
			textView2.setHeight(TimeUtil.dip2px(ZhaiInfoActivity.this, 30));
			textView2.setGravity(Gravity.CENTER);
			textView2.setPadding(0, 0, TimeUtil.dip2px(ZhaiInfoActivity.this, 15), 0);
			textView2.setText(Html.fromHtml(zhaiInfo_1.get(i).get("right")));
			textView2.setTextSize(TypedValue.COMPLEX_UNIT_SP,12);
			layoutH.addView(textView2);

			layout1.addView(layoutH);
		}
		
		for (int i = 0; i < zhaiInfo_2.size(); i++) {

			LinearLayout layoutH = new LinearLayout(ZhaiInfoActivity.this);
			layoutH.setOrientation(LinearLayout.HORIZONTAL);
			TextView textView1 = new TextView(ZhaiInfoActivity.this);
			textView1.setText(zhaiInfo_2.get(i).get("left"));
			textView1.setWidth(d.getWidth() / 3);
			textView1.setHeight(TimeUtil.dip2px(ZhaiInfoActivity.this, 30));
			textView1.setGravity(Gravity.CENTER_VERTICAL);
			textView1.setTextSize(TypedValue.COMPLEX_UNIT_SP,12);
			textView1.setPadding(TimeUtil.dip2px(ZhaiInfoActivity.this, 15), 0, 0, 0);

			layoutH.addView(textView1);

			TextView textView2 = new TextView(ZhaiInfoActivity.this);
			textView2.setHeight(TimeUtil.dip2px(ZhaiInfoActivity.this, 30));
			textView2.setGravity(Gravity.CENTER);
			textView2.setPadding(0, 0, TimeUtil.dip2px(ZhaiInfoActivity.this, 15), 0);
			textView2.setText(Html.fromHtml(zhaiInfo_2.get(i).get("right")));
			textView2.setTextSize(TypedValue.COMPLEX_UNIT_SP,12);
			layoutH.addView(textView2);

			layout2.addView(layoutH);
		}
		
		layout3.setPadding(TimeUtil.dip2px(ZhaiInfoActivity.this, 15), 0, 0, 0);
		for (int i = 0; i < zhaiInfo_3.size(); i++) {

			LinearLayout layoutH = new LinearLayout(ZhaiInfoActivity.this);
			layoutH.setOrientation(LinearLayout.HORIZONTAL);
			TextView textView1 = new TextView(ZhaiInfoActivity.this);
			textView1.setText(zhaiInfo_3.get(i).get("left"));
			textView1.setWidth(d.getWidth() / 3);
			textView1.setHeight(TimeUtil.dip2px(ZhaiInfoActivity.this, 40));
			textView1.setGravity(Gravity.CENTER_VERTICAL);
			textView1.setTextSize(TypedValue.COMPLEX_UNIT_SP,12);

			final String str1 = zhaiInfo_3.get(i).get("left");
			final String str2 = zhaiInfo_3.get(i).get("right");
			
			layoutH.addView(textView1);
			layoutH.setOnClickListener(new View.OnClickListener() {
				
				@Override
				public void onClick(View v) {
					// TODO Auto-generated method stub
					Intent intent = new Intent(ZhaiInfoActivity.this,MyWebViewActivity.class);
					intent.putExtra("title",str1 );
					intent.putExtra("url", str2+"&"+Tool.timechuo());
					startActivity(intent);
				}
			});
			
			layout3.addView(layoutH);
			View line = new View(ZhaiInfoActivity.this);
			line.setBackgroundColor(getResources().getColor(R.color.main_line_gray));
			
			if(i<zhaiInfo_3.size()-1){
				layout3.addView(line,new LayoutParams(LayoutParams.MATCH_PARENT,1));
			}
		}
		
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_back:
			ZhaiInfoActivity.this.finish();
			anim_right_out();
			break;

		case R.id.zhaiinfo_btn:
			Intent intent = new Intent(ZhaiInfoActivity.this,
					LiJiGouMaiActivity.class);
			intent.putExtra("pId", pId);
			intent.putExtra("pId", allZhai.getpId());
			intent.putExtra("shengyu", allZhai.getSyfs());
			intent.putExtra("goumai", allZhai.getGmzx());
			intent.putExtra("daishou", allZhai.getDsbx());
			intent.putExtra("zhuanrang", allZhai.getZqjg());
			
			Log.v("quqian", "-----pid----" + pId);
			startActivity(intent);
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

		RequestThreadAbstract thread = RequestFactory.createRequestThread(17,
				map, ZhaiInfoActivity.this, mHandler);
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

				Toast.makeText(ZhaiInfoActivity.this,
						msg.getData().getString("errMsg"), 1000).show();
				button.setVisibility(View.GONE);

				break;
			case 1:
				// 停止菊花
				zhaiInfo_1 = allZhai.make_sanInfo_1();
				zhaiInfo_2 = allZhai.san_bddx.make_sanInfo_1();
				zhaiInfo_3 = allZhai.san_bddx.make_sanInfo_2();
				doThing();
				break;
			case 2:
				Toast.makeText(ZhaiInfoActivity.this,
						msg.getData().getString("msg"), 1000).show();
				button.setVisibility(View.GONE);
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
		if (list.size() == 1) {
			allZhai = (ZhaiQuanProject) list.get(0);
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
