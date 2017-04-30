package com.quqian.activity.mine;

import java.util.List;
import java.util.Map;

import android.app.AlertDialog;
import android.app.Dialog;
import android.app.ActionBar.LayoutParams;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.Uri;
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
import android.widget.ToggleButton;

import com.example.quqian.R;
import com.quqian.activity.LoginActivity;
import com.quqian.activity.MainActivity;
import com.quqian.activity.index.IndexActivity;
import com.quqian.activity.more.SheZhiActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.UserMode;
import com.quqian.lockq.GestureVerifyActivity;
import com.quqian.util.CommonUtil;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.StaticVariable;
import com.quqian.util.Tool;

public class AnQuanXinXiActivity extends BaseActivity implements
		OnClickListener, HttpResponseInterface {

	// 身份证
	private TextView card = null;
	// 实名信息
	private TextView shiming = null;
	// 手机号
	private TextView shouji = null;
	// 设置 ,未设置
	private TextView shezhi = null;

	// 实名认证
	private RelativeLayout layout_shiming = null;
	// 修改手机
	private TextView layout_xiugai = null;
	// 登录密码
	private TextView layout_tixian = null;

	// 手势密码
	private ToggleButton shoushianniu = null;
	private RelativeLayout layout = null;
	private View view = null;
	private Button btn = null;

	private UserMode user = null;

	private Dialog juhua = null;

	// 接受广播
	BroadcastReceiver mBroadcastReceiver = null;

	@Override
	protected void onDestroy() {
		super.onDestroy();
		unregisterReceiver(mBroadcastReceiver);
	}

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_mine_anquan;
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("设置");
		showBack();

		juhua = new ProcessDialogUtil(AnQuanXinXiActivity.this);

		card = (TextView) findViewById(R.id.main_mine_anquan_card);
		shiming = (TextView) findViewById(R.id.main_mine_anquan_shiming);
		shouji = (TextView) findViewById(R.id.main_mine_anquan_shouji);
		shezhi = (TextView) findViewById(R.id.main_mine_anquan_shezhi);

		layout_shiming = (RelativeLayout) findViewById(R.id.main_mine_anquan_layout_shiming1);
		layout_xiugai = (TextView) findViewById(R.id.main_mine_anquan_layout_xiugai);
		layout_tixian = (TextView) findViewById(R.id.main_mine_anquan_layout_tixian);

		//
		shoushianniu = (ToggleButton) findViewById(R.id.sz_shoushi);
		view = (View) findViewById(R.id.sz_view);
		layout = (RelativeLayout) findViewById(R.id.sz_layout);
		btn = (Button) findViewById(R.id.sz_btn);

		// 加载数据
		reloadData();

		// 接受广播
		mBroadcastReceiver = new BroadcastReceiver() {
			@Override
			public void onReceive(Context arg0, Intent arg1) {
				// TODO Auto-generated method stub
				// Intent intent = getIntent();
				reloadData();

				// 发送通知
				Intent intent = new Intent();
				intent.setAction("dengluhoushuaxinshuju");
				sendBroadcast(intent);
			}
		};
		IntentFilter intentFilter = new IntentFilter();
		intentFilter.addAction("wanchenghoudeshuaxin");
		registerReceiver(mBroadcastReceiver, intentFilter);

	}

	public void reloadData() {
		// 进行初始化赋值--获取用户的信息
		user = Tool.getUser(AnQuanXinXiActivity.this);
		// 没有实名认证
		if (user.getSfzsfrz().equals("false")) {
			card.setVisibility(View.GONE);
			shiming.setText("设置");
			shiming.setTextColor(getResources().getColor(R.color.main_blue));
		} else {
			// 设置数据
			card.setVisibility(View.VISIBLE);
			card.setText(user.getSfzh());
			shiming.setText(user.getXm());
			shiming.setTextColor(getResources().getColor(
					R.color.main_text_black));
		}
		// 没有设置了手机号
		if (user.getSjsfsz().equals("false")) {

		} else {
			// 设置数据
			shouji.setText(user.new_mobile());
		}
		// 没有设置登录密码
		// if (user.getTxmmsfsz().equals("false")) {
		// shezhi.setVisibility(View.GONE);
		// } else {
		// // 设置数据
		// shezhi.setVisibility(View.VISIBLE);
		// }
	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);

		layout_shiming.setOnClickListener(this);
		layout_xiugai.setOnClickListener(this);
		layout_tixian.setOnClickListener(this);
		shoushianniu.setOnClickListener(this);
		layout.setOnClickListener(this);
		btn.setOnClickListener(this);

	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_back:
			AnQuanXinXiActivity.this.finish();
			anim_right_out();
			break;
		case R.id.main_mine_anquan_layout_shiming:
			// 没有实名认证
			if (user.getSfzsfrz().equals("false")) {
				startActivity(new Intent(AnQuanXinXiActivity.this,
						ShiMingRenZhengActivity.class));
				anim_right_in();
			}
			break;
		case R.id.main_mine_anquan_layout_xiugai:
			if (user.getSjsfsz().equals("false")) {

			} else {
				// 修改手机
				startActivity(new Intent(AnQuanXinXiActivity.this,
						XiuGaiShouJiActivity.class));
				anim_right_in();
			}
			break;
		case R.id.main_mine_anquan_layout_tixian:
			// if (user.getTxmmsfsz().equals("false")) {
			// startActivity(new Intent(AnQuanXinXiActivity.this,
			// SheZhiTiXianMiMaActivity.class));
			// anim_right_in();
			// } else {
			// xiugaizhaohui();
			// }
			// 设置登录密码
			startActivity(new Intent(AnQuanXinXiActivity.this,
					XiuGaiDengLuMiMaActivity.class));
			anim_right_in();
			break;

		case R.id.sz_shoushi:
			// 手势按钮，
			if (shoushianniu.isChecked()) {
				view.setVisibility(View.VISIBLE);
				layout.setVisibility(View.VISIBLE);
			} else {
				view.setVisibility(View.GONE);
				layout.setVisibility(View.GONE);
			}

			break;
		case R.id.sz_layout:
			UserMode user = Tool.getUser(this);
			if (user == null) {
				// 跳转到登录页面，
				startActivity(new Intent(AnQuanXinXiActivity.this,
						LoginActivity.class));
			} else {
				// 跳转到校验手势
				Intent intent = new Intent(AnQuanXinXiActivity.this,
						GestureVerifyActivity.class);
				intent.putExtra("type", "jiaoyan");
				startActivity(intent);
			}
			break;

		case R.id.sz_btn:
			// 退出按钮
			clearLogin();
			Intent intent3 = new Intent(this, MainActivity.class);
			StaticVariable.put(StaticVariable.sv_toIndex, "1");
			startActivity(intent3);
			finish();
			anim_right_out();
			break;
		default:
			break;
		}
	}

	// 清除登录账户，仅仅是登录人的登录状态，
	private void clearLogin() {
		CommonUtil.clearByKey(AnQuanXinXiActivity.this, "loginState", "", "");
	}

	private Dialog dialog = null;

	// 修改找回的对话框
	private void xiugaizhaohui() {

		View view = LayoutInflater.from(AnQuanXinXiActivity.this).inflate(
				R.layout.dialog_xiugai, null);

		Button d_xiugai = (Button) view.findViewById(R.id.dialog_down_xiugai);
		Button d_zhaohui = (Button) view.findViewById(R.id.dialog_down_zhaohui);
		Button d_quxiao = (Button) view.findViewById(R.id.dialog_down_quxiao);

		d_xiugai.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View arg0) {
				// TODO Auto-generated method stub
				startActivity(new Intent(AnQuanXinXiActivity.this,
						XiuGaiDengLuMiMaActivity.class));
				anim_right_in();
				dialog.dismiss();
			}
		});

		d_zhaohui.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View arg0) {
				// TODO Auto-generated method stub
				startActivity(new Intent(AnQuanXinXiActivity.this,
						ZhaoHuiTiXianMiMaActivity.class));
				anim_right_in();
				dialog.dismiss();
			}
		});

		d_quxiao.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View arg0) {
				// TODO Auto-generated method stub
				dialog.dismiss();
			}
		});

		dialog = new AlertDialog.Builder(AnQuanXinXiActivity.this)
				.setView(view).create();

		Window window = dialog.getWindow();

		// WindowManager m = getWindowManager();
		// Display d = m.getDefaultDisplay(); // 获取屏幕宽、高用
		// WindowManager.LayoutParams p = window.getAttributes(); // 获取对话框当前的参数值
		// p.height = (int)( d.getHeight()*0.3 ); // 高度设置为屏幕
		// p.width = (int) d.getWidth() ; // 宽度设置为屏幕
		//
		// window.setAttributes(p);
		window.setGravity(Gravity.BOTTOM);
		window.setWindowAnimations(R.style.mydialogstyle);

		dialog.show();
	}

	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub

	}

	@Override
	public void httpResponse_fail(Map<String, String> map, String msg,
			Object jsonObj) {
		// TODO Auto-generated method stub

	}

}
