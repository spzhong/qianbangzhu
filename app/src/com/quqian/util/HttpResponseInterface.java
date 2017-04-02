package com.quqian.util;

import java.util.List;
import java.util.Map;

public interface HttpResponseInterface {
	
	//网络成功的回调 参数说明：map是请求post／get的对象，list是数据封装的对象，jsonObj是返回的json数据
	public void httpResponse_success(Map<String,String> map,List<Object> list,Object jsonObj) ;
	
	//网络失败的回调 参数说明：map是请求post／get的对象，msg是异常错误的信息，jsonObj是返回的json数据
	public void httpResponse_fail(Map<String,String> map,String msg,Object jsonObj) ;
	
}
