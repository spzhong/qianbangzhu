package com.quqian.activity.mine;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.base.BaseActivity;
import com.quqian.been.Chongzhi;
import com.quqian.been.UserMode;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.Tool;
import com.yintong.pay.utils.BaseHelper;
import com.yintong.pay.utils.Constants;

public class ChongZhiActivity extends BaseActivity implements OnClickListener,
		HttpResponseInterface {

	// 未绑定布局
	private RelativeLayout layout1 = null;
	// 输入银行卡号
	private EditText shuruyinhangkahao = null;

	// 绑定布局
	private RelativeLayout layout2 = null;
	// 显示银行卡号
	private TextView xianshiyinhangkahao = null;

	// 充值金额
	private EditText chongzhijiner = null;
	// 充值手续费
	private TextView shouxufei = null;
	// 实际支付金额
	private TextView zhifujiner = null;
	// 下一步
	private Button next = null;

	private ProcessDialogUtil juhua = null;

	private Chongzhi chongzhiModel = null;

	private String content4Pay = null;
	
	private String mchnt_cd = null;
	private String mchnt_txn_ssn = null;
	private String amt = null;
	private String login_id = null;
	private String page_notify_url = null;
	private String back_notify_url = null;
	private String signatureStr = null;
	private String fyUrl = null;
	private String type = "ks";

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_mine_chongzhi;
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
		setTitle("充值");
		showBack();

		juhua = new ProcessDialogUtil(ChongZhiActivity.this);

		layout1 = (RelativeLayout) findViewById(R.id.main_mine_chongzhi_layout1);
		shuruyinhangkahao = (EditText) findViewById(R.id.main_mine_chongzhi_yinhangkahao);

		layout2 = (RelativeLayout) findViewById(R.id.main_mine_chongzhi_layout2);
		xianshiyinhangkahao = (TextView) findViewById(R.id.main_mine_chongzhi_bangding);

		chongzhijiner = (EditText) findViewById(R.id.main_mine_chongzhi_shurujiner);
		shouxufei = (TextView) findViewById(R.id.main_mine_chongzhi_shouxufei);
		zhifujiner = (TextView) findViewById(R.id.main_mine_chongzhi_shijizhifu);

		next = (Button) findViewById(R.id.main_mine_chongzhi_next);

		TextView chongzhishouxu = (TextView) findViewById(R.id.main_mine_chongzhi_shouming);
		chongzhishouxu.setText("充值费率" + chongzhiModel.getRechargeFactorage()
				+ "，由第三方平台收取");

		// 未签约
		if (chongzhiModel.getIsBound().equals("0")) {
			layout1.setVisibility(View.VISIBLE);
			layout2.setVisibility(View.GONE);
			
			//可以进行编辑的
			shuruyinhangkahao.setText(chongzhiModel.getBankNumber());
			
		} else {
			layout1.setVisibility(View.GONE);
			layout2.setVisibility(View.VISIBLE);
			xianshiyinhangkahao.setText(chongzhiModel.getBankName() + " "
					+ chongzhiModel.getBankNumber());
		}

		chongzhijiner.setHint("请输入充值金额,至少" + chongzhiModel.getRechargeMin());

		chongzhijiner.addTextChangedListener(new TextWatcher() {
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
				String newString = chongzhijiner.getText().toString();

				if(newString.length()==0){
					shouxufei.setText("0.00");
					zhifujiner.setText("0.00");
					return;
				}
				
				// 手续费
				shouxufei.setText((Double.valueOf(newString) * Double
						.valueOf(chongzhiModel.getRechargeFactorage())) + "");
				if (Double.valueOf(newString)
						* Double.valueOf(chongzhiModel.getRechargeFactorage()) > Double
						.valueOf(chongzhiModel.getFreeFactorageAmount())) {
					shouxufei.setText(chongzhiModel.getFreeFactorageAmount());
				}
				//实际支付金额
				zhifujiner.setText((Double.valueOf(newString) + Double
						.valueOf(shouxufei.getText().toString())) + "");
			}
		});

	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);

		next.setOnClickListener(this);

	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub
		switch (arg0.getId()) {
		case R.id.title_bar_back:
			ChongZhiActivity.this.finish();
			anim_right_out();
			break;
		case R.id.main_mine_chongzhi_next:

			String bankNumbles = "";
			if (chongzhiModel.getIsBound().equals("0")) {
				bankNumbles = shuruyinhangkahao.getText().toString();
			} else {
				bankNumbles = chongzhiModel.getBankName();
			}
			if (bankNumbles.length() == 0) {
				Toast.makeText(ChongZhiActivity.this, "请输入银行卡号", 1000).show();
				return;
			}
			// 充值的金额
			double chongje = Double.valueOf(chongzhijiner.getText().toString());
			if (chongje < Double.valueOf(chongzhiModel.getRechargeMin())) {
				Toast.makeText(ChongZhiActivity.this,
						"充值金额至少" + chongzhiModel.getRechargeMin() + "元", 1000)
						.show();
				return;
			}

			// 发送网络请求
			loadHttp_chongzhi();

			break;

		default:
			break;
		}
	}

	private Handler mHandler = createHandler();

	private Handler createHandler() {
		return new Handler() {
			public void handleMessage(Message msg) {
				String strRet = (String) msg.obj;

				juhua.cancel();

				switch (msg.what) {

				case 10:

					Toast.makeText(ChongZhiActivity.this,
							msg.getData().getString("errMsg"), 1000).show();

					break;
				case 11:// 进入充值的页面
					Intent intent  = new Intent();
					intent.putExtra("mchnt_cd", mchnt_cd);
					intent.putExtra("mchnt_txn_ssn", mchnt_txn_ssn);
					intent.putExtra("amt", amt);
					intent.putExtra("login_id", login_id);
					intent.putExtra("page_notify_url", page_notify_url);
					intent.putExtra("back_notify_url", back_notify_url);
					intent.putExtra("signatureStr", signatureStr);
					intent.putExtra("fyUrl", fyUrl);
					//tartActivity(intent);
					intent.setClass(ChongZhiActivity.this,KjChongZhiActivity.class);
				    startActivity(intent);
					break;
				case 12:
					Toast.makeText(ChongZhiActivity.this,
							msg.getData().getString("msg"), 1000).show();
					break;

				case Constants.RQF_PAY: {
					JSONObject objContent = BaseHelper.string2JSON(strRet);
					String retCode = objContent.optString("ret_code");
					String retMsg = objContent.optString("ret_msg");
					// TODO 先判断状态码，状态码为 成功或处理中 的需要 验签
					if (Constants.RET_CODE_SUCCESS.equals(retCode)) {
						// TODO 卡前置模式返回的银行卡绑定协议号，用来下次支付时使用，此处仅作为示例使用。正式接入时去掉
						String resulPay = objContent.optString("result_pay");
						if (Constants.RESULT_PAY_SUCCESS
								.equalsIgnoreCase(resulPay)) {
							BaseHelper.showDialog(ChongZhiActivity.this, "提示",
									"支付成功，交易状态码：" + retCode,
									android.R.drawable.ic_dialog_alert);

							// 保存数据
							UserMode user = Tool.getUser(ChongZhiActivity.this);
							user.setKyye((Double.valueOf(user.getKyye()) + Double.valueOf(chongzhijiner.getText().toString())) + "");
							user.saveUserToDB(ChongZhiActivity.this);
							// 保存数据

							// TODO 支付成功后续处理
						} else {
							BaseHelper.showDialog(ChongZhiActivity.this, "提示",
									retMsg + "，交易状态码:" + retCode,
									android.R.drawable.ic_dialog_alert);
						}

					} else if (Constants.RET_CODE_PROCESS.equals(retCode)) {
						String resulPay = objContent.optString("result_pay");
						if (Constants.RESULT_PAY_PROCESSING
								.equalsIgnoreCase(resulPay)) {
							BaseHelper.showDialog(ChongZhiActivity.this, "提示",
									objContent.optString("ret_msg") + "交易状态码："
											+ retCode,
									android.R.drawable.ic_dialog_alert);
						}

					} else {
						BaseHelper.showDialog(ChongZhiActivity.this, "提示",
								retMsg + "，交易状态码:" + retCode,
								android.R.drawable.ic_dialog_alert);
					}
				}
					break;
				}
				super.handleMessage(msg);
			}
		};

	}

	// 充值
	private void loadHttp_chongzhi() {
		// TODO Auto-generated method stub

		String bankNumbles = "";
		if (chongzhiModel.getIsBound().equals("0")) {
			bankNumbles = shuruyinhangkahao.getText().toString();
		} else {
			bankNumbles = chongzhiModel.getBankNumber();
		}

		// 逻辑判断
		if (bankNumbles.length() == 0) {
			Toast.makeText(ChongZhiActivity.this, "请输入银行卡号", 1000).show();
			return;
		}
		if (chongzhijiner.getText().toString().length() == 0) {
			Toast.makeText(ChongZhiActivity.this, "请输入充值金额", 1000).show();
			return;
		}

		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁

		map.put("amount", chongzhijiner.getText().toString());// 充值金额
		map.put("bankNumber", bankNumbles);// 银行账号
		map.put("type", "LL");//
		map.put("czlx", type);
		RequestThreadAbstract thread = RequestFactory.createRequestThread(39,
				map, ChongZhiActivity.this, mHandler);
		RequestPool.execute(thread);
		
	}

	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub

		// 充值
		if (map.get("urlTag").equals("1")) {

			JSONObject json = (JSONObject) jsonObj;

			try {
				JSONObject sdkParameter = json.getJSONObject("rvalue").getJSONObject("sdkParameter");
				mchnt_cd = sdkParameter.getString("mchnt_cd");
				mchnt_txn_ssn = sdkParameter.getString("mchnt_txn_ssn");
				amt = sdkParameter.getString("amt");
				login_id = sdkParameter.getString("login_id");
				page_notify_url = sdkParameter.getString("page_notify_url");
				back_notify_url = sdkParameter.getString("back_notify_url");
				signatureStr = sdkParameter.getString("signatureStr");
				fyUrl = sdkParameter.getString("fyUrl");
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			// JSONObject risk_item = sdkParameter.getJSONObject("risk_item");

			Message msg1 = new Message();
			msg1.what = 11;
			mHandler.sendMessage(msg1);
		}
	}

	@Override
	public void httpResponse_fail(Map<String, String> map, String msg,
			Object jsonObj) {
		// TODO Auto-generated method stub
		Message msg2 = new Message();
		msg2.what = 12;
		Bundle bundle = new Bundle();
		bundle.putString("msg", msg);
		msg2.setData(bundle);
		mHandler.sendMessage(msg2);
	}

}
