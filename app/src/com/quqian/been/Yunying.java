package com.quqian.been;

import org.json.JSONException;
import org.json.JSONObject;

 

public class Yunying {
	
	public String yysj; // 安全运营时间
	public String jkbs; // 完成借款数量
	public String zcrs; // 注册人数
	public String ljcj; // 累计成交金额
	public String tzrljsy; // 投资人累计赚取收益
	public String dhbj; // 待还本金
	public String tzrdhsy; // 投资人待收收益
	 
	public String getYysj() {
		return yysj;
	}
	public void setYysj(String yysj) {
		this.yysj = yysj;
	}
	public String getJkbs() {
		return jkbs;
	}
	public void setJkbs(String jkbs) {
		this.jkbs = jkbs;
	}
	public String getZcrs() {
		return zcrs;
	}
	public void setZcrs(String zcrs) {
		this.zcrs = zcrs;
	}
	public String getLjcj() {
		return ljcj;
	}
	public void setLjcj(String ljcj) {
		this.ljcj = ljcj;
	}
	public String getTzrljsy() {
		return tzrljsy;
	}
	public void setTzrljsy(String tzrljsy) {
		this.tzrljsy = tzrljsy;
	}
	public String getDhbj() {
		return dhbj;
	}
	public void setDhbj(String dhbj) {
		this.dhbj = dhbj;
	}
	public String getTzrdhsy() {
		return tzrdhsy;
	}
	public void setTzrdhsy(String tzrdhsy) {
		this.tzrdhsy = tzrdhsy;
	}
	
	public void initMakeData_Info(JSONObject json){
		 try {
			this.setYysj(json.getString("yysj"));
			this.setJkbs(json.getString("jkbs"));
			this.setZcrs(json.getString("zcrs"));
			this.setLjcj(json.getString("ljcj"));
			this.setTzrljsy(json.getString("tzrljsy"));
			this.setDhbj(json.getString("dhbj"));
			this.setTzrdhsy(json.getString("tzrdhsy"));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
