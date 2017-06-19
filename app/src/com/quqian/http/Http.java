package com.quqian.http;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.SocketTimeoutException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.KeyStore;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.HttpVersion;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ClientConnectionManager;
import org.apache.http.conn.ConnectTimeoutException;
import org.apache.http.conn.scheme.PlainSocketFactory;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.CoreConnectionPNames;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.params.HttpProtocolParams;
import org.apache.http.protocol.HTTP;
import org.apache.http.protocol.ResponseContent;
import org.apache.http.util.EncodingUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.util.Log;

import com.quqian.util.HttpResponseInterface;
import com.quqian.util.Tool;

public class Http {

	// log 操作Tag
	static String TAG_STRING = "log_http_get";

	static HttpClient getClient = null;

	// 请求前的操作
	public static String BaseHttp(Map<String, String> map,
			HttpResponseInterface activity) {

		// 异常处理
		if (map.get("url") == null) {
			return "break";
		}
		if (map.get("urlNum") == null) {
			return "break";
		}
		if (activity == null) {
			return "break";
		}

		String cookieValue = Tool.readData((Context) activity, "cooke",
				"cookieValue");
		if (cookieValue != null) {
			map.put("cookieValue", cookieValue);
		}

		//
		// if(map.get("urlNum").equals("1") || map.get("urlNum").equals("3") ||
		// map.get("urlNum").equals("33") ){
		//
		// }else{
		// String cookieValue = Tool.readData((Context) activity, "cooke",
		// "cookieValue");
		// if (cookieValue != null) {
		// map.put("cookieValue", cookieValue);
		// }
		//
		// }

		Log.i(TAG_STRING,
				"请求的URL: " + map.get("url") + "=====" + map.toString());

		return "go";
	}

	// get请求
	public static void GET(Map<String, String> map,
			HttpResponseInterface activity) {

		// 请求操作前
		if (BaseHttp(map, activity) == "break") {
			return;
		}

		try {
			// 得到HttpClient对象
			getClient = new DefaultHttpClient();

			HttpParams params = getClient.getParams();
			HttpConnectionParams.setConnectionTimeout(params, 5000);
			HttpConnectionParams.setSoTimeout(params, 5000);

			// getClient.getParams().setParameter(CoreConnectionPNames.CONNECTION_TIMEOUT,
			// 6000);

			// 得到HttpGet对象
			HttpGet request = new HttpGet(map.get("url"));
			// 客户端使用GET方式执行请教，获得服务器端的回应response
			HttpResponse response = getClient.execute(request);

			// 判断请求是否成功
			if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {

				// 获得输入流
				InputStream inStrem = response.getEntity().getContent();
				int result = inStrem.read();
				// 字符缓冲
				StringBuffer string = new StringBuffer("");
				while (result != -1) {
					string.append((char) result);
					result = inStrem.read();
				}
				// 关闭输入流
				inStrem.close();
				String resultStr = string.toString();

				Log.i(TAG_STRING, "网络成功: " + resultStr);
				makeDataToModel(resultStr, activity, map);

			} else {
				activity.httpResponse_fail(map, "请求服务器端失败", null);
				Log.i(TAG_STRING, "请求服务器端失败");
			}
		} catch (ConnectTimeoutException cte) {
			System.out.println("ConnectTimeoutException");
			cte.printStackTrace();
			activity.httpResponse_fail(map, "请求服务器连接超时", null);
		} catch (SocketTimeoutException ste) {
			System.out.println("SocketTimeoutException");
			ste.printStackTrace();
			activity.httpResponse_fail(map, "请求服务器读取超时", null);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			// e.printStackTrace();
			activity.httpResponse_fail(map, "请求服务器端异常的处理", null);
			Log.i(TAG_STRING, "请求服务器端异常的处理");
		}
	}

	// post请求
	public static void POST(Map<String, String> map,
			HttpResponseInterface activity) {

		// 请求操作前
		if (BaseHttp(map, activity) == "break") {
			return;
		}

		// 处理数据
		if (activity == null) {
			return;
		}

		BufferedReader in = null;
		HttpClient client = null;

		try {

			client = new DefaultHttpClient();

			// 请求超时
			client.getParams().setParameter(
					CoreConnectionPNames.CONNECTION_TIMEOUT, 30000);
			// 读取超时
			client.getParams().setParameter(CoreConnectionPNames.SO_TIMEOUT,
					30000);

			HttpPost request = new HttpPost(map.get("url"));
			// HttpPost request = new HttpPost("http://www.baidu.com");
			// 使用NameValuePair来保存要传递的Post参数
			List<NameValuePair> postParameters = new ArrayList<NameValuePair>();
			// 添加要传递的参数
			Set<String> keySet = map.keySet(); // key的set集合
			Iterator<String> it = keySet.iterator();
			while (it.hasNext()) {
				String k = it.next(); // key
				if ((k == "url") || (k == "urlTag") || (k == "isLock")
						|| (k == "urlNum")) {
					continue;
				}
				String v = map.get(k); // value
				if (v.length() == 0) {
					continue;
				}
				postParameters.add(new BasicNameValuePair(k, v));
			}
			// 实例化UrlEncodedFormEntity对象
			UrlEncodedFormEntity formEntity = new UrlEncodedFormEntity(
					postParameters, HTTP.UTF_8);

			// 使用HttpPost对象来设置UrlEncodedFormEntity的Entity
			request.setEntity(formEntity);

			HttpResponse response = client.execute(request);

			if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
				in = new BufferedReader(new InputStreamReader(response
						.getEntity().getContent()));
				StringBuffer string = new StringBuffer("");
				String lineStr = "";
				while ((lineStr = in.readLine()) != null) {
					string.append(lineStr);
				}
				in.close();

				String resultStr = string.toString();

				Log.i(TAG_STRING, "网络成功: " + resultStr);

				makeDataToModel(resultStr, activity, map);

				client.getConnectionManager().shutdown();

			} else {

				client.getConnectionManager().shutdown();

				if (activity != null) {
					activity.httpResponse_fail(map, "请求服务器端异常", null);
				}
				Log.i(TAG_STRING, "求服务器端异常");
			}

		} catch (ConnectTimeoutException cte) {
			System.out.println("ConnectTimeoutException");
			cte.printStackTrace();
			client.getConnectionManager().shutdown();

			if (activity != null) {
				activity.httpResponse_fail(map, "链接网络超时，请稍后再试", null);
			}

		} catch (SocketTimeoutException ste) {
			System.out.println("SocketTimeoutException");
			ste.printStackTrace();
			client.getConnectionManager().shutdown();
			if (activity != null) {
				activity.httpResponse_fail(map, "链接网络超时，请稍后再试", null);
			}

		} catch (Exception e) {
			// Do something about exceptions

			client.getConnectionManager().shutdown();

			if (activity != null) {
				activity.httpResponse_fail(map, "请检查网络是否链接异常", null);
			}
			Log.i(TAG_STRING, "请检查网络是否链接异常");
		}
	}

	// 组装数据
	@SuppressWarnings("deprecation")
	public static void makeDataToModel(String resultStr,
			HttpResponseInterface activity, Map<String, String> map) {

		if (activity == null) {
			return;
		}

		// 处理解析
		try {
			JSONObject resultJson = new JSONObject(resultStr);

			int code;
			String msg = "";
			boolean isAuthenticated;
			Object resultObj = null;

			code = resultJson.getInt("code");
			msg = resultJson.getString("msg");
			isAuthenticated = resultJson.getBoolean("authenticated");

			if (resultJson.get("rvalue") instanceof JSONArray) {
				resultObj = resultJson.getJSONArray("rvalue");
			} else if (resultJson.get("rvalue") instanceof JSONObject) {
				resultObj = resultJson.getJSONObject("rvalue");
			} else {
				// activity.httpResponse_fail(map, "rvalue对象异常", null);
			}

			// 请求的编号
			String urlNum = map.get("urlNum");

			// 特殊的处理判断
			// if (isAuthenticated==false) {
			// activity.httpResponse_fail(map, msg, resultJson);
			// return;
			// }

			// 保存cookie
			String cookieValue = resultJson.getString("cookieValue");
			Tool.writeData((Context) activity, "cooke", "cookieValue",
					cookieValue);

			// 错误的判断
			if (code > 0) {
				activity.httpResponse_fail(map, msg, resultJson);
				return;
			}

			// 不需要组装的接口
			if (urlNum == "4" || urlNum == "5" || urlNum == "6"
					|| urlNum == "7" || urlNum == "10" || urlNum == "13"
					|| urlNum == "14" || urlNum == "15" || urlNum == "18"
					|| urlNum == "19" || urlNum == "20" || urlNum == "21"
					|| urlNum == "22" || urlNum == "23" || urlNum == "24"
					|| urlNum == "25" || urlNum == "26" || urlNum == "33"
					|| urlNum == "34" || urlNum == "35" || urlNum == "36"
					|| urlNum == "37" || urlNum == "38" || urlNum == "39"
					|| urlNum == "40" || urlNum == "41" || urlNum == "42"
					|| urlNum == "43" || urlNum == "44" || urlNum == "45"
					|| urlNum == "46" || urlNum == "47" || urlNum == "101"
					|| urlNum == "100" || urlNum == "102" || urlNum == "103"
					|| urlNum == "104" || urlNum == "105" || urlNum == "106"
					|| urlNum == "107" || urlNum == "108" || urlNum == "109"
					|| urlNum == "110" || urlNum == "111" || urlNum == "112"
					|| urlNum == "113" || urlNum == "114" || urlNum == "115"
					|| urlNum == "116" || urlNum == "201" || urlNum == "202") {
				// 成功的操作
				if (code == 0) {
					// 填充数据
					// 特殊判断处理
					if (urlNum == "112" || urlNum == "26" || urlNum == "111" || urlNum == "112"
							|| urlNum == "107"|| urlNum == "108") {
						activity.httpResponse_fail(map, "暂无数据", resultJson);
					} else {
						activity.httpResponse_success(map, null, resultJson);
					}
				} else {
					activity.httpResponse_fail(map, msg, resultJson);
				}
			} else {

				// 特殊判断处理
				if (resultObj == null) {
					// 填充数据

					if (urlNum == "8" || urlNum == "9" || urlNum == "11"
							|| urlNum == "16" || urlNum == "27"
							|| urlNum == "28" || urlNum == "29"
							|| urlNum == "371" || urlNum == "48") {
						activity.httpResponse_fail(map, "暂无数据", resultJson);
					} else {
						activity.httpResponse_fail(map, msg, resultJson);
					}
					return;
				}
				// 组装数据
				Data data = new Data(urlNum, resultObj, activity);
				data.addDataToList();
				// 成功的操作
				if (code == 0) {
					// 填充数据
					activity.httpResponse_success(map, data.getList(),
							resultJson);
				} else {
					activity.httpResponse_fail(map, msg, resultJson);
				}
			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			if (activity != null) {
				activity.httpResponse_fail(map, "数据解析异常", null);
			}
			Log.i(TAG_STRING, "数据解析异常");

		}
	}

}
