package com.quqian.activity.mine;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.app.Dialog;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.MainActivity;
import com.quqian.activity.RegisterActivity;
import com.quqian.activity.index.IndexActivity;
import com.quqian.activity.more.SheZhiActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.UserMode;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.CommonUtil;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.StaticVariable;
import com.quqian.util.Tool;

public class ZhangHuGuanLiActivity extends BaseActivity implements
		OnClickListener, HttpResponseInterface {

	private TextView nicheng = null;
	private TextView xingbie = null;
	private TextView chusheng = null;
	private TextView fuwuma = null;

	// 安全信息按钮
	private RelativeLayout layout_anquan = null;
	// 昵称按钮
	private RelativeLayout layout_nicheng = null;
	// 性别按钮
	private RelativeLayout layout_xinbie = null;
	// 出生日期
	private RelativeLayout layout_chusheng = null;
	// 服务码
	private RelativeLayout layout_fuuwma = null;
	// 二维码
	private RelativeLayout layout_erweima = null;

	// 退出按钮
	private Button button = null;

	private Dialog juhua = null;
	
	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_mine_zhanghu;
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("账户管理");
		showBack();

		juhua = new ProcessDialogUtil(ZhangHuGuanLiActivity.this);
		
		nicheng = (TextView) findViewById(R.id.main_mine_zhanghu_nicheng);
		xingbie = (TextView) findViewById(R.id.main_mine_zhanghu_xingbie);
		chusheng = (TextView) findViewById(R.id.main_mine_zhanghu_chusheng);
		fuwuma = (TextView) findViewById(R.id.main_mine_zhanghu_fuwuma);

		layout_anquan = (RelativeLayout) findViewById(R.id.main_mine_zhanghu_layout_anquan);
		layout_nicheng = (RelativeLayout) findViewById(R.id.main_mine_zhanghu_layout_nicheng);
		layout_xinbie = (RelativeLayout) findViewById(R.id.main_mine_zhanghu_layout_xingbie);
		layout_chusheng = (RelativeLayout) findViewById(R.id.main_mine_zhanghu_layout_chusheng);
		layout_fuuwma = (RelativeLayout) findViewById(R.id.main_mine_zhanghu_layout_fuwuma);
		layout_erweima = (RelativeLayout) findViewById(R.id.main_mine_zhanghu_layout_erweima);

		button = (Button) findViewById(R.id.main_mine_zhanghu_btn);

		//初始化数据
		UserMode user = Tool.getUser(ZhangHuGuanLiActivity.this);
		nicheng.setText(user.getNc());
		xingbie.setText(user.getXb());
		chusheng.setText(user.getCsrq());
		fuwuma.setText(user.getWdfwm());
		//更新数据
		loadHttp_info();
	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);

		layout_anquan.setOnClickListener(this);
		layout_nicheng.setOnClickListener(this);
		layout_xinbie.setOnClickListener(this);
		layout_chusheng.setOnClickListener(this);
		layout_fuuwma.setOnClickListener(this);
		layout_erweima.setOnClickListener(this);
		button.setOnClickListener(this);

	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_back:
			ZhangHuGuanLiActivity.this.finish();
			anim_right_out();
			break;
		case R.id.main_mine_zhanghu_layout_anquan:
			startActivity(new Intent(ZhangHuGuanLiActivity.this,AnQuanXinXiActivity.class));
			anim_right_in();
			
			break;
		case R.id.main_mine_zhanghu_layout_nicheng:

			break;
		case R.id.main_mine_zhanghu_layout_xingbie:

			break;
		case R.id.main_mine_zhanghu_layout_chusheng:

			break;
		case R.id.main_mine_zhanghu_layout_fuwuma:

			break;
		case R.id.main_mine_zhanghu_layout_erweima:
			Intent intent = new Intent(ZhangHuGuanLiActivity.this,WoErWeiMaActivity.class);
			UserMode user = Tool.getUser(ZhangHuGuanLiActivity.this);
			intent.putExtra("fuwuma", user.getFwmlj());
			startActivity(intent);
			break;
		case R.id.main_mine_zhanghu_btn:
			loadHttp_zhuxiao();
			break;

		default:
			break;
		}
	}

	// 清除登录账户，仅仅是登录人的登录状态，
	private void clearLogin() {
		// CommonUtil.clearByKey(ZhangHuGuanLiActivity.this, "loginState", "", "");
		Tool.writeData(ZhangHuGuanLiActivity.this, "loginState", "zhanghu", "");
		Tool.writeData(ZhangHuGuanLiActivity.this, "cooke", "cookieValue", "");
		Intent intent3 = new Intent(this, MainActivity.class);
		StaticVariable.put(StaticVariable.sv_toIndex, "1");
		startActivity(intent3);
		finish();
		anim_right_out();
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

				Toast.makeText(ZhangHuGuanLiActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:
				// 停止菊花
				UserMode user = Tool.getUser(ZhangHuGuanLiActivity.this);
				
				nicheng.setText(user.getYhzh());
				xingbie.setText(user.getXb());
				chusheng.setText(user.getCsrq());
				fuwuma.setText(user.getWdfwm());
				
				

				break;
			case 3://注销
				clearLogin();
				break;
			case 2:
				Toast.makeText(ZhangHuGuanLiActivity.this,
						msg.getData().getString("msg"), 1000).show();
				break;

			default:
				break;
			}
		}
	};

	 
	// 获取个人资料信息
	private void loadHttp_info() {
		
		juhua.show();
		
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		RequestThreadAbstract thread = RequestFactory.createRequestThread(2,
				map, ZhangHuGuanLiActivity.this, mHandler);
		RequestPool.execute(thread);

	}


	// 注销退出登录
	private void loadHttp_zhuxiao() {
		
		juhua.show();
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "3");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		RequestThreadAbstract thread = RequestFactory.createRequestThread(4,
				map, ZhangHuGuanLiActivity.this, mHandler);
		RequestPool.execute(thread);
	}

	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub

		// 获取个人资料
		if (map.get("urlTag").equals("1")) {
			if (list.size() == 1) {
				Message msg1 = new Message();
				msg1.what = 1;
				mHandler.sendMessage(msg1);
			}
		} else if (map.get("urlTag").equals("3")) {// 进行注销
			Message msg1 = new Message();
			msg1.what = 3;
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
