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
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.MainActivity;
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

	// 我的账户按钮
	private LinearLayout zhanghu = null;

	private TextView mine_name = null;
	// 三个点亮图标
	private ImageView iv_phone = null;
	private ImageView iv_people = null;
	private ImageView iv_qian = null;
	private ImageView iv_xiaoxi = null;

	// 余额详情按钮
	private LinearLayout yuer = null;
	// 可用余额显示文本
	private TextView tv_keyong = null;
	// 已赚总额显示文本
	private TextView tv_yizhuan = null;

	// 我的散标投资按钮
	private RelativeLayout sanbiaotouzi = null;
	// 我的稳赚宝按钮
	// private RelativeLayout wenzhuanbao = null;
	// 我的债权转让按钮
	private RelativeLayout zhaiquan = null;
	// 交易记录按钮
	private RelativeLayout jiaoyi = null;
	// 充值按钮
	private Button chongzhi = null;
	// 提款按钮
	private Button tikuan = null;

	private UserMode user = null;

	private Chongzhi chongzhiModel = null;

	private ProcessDialogUtil juhua = null;

	// 退出按钮
	private Button button = null;

	// 接受广播
	BroadcastReceiver mBroadcastReceiver = null;

	// 返回过来的消息个数
	private String xiaoxi = "";
	
	private GridView list_home;  
	private MyAdapter adapter;  
	private static String [] names = {  
				"账户总览","活动奖励","热门活动",  
	            "交易记录","我的投标","债权转让",  
	            "我的借款","我的推广","我的加息卡"  
	  
	};  
	  
	private static int[] ids = {  
			R.drawable.mine_zh,R.drawable.mine_hdjl,R.drawable.mine_hd,  
			R.drawable.mine_jy,R.drawable.mine_tb,R.drawable.mine_zr, 
			R.drawable.mine_jk,R.drawable.mine_tg,R.drawable.mine_jxq
	  
	};  

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
		showMenu();
		setMenu("通知");

		juhua = new ProcessDialogUtil(MineActivity.this);

		mine_name = (TextView) findViewById(R.id.mine_name);
		zhanghu = (LinearLayout) findViewById(R.id.mine_layout_zhanghu);
		iv_phone = (ImageView) findViewById(R.id.mine_phone);
		iv_people = (ImageView) findViewById(R.id.mine_people);
		iv_qian = (ImageView) findViewById(R.id.mine_qian);
		iv_xiaoxi = (ImageView) findViewById(R.id.mine_xiaoxi);

		yuer = (LinearLayout) findViewById(R.id.mine_layout_yuer);
		tv_keyong = (TextView) findViewById(R.id.mine_tv_keyong);
		tv_yizhuan = (TextView) findViewById(R.id.mine_tv_yizhuan);

		sanbiaotouzi = (RelativeLayout) findViewById(R.id.mine_layout_sanbiaotouzi);
		// wenzhuanbao = (RelativeLayout)
		// findViewById(R.id.mine_layout_wenzhuanbao);
		zhaiquan = (RelativeLayout) findViewById(R.id.mine_layout_zhaiquanzhuanrang);
		jiaoyi = (RelativeLayout) findViewById(R.id.mine_layout_licaitiyan);
		chongzhi = (Button) findViewById(R.id.main_mine_index_cz_btn);
		tikuan = (Button) findViewById(R.id.main_mine_index_tx_btn);
		
		//退出
		button = (Button) findViewById(R.id.main_mine_zhanghu_btn);

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

			if (user.getSfzsfrz().equals("false")) {
				iv_people.setImageDrawable(getResources().getDrawable(
						R.drawable.mine_people1));
			} else {
				iv_people.setImageDrawable(getResources().getDrawable(
						R.drawable.mine_people2));
			}
			// 没有设置了手机号
			if (user.getSjsfsz().equals("false")) {
				iv_phone.setImageDrawable(getResources().getDrawable(
						R.drawable.mine_phone1));
			} else {
				iv_phone.setImageDrawable(getResources().getDrawable(
						R.drawable.mine_phone2));
			}
			// 没有设置提现密码
			if (user.getTxmmsfsz().equals("false")) {
				iv_qian.setImageDrawable(getResources().getDrawable(
						R.drawable.mine_yang1));
			} else {
				iv_qian.setImageDrawable(getResources().getDrawable(
						R.drawable.mine_yang2));
			}
			// email
			if (user.getYjsfsz().equals("false")) {
				iv_xiaoxi.setImageDrawable(getResources().getDrawable(
						R.drawable.mine_xiaoxi1));
			} else {
				iv_xiaoxi.setImageDrawable(getResources().getDrawable(
						R.drawable.mine_xiaoxi2));
			}

			// mine_name.setText(user.getNc());
			tv_keyong.setText(user.getKyye());// 可用余额
			tv_yizhuan.setText(user.getYzze());// 已赚取金额
			
			list_home = (GridView) findViewById(R.id.main_mine_index_grd);  
	        adapter = new MyAdapter();  
	        list_home.setAdapter(adapter);  
	        list_home.setOnItemClickListener(new ItemClickListener());
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
	
	//当AdapterView被单击(触摸屏或者键盘)，则返回的Item单击事件     
	private class ItemClickListener implements OnItemClickListener{
		@Override
		public void onItemClick(AdapterView<?> arg0, View arg1, int index,long arg3) {
				// TODO Auto-generated method stub
				//得到点击item的index
				if(index == 0){
					//跳转到账户总览页面
					
					startActivity(new Intent(MineActivity.this,ZiJinGuanLiActivity.class));
				}else if(index == 1){
					//跳转到活动奖励页面
				}else if(index == 2){
					//跳转到热门活动页面
				}else if(index == 3){
					//跳转到交易记录页面
					startActivity(new Intent(MineActivity.this,MyJiaoYiJiLuActivity.class));
				}else if(index == 4){
					//跳转到我的投标页面
					startActivity(new Intent(MineActivity.this, MyTouBiaoActivity.class));
					anim_right_in();
				}else if(index == 5){
					//跳转到债权转让页面
				}else if(index == 6){
					//跳转到我的借款页面
				}else if(index == 7){
					//跳转到我的推广页面
				}else if(index == 8){
					//跳转到我的加息卡页面
				}
			}       	  
		} 
	
	private class MyAdapter extends BaseAdapter{  
        @Override  
        public int getCount() {  
            return names.length;  
        }  
  
        @Override  
        public Object getItem(int i) {  
            return null;  
        }  
  
        @Override  
        public long getItemId(int i) {  
            return 0;  
        }  
  
        @Override  
        public View getView(int position, View convertView, ViewGroup parent) {  
            // TODO Auto-generated method stub  
            View view = View.inflate(MineActivity.this, R.layout.main_mine_grd_item, null);  
            ImageView iv_item = (ImageView) view.findViewById(R.id.iv_item);  
            TextView tv_item = (TextView) view.findViewById(R.id.tv_item);  
  
            tv_item.setText(names[position]);  
            iv_item.setImageResource(ids[position]); 
            return view;  
        }  
    }  

	public void reload() {

		user = Tool.getUser(MineActivity.this);
		if (user == null) {

		} else {

			mine_name.setText(user.getYhzh());

			if (user.getSfzsfrz().equals("false")) {
				iv_people.setImageDrawable(getResources().getDrawable(
						R.drawable.mine_people1));
			} else {
				iv_people.setImageDrawable(getResources().getDrawable(
						R.drawable.mine_people2));
			}
			// 没有设置了手机号
			if (user.getSjsfsz().equals("false")) {
				iv_phone.setImageDrawable(getResources().getDrawable(
						R.drawable.mine_phone1));
			} else {
				iv_phone.setImageDrawable(getResources().getDrawable(
						R.drawable.mine_phone2));
			}
			// 没有设置提现密码
			if (user.getTxmmsfsz().equals("false")) {
				iv_qian.setImageDrawable(getResources().getDrawable(
						R.drawable.mine_yang1));
			} else {
				iv_qian.setImageDrawable(getResources().getDrawable(
						R.drawable.mine_yang2));
			}
			// email
			if (user.getYjsfsz().equals("false")) {
				iv_xiaoxi.setImageDrawable(getResources().getDrawable(
						R.drawable.mine_xiaoxi1));
			} else {
				iv_xiaoxi.setImageDrawable(getResources().getDrawable(
						R.drawable.mine_xiaoxi2));
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
		titleBarMenu.setOnClickListener(this);

		zhanghu.setOnClickListener(this);
		yuer.setOnClickListener(this);

		sanbiaotouzi.setOnClickListener(this);
		// wenzhuanbao.setOnClickListener(this);
		zhaiquan.setOnClickListener(this);
		jiaoyi.setOnClickListener(this);
		chongzhi.setOnClickListener(this);
		tikuan.setOnClickListener(this);
		button.setOnClickListener(this);
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_menu:
			startActivity(new Intent(MineActivity.this, TongZhiActivity.class));
			anim_right_in();
			break;
		case R.id.mine_layout_zhanghu:
			startActivity(new Intent(MineActivity.this,
					ZhangHuGuanLiActivity.class));
			anim_right_in();
			break;
		case R.id.mine_layout_yuer:
			startActivity(new Intent(MineActivity.this,
					ZiJinGuanLiActivity.class));
			anim_right_in();
			break;
		case R.id.mine_layout_sanbiaotouzi:
			startActivity(new Intent(MineActivity.this, MyTouBiaoActivity.class));
			anim_right_in();
			break;
		// case R.id.mine_layout_wenzhuanbao:
		// Toast.makeText(MineActivity.this, "wodewenzhuanbao",
		// Toast.LENGTH_SHORT)
		// .show();
		// break;
		case R.id.mine_layout_zhaiquanzhuanrang:
			startActivity(new Intent(MineActivity.this, MyLiCaiActivity.class));
			anim_right_in();
			break;
		case R.id.mine_layout_licaitiyan:
			startActivity(new Intent(MineActivity.this,
					MyJiaoYiJiLuActivity.class));
			break;
		case R.id.main_mine_index_cz_btn:
			isgoto_chongzhi_tixian(0);
			break;
		case R.id.main_mine_index_tx_btn:
			isgoto_chongzhi_tixian(1);
			break;
		case R.id.main_mine_zhanghu_btn:
			loadHttp_zhuxiao();
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
