package com.quqian.activity.mine;

import com.example.quqian.R;
import com.google.zxing.WriterException;
import com.quqian.base.BaseActivity;
import com.quqian.http.API;
import com.quqian.util.EncodingHandler;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

public class WoErWeiMaActivity extends BaseActivity implements OnClickListener {
	
	private ImageView image;
	private String fuwuma = "";

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
		setTitle("我的二维码");
		showBack();

		image = (ImageView) findViewById(R.id.erweima);

		Bitmap qrCodeBitmap;
		try {
			qrCodeBitmap = EncodingHandler.createQRCode(fuwuma, 500);
			image.setImageBitmap(qrCodeBitmap);

		} catch (WriterException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
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

}
