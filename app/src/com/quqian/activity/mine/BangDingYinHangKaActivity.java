package com.quqian.activity.mine;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
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
import android.os.Parcelable;
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
import com.quqian.base.BaseActivity;
import com.quqian.been.Chongzhi;
import com.quqian.been.QuYu;
import com.quqian.been.UserMode;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.Tool;
import com.quqian.util.view.WheelViewDialog;
import com.quqian.util.view.WheelViewDialog.WheelCallback;

public class BangDingYinHangKaActivity extends BaseActivity implements
		OnClickListener, HttpResponseInterface {

	// 开户名
	private TextView kaihuming = null;
	// 选择银行
	private TextView xuanzeyinhang = null;

	// 开户所在地
	private TextView kahudi = null;
	// 开户行
	private EditText kahuhang = null;
	// 银行卡号
	private EditText yinhangkahao = null;

	// 确认绑定
	private Button next = null;

	private Chongzhi chongzhiModel = null;

	private ArrayList<Map<String, String>> arr = new ArrayList<Map<String, String>>();
	private ArrayList<QuYu> arrQuYu = new ArrayList<QuYu>();

	private ProcessDialogUtil juhua = null;

	JSONArray quyuArray = null;
	
	// 接受广播
	BroadcastReceiver mBroadcastReceiver = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_mine_bangdingyinhangka;
	}

	@Override
	protected void onDestroy() {
		super.onDestroy();
		unregisterReceiver(mBroadcastReceiver);
	}

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
		Intent intent = getIntent();
		chongzhiModel = (Chongzhi) intent.getSerializableExtra("chongzhiModel");
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle(chongzhiModel.getTitle());
		showBack();

		juhua = new ProcessDialogUtil(BangDingYinHangKaActivity.this);

		kaihuming = (TextView) findViewById(R.id.main_mine_bangding_kaihuming);
		xuanzeyinhang = (TextView) findViewById(R.id.main_mine_bangding_xuanzeyinhang);
		kahudi = (TextView) findViewById(R.id.main_mine_bangding_kaihusuozaidi);
		kahuhang = (EditText) findViewById(R.id.main_mine_bangding_kaihuhang);
		yinhangkahao = (EditText) findViewById(R.id.main_mine_bangding_yinhangkahao);

		next = (Button) findViewById(R.id.main_mine_bangding_next);

		UserMode user = Tool.getUser(BangDingYinHangKaActivity.this);
		kaihuming.setText(user.getXm());

		// 绑定银行卡信息
		if (chongzhiModel.getType().equals("0")) {
			next.setText("绑定银行卡");
		} else {// 修改和完善银行卡信息
			loadHttp_bankInfo();
			next.setText("完成");
		}

		// 接受广播
		mBroadcastReceiver = new BroadcastReceiver() {
			@Override
			public void onReceive(Context arg0, Intent arg1) {
				// TODO Auto-generated method stub
				  
				if(arg1.getStringExtra("type").equals("0")){
					
					String bankId = (String)arg1.getStringExtra("bankId");
					String bankName = (String)arg1.getStringExtra("bankName");
					
					chongzhiModel.setBankId(bankId);
					chongzhiModel.setBankName(bankName);
					xuanzeyinhang.setText(chongzhiModel.getBankName());
					
				} else{
			   
					String ss = (String)arg1.getStringExtra("cityId");
					chongzhiModel.setCity((String)arg1.getStringExtra("city"));
					chongzhiModel.setCityId((String)arg1.getStringExtra("cityId"));
					kahudi.setText(chongzhiModel.getCity());
					 
				}
			}
		};
		IntentFilter intentFilter = new IntentFilter();
		intentFilter.addAction("xiugaiyinhanghangkashuxinshju");
		registerReceiver(mBroadcastReceiver, intentFilter);

	}

	
	
	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);

		xuanzeyinhang.setOnClickListener(this);
		kahudi.setOnClickListener(this);
		next.setOnClickListener(this);

	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_back:
			BangDingYinHangKaActivity.this.finish();
			anim_right_out();
			break;
		case R.id.main_mine_bangding_xuanzeyinhang:

			// 不可修改银行的信息
			if (chongzhiModel.getIsBound().equals("1")) {
				return;
			}

			loadHttp_allYinhang();

			break;
		case R.id.main_mine_bangding_kaihusuozaidi:
			// 请选择开户所在地
			
			Intent intent2 = new Intent(BangDingYinHangKaActivity.this,
					SelectInfoActivity.class);
			intent2.putExtra("title", "选择省份");
			intent2.putExtra("type1", "0");
			intent2.putExtra("type", "1");
			startActivity(intent2);
			anim_right_in();
			
			
			//loadHttp_kaihuhangsuozaidi();
			break;
		case R.id.main_mine_bangding_next:
			// 下一步
			loadHttp_bangding();
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

				Toast.makeText(BangDingYinHangKaActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1: // 获取银行卡信息

				yinhangkahao.setText(chongzhiModel.getBankNumber());
				xuanzeyinhang.setText(chongzhiModel.getBankName());
				kahudi.setText(chongzhiModel.getCity());
				kahuhang.setText(chongzhiModel.getSubbranch());

				//不可编辑
				if (chongzhiModel.getIsBound().equals("1")) {
					xuanzeyinhang.setFocusableInTouchMode(false);
					yinhangkahao.setFocusableInTouchMode(false);
					yinhangkahao.setEnabled(false);
				}

				break;
			case 3:// 绑定和修改银行卡

				Toast.makeText(BangDingYinHangKaActivity.this,"成功", 1000).show();
				
				Intent intent = new Intent();
				intent.setAction("tixianshuaxindata");
				intent.putExtra("chongzhiModel", chongzhiModel);
				sendBroadcast(intent);
				BangDingYinHangKaActivity.this.finish();
				anim_right_out();
				break;
			case 4:// 获取所有的银行卡列表

				Intent intent1 = new Intent(BangDingYinHangKaActivity.this,
						SelectInfoActivity.class);
				intent1.putExtra("arr_bank_map", arr);
				intent1.putExtra("title", "选择银行");
				intent1.putExtra("type", "0");
				startActivity(intent1);
				anim_right_in();

				break;
			case 5: // 获取银行卡开户所在地

				Intent intent2 = new Intent(BangDingYinHangKaActivity.this,
						SelectInfoActivity.class);
				intent2.putExtra("arr_bank_map", arrQuYu);
				intent2.putExtra("title", "选择银行卡");
				intent2.putExtra("type1", "0");
				intent2.putExtra("type", "1");
				startActivity(intent2);
				anim_right_in();

				break;
			case 2:

				// 特殊处理
				if (msg.getData().getString("tag").equals("1")) {
					BangDingYinHangKaActivity.this.finish();
					anim_right_out();
				}
				Toast.makeText(BangDingYinHangKaActivity.this,
						msg.getData().getString("msg"), 1000).show();
				break;
			default:
				break;
			}
		}
	};

	// 获取银行卡信息
	private void loadHttp_bankInfo() {
		// TODO Auto-generated method stub

		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		RequestThreadAbstract thread = RequestFactory.createRequestThread(43,
				map, BangDingYinHangKaActivity.this, mHandler);
		RequestPool.execute(thread);
	}

	// 绑定银行卡信息
	private void loadHttp_bangding() {
		// TODO Auto-generated method stu
		// 参数判断
		
		if (yinhangkahao.getText().toString().length() == 0) {
			Toast.makeText(BangDingYinHangKaActivity.this, "请输入银行卡号", 1000)
					.show();
			return;
		}
 
		if (chongzhiModel.getBankName().equals("")) {
			Toast.makeText(BangDingYinHangKaActivity.this, "请选择银行", 1000)
					.show();
			return;
		}

		if(chongzhiModel.getCityId() == null){
			Toast.makeText(BangDingYinHangKaActivity.this, "请选择开户所在地", 1000)
			.show();
			return;
		}
		if (chongzhiModel.getCityId().length() == 0) {
			Toast.makeText(BangDingYinHangKaActivity.this, "请选择开户所在地", 1000)
					.show();
			return;
		}

		if (kahuhang.getText().toString().length() == 0) {
			Toast.makeText(BangDingYinHangKaActivity.this, "请填写开户行", 1000)
					.show();
			return;
		}

		chongzhiModel.setBankNumber(yinhangkahao.getText().toString());

		juhua.show();
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "3");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁

		// 银行信息id
		if (chongzhiModel.getBankCardId().equals("")) {
			map.put("bankCardId", "");
		} else {
			map.put("bankCardId", chongzhiModel.getBankCardId());
		}
		map.put("bankNumber", yinhangkahao.getText().toString());
		
		try {
			map.put("subbranch",URLEncoder.encode(kahuhang.getText().toString(), "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		map.put("bankId", chongzhiModel.getBankId());
		map.put("cityId", chongzhiModel.getCityId());

		RequestThreadAbstract thread = RequestFactory.createRequestThread(46,
				map, BangDingYinHangKaActivity.this, mHandler);
		RequestPool.execute(thread);
	}

	// 获取银行
	private void loadHttp_allYinhang() {
		// TODO Auto-generated method stu
		juhua.show();
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "4");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		RequestThreadAbstract thread = RequestFactory.createRequestThread(44,
				map, BangDingYinHangKaActivity.this, mHandler);
		RequestPool.execute(thread);
	}

	// 获取开户行所在地址
	private void loadHttp_kaihuhangsuozaidi() {
		// TODO Auto-generated method stu
		juhua.show();
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "5");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		RequestThreadAbstract thread = RequestFactory.createRequestThread(45,
				map, BangDingYinHangKaActivity.this, mHandler);
		RequestPool.execute(thread);
	}

	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub

		// 获取银行卡信息
		if (map.get("urlTag").equals("1")) {
			// 储存银行卡信息
			chongzhiModel = new Chongzhi();
			chongzhiModel.initMakeData_bankInfo((JSONObject) jsonObj);

			Message msg1 = new Message();
			msg1.what = 1;
			mHandler.sendMessage(msg1);
		} else if (map.get("urlTag").equals("3")) {// 绑定银行卡

			JSONObject json = (JSONObject) jsonObj;
			try {
				chongzhiModel.setBankCardId(json.getJSONObject("rvalue")
						.getString("bankCardId"));
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			Message msg1 = new Message();
			msg1.what = 3;
			mHandler.sendMessage(msg1);
		} else if (map.get("urlTag").equals("4")) {// 获取所有的银行

			arr.clear();
			JSONObject json = (JSONObject) jsonObj;
			try {
				JSONArray rvalueArray1 = json.getJSONArray("rvalue");
				for (int i = 0; i < rvalueArray1.length(); i++) {
					JSONObject jsonM = rvalueArray1.getJSONObject(i);
					Map<String, String> map12 = new HashMap<String, String>();
					map12.put("bankName", jsonM.getString("bankName"));
					map12.put("bankId", jsonM.getString("bankId"));
					arr.add(map12);
				}
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			Message msg1 = new Message();
			msg1.what = 4;
			mHandler.sendMessage(msg1);
		} else if (map.get("urlTag").equals("5")) {// 获取开户所在地
			
			JSONObject json = (JSONObject) jsonObj;
			
			
			try {
				quyuArray  = json.getJSONArray("rvalue");
				for (int i = 0; i < quyuArray.length(); i++) {
					JSONObject jsonM = quyuArray.getJSONObject(i);
					QuYu qu = new QuYu();
					qu.setId(jsonM.getString("id"));
					qu.setName(jsonM.getString("name"));
					 
					ArrayList<QuYu> quyuLiset = new ArrayList<QuYu>();
					for(int j = 0; j < jsonM.getJSONArray("children").length(); j++){
						JSONArray rvalueArray2 = jsonM.getJSONArray("children");
						JSONObject jsonN = rvalueArray2.getJSONObject(i);
						QuYu qu1 = new QuYu();
						qu1.setId(jsonN.getString("id"));
						qu1.setName(jsonN.getString("name"));
						rvalueArray2.put(qu1);
					} 
					
					qu.setList(quyuLiset); 
					arrQuYu.add(qu);
				}
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
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
		bundle.putString("tag", map.get("urlTag"));
		bundle.putString("msg", msg);
		msg2.setData(bundle);
		mHandler.sendMessage(msg2);
	}

}
