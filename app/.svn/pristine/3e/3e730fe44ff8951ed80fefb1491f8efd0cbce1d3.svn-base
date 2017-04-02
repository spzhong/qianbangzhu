package com.quqian.been;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

public class TiYanProject{

	// 列表
	public String pId; // 理财体验id
	public String bt; // 标题
	public String rzjd; // 融资进度
	public String jhje= ""; // 计划金额
	public String nll; // 年利率
	public String sdqx; // 锁定期限
	public String zt = ""; // 状态（预售中、立即申请、已满额、已截止）
	public String joinLimit;// 加入上限

	// 详情
	public String syje; // 剩余金额
	public String tzfs; // 投资方式，体验金、现金

	

	public String fbsj; // 发布时间，距离发售【状态为预售中】默认为-1不显示
	public String ckqx; // 筹款期限（天），距离截止时间 【状态为立即申请】默认为-1不显示
	public String sdjssj; // 锁定结束时间
	public String meys; // 满额用时，满额时间【状态为已满额，已截止】默认为-1不显示 发布时间和满额时间差
	public String sycl; // 收益处理，收益处理，0每月还息、1到期一次清付清、2等额本息
	public String flcl; // 费率处理，体验活动不收取任何费用
	public String jhjs; // 计划介绍
	public String lcsm_url; // 理财说明url
	// public String zt; //状态（预售中、立即申请、已满额、已截止）
	public String time; // 作为【状态为已满额，已截止】计算满额用时

	// 我的理财体验－－列表
	public String jrje; // 加入金额
	public String syqs; // 剩余期数
	public String zqs; // 总期数
	public String xyghkr=""; // 下一个回款日
	public String yzje; // 已赚金额
	public String jzrq=""; // 截止日期
	public String dssy; //待收收益

	public TiYanProject() {
		// TODO Auto-generated constructor stub
	}

	// 理财体验-列表
	public void initMakeData_list(JSONObject json) {
		try {
			this.pId = json.getString("id");
			this.bt = json.getString("bt");
			this.jhje = json.getString("jhje");
			this.nll = json.getString("nll");
			this.sdqx = json.getString("sdqx");
			this.zt = json.getString("zt");
			this.rzjd = json.getString("rzjd");
			this.joinLimit = json.getString("joinLimit");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 理财体验-详情
	public void initMakeData_listInfo(JSONObject json) {
		try {
			// 列表
			//initMakeData_list(json);
			
			this.pId = json.getString("id");
			this.bt = json.getString("bt");
			this.jhje = json.getString("jhje");
			this.nll = json.getString("nll");
			this.sdqx = json.getString("sdqx");
			
			this.zt = json.getString("zt");
			this.joinLimit = json.getString("joinLimit");
			
			// 详情
			this.syje = json.getString("syje");
			this.tzfs = json.getString("tzfs");
			this.time = json.getString("time");
			
			this.fbsj = json.getString("fbsj");
			this.ckqx = json.getString("ckqx");
			this.sdjssj = json.getString("sdjssj");
			this.meys = json.getString("meys");
			this.sycl = json.getString("sycl");
			this.flcl = json.getString("flcl");
			this.jhjs = json.getString("jhjs");
			this.lcsm_url = json.getString("lcsm_url");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 我的理财体验
	public void initMakeData_my_listInfo(JSONObject json) {
		try {
			// 列表
			//initMakeData_list(json);
			//initMakeData_listInfo(json);
			
			this.rzjd = json.getString("rzjd");
			this.syje = json.getString("syje");
			
			this.pId = json.getString("id");
			this.bt = json.getString("bt");
			this.dssy = json.getString("dssy");
			this.nll = json.getString("nll");
			this.sdqx = json.getString("sdqx");
			this.joinLimit = json.getString("joinLimit");
			
			// 详情
			this.jrje = json.getString("jrje");
			this.syqs = json.getString("syqs");
			this.zqs = json.getString("zqs");
			this.xyghkr = json.getString("xyghkr");
			this.yzje = json.getString("yzje");
			this.jzrq = json.getString("jzrq");
			
			
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	
	// 判断是否可以点击投标的按钮
	public boolean isJudgment_bid_butonPress() {
		if (this.getZt().equals("预售中")) {
			return false;
		}
		if (this.getZt().equals("立即申请")) {
			return true;
		}
		if (this.getZt().equals("已满额")) {
			return false;
		}
		if (this.getZt().equals("已截止")) {
			return false;
		}
		return false;
	}

	
	
	// 计划金额
	public String show_list_one() {
		if(this.getJhje().equals("") || this.getJhje() == null){
			this.jhje = "0.00";
		}
	    //标的总额
	    if (Double.valueOf(this.getJhje()) < 10000) {
	    	return exchangeStringToHtml_list(this.getJhje(), "元", "标的总额");
	    }else if (Double.valueOf(this.getJhje()) > 1000000000){
	        double zonge = Double.valueOf(this.getJhje())/1000000000;
	        return exchangeStringToHtml_list(zonge+"", "亿", "标的总额");
	    }else{
	        double zonge = Double.valueOf(this.getJhje())/10000;
	        return exchangeStringToHtml_list(zonge+"", "万", "标的总额");
	    }
	}
	
	//我的 加入金额
	public String show_my_list_one() {
		if(this.getJrje().equals("")){
			this.jhje = "0.00";
		}
	    //标的总额
	    if (Double.valueOf(this.getJrje()) < 10000) {
	    	return exchangeStringToHtml_list(this.getJrje(), "元", "加入金额");
	    }else if (Double.valueOf(this.getJrje()) > 1000000000){
	        double zonge = Double.valueOf(this.getJrje())/1000000000;
	        return exchangeStringToHtml_list(zonge+"", "亿", "加入金额");
	    }else{
	        double zonge = Double.valueOf(this.getJrje())/10000;
	        return exchangeStringToHtml_list(zonge+"", "万", "加入金额");
	    }
	}

	// 年利率
	public String show_list_two() {
		return exchangeStringToHtml_list(this.nll,"%", "年利率");
	}

	// 锁定期限
	public String show_list_three() {
		return exchangeStringToHtml_list(this.sdqx, "个月", "锁定期限");
	}

	// 转换成html
	private String exchangeStringToHtml_list(String string, String danwei,
			String name) {

		StringBuffer strBuf = new StringBuffer();
			strBuf.append("<div align='center'>");
			strBuf.append(String.format(
					"<font size=15 face='HelveticaNeue'>%s</font>", string));
			strBuf.append(String.format(
					"<font size=12 face='HelveticaNeue'>%s</font>", danwei));
			strBuf.append(String
					.format("<br><font size =11 color='#8B8B8B' face='HelveticaNeue'>%s</font>",
							name));
			strBuf.append("</div>");
		return new String(strBuf);
	}
	
	
	
	// 散标详情
	public List<Map<String, String>> make_sanInfo_1(){
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		make_map(list,this.jhje,"计划金额", exchangeStringToHtml_info_2(this.jhje, "元"));
		make_map(list,this.nll,"预期收益", exchangeStringToHtml_info_1(this.nll+"％"));
		//投资方式
		if (this.tzfs.equals("0"))
			make_map(list,"体验金","投资方式", exchangeStringToHtml_info_1("体验金"));
		if (this.tzfs.equals("1"))
			make_map(list,"现金", "投资方式",exchangeStringToHtml_info_1("现金"));
		make_map(list,this.lcsm_url,"理财说明","《理财体验说明书》");
		if (this.zt.equals("0"))
			make_map(list,this.zt,"计划状态", exchangeStringToHtml_info_1("预售中"));
		if (this.zt.equals("1"))
			make_map(list,this.zt,"计划状态", exchangeStringToHtml_info_1("申请中"));
		if (this.zt.equals("2"))
			make_map(list,this.zt,"计划状态", exchangeStringToHtml_info_1("已满额"));
		if (this.zt.equals("3"))
			make_map(list,this.zt,"计划状态", exchangeStringToHtml_info_1("已截止"));
		
	    //距离发售
	    //距离截止
	    //满额用时
		make_map(list,this.ckqx,"距离截止", exchangeStringToHtml_info_1(this.ckqx));
		make_map(list,this.fbsj,"距离发售", exchangeStringToHtml_info_1(this.fbsj));
		make_map(list,this.meys,"满额用时", exchangeStringToHtml_info_1(this.meys));
	    //距离发售
	    //距离截止
	    //满额用时
		make_map(list,this.sdqx,"锁定期限", exchangeStringToHtml_info_1(this.sdqx+"个月"));
		make_map(list,this.sdjssj,"锁定结束", exchangeStringToHtml_info_1(this.sdjssj));
		if (this.sycl.equals("0"))
			make_map(list,this.sycl,"收益处理", exchangeStringToHtml_info_1("每月还息"));
		if (this.sycl.equals("1"))
			make_map(list,this.sycl,"收益处理", exchangeStringToHtml_info_1("到期一次清付清"));
		if (this.sycl.equals("2"))
			make_map(list,this.sycl,"收益处理", exchangeStringToHtml_info_1("等额本息"));
		
		//费率说明
		make_map(list,this.zt,"费率说明", exchangeStringToHtml_info_1("体验活动不收取任何费用"));
	     
		return list;
	}
	
	//URL介绍
	public List<Map<String, String>> make_sanInfo_2(){
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		make_map(list,this.jhjs,"", this.jhjs);
		return list;
	}
	
	
	//创建map
	private void make_map(List<Map<String, String>> list, String value ,String left,String right) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("left",left);
		if(!value.equals("-1")){
			map.put("right",right);
			list.add(map);
		}
	}
	
	
	
	private String exchangeStringToHtml_info_1(String name) {
		StringBuffer strBuf = new StringBuffer();
		strBuf.append("<div align='left'>");
		strBuf.append(String.format("<font size =14 face='HelveticaNeue'>%s</font>",name));
		strBuf.append("</div>");
		return new String(strBuf);
	}

	private String exchangeStringToHtml_info_2(String name,String vlaue) {
		StringBuffer strBuf = new StringBuffer();
		strBuf.append("<div align='left'>");
		strBuf.append(String.format("<font size =14 face='HelveticaNeue' color='#F08F00'>%s</font>",name));
		strBuf.append(String.format("<font size =14 face='HelveticaNeue'>%s</font>",vlaue));
		strBuf.append("</div>");
		return new String(strBuf);
	}

	
	
	
	// 我的体验--列表(参与中)
	public Map<String, String> my_tiyan_canyuzhong_list() {
		String xiayigehuikuanri = "";
		if(this.getXyghkr().length() > 11){
			xiayigehuikuanri = this.getXyghkr().substring(0, 11);
		}else{
			xiayigehuikuanri = this.getXyghkr();
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put( "1",my_exchage_html(this.dssy,"待收收益"));
		map.put( "2",my_exchage_html(this.nll+"%","年利率"));
		map.put("3",my_exchage_html(this.syqs+"/"+this.zqs,"剩余期数"));
		map.put("4",my_exchage_html(xiayigehuikuanri,"下个回款日"));
		return map;
	}
	
	
	// 我的体验--列表(已截止)
	public Map<String, String> my_tiyan_yijiezhi_list() {
		String jiezhiriqi = "";
		if(this.getJzrq().length() > 11){
			jiezhiriqi = this.getJzrq().substring(0, 11);
		}else{
			jiezhiriqi = this.getJzrq();
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("1",my_exchage_html(this.jrje,"加入金额"));
		map.put("2",my_exchage_html(this.nll+"%","年利率"));
		map.put("3",my_exchage_html(this.yzje,"已赚金额"));
		map.put("4",my_exchage_html(jiezhiriqi,"截止日期"));
		return map;
	}

	
	//我的列表的html
	private String my_exchage_html(String string,String name) {
		StringBuffer strBuf = new StringBuffer();
		strBuf.append("<div align='center'>");
		strBuf.append(String
				.format("<font size =12 face='HelveticaNeue'>%s</font>",
						string));
		strBuf.append(String.format(
				"<br/><font size =11 face='HelveticaNeue' color='#8B8B8B'>%s</font>", name));
		strBuf.append("</div>");
		return new String(strBuf);
	}
  
	
	public String getpId() {
		return pId;
	}

	public void setpId(String pId) {
		this.pId = pId;
	}

	public String getBt() {
		return bt;
	}

	public void setBt(String bt) {
		this.bt = bt;
	}

	public String getRzjd() {
		return rzjd;
	}

	public void setRzjd(String rzjd) {
		this.rzjd = rzjd;
	}

	public String getJhje() {
		return jhje;
	}

	public void setJhje(String jhje) {
		this.jhje = jhje;
	}

	public String getNll() {
		return nll;
	}

	public void setNll(String nll) {
		this.nll = nll;
	}

	public String getSdqx() {
		return sdqx;
	}

	public void setSdqx(String sdqx) {
		this.sdqx = sdqx;
	}

	public String getZt() {
		return zt;
	}

	public void setZt(String zt) {
		this.zt = zt;
	}

	public String getJoinLimit() {
		return joinLimit;
	}

	public void setJoinLimit(String joinLimit) {
		this.joinLimit = joinLimit;
	}

	public String getSyje() {
		return syje;
	}

	public void setSyje(String syje) {
		this.syje = syje;
	}

	public String getTzfs() {
		return tzfs;
	}

	public void setTzfs(String tzfs) {
		this.tzfs = tzfs;
	}

	public String getFbsj() {
		return fbsj;
	}

	public void setFbsj(String fbsj) {
		this.fbsj = fbsj;
	}

	public String getCkqx() {
		return ckqx;
	}

	public void setCkqx(String ckqx) {
		this.ckqx = ckqx;
	}

	public String getSdjssj() {
		return sdjssj;
	}

	public void setSdjssj(String sdjssj) {
		this.sdjssj = sdjssj;
	}

	public String getMeys() {
		return meys;
	}

	public void setMeys(String meys) {
		this.meys = meys;
	}

	public String getSycl() {
		return sycl;
	}

	public void setSycl(String sycl) {
		this.sycl = sycl;
	}

	public String getFlcl() {
		return flcl;
	}

	public void setFlcl(String flcl) {
		this.flcl = flcl;
	}

	public String getJhjs() {
		return jhjs;
	}

	public void setJhjs(String jhjs) {
		this.jhjs = jhjs;
	}

	public String getLcsm_url() {
		return lcsm_url;
	}

	public void setLcsm_url(String lcsm_url) {
		this.lcsm_url = lcsm_url;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getJrje() {
		return jrje;
	}

	public void setJrje(String jrje) {
		this.jrje = jrje;
	}

	public String getSyqs() {
		return syqs;
	}

	public void setSyqs(String syqs) {
		this.syqs = syqs;
	}

	public String getZqs() {
		return zqs;
	}

	public void setZqs(String zqs) {
		this.zqs = zqs;
	}

	public String getXyghkr() {
		return xyghkr;
	}

	public void setXyghkr(String xyghkr) {
		this.xyghkr = xyghkr;
	}

	public String getYzje() {
		return yzje;
	}

	public void setYzje(String yzje) {
		this.yzje = yzje;
	}

	public String getJzrq() {
		return jzrq;
	}

	public void setJzrq(String jzrq) {
		this.jzrq = jzrq;
	}
	public String getDssy() {
		return dssy;
	}

	public void setDssy(String dssy) {
		this.dssy = dssy;
	}

	
}
