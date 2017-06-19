package com.quqian.activity.mine.xin;

import org.apache.http.protocol.HTTP;

import android.content.Intent;
import android.graphics.Bitmap;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.webkit.JavascriptInterface;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import com.example.quqian.R;
import com.quqian.activity.LoginActivity;
import com.quqian.activity.MainActivity;
import com.quqian.activity.RegisterActivity;
import com.quqian.activity.mine.AppWithdrawActivity;
import com.quqian.activity.mine.MineActivity;
import com.quqian.activity.mine.AppWithdrawActivity.JavaScriptinterface;
import com.quqian.base.BaseActivity;
import com.quqian.been.UserMode;
import com.quqian.http.API;
import com.quqian.util.StaticVariable;
import com.quqian.util.Tool;

public class CGWebView extends BaseActivity implements OnClickListener {

	private String url = "";
	private String sendStr = "";
	private String transCode = "";

	private String title = "";

	private String zhuangtai = "";

	private WebView webView;
	private String seqNum = "";

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
		if (getIntent().getStringExtra("sendUrl") != null) {
			url = getIntent().getStringExtra("sendUrl");
		}
		if (getIntent().getStringExtra("sendStr") != null) {
			this.sendStr = getIntent().getStringExtra("sendStr");
		}
		if (getIntent().getStringExtra("transCode") != null) {
			this.transCode = getIntent().getStringExtra("transCode");
		}
		if (getIntent().getStringExtra("title") != null) {
			this.title = getIntent().getStringExtra("title");
		}
		if (getIntent().getStringExtra("zhuangtai") != null) {
			this.zhuangtai = getIntent().getStringExtra("zhuangtai");
		}
		if (getIntent().getStringExtra("seqNum") != null) {
			this.seqNum = getIntent().getStringExtra("seqNum");
		}

	}

	/**
	 * 接受页面参数类，用于跳转和数据核对 tag：1，投标确认，返回投标的列表（刷新） tag：2，开通存管账号，返回注册的页面（进入设置手势的页面）
	 * tag：3，开通存管账号，返回充值的页面（刷新） tag：4，绑定存管账号，返回充值的页面（刷新） tag：5，充值，返回充值的页面（刷新）
	 * tag：6，开通存管账号，返回提现的页面（刷新） tag：7，绑定存管账号，返回提现的页面（刷新） tag：8，提现，返回充值的页面（刷新）
	 * tag：9，开通存管账号，返回银行卡管理的页面（刷新） tag：10，绑定存管账号，返回银行卡管理的页面（刷新）
	 */
	public class JavaScriptinterface {

		@JavascriptInterface
		public void getCode(String code) {
			if (code.equals("0000")) {
				String tag = getIntent().getStringExtra("tag");
				if (tag != null) {
					if (tag.endsWith("1")) {
						// 投标成功后发送刷新通知
						Intent intent = new Intent();
						intent.setAction("sanbiao_reloadata");
						sendBroadcast(intent);
						// 如何跳转到投标的列表
						Intent intent1 = new Intent(CGWebView.this,
								MainActivity.class);
						StaticVariable.put(StaticVariable.licaitab, "2");
						startActivity(intent1);
						CGWebView.this.finish();

					} else if (tag.endsWith("2")) {
						// 注册返回
						Intent intent = new Intent();
						intent.setAction("zhuce_reloadata");
						sendBroadcast(intent);
						CGWebView.this.finish();
					}

				} else {
					// 通知刷新我的账户数据
					Intent intent = new Intent();
					intent.setAction("zhanghu_reloadata");
					sendBroadcast(intent);

					// 返回跳转到现有的我的账户
					Intent intent1 = new Intent(CGWebView.this,
							MainActivity.class);
					StaticVariable.put(StaticVariable.sv_toMine, "2");
					startActivity(intent1);
					CGWebView.this.finish();
				}
			} else {
				CGWebView.this.finish();
			}
		}
	}

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.activity_cgcz_webview;
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		setTitle(title);
		showBack();

		initWebView();
	}

	private void initWebView() {
		webView = (WebView) findViewById(R.id.webViewchongzhi);
		// 初始化webview
		// 启用支持javascript
		WebSettings settings = webView.getSettings();
		settings.setJavaScriptEnabled(true);// 支持javaScript
		settings.setDefaultTextEncodingName("utf-8");// 设置网页默认编码
		settings.setJavaScriptCanOpenWindowsAutomatically(true);
		webView.addJavascriptInterface(new JavaScriptinterface(), "android");
		Log.d("TAG", "url:" + url);
		// post请求(使用键值对形式，格式与get请求一样，key=value,多个用&连接)
		// urlParameter = "RequestData=" + sendStr + "&" +
		// "transCode="+transCode;
		// webView.postUrl(url, urlParameter.getBytes());

		String html = "<!doctype html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta name=\"Generator\" content=\"EditPlus®\">"
				+ "<meta name=\"Author\" content=\"\">"
				+ "<meta name=\"Keywords\" content=\"\">"
				+ "<meta name=\"Description\" content=\"\">"
				+ "<title>Document</title></head>"
				+ "<body>"
				+ "<form  id=\"cgForm\" method=\"post\" action=\""
				+ url
				+ "\">"
				+ "<input type=\"hidden\" name=\"RequestData\" id=\"RequestData\" value=\""
				+ sendStr
				+ "\" />"
				+ "<input type=\"hidden\" name=\"transCode\" id=\"transCode\" value=\""
				+ transCode
				+ "\" />"
				+ "</form>"
				+ "<script type=\"text/javascript\">"
				+ "window.onload= function(){document.getElementById('cgForm').submit();}</script></body></html>";

		webView.loadDataWithBaseURL("", html, "text/html", "utf-8", null);
		webView.getSettings().setJavaScriptEnabled(true);
		webView.setWebViewClient(new WebViewClient() {
			@Override
			public boolean shouldOverrideUrlLoading(WebView view, String url) {
				// 返回值是true的时候控制去WebView打开，为false调用系统浏览器或第三方浏览器
				Log.d("TAG", "url:" + url);

				if (url.indexOf(API.huaxingHttp_payCgBack) != -1) {
					newinitWebView("http://" + API.huaxingHttp_payCgBack);
					return false;
				}
				if (url.indexOf(API.huaxingHttp_withCgBak) != -1) {
					newinitWebView("http://" + API.huaxingHttp_withCgBak);
					return false;
				}
				if (url.indexOf(API.huaxingHttp_tbBack) != -1) {
					newinitWebView("http://" + API.huaxingHttp_tbBack);
					return false;
				}
				if (url.indexOf(API.huaxingHttp_bankcardregCgBack) != -1) {
					newinitWebView("http://"
							+ API.huaxingHttp_bankcardregCgBack);
					return false;
				}
				if (url.indexOf(API.huaxingHttp_bankcardregCgBkBack) != -1) {
					newinitWebView("http://"
							+ API.huaxingHttp_bankcardregCgBkBack);
					return false;
				}

				view.loadUrl(url);
				return true;
			}

			@Override
			public void onPageStarted(WebView view, String url, Bitmap favicon) {
				Log.d("TAG", "onPageStarted--url:" + url);
				// 支付完成后,点返回关闭界面

				super.onPageStarted(view, url, favicon);
			}

			@Override
			public void onLoadResource(WebView view, String url) {
				// TODO Auto-generated method stub
				super.onLoadResource(view, url);

			}

			@Override
			public void onPageFinished(WebView view, String url) {
				super.onPageFinished(view, url);

			}

		});

	}

	private void newinitWebView(String url) {
		webView = (WebView) findViewById(R.id.webViewchongzhi);
		// 初始化webview
		// 启用支持javascript
		WebSettings settings = webView.getSettings();
		settings.setJavaScriptEnabled(true);// 支持javaScript
		settings.setDefaultTextEncodingName("utf-8");// 设置网页默认编码
		settings.setJavaScriptCanOpenWindowsAutomatically(true);
		webView.addJavascriptInterface(new JavaScriptinterface(), "android");
		String postData = "seqNum=" + seqNum;
		webView.postUrl(url, postData.getBytes());
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
			finish();
			break;

		default:
			break;
		}
	}

	// 改写物理按键——返回的逻辑
	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		// TODO Auto-generated method stub
		if (keyCode == KeyEvent.KEYCODE_BACK) {
			if (webView.canGoBack()) {
				webView.goBack();// 返回上一页面
				return true;
			} else {
				finish();
			}
		}
		return super.onKeyDown(keyCode, event);
	}

}
