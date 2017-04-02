package com.yintong.pay.utils;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.SocketTimeoutException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ConnectTimeoutException;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.CoreConnectionPNames;
import org.apache.http.protocol.HTTP;

public class TestHttp {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		loadHttp_chongzhi();
	}
	
	private static void loadHttp_chongzhi() {
		Map<String, String> map = new HashMap<String, String>();
		map.put("mchnt_cd", "0002900F0041077");
		map.put("mchnt_txn_ssn", "qbz68288609433719");
		map.put("amt", "600000");
		map.put("login_id", "13788287787");
		map.put("page_notify_url", "http://localhost/user/m/capital/kjPay.htm");
		map.put("back_notify_url", "");
		map.put("signatureStr", "tSoXbgr1Bect12WZbOtTkc748YiF44PczzaF8PRqaI6CPBvDKKuS2ORelZbWtmAjF+adG8PUUfRNw4Dd4qxXw83UE4HkXcnHJYdkcEC46lRM7fsVy9GaAoJSElDw1EjVk9P7MlI+z1/U3qwVkU3NBTr1BYZ2KdaAJGcMq6Ivr8o=");
		String url = "http://www-1.fuiou.com:9057/jzh/app/500002.action";
		// 请求操作前
		post(url,map);
	}
	
	private static void post(String url,Map<String, String> map){
		BufferedReader in = null;
		HttpClient client = null;
		try {
			client = new DefaultHttpClient();
			// 请求超时
			client.getParams().setParameter(CoreConnectionPNames.CONNECTION_TIMEOUT, 30000);
			// 读取超时
			client.getParams().setParameter(CoreConnectionPNames.SO_TIMEOUT,30000);
			HttpPost request = new HttpPost(url);
			// HttpPost request = new HttpPost("http://www.baidu.com");
			// 使用NameValuePair来保存要传递的Post参数
			List<NameValuePair> postParameters = new ArrayList<NameValuePair>();
			// 添加要传递的参数
			Set<String> keySet = map.keySet(); // key的set集合
			Iterator<String> it = keySet.iterator();
			while (it.hasNext()) {
				String k = it.next(); // key
				String v = map.get(k); // value
				postParameters.add(new BasicNameValuePair(k, v));
				}
				// 实例化UrlEncodedFormEntity对象
				UrlEncodedFormEntity formEntity = new UrlEncodedFormEntity(
					postParameters,HTTP.UTF_8);
				formEntity.setContentEncoding(HTTP.UTF_8);
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
					System.out.println(resultStr);
					client.getConnectionManager().shutdown();
						  
				} else {

					client.getConnectionManager().shutdown();
						
				}

				} catch (ConnectTimeoutException cte) {
					System.out.println("ConnectTimeoutException");
					cte.printStackTrace();
					client.getConnectionManager().shutdown();
					

				} catch (SocketTimeoutException ste) {
					System.out.println("SocketTimeoutException");
					ste.printStackTrace();
					client.getConnectionManager().shutdown();

				} catch (Exception e) {
					// Do something about exceptions
					
				client.getConnectionManager().shutdown();	
		}
	}
}
