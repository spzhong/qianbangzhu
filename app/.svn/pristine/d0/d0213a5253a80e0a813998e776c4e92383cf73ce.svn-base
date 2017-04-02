package com.quqian.http;

import java.util.Map;

import com.quqian.util.HttpResponseInterface;

import android.os.Handler;

public class RequestFactory {
	public static RequestThreadAbstract createRequestThread(int i,
			Map<String, String> map, HttpResponseInterface context,
			Handler handler) {
		return new RequestThreadImp(i, map, context, handler);
	}
}
