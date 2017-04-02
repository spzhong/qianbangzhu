package com.quqian.been;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.R.bool;
import android.util.Log;

public class ZhaiQuanProject{

	// 列表
	public String pId; // 债权转让id
	public String bt; // 标题
	public String bdbt; //详情中使用
	public JSONArray tb; // 图标，实地认证、机构担保、信用担保
	public String xydj; // 信用等级（AA、A、B、C、D、E、HR）
	public String nll; // 年利率
	public String syqs; // 剩余期数
	public String zqs; // 总期数
	public String zqjz; // 债权价值
	public String zqjg; // 转让价格
	public String syfs; // 剩余份数
	public String zt; // 状态（立即购买）

	public String getBdbt() {
		return bdbt;
	}


	public void setBdbt(String bdbt) {
		this.bdbt = bdbt;
	}


	public String getGmzx() {
		return gmzx;
	}


	public void setGmzx(String gmzx) {
		this.gmzx = gmzx;
	}


	public String getJkqx() {
		return jkqx;
	}


	public void setJkqx(String jkqx) {
		this.jkqx = jkqx;
	}


	public String getBddx() {
		return bddx;
	}


	public void setBddx(String bddx) {
		this.bddx = bddx;
	}


	public SanProject getSan_bddx() {
		return san_bddx;
	}


	public void setSan_bddx(SanProject san_bddx) {
		this.san_bddx = san_bddx;
	}

	public String gmzx;//购买总需
	
	// 详情
	public String dsbx; // 待收本息
	public String xyhkr; // 下一还款日
	public String ystzje; // 原始投资金额
	public String yqqk; // 逾期情况，未发生逾期、逾期、严重逾期
	public String jkqx; //借款期限
	public String bddx; //标题

	public SanProject san_bddx;// 标的信息

	public ZhaiQuanProject() {
		// TODO Auto-generated constructor stub
	}
	

//	
//	private boolean isHaveKey(JSONObject json,String key) {
//		Iterator<String> iterator = json.keys();
//		 String newKey = null;
//		 int tag = 0;
//	        while (iterator.hasNext()) {
//	        	newKey = (String) iterator.next();
//	            if(key.equals(newKey)){
//	            	tag = 1;
//	            	break;
//	            }
//	        }
//	        
//	    if(tag==1){
//	    	return true;
//	    }
//		return false;
//	}

	// 散标-列表
	public void initMakeData_list(JSONObject json) {
		
		try {
			this.pId = json.getString("id");
			this.tb = json.getJSONArray("tb");
			this.bt = json.getString("bt");
			this.xydj = json.getString("xydj");
			this.nll = json.getString("nll");
			this.syqs = json.getString("syqs");
			this.zqjz = json.getString("zqjz");
			this.zqjg = json.getString("zqjg");
			this.syfs = json.getString("syfs");
			this.jkqx = json.getString("jkqx");
			this.zt = json.getString("zt");
			//this.bddx = json.getString("bddx");
			this.bddx = "";
			
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 散标-详情
	public void initMakeData_listInfo(JSONObject json) {
	
		Log.i("a", "aaa");

		JSONObject jso = null;
		try {
			// 详情
			this.pId = json.getString("id");
			this.syqs = json.getString("syqs");
			this.jkqx = json.getString("jkqx");
			this.zqjg = json.getString("zqjg");
			this.dsbx = json.getString("dsbx");
			this.xyhkr = json.getString("xyhkr");
			this.ystzje = json.getString("ystzje");
			this.yqqk = json.getString("yqqk");
			this.syfs = json.getString("syfs");
			// 标的详情
			this.san_bddx = new SanProject();
			jso = json.getJSONObject("bddx");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//开始散标
		this.san_bddx.initMakeData_listInfo(jso,"zhaiquan");
	}

	// 设置图标
	public List<Map<String, String>> tuBiaoList() {
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		for (int i = 0; i < this.tb.length(); i++) {
			try {
				Map<String, String> map = new HashMap<String, String>();
				String tb1 = this.tb.getString(i);
				if (tb1.equals("0")) {
					map.put("sx", "企");
					map.put("xq", "企业融资");
				} else if (tb1.equals("1")) {
					map.put("sx", "保");
					map.put("xq", "机构担保");
				} else if (tb1.equals("2")) {
					map.put("sx", "信");
					map.put("xq", "信用担保");
				} else if (tb1.equals("3")) {
					map.put("sx", "实");
					map.put("xq", "实地认证");
				} else {
					continue;
				}
				list.add(map);
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		return list;
	}

	// 年利率
	public String show_list_one() {
		return exchangeStringToHtml_list(this.nll, "%", "年利率");
	}

	// 剩余期限
	public String show_list_two() {
		return exchangeStringToHtml_list(this.syqs, "个月", "剩余期限");
	}

	// 债权价值
	public String show_list_three() {
		return exchangeStringToHtml_list(this.zqjz, "元/份", "债权价值");
	}

	// 转让价格
	public String show_list_four() {
		return exchangeStringToHtml_list(this.zqjg, "元/份", "转让价格");
	}

	// 剩余份数
	public String show_list_five() {
		return exchangeStringToHtml_list(this.syfs, "", "剩余份数");
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
	
	
	
	
	// 债权转让详情
	public List<Map<String, String>> make_sanInfo_1(){
		List<Map<String, String>> list = new ArrayList<Map<String,String>>();
		make_map(list,this.syqs,"剩余期限", exchangeStringToHtml_info_2(this.syqs+"/"+this.jkqx, "个月"));
		make_map(list,this.zqjg,"转让价格", exchangeStringToHtml_info_1(this.zqjg+"元/份"));
		make_map(list,this.dsbx,"待收本息", exchangeStringToHtml_info_1(this.dsbx+"元/份"));
		make_map(list,this.xyhkr,"下一还款日", exchangeStringToHtml_info_1(this.xyhkr));
		make_map(list,this.ystzje,"原始投资金额", exchangeStringToHtml_info_1(this.ystzje+"元"));
		
		if(this.yqqk.equals("0"))
			make_map(list,this.xyhkr,"逾期情况", exchangeStringToHtml_info_1("未发生逾期"));
		if(this.yqqk.equals("1"))
			make_map(list,this.xyhkr,"逾期情况", exchangeStringToHtml_info_1("逾期"));
		if(this.yqqk.equals("2"))
			make_map(list,this.xyhkr,"逾期情况", exchangeStringToHtml_info_1("严重逾期"));
		return list;
	}
	
	//创建map
	private void make_map(List<Map<String, String>> list, String value ,String left,String right) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("left",left);
		if(value == null){
			return;
		}
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

	public JSONArray getTb() {
		return tb;
	}

	public void setTb(JSONArray tb) {
		this.tb = tb;
	}

	public String getXydj() {
		return xydj;
	}

	public void setXydj(String xydj) {
		this.xydj = xydj;
	}

	public String getNll() {
		return nll;
	}

	public void setNll(String nll) {
		this.nll = nll;
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

	public String getZqjz() {
		return zqjz;
	}

	public void setZqjz(String zqjz) {
		this.zqjz = zqjz;
	}

	public String getZqjg() {
		return zqjg;
	}

	public void setZqjg(String zqjg) {
		this.zqjg = zqjg;
	}

	public String getSyfs() {
		return syfs;
	}

	public void setSyfs(String syfs) {
		this.syfs = syfs;
	}

	public String getZt() {
		return zt;
	}

	public void setZt(String zt) {
		this.zt = zt;
	}

	public String getDsbx() {
		return dsbx;
	}

	public void setDsbx(String dsbx) {
		this.dsbx = dsbx;
	}

	public String getXyhkr() {
		return xyhkr;
	}

	public void setXyhkr(String xyhkr) {
		this.xyhkr = xyhkr;
	}

	public String getYstzje() {
		return ystzje;
	}

	public void setYstzje(String ystzje) {
		this.ystzje = ystzje;
	}

	public String getYqqk() {
		return yqqk;
	}

	public void setYqqk(String yqqk) {
		this.yqqk = yqqk;
	}

}
