package com.quqian.activity.mine;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.index.IndexActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.Chongzhi;
import com.quqian.been.UserMode;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.Tool;

public class ZiJinGuanLiActivity extends BaseActivity implements
		OnClickListener, HttpResponseInterface {

	private TextView keyong = null;
	private TextView dongjie = null;
	private TextView zhanghu = null;
	private TextView tiyanjin = null;

	private RelativeLayout layout = null;

	private Dialog juhua = null;

	private Button index_login = null;
	private Button index_register = null;

	private Chongzhi chongzhiModel = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_mine_zijinguanli;
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("资金管理");
		showBack();

		juhua = new ProcessDialogUtil(ZiJinGuanLiActivity.this);

		index_login = (Button) findViewById(R.id.index_btn_denglu);
		index_register = (Button) findViewById(R.id.index_btn_zhuce);

		keyong = (TextView) findViewById(R.id.main_mine_zijin_keyong);
		dongjie = (TextView) findViewById(R.id.main_mine_zijin_dongjie);
		zhanghu = (TextView) findViewById(R.id.main_mine_zijin_zhanghu);
		tiyanjin = (TextView) findViewById(R.id.main_mine_zijin_tiyanjin);
		layout = (RelativeLayout) findViewById(R.id.main_mine_zijin_layout);

		// 初始化数据
		UserMode user = Tool.getUser(ZiJinGuanLiActivity.this);
		keyong.setText(user.getKyye());
		dongjie.setText(user.getDjje());
		zhanghu.setText(user.getZhze());
		tiyanjin.setText(user.getTyjze());

		// 获取用户账户的信息
		loadHttp_info();
	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);

		layout.setOnClickListener(this);

		index_login.setOnClickListener(this);
		index_register.setOnClickListener(this);
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_back:
			ZiJinGuanLiActivity.this.finish();
			anim_right_out();
			break;
		case R.id.main_mine_zijin_layout:
			lingqutiyanjin();
			break;
		case R.id.index_btn_denglu:// 充值
			isgoto_chongzhi_tixian(0);
			break;
		case R.id.index_btn_zhuce:// 提款
			isgoto_chongzhi_tixian(1);
			break;
		default:
			break;
		}
	}

	private Dialog dialog = null;

	// 领取体验金对话框
	private void lingqutiyanjin() {

		View view = LayoutInflater.from(ZiJinGuanLiActivity.this).inflate(
				R.layout.dialog_all, null);
		TextView tv_title = (TextView) view.findViewById(R.id.dialog_title);
		tv_title.setText("领取体验金");
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

		dialog = new AlertDialog.Builder(ZiJinGuanLiActivity.this)
				.setView(view).create();
		dialog.show();
	}

	// 进行逻辑的判断 0是充值，1是提现
	public void isgoto_chongzhi_tixian(int tag) {

		UserMode user = Tool.getUser(ZiJinGuanLiActivity.this);
		// 实名认证
		if (user.getSfzsfrz().equals("false")) {
			startActivity(new Intent(ZiJinGuanLiActivity.this,
					ShiMingRenZhengActivity.class));
			anim_right_in();
			return;
		}
		// 提现密码是否设置
		if (user.getTxmmsfsz().equals("false")) {
			startActivity(new Intent(ZiJinGuanLiActivity.this,
					SheZhiTiXianMiMaActivity.class));
			anim_right_in();
			return;
		}

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

				Toast.makeText(ZiJinGuanLiActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:
				// 停止菊花
				UserMode user = Tool.getUser(ZiJinGuanLiActivity.this);

				keyong.setText(user.getKyye());
				dongjie.setText(user.getDjje());
				zhanghu.setText(user.getZhze());
				tiyanjin.setText(user.getTyjze());
				
				//发送通知
				Intent intent12 = new Intent();
				intent12.setAction("dengluhoushuaxinshuju");
			    sendBroadcast(intent12);
				
				

				break;
			case 3:
				// 获取体验金之后再次调用接口刷新，获取资金管理信息，
				
				Toast.makeText(ZiJinGuanLiActivity.this,"成功", 1000).show();
				
				loadHttp_info();
				break;
			case 4:// 充值
				Intent intent = new Intent(ZiJinGuanLiActivity.this,
						ChongZhiActivity.class);
				intent.putExtra("chongzhiModel", chongzhiModel);
				startActivity(intent);
				break;
			case 5:// 提款

				Intent intent1 = new Intent(ZiJinGuanLiActivity.this,
						TiXianActivity.class);
				intent1.putExtra("chongzhiModel", chongzhiModel);
				startActivity(intent1);

				break;
			case 2:
				Toast.makeText(ZiJinGuanLiActivity.this,
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

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		RequestThreadAbstract thread = RequestFactory.createRequestThread(2,
				map, ZiJinGuanLiActivity.this, mHandler);
		RequestPool.execute(thread);

	}

	// 领取体验金额
	private void loadHttp_tiyanjin(String quanhao) {
		// TODO Auto-generated method stub

		 if(quanhao.length()==0){
			 Toast.makeText(ZiJinGuanLiActivity.this,"请输入券号", 1000).show();
			 return;
		 }
		
		
		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "2");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("qh", quanhao);// 券号
		RequestThreadAbstract thread = RequestFactory.createRequestThread(15,
				map, ZiJinGuanLiActivity.this, mHandler);
		RequestPool.execute(thread);
	}

	// 充值
	private void loadHttp_chongzhi() {
		// TODO Auto-generated method stub

		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "3");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		RequestThreadAbstract thread = RequestFactory.createRequestThread(38,
				map, ZiJinGuanLiActivity.this, mHandler);
		RequestPool.execute(thread);
	}

	// 提款
	private void loadHttp_tixian() {
		// TODO Auto-generated method stub

		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "4");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁

		RequestThreadAbstract thread = RequestFactory.createRequestThread(40,
				map, ZiJinGuanLiActivity.this, mHandler);
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
		} else if (map.get("urlTag").equals("2")) {
			Message msg1 = new Message();
			msg1.what = 3;
			mHandler.sendMessage(msg1);
		} else if (map.get("urlTag").equals("3")) {

			chongzhiModel = new Chongzhi();
			chongzhiModel.initMakeData_chongzhi((JSONObject) jsonObj);

			Message msg1 = new Message();
			msg1.what = 4;
			mHandler.sendMessage(msg1);
		} else if (map.get("urlTag").equals("4")) {
			chongzhiModel = new Chongzhi();
			chongzhiModel.initMakeData_tixian((JSONObject) jsonObj);

			Message msg1 = new Message();
			msg1.what = 5;
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
