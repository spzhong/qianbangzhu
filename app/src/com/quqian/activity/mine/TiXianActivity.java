package com.quqian.activity.mine;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.app.AlertDialog;
import android.app.Dialog;
import android.app.ActionBar.LayoutParams;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.Display;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.index.IndexActivity;
import com.quqian.activity.mine.xin.BangDingYinHangKaActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.Chongzhi;
import com.quqian.been.UserMode;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.Tool;

public class TiXianActivity extends BaseActivity implements OnClickListener,
		HttpResponseInterface {

	// 绑定银行卡
	private RelativeLayout layout_bangding = null;
	// 绑定银行卡
	private TextView bangding = null;
	// 绑定状态
	private TextView bangdingzt = null;

	// 可用余额
	private TextView keyongyuer = null;
	// 提现金额
	private EditText tixianjiner = null;
	// 提现手续费
	private TextView tixianshouxufei = null;
	// 实际扣除金额
	private TextView shijikouchu = null;
	// 提现密码
	private EditText tixianmima = null;

	// 提现密码
	private Button next = null;

	private Chongzhi chongzhiModel = null;
	private ProcessDialogUtil juhua = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_mine_tixian;
	}

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
		Intent intent = getIntent();
		chongzhiModel = (Chongzhi) intent.getSerializableExtra("chongzhiModel");

	}

	public static final String BROADCAST_ACTION = "tixianshuaxindata";
	private BroadcastReceiver mBroadcastReceiver;

	@Override
	protected void onDestroy() {
		super.onDestroy();
		unregisterReceiver(mBroadcastReceiver);
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("提现");
		showBack();

		juhua = new ProcessDialogUtil(TiXianActivity.this);

		layout_bangding = (RelativeLayout) findViewById(R.id.main_mine_tixian_bangding);

		bangding = (TextView) findViewById(R.id.main_mine_tixian_tv_bangdingyinhangka);
		bangdingzt = (TextView) findViewById(R.id.main_mine_tixian_tv_xiugai);

		keyongyuer = (TextView) findViewById(R.id.main_mine_tianxian_keyong);
		tixianjiner = (EditText) findViewById(R.id.main_mine_tixian_et_jiner);
		tixianshouxufei = (TextView) findViewById(R.id.main_mine_tixian_shouxufei);
		shijikouchu = (TextView) findViewById(R.id.main_mine_tixian_kouchu);
		tixianmima = (EditText) findViewById(R.id.main_mine_tixian_et_mima);

		next = (Button) findViewById(R.id.main_mine_tixian_next);

		UserMode user = Tool.getUser(TiXianActivity.this);
		keyongyuer.setText(user.getKyye());

		// 判断类型
		if (chongzhiModel.getBankCardId().equals("")) {
			// layout_bangding.setVisibility(View.VISIBLE);
			bangdingzt.setVisibility(View.GONE);
			bangding.setText("绑定银行卡");
		} else {
			// layout_bangding.setVisibility(View.GONE);
			bangding.setText(chongzhiModel.getBankName() + " "
					+ chongzhiModel.getBankNumber());
		}
		// 未签约
		if (chongzhiModel.getIsBound().equals("0")) {

		} else {
			bangdingzt.setVisibility(View.GONE);
		}

		tixianjiner.setHint("请输入提现金额,至少" + chongzhiModel.getWithdrawMin());

		tixianjiner.addTextChangedListener(new TextWatcher() {
			@Override
			public void onTextChanged(CharSequence s, int start, int before,
					int count) {

			}

			@Override
			public void beforeTextChanged(CharSequence s, int start, int count,
					int after) {
			}

			@Override
			public void afterTextChanged(Editable s) {
				String newString = tixianjiner.getText().toString();

				if (newString.length() == 0) {
					tixianshouxufei.setText("0.00");
					shijikouchu.setText("0.00");
					chongzhiModel.setShouxufei("");
					chongzhiModel.setShjikouchu("");
					return;
				}
				// 手续费
				if (Double.valueOf(newString) < 5000) {
					tixianshouxufei.setText(chongzhiModel
							.getWithdrawFactorage_1());
				} else {
					tixianshouxufei.setText(chongzhiModel
							.getWithdrawFactorage_2());
				}
				// 实际支付金额
				shijikouchu.setText((Double.valueOf(newString) + Double
						.valueOf(tixianshouxufei.getText().toString())) + "");

				chongzhiModel
						.setShouxufei(tixianshouxufei.getText().toString());
				chongzhiModel.setShjikouchu(shijikouchu.getText().toString());
			}
		});

		
		//接受广播
		mBroadcastReceiver = new BroadcastReceiver() {
			@Override
			public void onReceive(Context arg0, Intent arg1) {
				// TODO Auto-generated method stub
				//Intent intent = getIntent();
				Chongzhi newchognzhi = (Chongzhi) arg1.getSerializableExtra("chongzhiModel");
				shuxinshuju( newchognzhi);
				bangdingzt.setVisibility(View.VISIBLE);
			}
		};
		IntentFilter intentFilter = new IntentFilter();
		intentFilter.addAction(BROADCAST_ACTION);
		registerReceiver(mBroadcastReceiver, intentFilter);

	}
	
	//刷新数据
	public void shuxinshuju(Chongzhi newchognzhi){
		 
		bangding.setText(newchognzhi.getBankName() + " "
				+ newchognzhi.getBankNumber());
		chongzhiModel.setBankCardId(newchognzhi.getBankCardId());
		chongzhiModel.setBankName(newchognzhi.getBankName());
		chongzhiModel.setBankNumber(newchognzhi.getBankNumber());
		chongzhiModel.setIsFull("1");
	}
	

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);

		layout_bangding.setOnClickListener(this);
		next.setOnClickListener(this);

	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_back:
			TiXianActivity.this.finish();
			anim_right_out();
			break;
		case R.id.main_mine_tixian_bangding:

			if (chongzhiModel.getIsBound().equals("0")) {

				if (chongzhiModel.getBankCardId().equals("")) {
					chongzhiModel.setType("0");
					chongzhiModel.setTitle("绑定银行卡");
					Intent intent1 = new Intent(TiXianActivity.this,
							BangDingYinHangKaActivity.class);
					intent1.putExtra("chongzhiModel", chongzhiModel);
					startActivity(intent1);
					anim_right_in();

				} else {

					// 修改银行卡
					chongzhiModel.setType("1");
					chongzhiModel.setTitle("修改银行卡");
					Intent intent1 = new Intent(TiXianActivity.this,
							BangDingYinHangKaActivity.class);
					intent1.putExtra("chongzhiModel", chongzhiModel);
					startActivity(intent1);
					anim_right_in();

				}

			}

			break;
		case R.id.main_mine_tixian_next:

			if (chongzhiModel.getBankCardId().equals("")) {
				// 绑定银行卡
				chongzhiModel.setType("0");
				chongzhiModel.setTitle("绑定银行卡");
				Intent intent1 = new Intent(TiXianActivity.this,
						BangDingYinHangKaActivity.class);
				intent1.putExtra("chongzhiModel", chongzhiModel);
				startActivity(intent1);
				anim_right_in();
				return;
			}
			if (chongzhiModel.getIsFull().equals("0")) {
				// 完善信息
				chongzhiModel.setType("2");
				chongzhiModel.setTitle("完善银行卡");
				Intent intent1 = new Intent(TiXianActivity.this,
						BangDingYinHangKaActivity.class);
				intent1.putExtra("chongzhiModel", chongzhiModel);
				startActivity(intent1);
				anim_right_in();
				return;
			}

			// 判断金额
			if (tixianjiner.getText().toString().length() == 0) {
				Toast.makeText(TiXianActivity.this, "请输入提现金额", 1000).show();
				return;
			}
			//最小
			if(Double.valueOf(chongzhiModel.getWithdrawMin()) > Double.valueOf(tixianjiner.getText().toString())){
				Toast.makeText(TiXianActivity.this, "提现金额至少"+ chongzhiModel.getWithdrawMin(), 1000).show();
				return;
			}
			
			// 判断提现密码
			if (tixianmima.getText().toString().length() == 0) {
				Toast.makeText(TiXianActivity.this, "请输入提现密码", 1000).show();
				return;
			}

			chongzhiModel.setPassword(tixianmima.getText().toString());
			chongzhiModel.setMoney(tixianjiner.getText().toString());

			// 获取提款的密码
			loadHttp_tikuancode();

			break;

		default:
			break;
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

				Toast.makeText(TiXianActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:
				// 停止菊花

				// 下一步

				Intent intent1 = new Intent(TiXianActivity.this,
						QueRenTiXianActivity.class);
				intent1.putExtra("chongzhiModel", chongzhiModel);
				TiXianActivity.this.finish();
				startActivity(intent1);
				anim_right_in();

				break;
			case 2:
				Toast.makeText(TiXianActivity.this,
						msg.getData().getString("msg"), 1000).show();
				break;

			default:
				break;
			}
		}
	};

	// 判断提款密码的信息
	private void loadHttp_tikuancode() {
		// TODO Auto-generated method stub

		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "2");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("password", tixianmima.getText().toString());

		RequestThreadAbstract thread = RequestFactory.createRequestThread(41,
				map, TiXianActivity.this, mHandler);
		// map.put("type", "android");//类型
		// RequestThreadAbstract thread = RequestFactory.createRequestThread(35,
		// map, IndexActivity.this, mHandler);
		RequestPool.execute(thread);
	}

	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub

		Message msg1 = new Message();
		msg1.what = 1;
		mHandler.sendMessage(msg1);

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
