package com.quqian.been;
 
import org.json.JSONException;
import org.json.JSONObject;


import android.content.Context;

import com.quqian.util.Tool;

public class UserMode {

	public String yhzh; // 账户
	public String kyye; // 可用余额
	public String djje; // 冻结金额
	public String yzze; // 已赚总额
	public String zhze; // 账户总额
	public String tyjze; // 体验金总额
	public String nc; // 昵称
	public String xb; // 性别
	public String csrq; // 出生日期
	public String wdfwm; // 我的服务码
	public String sjh; // 手机号
	public String sfzh; // 身份证号
	public String xm; // 姓名
	public String sjsfsz; // 是否设置了手机号
	public String sfzsfrz; // 是否设置了身份认证
	public String txmmsfsz; // 提现密码是否设置
	public String yjsfsz; // 邮件是否设置
	public String znxwdts;//站内未读数
	public String fwmlj;//服务码连接
	
	//其他特殊的字段
	public String codeError;//输入错误手势密码的次数
	public String shoushiCode;//手势密码

	
	//新增4月5号
	public String cgkyye;//存管账户可用余额
	public String cgdjje;//存管账户冻结金额
	public String cgyzze;//存管账户已赚金额
	public String cgzhze;//存管账户总金额
	//新增4月5号
	
	 
	public String getZnxwdts() {
		return znxwdts;
	}

	public String getCgkyye() {
		return cgkyye;
	}

	public void setCgkyye(String cgkyye) {
		this.cgkyye = cgkyye;
	}

	public String getCgdjje() {
		return cgdjje;
	}

	public void setCgdjje(String cgdjje) {
		this.cgdjje = cgdjje;
	}

	public String getCgyzze() {
		return cgyzze;
	}

	public void setCgyzze(String cgyzze) {
		this.cgyzze = cgyzze;
	}

	public String getCgzhze() {
		return cgzhze;
	}

	public void setCgzhze(String cgzhze) {
		this.cgzhze = cgzhze;
	}

	public void setZnxwdts(String znxwdts) {
		this.znxwdts = znxwdts;
	}

	public String getFwmlj() {
		return fwmlj;
	}

	public void setFwmlj(String fwmlj) {
		this.fwmlj = fwmlj;
	}

	public String getShoushiCode() {
		return shoushiCode;
	}

	public void setShoushiCode(String shoushiCode) {
		this.shoushiCode = shoushiCode;
	}

	public String getYhzh() {
		return yhzh;
	}

	public void setYhzh(String yhzh) {
		this.yhzh = yhzh;
	}

	public String getKyye() {
		return kyye;
	}

	public String getSfzh() {
		return sfzh;
	}

	public void setSfzh(String sfzh) {
		this.sfzh = sfzh;
	}

	public String getXm() {
		return xm;
	}

	public void setXm(String xm) {
		this.xm = xm;
	}

	public String getCodeError() {
		return codeError;
	}

	public void setCodeError(String codeError) {
		this.codeError = codeError;
	}

	public void setKyye(String kyye) {
		this.kyye = kyye;
	}

	public String getDjje() {
		return djje;
	}

	public void setDjje(String djje) {
		this.djje = djje;
	}

	public String getYzze() {
		return yzze;
	}

	public void setYzze(String yzze) {
		this.yzze = yzze;
	}

	public String getZhze() {
		return zhze;
	}

	public void setZhze(String zhze) {
		this.zhze = zhze;
	}

	public String getTyjze() {
		return tyjze;
	}

	public void setTyjze(String tyjze) {
		this.tyjze = tyjze;
	}

	public String getNc() {
		return nc;
	}

	public void setNc(String nc) {
		this.nc = nc;
	}

	public String getXb() {
		return xb;
	}

	public void setXb(String xb) {
		this.xb = xb;
	}

	public String getCsrq() {
		return csrq;
	}

	public void setCsrq(String csrq) {
		this.csrq = csrq;
	}

	public String getWdfwm() {
		return wdfwm;
	}

	public void setWdfwm(String wdfwm) {
		this.wdfwm = wdfwm;
	}

	public String getSjh() {
		return sjh;
	}

	public void setSjh(String sjh) {
		this.sjh = sjh;
	}

	public String getSjsfsz() {
		return sjsfsz;
	}

	public void setSjsfsz(String sjsfsz) {
		this.sjsfsz = sjsfsz;
	}

	public String getSfzsfrz() {
		return sfzsfrz;
	}

	public void setSfzsfrz(String sfzsfrz) {
		this.sfzsfrz = sfzsfrz;
	}

	public String getTxmmsfsz() {
		return txmmsfsz;
	}

	public void setTxmmsfsz(String txmmsfsz) {
		this.txmmsfsz = txmmsfsz;
	}

	public String getYjsfsz() {
		return yjsfsz;
	}

	public void setYjsfsz(String yjsfsz) {
		this.yjsfsz = yjsfsz;
	}

  
	
	// 初始化数据
	public UserMode() {
		// TODO Auto-generated constructor stub
		yhzh = "";
		kyye = "0.00";
		djje = "0.00";
		yzze = "0.00";
		zhze = "0.00";
		nc = "0.00";
	}

	public void initMakeData(JSONObject json) {
		try {
			this.yhzh = json.getString("yhzh");
			this.kyye = json.getString("kyye");
			this.djje = json.getString("djje");
			this.yzze = json.getString("yzze");
			this.zhze = json.getString("zhze");
			this.tyjze = json.getString("tyjze");
			this.nc = json.getString("nc");
			this.xb = json.getString("xb");
			this.csrq = json.getString("csrq");
			this.wdfwm = json.getString("wdfwm");
			this.sjh = json.getString("sjh");
			this.sjsfsz = json.getString("sjsfsz");
			this.sfzsfrz = json.getString("sfzsfrz");
			this.txmmsfsz = json.getString("txmmsfsz");
			this.yjsfsz = json.getString("yjsfsz");
			this.sfzh = json.getString("sfzh");
			this.xm = json.getString("xm");
			this.fwmlj = json.getString("fwmlj");
			this.znxwdts = json.getString("znxwdts");
			this.cgkyye = json.getString("cgkyye");
			this.cgdjje = json.getString("cgdjje");
			this.cgyzze = json.getString("cgyzze");
			this.cgzhze = json.getString("cgzhze");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 一些特殊的方法处理
	// 身份证的隐藏显示
	 

	// 手机号的两端显示
	public String new_mobile() {
		StringBuffer string = new StringBuffer();
		if (this.sjh.length() == 11) {
			string.append(this.sjh.substring(0, 3));
			string.append("****");
			string.append(this.sjh.substring(7, 11));
			return new String(string);
		}
		return "";
	}
 
	
	//写到数据库中
	public void saveUserToDB(Context ctx){
 
		Tool.writeData(ctx, "user", "yhzh", this.getYhzh());
		Tool.writeData(ctx, "user", "kyye", this.getKyye());
		Tool.writeData(ctx, "user", "djje", this.getDjje());
		Tool.writeData(ctx, "user", "yzze", this.getYzze());
		Tool.writeData(ctx, "user", "zhze", this.getZhze());
		Tool.writeData(ctx, "user", "tyjze", this.getTyjze());
		Tool.writeData(ctx, "user", "nc", this.getNc());
		Tool.writeData(ctx, "user", "xb", this.getXb());
		Tool.writeData(ctx, "user", "csrq", this.getCsrq());
		Tool.writeData(ctx, "user", "wdfwm", this.getWdfwm());
		Tool.writeData(ctx, "user", "sjh", this.getSjh());
		Tool.writeData(ctx, "user", "sfzh", this.getSfzh());
		Tool.writeData(ctx, "user", "xm", this.getXm());
		Tool.writeData(ctx, "user", "codeError", this.getCodeError());
		Tool.writeData(ctx, "user", "sjsfsz", this.getSjsfsz());
		Tool.writeData(ctx, "user", "sfzsfrz", this.getSfzsfrz());
		Tool.writeData(ctx, "user", "txmmsfsz", this.getTxmmsfsz());
		Tool.writeData(ctx, "user", "yjsfsz", this.getYjsfsz());
		Tool.writeData(ctx, "user", "shoushiCode", this.getShoushiCode());
		Tool.writeData(ctx, "user", "fwmlj", this.getFwmlj());
		Tool.writeData(ctx, "user", "znxwdts", this.getZnxwdts());
		Tool.writeData(ctx, "user", "cgkyye", this.getCgkyye());
		Tool.writeData(ctx, "user", "cgdjje", this.getCgdjje());
		Tool.writeData(ctx, "user", "cgyzze", this.getCgyzze());
		Tool.writeData(ctx, "user", "cgzhze", this.getCgzhze());
	}
 

}
