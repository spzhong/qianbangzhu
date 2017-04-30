package com.quqian.activity.mine.xin;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.os.Message;
import android.provider.MediaStore;
import android.util.Base64;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.mine.SelectInfoActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.Chongzhi;
import com.quqian.been.QuYu;
import com.quqian.been.UserMode;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ImageThumbnail;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.Tool;

public class QiYeBangDingYinHangKaActivity extends BaseActivity implements
		OnClickListener, HttpResponseInterface {

	// 开户名
	private EditText kaihuming = null;
	// 开户身份证
	private EditText shenfenzheng = null;
	// 企业名称
	private EditText qiye = null;
	// 社会统一信用代码
	private EditText shehui = null;
	// 选择银行
	private TextView xuanzeyinhang = null;
	// 开户所在地
	private TextView kahudi = null;
	// 开户行所在城市
	private TextView kahuchengshi = null;

	private String shengId = null;
	
	private String imgbitbase64String = null;

	// 银行卡号
	private EditText yinhangkahao = null;

	// 图片
	private ImageView img = null;
	// 上传按钮
	private TextView shangchuan = null;

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
		return R.layout.main_mine_bangdingyinhangkaqiye;
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
		chongzhiModel = new Chongzhi();
		chongzhiModel.setType("0");

	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("企业账户绑定卡");
		showBack();

		juhua = new ProcessDialogUtil(QiYeBangDingYinHangKaActivity.this);

		kaihuming = (EditText) findViewById(R.id.main_mine_bangding_q_kaihuming);
		xuanzeyinhang = (TextView) findViewById(R.id.main_mine_bangding_q_xuanzeyinhang);
		kahudi = (TextView) findViewById(R.id.main_mine_bangding_q_kaihusuozaidi);
		// kahuchengshi = (TextView)
		// findViewById(R.id.main_mine_bangding_q_kaihusuozaishi);
		shenfenzheng = (EditText) findViewById(R.id.main_mine_bangding_q_shenfenzheng);
		yinhangkahao = (EditText) findViewById(R.id.main_mine_bangding_q_yinhangkahao);
		qiye = (EditText) findViewById(R.id.main_mine_bangding_q_qiye);
		shehui = (EditText) findViewById(R.id.main_mine_bangding_q_shehui);
		img = (ImageView) findViewById(R.id.main_mine_bangding_q_shangchuan);
		shangchuan = (TextView) findViewById(R.id.main_mine_bangding_q_shangchuanbtn);

		next = (Button) findViewById(R.id.main_mine_bangding_q_next);

		UserMode user = Tool.getUser(QiYeBangDingYinHangKaActivity.this);
		kaihuming.setText(user.getXm());

		// 绑定银行卡信息
		if (chongzhiModel.getType().equals("0")) {
			next.setText("绑定企业账户");
		} else {// 修改和完善银行卡信息
			loadHttp_bankInfo();
			next.setText("完成");
		}

		// 接受广播
		mBroadcastReceiver = new BroadcastReceiver() {
			@Override
			public void onReceive(Context arg0, Intent arg1) {
				// TODO Auto-generated method stub

				if (arg1.getStringExtra("type").equals("0")) {

					String bankId = (String) arg1.getStringExtra("bankId");
					String bankName = (String) arg1.getStringExtra("bankName");

					chongzhiModel.setBankId(bankId);
					chongzhiModel.setBankName(bankName);
					xuanzeyinhang.setText(chongzhiModel.getBankName());

				} else {

					String ss = (String) arg1.getStringExtra("cityId");
					chongzhiModel.setCity((String) arg1.getStringExtra("city"));
					chongzhiModel.setCityId((String) arg1
							.getStringExtra("cityId"));
					kahudi.setText(chongzhiModel.getCity());
					shengId = (String) arg1.getStringExtra("shengid");
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
		// kahuchengshi.setOnClickListener(this);

		shangchuan.setOnClickListener(this);
		next.setOnClickListener(this);

	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_back:
			QiYeBangDingYinHangKaActivity.this.finish();
			anim_right_out();
			break;
		case R.id.main_mine_bangding_q_xuanzeyinhang:

			loadHttp_allYinhang();

			break;
		case R.id.main_mine_bangding_q_kaihusuozaidi:
			// 请选择开户所在地

			Intent intent2 = new Intent(QiYeBangDingYinHangKaActivity.this,
					SelectInfoActivity.class);
			intent2.putExtra("title", "选择省份");
			intent2.putExtra("type1", "0");
			intent2.putExtra("type", "1");
			startActivity(intent2);
			anim_right_in();

			// loadHttp_kaihuhangsuozaidi();
			break;
		// case R.id.main_mine_bangding_q_kaihusuozaishi:
		// // 请选择开户所在地
		//
		// Intent intent3 = new Intent(QiYeBangDingYinHangKaActivity.this,
		// SelectInfoActivity.class);
		// intent3.putExtra("title", "选择省份");
		// intent3.putExtra("type1", "0");
		// intent3.putExtra("type", "1");
		// startActivity(intent3);
		// anim_right_in();
		//
		// // loadHttp_kaihuhangsuozaidi();
		// break;
		case R.id.main_mine_bangding_q_shangchuanbtn:
			// 拍照按钮
			Intent cameraIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
			Uri imageUri = Uri.fromFile(new File(Environment
					.getExternalStorageDirectory(), "workupload.png"));
			// 指定照片保存路径（SD卡），workupload.jpg为一个临时文件，每次拍照后这个图片都会被替换
			cameraIntent.putExtra(MediaStore.EXTRA_OUTPUT, imageUri);
			startActivityForResult(cameraIntent, 1);

			break;
		case R.id.main_mine_bangding_q_next:
			// 下一步
			loadHttp_bangding();
			break;

		default:
			break;
		}
	}

	// 拍照返回
	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		if (resultCode != Activity.RESULT_OK) {// result is not correct
			return;
		} else {
			if (requestCode == 1) {
				// 将保存在本地的图片取出并缩小后显示在界面上
				Bitmap camorabitmap = BitmapFactory.decodeFile(Environment
						.getExternalStorageDirectory() + "/workupload.png");
				if (null != camorabitmap) {
					// 下面这两句是对图片按照一定的比例缩放，这样就可以完美地显示出来。
					int scale = ImageThumbnail.reckonThumbnail(
							camorabitmap.getWidth(), camorabitmap.getHeight(),
							35, 35);
					Bitmap bitMap = ImageThumbnail.PicZoom(camorabitmap,
							camorabitmap.getWidth() / scale,
							camorabitmap.getHeight() / scale);
					// 由于Bitmap内存占用较大，这里需要回收内存，否则会报out of memory异常
					camorabitmap.recycle();
					// 将处理过的图片显示在界面上，并保存到本地
					img.setImageBitmap(bitMap);
					 
					imgbitbase64String =  QiYeBangDingYinHangKaActivity.bitmapToBase64(bitMap);
					 
				}
			}
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

				Toast.makeText(QiYeBangDingYinHangKaActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1: // 获取银行卡信息

				yinhangkahao.setText(chongzhiModel.getBankNumber());
				xuanzeyinhang.setText(chongzhiModel.getBankName());
				kahudi.setText(chongzhiModel.getCity());
				shenfenzheng.setText(chongzhiModel.getSubbranch());

				// 不可编辑
				if (chongzhiModel.getIsBound().equals("1")) {
					xuanzeyinhang.setFocusableInTouchMode(false);
					yinhangkahao.setFocusableInTouchMode(false);
					yinhangkahao.setEnabled(false);
				}

				break;
			case 3:// 绑定和修改银行卡

				Toast.makeText(QiYeBangDingYinHangKaActivity.this, "成功", 1000)
						.show();

				Intent intent = new Intent();
				intent.setAction("tixianshuaxindata");
				intent.putExtra("chongzhiModel", chongzhiModel);
				sendBroadcast(intent);
				QiYeBangDingYinHangKaActivity.this.finish();
				anim_right_out();
				break;
			case 4:// 获取所有的银行卡列表

				Intent intent1 = new Intent(QiYeBangDingYinHangKaActivity.this,
						SelectInfoActivity.class);
				intent1.putExtra("arr_bank_map", arr);
				intent1.putExtra("title", "选择银行");
				intent1.putExtra("type", "0");
				startActivity(intent1);
				anim_right_in();

				break;
			case 5: // 获取银行卡开户所在地

				Intent intent2 = new Intent(QiYeBangDingYinHangKaActivity.this,
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
					QiYeBangDingYinHangKaActivity.this.finish();
					anim_right_out();
				}
				Toast.makeText(QiYeBangDingYinHangKaActivity.this,
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
				map, QiYeBangDingYinHangKaActivity.this, mHandler);
		RequestPool.execute(thread);
	}

	// 绑定银行卡信息
	private void loadHttp_bangding() {
		// TODO Auto-generated method stu
		// 参数判断
		if (kaihuming.getText().toString().length() == 0) {
			Toast.makeText(QiYeBangDingYinHangKaActivity.this, "请输入法人姓名", 1000)
					.show();
			return;
		}

		if (qiye.getText().toString().length() == 0) {
			Toast.makeText(QiYeBangDingYinHangKaActivity.this, "请输入企业名称", 1000)
					.show();
			return;
		}

		if (shehui.getText().toString().length() == 0) {
			Toast.makeText(QiYeBangDingYinHangKaActivity.this, "请输入社会统一信用代码", 1000)
					.show();
			return;
		}
		
		if (yinhangkahao.getText().toString().length() == 0) {
			Toast.makeText(QiYeBangDingYinHangKaActivity.this, "请输入银行卡号", 1000)
					.show();
			return;
		}

		if (chongzhiModel.getBankName().equals("")) {
			Toast.makeText(QiYeBangDingYinHangKaActivity.this, "请选择银行", 1000)
					.show();
			return;
		}

		if (chongzhiModel.getCityId() == null) {
			Toast.makeText(QiYeBangDingYinHangKaActivity.this, "请选择开户所在地", 1000)
					.show();
			return;
		}

		if (shenfenzheng.getText().toString().length() == 0) {
			Toast.makeText(QiYeBangDingYinHangKaActivity.this, "请输入法人身份证号码",
					1000).show();
			return;
		}
		
		//取出图片
		if(imgbitbase64String == null){
			Toast.makeText(QiYeBangDingYinHangKaActivity.this, "请选择企业章图片",
					1000).show();
			return;
		}
		//取出图片
		
		chongzhiModel.setBankNumber(yinhangkahao.getText().toString());

		juhua.show();
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "3");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁

		map.put("realname", kaihuming.getText().toString());
		map.put("idcard", shenfenzheng.getText().toString());
		map.put("corpname", qiye.getText().toString());
		map.put("campcode", shehui.getText().toString());
		map.put("banknumber", yinhangkahao.getText().toString());
		map.put("bankname", chongzhiModel.getBankId());
		map.put("shi", chongzhiModel.getCityId());
		map.put("type", "QYKH");
		map.put("upload",imgbitbase64String);
		map.put("sheng", shengId);
		
		RequestThreadAbstract thread = RequestFactory.createRequestThread(109,
				map, QiYeBangDingYinHangKaActivity.this, mHandler);
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
				map, QiYeBangDingYinHangKaActivity.this, mHandler);
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
				map, QiYeBangDingYinHangKaActivity.this, mHandler);
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
				quyuArray = json.getJSONArray("rvalue");
				for (int i = 0; i < quyuArray.length(); i++) {
					JSONObject jsonM = quyuArray.getJSONObject(i);
					QuYu qu = new QuYu();
					qu.setId(jsonM.getString("id"));
					qu.setName(jsonM.getString("name"));

					ArrayList<QuYu> quyuLiset = new ArrayList<QuYu>();
					for (int j = 0; j < jsonM.getJSONArray("children").length(); j++) {
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
	
	public static String bitmapToBase64(Bitmap bitmap) {  
		  
	    String result = null;  
	    ByteArrayOutputStream baos = null;  
	    try {  
	        if (bitmap != null) {  
	            baos = new ByteArrayOutputStream();  
	            bitmap.compress(Bitmap.CompressFormat.PNG, 100, baos);  
	  
	            baos.flush();  
	            baos.close();  
	  
	            byte[] bitmapBytes = baos.toByteArray();  
	            result = Base64.encodeToString(bitmapBytes, Base64.DEFAULT);  
	        }  
	    } catch (IOException e) {  
	        e.printStackTrace();  
	    } finally {  
	        try {  
	            if (baos != null) {  
	                baos.flush();  
	                baos.close();  
	            }  
	        } catch (IOException e) {  
	            e.printStackTrace();  
	        }  
	    }  
	    return result;  
	}  

}
