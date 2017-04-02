package com.quqian.lockq;

import com.example.quqian.R;
import com.quqian.activity.LoginActivity;
import com.quqian.activity.MainActivity;
import com.quqian.activity.mine.ZhangHuGuanLiActivity;
import com.quqian.activity.more.MoreActivity;
import com.quqian.activity.more.SheZhiActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.UserMode;
import com.quqian.lock.widget.GestureContentView;
import com.quqian.lock.widget.GestureDrawline.GestureCallBack;
import com.quqian.util.CommonUtil;
import com.quqian.util.Tool;

import android.R.integer;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.text.Html;
import android.text.TextUtils;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

/**
 * 
 * 手势绘制/校验界面
 *
 */
public class GestureVerifyActivity extends BaseActivity implements android.view.View.OnClickListener {
	/** 手机号码*/
	public static final String PARAM_PHONE_NUMBER = "PARAM_PHONE_NUMBER";
	/** 意图 */
	public static final String PARAM_INTENT_CODE = "PARAM_INTENT_CODE";
	
	
	private ImageView mImgUserLogo;
	private TextView mTextPhoneNumber;
	private TextView mTextTip;
	private FrameLayout mGestureContainer;
	private GestureContentView mGestureContentView;
	private TextView mTextForget;
	private TextView mTextOther;
	private String mParamPhoneNumber;
	private long mExitTime = 0;
	private int mParamIntentCode;

	//忘记密码跟其他登录方式的按钮，布局
	private LinearLayout layout = null;
	
	//手势密码
	private String password_showshi = "";
	//判断类型，是否是 jiaoyan,denglu,
	private String type = "";
	
	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.activity_gesture_verify;
	}
	
	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
		if(getIntent().getStringExtra("type")!= null){
			type = getIntent().getStringExtra("type");
		}
		UserMode user = Tool.getUser(this);
		if(user != null && user.getShoushiCode() != null ){
			password_showshi = user.getShoushiCode();
		}else{
			//字典mode里面没有了手势密码，应该是跳转到登录界面，在这里还要判断输入错误的次数
			finish();
		}
		
	}
	
	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		layout = (LinearLayout)findViewById(R.id.jiaoyan_layout);
		if("jiaoyan".equals(type)){
			layout.setVisibility(View.GONE);
		}else{
			layout.setVisibility(View.VISIBLE);
		}
		
		ObtainExtraData();
		setUpViews();
		setUpListeners();
	}
	
	private void ObtainExtraData() {
		mParamPhoneNumber = getIntent().getStringExtra(PARAM_PHONE_NUMBER);
		mParamIntentCode = getIntent().getIntExtra(PARAM_INTENT_CODE, 0);
	}
	
	private void setUpViews() {
		
		mImgUserLogo = (ImageView) findViewById(R.id.user_logo);
		mTextPhoneNumber = (TextView) findViewById(R.id.text_phone_number);
		
		UserMode user = Tool.getUser(this);
		if(user.getNc() == null || "".equals(user.getNc())){
			mTextPhoneNumber.setText(user.getYhzh());
		}else{
			mTextPhoneNumber.setText(user.getNc());
		}
		
		
		mTextTip = (TextView) findViewById(R.id.text_tip);
		mGestureContainer = (FrameLayout) findViewById(R.id.gesture_container);
		mTextForget = (TextView) findViewById(R.id.text_forget_gesture);
		mTextOther = (TextView) findViewById(R.id.text_other_account);
		
		
		// 初始化一个显示各个点的viewGroup
		mGestureContentView = new GestureContentView(this, true, password_showshi,
				new GestureCallBack() {

					@Override
					public void onGestureCodeInput(String inputCode) {

					}

					@Override
					public void checkedSuccess() {
						
						mGestureContentView.clearDrawlineState(0L);
						
						if(!"".equals(type) && "jiaoyan".equals(type)){
							Intent intent = new Intent(GestureVerifyActivity.this,GestureEditActivity.class);
							intent.putExtra("from", "shezhi");
							startActivity(intent);
						}else{
							startActivity(new Intent(GestureVerifyActivity.this, MainActivity.class));
						}
						UserMode user = Tool.getUser(GestureVerifyActivity.this);
						user.codeError = "0";
						user.saveUserToDB(GestureVerifyActivity.this);
						GestureVerifyActivity.this.finish();
						anim_right_out();
					}

					@Override
					public void checkedFail() {
						mGestureContentView.clearDrawlineState(1300L);
						mTextTip.setVisibility(View.VISIBLE);
					
						UserMode user = Tool.getUser(GestureVerifyActivity.this);
						String a = "";
						if((user.getCodeError().equals(""))){
							a = "0";
						}else{
							a = user.getCodeError();
						}
						int cishu = Integer.valueOf(a);
						if(cishu>=4){
							user.codeError = "0";
							user.setShoushiCode("");
							user.saveUserToDB(GestureVerifyActivity.this);
							Tool.writeData(GestureVerifyActivity.this, "loginState", "zhanghu", "");
							
							Intent intent = new Intent(GestureVerifyActivity.this,LoginActivity.class);
							intent.putExtra("fangxiang", "main");
							startActivity(intent);
							GestureVerifyActivity.this.finish();
							anim_right_out();
						}else{
							Toast.makeText(GestureVerifyActivity.this, "密码错误,您还可以输入"+(4-cishu)+"次", Toast.LENGTH_SHORT).show();
							cishu++;
							user.codeError = cishu+"";
							user.saveUserToDB(GestureVerifyActivity.this);
						}
						
//						mTextTip.setText(Html
//								.fromHtml("<font color='#c70c1e'>密码错误</font>"));
//						// 左右移动动画
//						Animation shakeAnimation = AnimationUtils.loadAnimation(GestureVerifyActivity.this, R.anim.shake);
//						mTextTip.startAnimation(shakeAnimation);
					}
				});
		// 设置手势解锁显示到哪个布局里面
		mGestureContentView.setParentView(mGestureContainer);
	}
	
	private void setUpListeners() {
		mTextForget.setOnClickListener(this);
		mTextOther.setOnClickListener(this);
	}
	
	private String getProtectedMobile(String phoneNumber) {
		if (TextUtils.isEmpty(phoneNumber) || phoneNumber.length() < 11) {
			return "";
		}
		StringBuilder builder = new StringBuilder();
		builder.append(phoneNumber.subSequence(0,3));
		builder.append("****");
		builder.append(phoneNumber.subSequence(7,11));
		return builder.toString();
	}
	
	

	@Override
	public void onClick(View v) {
		switch (v.getId()) {
		case R.id.text_forget_gesture:
			wenxintishi();
			break;
		
		case R.id.text_other_account:
			wenxintishi();
			break;
		default:
			break;
		}
	}

	// 对框框
	private Dialog dialog = null;
	private void wenxintishi(){
		
		View view = LayoutInflater.from(GestureVerifyActivity.this).inflate(R.layout.dialog_all,
				null);
		TextView tv_title = (TextView) view.findViewById(R.id.dialog_title);
		tv_title.setText("温馨提示");
		TextView tv_content = (TextView) view.findViewById(R.id.dialog_content);
		tv_content.setText("忘记手势密码或用其他账号登录");
		Button tv_cancel = (Button) view.findViewById(R.id.dialog_cancel);
		Button tv_submit = (Button) view.findViewById(R.id.dialog_submit);
		tv_cancel.setText("取消");
		tv_submit.setText("确认");
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
				UserMode user = Tool.getUser(GestureVerifyActivity.this);
				user.codeError = "0";
				user.setShoushiCode("");
				user.saveUserToDB(GestureVerifyActivity.this);
				Tool.writeData(GestureVerifyActivity.this, "loginState", "zhanghu", "");
				
				Intent intent = new Intent(GestureVerifyActivity.this,LoginActivity.class); 
				intent.putExtra("fangxiang", "main");
	            startActivity(intent); 
	            GestureVerifyActivity.this.finish();
	            dialog.dismiss();
			}
		});
		
		dialog = new AlertDialog.Builder(GestureVerifyActivity.this).setView(view).create();
		dialog.show();
	
	}
	
	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		// TODO Auto-generated method stub
		if(keyCode == KeyEvent.KEYCODE_BACK){
			return false;
		}
		return false;
	}
	
	
}
