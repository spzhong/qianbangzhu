package com.quqian.lockq;

import com.example.quqian.R;
import com.quqian.activity.LoginActivity;
import com.quqian.activity.MainActivity;
import com.quqian.activity.mine.AnQuanXinXiActivity;
import com.quqian.activity.more.SheZhiActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.UserMode;
import com.quqian.lock.common.Constants;
import com.quqian.lock.widget.GestureContentView;
import com.quqian.lock.widget.LockIndicator;
import com.quqian.lock.widget.GestureDrawline.GestureCallBack;
import com.quqian.util.CommonUtil;
import com.quqian.util.StaticVariable;
import com.quqian.util.Tool;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.telephony.gsm.GsmCellLocation;
import android.text.Html;
import android.text.TextUtils;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.FrameLayout;
import android.widget.TextView;
import android.widget.Toast;

/**
 * 
 * 手势密码设置界面
 *
 */
public class GestureEditActivity extends BaseActivity implements OnClickListener {
	/** 手机号码*/
	public static final String PARAM_PHONE_NUMBER = "PARAM_PHONE_NUMBER";
	/** 意图 */
	public static final String PARAM_INTENT_CODE = "PARAM_INTENT_CODE";
	/** 首次提示绘制手势密码，可以选择跳过 */
	public static final String PARAM_IS_FIRST_ADVICE = "PARAM_IS_FIRST_ADVICE";
	
	private TextView mTextTip;
	private FrameLayout mGestureContainer;
	private GestureContentView mGestureContentView;
	private TextView mTextReset;
	private String mParamSetUpcode = null;
	private String mParamPhoneNumber;
	private boolean mIsFirstInput = true;
	private String mFirstPassword = null;
	private String mConfirmPassword = null;
	private int mParamIntentCode;

	//type 0是设置手势密码，1是确认手势密码，3是验证手势密码
	//fromActivity 上层来源 login,register,shezhi
	private String type = "";
	private String from = "";
	
	
	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.activity_gesture_edit;
	}
	
	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
		Intent intent = getIntent();
		type = intent.getStringExtra("type");
		from = intent.getStringExtra("from");
		
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		
		setUpViews();
		setUpListeners();
	}	
	
	private void setUpViews() {
		//mTextTitle = (TextView) findViewById(R.id.text_title);
		//mTextCancel = (TextView) findViewById(R.id.text_cancel);
		mTextReset = (TextView) findViewById(R.id.text_reset);
		mTextReset.setClickable(false);
		//mLockIndicator = (LockIndicator) findViewById(R.id.lock_indicator);
		mTextTip = (TextView) findViewById(R.id.text_tip);
		mGestureContainer = (FrameLayout) findViewById(R.id.gesture_container);
		// 初始化一个显示各个点的viewGroup
		mGestureContentView = new GestureContentView(this, false, "", new GestureCallBack() {
			@Override
			public void onGestureCodeInput(String inputCode) {
				if (!isInputPassValidate(inputCode)) {
					Toast.makeText(GestureEditActivity.this, "最少链接4个点, 请重新输入", Toast.LENGTH_SHORT).show();
					//mTextTip.setText(Html.fromHtml("<font color='#c70c1e'>最少链接4个点, 请重新输入</font>"));
					mGestureContentView.clearDrawlineState(0L);
					return;
				}
				if (mIsFirstInput) {
					mFirstPassword = inputCode;
					//updateCodeList(inputCode);
					mGestureContentView.clearDrawlineState(0L);
					mTextTip.setText(getString(R.string.setup_gesture_pattern_again));
					mTextReset.setClickable(true);
					mTextReset.setText(getString(R.string.reset_gesture_code));
				} else {
					if (inputCode.equals(mFirstPassword)) {
						Toast.makeText(GestureEditActivity.this, "设置成功", Toast.LENGTH_SHORT).show();
						mGestureContentView.clearDrawlineState(0L);
						
						//写入手势密码
						//CommonUtil.addConfigInfo(GestureEditActivity.this, "shoushi", inputCode, "", "");
						UserMode user = Tool.getUser(GestureEditActivity.this);
						user.setShoushiCode(inputCode);
						user.saveUserToDB(GestureEditActivity.this);
						
						if("login".equals(from)){
							Intent intent3 = new Intent(GestureEditActivity.this,
									MainActivity.class);
							StaticVariable.put(StaticVariable.sv_toIndex, "1");
							startActivity(intent3);
						}else if("shezhi".equals(from)){
							Intent intent3 = new Intent(GestureEditActivity.this,
									AnQuanXinXiActivity.class);
							startActivity(intent3);
						}
						GestureEditActivity.this.finish();
						anim_right_out();
					} else {
						Toast.makeText(GestureEditActivity.this, "与上一次输入不一致, 请重新输入", Toast.LENGTH_SHORT).show();
						//mTextTip.setText(Html.fromHtml("<font color='#c70c1e'>与上一次绘制不一致，请重新绘制</font>"));
						// 左右移动动画
						//Animation shakeAnimation = AnimationUtils.loadAnimation(GestureEditActivity.this, R.anim.shake);
						//mTextTip.startAnimation(shakeAnimation);
						// 保持绘制的线，1.5秒后清除
						mGestureContentView.clearDrawlineState(1300L);
					}
				}
				mIsFirstInput = false;
			}

			@Override
			public void checkedSuccess() {
				
			}

			@Override
			public void checkedFail() {
				
			}
		});
		// 设置手势解锁显示到哪个布局里面
		mGestureContentView.setParentView(mGestureContainer);
		//updateCodeList("");
	}
	
	private void setUpListeners() {
		//mTextCancel.setOnClickListener(this);
		mTextReset.setOnClickListener(this);
	}
	
//	private void updateCodeList(String inputCode) {
//		// 更新选择的图案
//		mLockIndicator.setPath(inputCode);
//	}

	@Override
	public void onClick(View v) {
		switch (v.getId()) {
		case R.id.text_reset:
			mIsFirstInput = true;
			//updateCodeList("");
			mTextTip.setText(getString(R.string.set_gesture_pattern));
			mTextReset.setText(getString(R.string.set_gesture_pattern_reason));
			break;
		default:
			break;
		}
	}
	
	private boolean isInputPassValidate(String inputPassword) {
		if (TextUtils.isEmpty(inputPassword) || inputPassword.length() < 4) {
			return false;
		}
		return true;
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
