package com.quqian.activity.mine;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

import com.example.quqian.R;
import com.google.zxing.WriterException;
import com.loopj.android.image.SmartImageView;
import com.quqian.activity.mine.xin.HuanKuan;
import com.quqian.activity.mine.xin.JiaoYIJiLu;
import com.quqian.base.BaseActivity;
import com.quqian.http.API;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.EncodingHandler;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

public class WoErWeiMaActivity extends BaseActivity implements OnClickListener,HttpResponseInterface {
	
	private SmartImageView image;
	private String fuwuma = "";

	private TextView tv_fuwuma = null;
	private TextView tv_lianjie = null;
	
	ProcessDialogUtil juhua = null;
	
	JSONObject jsonInfo = null;
	
	
	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_mine_erweima;
	}

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
		if (getIntent().getStringExtra("fuwuma") != null) {
			fuwuma = getIntent().getStringExtra("fuwuma");
		}

	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("邀请好友");
		showBack();

		juhua = new ProcessDialogUtil(WoErWeiMaActivity.this);
		
		image = (SmartImageView) findViewById(R.id.erweima);
		tv_fuwuma = (TextView) findViewById(R.id.fuwuma);
		tv_lianjie = (TextView) findViewById(R.id.lianjie);
		
//		tv_fuwuma.setText(fuwuma);
//		tv_lianjie.setText("http://www.qbzvip.com/register.html?code="+fuwuma);
//		image.setImageUrl(path,0, 0);
		
//		Bitmap qrCodeBitmap;
//		try {
//			qrCodeBitmap = EncodingHandler.createQRCode(fuwuma, 150);
//			image.setImageBitmap(qrCodeBitmap);
//		} catch (WriterException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		juhua.show();

		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		RequestThreadAbstract thread = RequestFactory.createRequestThread(113,
				map, WoErWeiMaActivity.this, mHandler);
		RequestPool.execute(thread);
		
		
	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();

		titleBarBack.setOnClickListener(this);
	}

	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		switch (v.getId()) {
		case R.id.title_bar_back:
			this.finish();
			anim_right_out();
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
				Toast.makeText(WoErWeiMaActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:
				try {
					image.setImageUrl(jsonInfo.getString("ewm"),0, 0);
					tv_fuwuma.setText(jsonInfo.getString("fwm"));
	 				tv_lianjie.setText(jsonInfo.getString("url"));
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				 
				break;
			case 2:
				Toast.makeText(WoErWeiMaActivity.this,
						msg.getData().getString("msg"), 1000).show();
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
		JSONObject json = (JSONObject) jsonObj;
		try {
			jsonInfo = json.getJSONObject("rvalue");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Message msg1 = new Message();
		msg1.what = 1;
		mHandler.sendMessage(msg1);
	}

	@Override
	public void httpResponse_fail(Map<String, String> map, String msg,
			Object jsonObj) {
		// TODO Auto-generated method stub
		
	}

	
}
