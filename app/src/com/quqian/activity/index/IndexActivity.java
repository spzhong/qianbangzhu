package com.quqian.activity.index;

import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.R.integer;
import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;
import android.support.v4.view.ViewPager;
import android.support.v4.view.ViewPager.OnPageChangeListener;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Toast;
import android.widget.LinearLayout.LayoutParams;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.example.quqian.R;
import com.loopj.android.image.SmartImageView;
import com.quqian.activity.LoginActivity;
import com.quqian.activity.MainActivity;
import com.quqian.activity.RegisterActivity;
import com.quqian.activity.YanZhengShouJiActivity;
import com.quqian.activity.index.xin.WoYaoJieKuan;
import com.quqian.activity.index.xin.WuYouCunZhengOne;
import com.quqian.activity.index.xin.YinHangCunGuanOne;
import com.quqian.activity.index.xin.YunYingShuJu;
import com.quqian.activity.mine.ZiJinGuanLiActivity;
import com.quqian.activity.more.MoreActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.TiYanProject;
import com.quqian.been.UserMode;
import com.quqian.http.API;
import com.quqian.http.Http;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.BitmapUtil;
import com.quqian.util.CommonUtil;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.StaticVariable;
import com.quqian.util.TimeUtil;
import com.quqian.util.Tool;
import com.quqian.util.MyWebViewActivity;

public class IndexActivity extends BaseActivity implements OnClickListener,
		HttpResponseInterface {

	// 引导图片
	// private static final int[] resource = new int[] { R.drawable.pic6,
	// R.drawable.pic7, R.drawable.pic5, R.drawable.pic8 };
	private ImageView[] dotImage;

	//运营数据布局按钮
	private LinearLayout yunyingshuju = null;
	private LinearLayout yinhangcunguan = null;
	private LinearLayout wuyoucunzheng = null;
	
	// 精选理财布局按钮
	private RelativeLayout jingxuanlicai = null;
	// 存管理财布局按钮
	private RelativeLayout cunguanlicai = null;
	// 我要借款布局按钮
	private RelativeLayout woyaojiekuan = null;


	// 读取登录状态 ，loginState = login.
	private Boolean loginState = false;
	private UserMode user = null;

	private Dialog juhua = null;

	// 图片地址集合
	private List<String> imageList = null;
	// url地址集合
	private List<String> urlList = null;
	private List<String> urlTitle = null;
	// jsonObj
	private JSONObject json = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_index;
	}

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
		// if ("login".equals(CommonUtil.getStringByKey(IndexActivity.this,
		// "loginState", "", ""))) {
		// loginState = true;
		// }
	}

	@Override
	protected void onResume() {
		// TODO Auto-generated method stub
		super.onResume();
		// if ("login".equals(CommonUtil.getStringByKey(IndexActivity.this,
		// "loginState", "", ""))) {
		// }

	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("钱帮主");

		juhua = new ProcessDialogUtil(IndexActivity.this);

		imageList = new ArrayList<String>();
		urlList = new ArrayList<String>();
		urlTitle = new ArrayList<String>();

		// 判断用户
		user = Tool.getUser(IndexActivity.this);
		if (user == null) {
			loginState = false;
		} else {
			loginState = true;
		}
	
		//运营数据
		yunyingshuju = (LinearLayout) findViewById(R.id.index_layout_yunyingshuju);
		//运营数据
		yinhangcunguan = (LinearLayout) findViewById(R.id.index_layout_yinhangchunguan);
		//运营数据
		wuyoucunzheng = (LinearLayout) findViewById(R.id.index_layout_wuyoucunzheng);
		
		//精选理财
		jingxuanlicai = (RelativeLayout) findViewById(R.id.index_layout_jingxuanlicai);
		//存管理财
		cunguanlicai = (RelativeLayout)findViewById(R.id.index_layout_cunguanlicai);
		//我要借款
		woyaojiekuan = (RelativeLayout) findViewById(R.id.index_layout_woyaojiekuan);
		

		// 获取广告条信息
		loadHttp_bannerInfo();
		// 获取个人资料信息
		// loadHttp_info();
 
		// 接受广播
//		BroadcastReceiver mBroadcastReceiver = new BroadcastReceiver() {
//			@Override
//			public void onReceive(Context arg0, Intent arg1) {
//				// Intent intent = getIntent();
//				user = Tool.getUser(IndexActivity.this);
//			}
//		};
//		IntentFilter intentFilter = new IntentFilter();
//		intentFilter.addAction("dengluhoushuaxinshuju");
//		registerReceiver(mBroadcastReceiver, intentFilter);
	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		yunyingshuju.setOnClickListener(this);
		yinhangcunguan.setOnClickListener(this);
		wuyoucunzheng.setOnClickListener(this);
		jingxuanlicai.setOnClickListener(this);
		cunguanlicai.setOnClickListener(this);
		woyaojiekuan.setOnClickListener(this);
	
	}

	protected void doOther() {
		// super.doOtherThing();
		LinearLayout pointLinear = (LinearLayout) findViewById(R.id.index_viewpager_layout);
		final int pointLength = imageList.size();
		dotImage = new ImageView[pointLength];
		for (int i = 0; i < pointLength; i++) {
			ImageView dotView = new ImageView(this);
			LayoutParams params = new LayoutParams(LayoutParams.WRAP_CONTENT,
					LayoutParams.WRAP_CONTENT);
			params.leftMargin = TimeUtil.dip2px(IndexActivity.this, 3);
			params.rightMargin = TimeUtil.dip2px(IndexActivity.this, 3);
			dotView.setLayoutParams(params);
			
			dotImage[i] = dotView;
			setDotColor(0, i);
			dotView.setId(i);
			ImageView icon = (ImageView) findViewById(i);
			pointLinear.removeView(icon);
			pointLinear.addView(dotView);
		}
		 
		
		MyFragmentStatePager adpter = new MyFragmentStatePager(
				getSupportFragmentManager());
		ViewPager viewPager = (ViewPager) findViewById(R.id.index_viewpager);
		viewPager.setAdapter(adpter);
		viewPager.setOnPageChangeListener(new OnPageChangeListener() {
			
			@Override
			public void onPageSelected(int position) {
				// TODO Auto-generated method stub
				for (int j = 0; j < pointLength; j++) {
					setDotColor(position, j);
				}
			}
			
			@Override
			public void onPageScrolled(int arg0, float arg1, int arg2) {
				// TODO Auto-generated method stub
				
			}
			
			@Override
			public void onPageScrollStateChanged(int arg0) {
				// TODO Auto-generated method stub
				
			}
		});
		//mPager.setAdapter(new MyPagerAdapter(listViews));
		/**
		 * 首先，你必须在 设置 Viewpager的 adapter 之后在调用这个方法 第二点，setmViewPager(ViewPager
		 * mViewPager,Object obj, int count, int... colors) 第一个参数 是 你需要传人的
		 * viewpager 第二个参数 是
		 * 一个实现了ColorAnimationView.OnPageChangeListener接口的Object,用来实现回调 第三个参数 是
		 * viewpager 的 孩子数量 第四个参数 int... colors ，你需要设置的颜色变化值~~ 如何你传人
		 * 空，那么触发默认设置的颜色动画
		 * */
		/**
		 * Frist: You need call this method after you set the Viewpager adpter;
		 * Second: setmViewPager(ViewPager mViewPager,Object obj， int count,
		 * int... colors) so,you can set any length colors to make the animation
		 * more cool! Third: If you call this method like below, make the colors
		 * no data, it will create a change color by default.
		 * */
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub

		switch (arg0.getId()) {
		case R.id.index_layout_yunyingshuju:
			// 跳转到运营数据
			startActivity(new Intent(IndexActivity.this,YunYingShuJu.class));
			anim_right_in();
			break;
		case R.id.index_layout_yinhangchunguan:
			// 跳转到银行存管
			startActivity(new Intent(IndexActivity.this,YinHangCunGuanOne.class));
			anim_right_in();
			break;
		case R.id.index_layout_wuyoucunzheng:
			// 跳转到无忧存证
			startActivity(new Intent(IndexActivity.this,WuYouCunZhengOne.class));
			anim_right_in();
			break;
		case R.id.index_layout_jingxuanlicai:
			// 跳转到精选理财
			Intent intent3 = new Intent(this, MainActivity.class);
			StaticVariable.put(StaticVariable.licaitab, "1");
			StaticVariable.put(StaticVariable.sv_toInvest, "4");
			startActivity(intent3);
			break;
		case R.id.index_layout_cunguanlicai:
			// 跳转存管理财
			Intent intent4 = new Intent(this, MainActivity.class);
			StaticVariable.put(StaticVariable.licaitab, "2");
			StaticVariable.put(StaticVariable.sv_toInvest, "4");
			startActivity(intent4);
			break;
		case R.id.index_layout_woyaojiekuan:
			// 跳转到我要借款
			startActivity(new Intent(IndexActivity.this,WoYaoJieKuan.class));
			anim_right_in();
			break;
		default:
			break;
		}
	}
	
	private void setDotColor(int position, int j) {
		if (j == position) {
			dotImage[j].setBackgroundResource(R.drawable.dot_focused);
		} else {
			dotImage[j].setBackgroundResource(R.drawable.dot_normal);
		}
	}

	public class MyFragmentStatePager extends FragmentStatePagerAdapter {

		public MyFragmentStatePager(FragmentManager fragmentManager) {
			super(fragmentManager);
		}

		@Override
		public Fragment getItem(int position) {
			return new MyFragment().getInstance(position);
		}

		@Override
		public int getCount() {
			return imageList.size();
		}
	}

	@SuppressLint("ValidFragment")
	public class MyFragment extends Fragment {
		private int position;

		private SmartImageView imageView;

		public MyFragment() {
		}

		public MyFragment getInstance(int position) {
			MyFragment fileViewFragment = new MyFragment();
			fileViewFragment.position = position;
			return fileViewFragment;
		}

		@Override
		public View onCreateView(LayoutInflater inflater, ViewGroup container,
				Bundle savedInstanceState) {

			TextView title, subtitle, btn;

			View view = inflater.inflate(R.layout.activity_guide_item, null);
			imageView = (SmartImageView) view.findViewById(R.id.image);
			title = (TextView) view.findViewById(R.id.title);
			title.setVisibility(View.GONE);
			subtitle = (TextView) view.findViewById(R.id.subtitle);
			subtitle.setVisibility(View.GONE);
			btn = (TextView) view.findViewById(R.id.btn);
			btn.setVisibility(View.GONE);
			
			String path = API.HTTP_WEB + imageList.get(position).substring(4);
			imageView.setImageUrl(path,0, 0);
			 
			
			imageView.setOnClickListener(new View.OnClickListener() {

				@Override
				public void onClick(View v) {
					// TODO Auto-generated method stub
					// Toast.makeText(IndexActivity.this, position+"",
					// 1000).show();
					Intent intent = new Intent(IndexActivity.this,
							MyWebViewActivity.class);
					intent.putExtra("title", urlTitle.get(position));
					intent.putExtra("url", urlList.get(position));
					startActivity(intent);
					anim_right_in();
				}
			});

			return view;
		}

		
	}

	private Dialog dialog = null;

	// 领取体验金对话框
	private void lingqutiyanjin() {

		View view = LayoutInflater.from(IndexActivity.this).inflate(
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
				loadHttp_tiyanjin(et_content.getText().toString());
				dialog.dismiss();
			}
		});

		dialog = new AlertDialog.Builder(IndexActivity.this).setView(view)
				.create();
		dialog.show();
	}

	// 登录--网络请求
	private Handler mHandler = new Handler() {

		@Override
		public void handleMessage(Message msg) {
			// TODO Auto-generated method stub
			super.handleMessage(msg);

			juhua.cancel();

			switch (msg.what) {
			case 0:

				Toast.makeText(IndexActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:
				// 停止菊花

				break;
			case 3:
				// 停止菊花

				// 设置图片，设置图片的链接地址
				getImage();

				break;
			case 4:
				// 停止菊花
				Toast.makeText(IndexActivity.this,"成功", 1000).show();
				break;
			case 2:
				Toast.makeText(IndexActivity.this,
						msg.getData().getString("msg"), 1000).show();
				break;

			default:
				break;
			}
		}
	};

	private void getImage() {
		if (json != null) {
			try {
				if (json.getJSONArray("rvalue") != null
						|| json.getJSONArray("rvalue").length() != 0) {
					JSONArray jsonarr = json.getJSONArray("rvalue");
					for (int i = 0; i < jsonarr.length(); i++) {
						JSONObject jsonObject = jsonarr.getJSONObject(i);
						imageList.add(jsonObject.getString("pictureUrl"));
						urlList.add(jsonObject.getString("linkUrl"));
						urlTitle.add(jsonObject.getString("title"));
					}
				}
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		doOther();

	}

	// 获取首页导航条信息
	private void loadHttp_bannerInfo() {
		// TODO Auto-generated method stub

		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "2");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		RequestThreadAbstract thread = RequestFactory.createRequestThread(33,
				map, IndexActivity.this, mHandler);
		// map.put("type", "android");//类型
		// RequestThreadAbstract thread = RequestFactory.createRequestThread(35,
		// map, IndexActivity.this, mHandler);
		RequestPool.execute(thread);
	}

	// 领取体验金额
	private void loadHttp_tiyanjin(String quanhao) {
		// TODO Auto-generated method stub

		if(quanhao.length()==0){
			Toast.makeText(IndexActivity.this,"请输入券号", 1000).show();
			return;
		}
		 
		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "3");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("qh", quanhao);// 券号
		RequestThreadAbstract thread = RequestFactory.createRequestThread(15,
				map, IndexActivity.this, mHandler);
		RequestPool.execute(thread);
	}

	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub

		// 个人资料信息
		if (map.get("urlTag").equals("1")) {
			if (list.size() == 1) {
				Message msg1 = new Message();
				msg1.what = 1;
				mHandler.sendMessage(msg1);
			}
		} else if (map.get("urlTag").equals("2")) {// 获取banner广告信息

			json = (JSONObject) jsonObj;

			Message msg1 = new Message();
			msg1.what = 3;
			mHandler.sendMessage(msg1);
		} else if (map.get("urlTag").equals("3")) {// 领取体验金券
			Message msg1 = new Message();
			msg1.what = 4;
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
