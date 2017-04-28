package com.quqian.activity.mine;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.MainActivity;
import com.quqian.activity.mine.xin.NewChongZhi;
import com.quqian.activity.mine.xin.NewTiXian;
import com.quqian.activity.mine.xin.NewYinHangKaGuanLi;
import com.quqian.base.BaseActivity;
import com.quqian.been.Chongzhi;
import com.quqian.been.UserMode;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.StaticVariable;
import com.quqian.util.Tool;
import com.readystatesoftware.viewbadger.BadgeView;

public class MineActivity extends BaseActivity implements OnClickListener,
		HttpResponseInterface {

	//用户名
	private TextView mine_name = null;
	//消息 设置
	private ImageView iv_xiaoxi = null;
	private ImageView iv_shezhi = null;
	
	//存管账户，普通账户按钮，
	private RadioGroup rg = null;
	private RadioButton rb1 = null;
	private RadioButton rb2 = null;
	
	// 可用余额显示文本，已赚总额显示文本
	private TextView tv_keyong = null;
	private TextView tv_yizhuan = null;

	// 充值按钮，提现按钮
	private TextView chongzhi = null;
	private TextView tikuan = null;

	//账户总额，交易记录，我的投标，邀请好友，
	private LinearLayout zhanghuzonge = null;
	private LinearLayout jiaoyijilu = null;
	private LinearLayout wodetoubiao = null;
	private LinearLayout yaoqinghaoyou = null;
	
	//推广记录，我的借款，我的加息卡，银行卡管理
	private LinearLayout tuiguangjilu = null;
	private LinearLayout wodejiekuan = null;
	private LinearLayout wodejiaxika = null;
	private LinearLayout yinhangkaguanli = null;
	
	//用户数据
	private UserMode user = null;
	private Chongzhi chongzhiModel = null;
	private ProcessDialogUtil juhua = null;


	// 接受广播
	BroadcastReceiver mBroadcastReceiver = null;

	// 返回过来的消息个数
	private String xiaoxi = "";
	 

	@Override
	protected void onDestroy() {
		super.onDestroy();
		unregisterReceiver(mBroadcastReceiver);
	}

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_mine;
	}

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
		if (getIntent().getExtras() != null) {
			xiaoxi = getIntent().getExtras().getString("xiaoxigeshu");
			Log.v("通知----", xiaoxi);
		}
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("我的账户");

		juhua = new ProcessDialogUtil(MineActivity.this);

		mine_name = (TextView) findViewById(R.id.mine_name);
		
		iv_xiaoxi = (ImageView) findViewById(R.id.mine_xiaoxi);
		iv_shezhi = (ImageView) findViewById(R.id.mine_shezhi);
		
		rg = (RadioGroup) findViewById(R.id.m_zhanghu_rg);
		rb1 = (RadioButton) findViewById(R.id.m_zhanghu_rb1);
		rb2 = (RadioButton) findViewById(R.id.m_zhanghu_rb2);

		tv_keyong = (TextView) findViewById(R.id.mine_tv_keyong);
		tv_yizhuan = (TextView) findViewById(R.id.mine_tv_yizhuan);

		chongzhi = (TextView) findViewById(R.id.main_mine_index_cz_btn);
		tikuan = (TextView) findViewById(R.id.main_mine_index_tx_btn);
		
		zhanghuzonge = (LinearLayout) findViewById(R.id.m_zhanghu);
		jiaoyijilu = (LinearLayout) findViewById(R.id.m_jiaoyi);
		wodetoubiao = (LinearLayout) findViewById(R.id.m_toubiao);
		yaoqinghaoyou = (LinearLayout) findViewById(R.id.m_yaoqing);
		
		tuiguangjilu = (LinearLayout) findViewById(R.id.m_tuiguangjilu);
		wodejiekuan = (LinearLayout) findViewById(R.id.m_wodejiekuan);
		wodejiaxika = (LinearLayout) findViewById(R.id.m_wodejiaxika);
		yinhangkaguanli = (LinearLayout) findViewById(R.id.m_yinhangkaguanli);

		user = Tool.getUser(MineActivity.this);
		if (user == null) {

		} else {

			xiaoxi = user.getZnxwdts();
			// badgeView
			BadgeView badgeView = new BadgeView(this, titleBarMenu);
			if ("".equals(xiaoxi) || "0".equals(xiaoxi)) {
				badgeView.hide();
			} else {
				badgeView.setTextSize(10);
				badgeView.setBadgePosition(BadgeView.POSITION_TOP_RIGHT);
				badgeView.setText(xiaoxi);
				badgeView.show();
			}

			mine_name.setText(user.getYhzh());

			// email
			if (user.getYjsfsz().equals("false")) {
				iv_xiaoxi.setImageDrawable(getResources().getDrawable(
						R.drawable.m_xiaoxi_yidu));
			} else {
				iv_xiaoxi.setImageDrawable(getResources().getDrawable(
						R.drawable.m_xiaoxi_weidu));
			}

			// mine_name.setText(user.getNc());
			tv_keyong.setText(user.getKyye());// 可用余额
			tv_yizhuan.setText(user.getYzze());// 已赚取金额
			
		}

		// 接受广播
		mBroadcastReceiver = new BroadcastReceiver() {
			@Override
			public void onReceive(Context arg0, Intent arg1) {
				// TODO Auto-generated method stub
				// Intent intent = getIntent();
				reload();
				// 发送通知
				Intent intent = new Intent();
				intent.setAction("dengluhoushuaxinshuju");
				sendBroadcast(intent);
			}
		};
		IntentFilter intentFilter = new IntentFilter();
		intentFilter.addAction("dengluhoushuaxinshuju");
		registerReceiver(mBroadcastReceiver, intentFilter);

	}
	
	public void reload() {

		user = Tool.getUser(MineActivity.this);
		if (user == null) {

		} else {

			mine_name.setText(user.getYhzh());

			// email
			if (user.getYjsfsz().equals("false")) {
				iv_xiaoxi.setImageDrawable(getResources().getDrawable(
						R.drawable.m_xiaoxi_yidu));
			} else {
				iv_xiaoxi.setImageDrawable(getResources().getDrawable(
						R.drawable.m_xiaoxi_weidu));
			}

			// mine_name.setText(user.getNc());
			tv_keyong.setText(user.getKyye());// 可用余额
			tv_yizhuan.setText(user.getYzze());// 已赚取金额
		}

	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();

		iv_xiaoxi.setOnClickListener(this);
		iv_shezhi.setOnClickListener(this);
		
		rb1.setOnClickListener(this);
		rb2.setOnClickListener(this);
		
		chongzhi.setOnClickListener(this);
		tikuan.setOnClickListener(this);
		
		zhanghuzonge.setOnClickListener(this);
		jiaoyijilu.setOnClickListener(this);
		wodetoubiao.setOnClickListener(this);
		yaoqinghaoyou.setOnClickListener(this);
		
		tuiguangjilu.setOnClickListener(this);
		wodejiekuan.setOnClickListener(this);
		wodejiaxika.setOnClickListener(this);
		yinhangkaguanli.setOnClickListener(this);
		
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.mine_xiaoxi://消息
			startActivity(new Intent(MineActivity.this, TongZhiActivity.class));
			anim_right_in();
			break;
		case R.id.mine_shezhi://设置
			startActivity(new Intent(MineActivity.this,
					ZhangHuGuanLiActivity.class));
			anim_right_in();
			break;
		case R.id.m_zhanghu://账户总额
			startActivity(new Intent(MineActivity.this,
					ZiJinGuanLiActivity.class));
			anim_right_in();
			break;
		case R.id.m_jiaoyi://交易记录
			startActivity(new Intent(MineActivity.this,
					MyJiaoYiJiLuActivity.class));
			break;
		case R.id.m_toubiao://我的投标
			startActivity(new Intent(MineActivity.this, MyTouBiaoActivity.class));
			anim_right_in();
			break;
		case R.id.m_yaoqing://邀请好友
			startActivity(new Intent(MineActivity.this, MyLiCaiActivity.class));
			anim_right_in();
			break;
		case R.id.m_tuiguangjilu://推广记录
			startActivity(new Intent(MineActivity.this, MyLiCaiActivity.class));
			anim_right_in();
			break;
		case R.id.m_wodejiekuan://我的借款
			startActivity(new Intent(MineActivity.this, MyLiCaiActivity.class));
			anim_right_in();
			break;
		case R.id.m_wodejiaxika://我的加息卡
			startActivity(new Intent(MineActivity.this, MyLiCaiActivity.class));
			anim_right_in();
			break;
		case R.id.m_yinhangkaguanli://银行卡管理
			startActivity(new Intent(MineActivity.this, NewYinHangKaGuanLi.class));
			anim_right_in();
			break;
		case R.id.main_mine_index_cz_btn://充值
			//isgoto_chongzhi_tixian(0);
			startActivity(new Intent(MineActivity.this, NewChongZhi.class));
			anim_right_in();
			break;
		case R.id.main_mine_index_tx_btn://提现
			//isgoto_chongzhi_tixian(1);
			startActivity(new Intent(MineActivity.this, NewTiXian.class));
			anim_right_in();
			break;
		default:
			break;
		}
	}

	// 进行逻辑的判断 0是充值，1是提现
	public void isgoto_chongzhi_tixian(int tag) {

		user = Tool.getUser(MineActivity.this);
		// 实名认证
		if (user.getSfzsfrz().equals("false")) {
			startActivity(new Intent(MineActivity.this,
					ShiMingRenZhengActivity.class));
			anim_right_in();
			return;
		}
		// 去掉判断提现密码是否设置
		/*if (user.getTxmmsfsz().equals("false")) {
			startActivity(new Intent(MineActivity.this,
					SheZhiTiXianMiMaActivity.class));
			anim_right_in();
			return;
		}*/

		if (tag == 0) {
			loadHttp_chongzhi();
		} else if (tag == 1) {
			loadHttp_tixian();
		}

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

				Toast.makeText(MineActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:// 进入充值的页面
					// 停止菊花

				Intent intent = new Intent(MineActivity.this,
						ChongZhiActivity.class);
				intent.putExtra("chongzhiModel", chongzhiModel);
				startActivity(intent);

				break;
			case 3:// 进入提款的页面
					// 停止菊花

				Intent intent1 = new Intent(MineActivity.this,
						TiXianActivity.class);
				intent1.putExtra("chongzhiModel", chongzhiModel);
				startActivity(intent1);

				break;
			case 4:
			
				// 停止菊花
				Tool.writeData(MineActivity.this, "loginState", "zhanghu", "");
				Tool.writeData(MineActivity.this, "cooke", "cookieValue", "");
				//弹框提醒
				Toast.makeText(MineActivity.this,"退出成功", 1000).show();
				 
				//进入首页
				Intent intent3 = new Intent(MineActivity.this,
						MainActivity.class);
				StaticVariable.put(StaticVariable.sv_toIndex, "1");
				startActivity(intent3);
				
				
				break;
			case 2:
				Toast.makeText(MineActivity.this,
						msg.getData().getString("msg"), 1000).show();
				break;

			default:
				break;
			}
		}
	};
	
	

	// 注销退出登录
	private void loadHttp_zhuxiao() {
		
		juhua.show();
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "3");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		RequestThreadAbstract thread = RequestFactory.createRequestThread(4,
				map, MineActivity.this, mHandler);
		RequestPool.execute(thread);
	}

	
	

	// 充值
	private void loadHttp_chongzhi() {
		// TODO Auto-generated method stub

		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		RequestThreadAbstract thread = RequestFactory.createRequestThread(38,
				map, MineActivity.this, mHandler);
		RequestPool.execute(thread);
	}

	// 提款
	private void loadHttp_tixian() {
		// TODO Auto-generated method stub

		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "2");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁

		RequestThreadAbstract thread = RequestFactory.createRequestThread(40,
				map, MineActivity.this, mHandler);
		RequestPool.execute(thread);
	}

	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub

		// 充值
		if (map.get("urlTag").equals("1")) {

			chongzhiModel = new Chongzhi();
			chongzhiModel.initMakeData_chongzhi((JSONObject) jsonObj);

			Message msg1 = new Message();
			msg1.what = 1;
			mHandler.sendMessage(msg1);
		} else if (map.get("urlTag").equals("2")) {// 提现

			chongzhiModel = new Chongzhi();
			chongzhiModel.initMakeData_tixian((JSONObject) jsonObj);

			Message msg1 = new Message();
			msg1.what = 3;
			mHandler.sendMessage(msg1);
		} else if (map.get("urlTag").equals("3")) {// 退出

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
