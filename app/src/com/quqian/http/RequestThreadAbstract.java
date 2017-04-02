package com.quqian.http;

import java.util.Map;

import com.quqian.util.HttpResponseInterface;

import android.os.Handler;

/**
 * 网络请求及处理线程虚拟类 <br/>
 * 线程处理网络请求，将返回结果交由handler处理
 * 
 * @author MagicFox
 * 
 */
public abstract class RequestThreadAbstract implements Runnable {

	protected int i;
	protected HttpResponseInterface context;
	protected Handler handler;
	protected Map<String, String> map;

	protected RequestThreadAbstract(int i, Map<String, String> map,
			HttpResponseInterface context, Handler handler) {
		this.i = i;
		this.map = map;
		this.context = context;
		this.handler = handler;
	}
}
