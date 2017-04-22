package com.quqian.activity.index.xin;

import org.json.JSONException;
import org.json.JSONObject;

import com.example.quqian.R;
import com.quqian.base.BaseActivity;
import com.quqian.http.API;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.webkit.JsResult;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;

public class WebViewActivity extends BaseActivity implements OnClickListener{

	private String url = "";
	private String sendStr = "";
	private String transCode = "";
	 
	
	private WebView webView;
	private String urlParameter = "";


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
		 
	}
	

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.activity_sign_webview;
	}
	

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		setTitle("立即投标");
		showBack();

		initWebView();

	}
	
	private void initWebView() {
		webView = (WebView) findViewById(R.id.webView11);
		// 初始化webview
		// 启用支持javascript
		WebSettings settings = webView.getSettings();
		settings.setJavaScriptEnabled(true);// 支持javaScript
		settings.setDefaultTextEncodingName("utf-8");// 设置网页默认编码
		settings.setJavaScriptCanOpenWindowsAutomatically(true);
		Log.d("TAG", "url:" + url);
		// post请求(使用键值对形式，格式与get请求一样，key=value,多个用&连接)
		urlParameter = "RequestData=" + sendStr + "&" + "transCode="+transCode;
		webView.postUrl(url, urlParameter.getBytes());

		
		// webView.loadUrl(url);//get
		//webView.setWebChromeClient(new MyWebChromeClient());// 设置浏览器可弹窗
		// 覆盖WebView默认使用第三方或系统默认浏览器打开网页的行为，使网页用WebView打开
		webView.setWebViewClient(new WebViewClient() {
			@Override
			public boolean shouldOverrideUrlLoading(WebView view, String url) {
				// 返回值是true的时候控制去WebView打开，为false调用系统浏览器或第三方浏览器
				Log.d("TAG", "url:" + url);
				view.loadUrl(url);
				return true;
			}

			@Override
			public void onPageStarted(WebView view, String url, Bitmap favicon) {
				Log.d("TAG", "onPageStarted--url:" + url);
				// 支付完成后,点返回关闭界面
				if (url.endsWith(API.HTTP+"sbtz/tbBack.htm")) {
					finish();
				}

				super.onPageStarted(view, url, favicon);
			}

			@Override
			public void onPageFinished(WebView view, String url) {
				super.onPageFinished(view, url);

			}

		});

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