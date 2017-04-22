package com.quqian.activity.more;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.MainActivity;
import com.quqian.base.BaseActivity;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;

public class MoreActivity extends BaseActivity implements OnClickListener,
		HttpResponseInterface {

	// 版本号
	private TextView tv_banbenhao = null;
	// 客服热线
	private LinearLayout more_kefu = null;
	// 意见反馈
	private LinearLayout more_yijian = null;
	// 检查更新
	private LinearLayout more_jianchagengxin = null;

	// 对框框
	private Dialog dialog = null;

	private Dialog juhua = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_more;
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("更多");

		juhua = new ProcessDialogUtil(MoreActivity.this);

		PackageManager manager;
		PackageInfo info = null;
		manager = this.getPackageManager();
		try {
			info = manager.getPackageInfo(this.getPackageName(), 0);
		} catch (NameNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		String version = info.versionName;

		tv_banbenhao = (TextView) findViewById(R.id.more_banbenhao);
		tv_banbenhao.setText("V" + version);
		more_kefu = (LinearLayout) findViewById(R.id.more_layout_kefurenxian);
		more_yijian = (LinearLayout) findViewById(R.id.more_layout_yijianfankui);
		more_jianchagengxin = (LinearLayout) findViewById(R.id.more_layout_jianchagenxin);

	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();

		more_kefu.setOnClickListener(this);
		more_yijian.setOnClickListener(this);
		more_jianchagengxin.setOnClickListener(this);

	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.more_layout_kefurenxian:
			// 弹出对话框确认拨打电话
			toCall();
			break;
		case R.id.more_layout_yijianfankui:
			// 跳转到意见反馈
			startActivity(new Intent(MoreActivity.this, JianYiActivity.class));
			anim_right_in();
			break;
		case R.id.more_layout_jianchagenxin:
			// 检查更新
			loadHttp_banbengengxi();
			break;
		default:
			break;
		}
	}

	// 打电话的对话框
	private void toCall() {

		View view = LayoutInflater.from(MoreActivity.this).inflate(
				R.layout.dialog_all, null);
		TextView tv_title = (TextView) view.findViewById(R.id.dialog_title);
		tv_title.setText("钱帮主");
		TextView tv_content = (TextView) view.findViewById(R.id.dialog_content);
		tv_content.setText("400-880-5306");
		Button tv_cancel = (Button) view.findViewById(R.id.dialog_cancel);
		Button tv_submit = (Button) view.findViewById(R.id.dialog_submit);
		tv_cancel.setText("取消");
		tv_submit.setText("呼叫");
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
				Intent intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:"
						+ "4008805306"));
				startActivity(intent);
				dialog.dismiss();
			}
		});

		dialog = new AlertDialog.Builder(MoreActivity.this).setView(view)
				.create();
		dialog.show();
	}

	// 检测版本更新
	private void loadHttp_banbengengxi() {

		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "2");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("type", "android");// 类型
		RequestThreadAbstract thread = RequestFactory.createRequestThread(35,
				map, MoreActivity.this, mHandler);
		RequestPool.execute(thread);
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

				Toast.makeText(MoreActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:
				// 停止菊花
				Toast.makeText(MoreActivity.this, "当前版本是最新版本", 1000).show();

				break;
			case 2:
				Toast.makeText(MoreActivity.this,
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
		Message msg2 = new Message();
		msg2.what = 1;
		mHandler.sendMessage(msg2);
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
