package com.quqian.http;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class RequestPool {

	private final static ExecutorService mThreadPool = Executors
			.newFixedThreadPool(5);

	public final static void execute(Runnable request) {
		mThreadPool.execute(request);
	}

}
