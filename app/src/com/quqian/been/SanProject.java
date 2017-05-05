package com.quqian.been;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class SanProject implements Serializable {

	public String getTjf() {
		return tjf;
	}

	public void setTjf(String tjf) {
		this.tjf = tjf;
	}

	public String getBdtype() {
		return bdtype;
	}

	public void setBdtype(String bdtype) {
		this.bdtype = bdtype;
	}

	public String getMbsj() {
		return mbsj;
	}

	public void setMbsj(String mbsj) {
		this.mbsj = mbsj;
	}

	public String getJkqx() {
		return jkqx;
	}

	public void setJkqx(String jkqx) {
		this.jkqx = jkqx;
	}

	public String getDjs() {
		return djs;
	}

	public void setDjs(String djs) {
		this.djs = djs;
	}

	public String getDhbj() {
		return dhbj;
	}

	public void setDhbj(String dhbj) {
		this.dhbj = dhbj;
	}

	public String getHkr() {
		return hkr;
	}

	public void setHkr(String hkr) {
		this.hkr = hkr;
	}

	public String getYhbj() {
		return yhbj;
	}

	public void setYhbj(String yhbj) {
		this.yhbj = yhbj;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getHsje() {
		return hsje;
	}

	public void setHsje(String hsje) {
		this.hsje = hsje;
	}

	//
	// @Override
	// public Object clone() throws CloneNotSupportedException {
	// // TODO Auto-generated method stub
	// return super.clone();
	//
	// }
	//
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// 列表
	public String pId = ""; // 标的id
	public JSONArray tbArray; // 图标，实地认证、机构担保、信用担保
	public String bdbt = ""; // 标的标题
	public String jllx = ""; // 奖励类型：限时奖、满堂彩、头彩奖、幸运奖、土豪奖、新手奖、普惠奖、进步奖
	public String rzjd = ""; // 融资进度
	public String bdze = "0"; // 标的总额
	public String nll = "0"; // 年利率
	public String jlll = "0"; // 奖励利率
	public String hkqx = "0"; // 还款期限
	public String jkfs = ""; // 0是按月，1是按天，2是秒标
	public String zt = ""; // 状态，（敬请期待、立即投标、已满标、还款中、已流标、已结清）
	public String tjf = "";// 推荐
	public String bdtype = "";// 标的类型，存管标：1普通标：0

	public String syje = "";// 剩余金额 （特殊处理，不要显示在详情列表中）

	// 详情的信息
	public String xydj = ""; // 信用等级（AA、A、B、C、D、E、HR）
	public String bzfs = ""; // 保障方式
	public String tqhkfl = ""; // 提前还款费率
	public String hkfs = ""; // 还款方式（等额本息、每月还息不扣首期利息，到期还本、每月还息扣首期利息，到期还本、到期一次性付清）
	public String yhbx = ""; // 月还本息
	public String grtbdcs = ""; // 个人投标的次数
	public String rzsysj = ""; // 融资剩余时间
	public String tbjd = ""; // 投标进度
	public String tbxe = ""; // 投标限额
	public String fbsj = ""; // 发布时间
	public String cbqx = ""; // 筹标期限（天）
	public String mbsj = "";// 满标用时
	// public String zt; //状态，预售中、申请中、已满标、还款中、已结清
	public String bdxq_url = ""; // 标的详情url
	public String xgzl_url = ""; // 相关资料url
	public String jlgz_url = ""; // 奖励规则url
	public String tbjl_url = ""; // 投标记录url
	public String hkjl_url = ""; // 还款记录url
	public String zqxx_url = ""; // 债权信息url
	public String zrjl_url = ""; // 转让记录url
	public String jlmd_url = ""; // 奖励名单url

	/*
	 * 新增属性（标的详情）5月4号
	 */
	public String djs = "";// 倒计时
	public String dhbj = "";// 待还本金
	public String hkr = "";// 下一个还款日
	public String yhbj = "";// 已还本金
	/*
	 * 新增属性（标的详情）5月4号
	 */

	// 我的散标－－列表
	public String dsbx = ""; // 待收本息
	public String syqs = ""; // 剩余期数
	public String zqs = ""; // 总期数
	public String xyhkr = ""; // 下一还款日
	public String jd = ""; // 进度
	public String tzje = ""; // 投资金额
	public String yzje = ""; // 已赚金额
	public String jqrq = ""; // 结清日期
	public String zccjfs = ""; // 转出成交份数
	public String zcsjsr = ""; // 转出实际收入
	public String zcjyfy = ""; // 转出交易费用
	public String zczryk = ""; // 转出转让盈亏
	public String jlje = ""; // 奖励金额
	public String jkqx = ""; // 借款期限 【新增字段】
	public String hsje = ""; // 回收金额 【新增字段】
	

	public SanProject() {
		// TODO Auto-generated constructor stub
	}

	// 散标-列表
	public void initMakeData_list(JSONObject json, String type) {
		try {
			this.pId = json.getString("id");
			this.tbArray = json.getJSONArray("tb");
			this.bdbt = json.getString("bdbt");
			this.jkfs = json.getString("jkfs");
			this.jllx = json.getString("jllx");
			//if (!type.equals("zhaiquan")) {
			//	if (type.equals("liebiao")) {
			//		this.rzjd = json.getInt("rzjd") + "";
			//	} else {
			this.tbjd = json.getString("tbjd");
			//	}
			//}
			this.bdze = json.getString("bdze");
			this.nll = json.getString("nll");
			this.jlll = json.getString("jlll");
			this.hkqx = json.getString("hkqx");
			this.zt = json.getString("zt");
			this.tjf = json.getString("tjf");
			this.bdtype = json.getString("bdtype");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 散标-详情
	public void initMakeData_listInfo(JSONObject json, String type) {
		try {
			// 列表
			initMakeData_list(json, type);
			// 详情
			this.tbxe = json.getString("tbxe");
			this.syje = json.getString("syje");
			this.xydj = json.getString("xydj");
			this.bzfs = json.getString("bzfs");
			this.tqhkfl = json.getString("tqhkfl");
			this.hkfs = json.getString("hkfs");
			this.yhbx = json.getString("yhbx");
			this.tbjd = json.getString("tbjd");
			this.grtbdcs = json.getString("grtbdcs");
			this.rzsysj = json.getString("rzsysj");
			this.tbxe = json.getString("tbxe");
			this.fbsj = json.getString("fbsj");
			this.cbqx = json.getString("cbqx");
			this.mbsj = json.getString("mbsj");
			this.bdxq_url = json.getString("bdxq_url");
			this.xgzl_url = json.getString("xgzl_url");
			this.jlgz_url = json.getString("jlgz_url");
			this.tbjl_url = json.getString("tbjl_url");
			this.hkjl_url = json.getString("hkjl_url");
			this.zqxx_url = json.getString("zqxx_url");
			this.zrjl_url = json.getString("zrjl_url");
			this.jlmd_url = json.getString("jlmd_url");
			this.bdtype = json.getString("bdtype");
			this.djs = json.getString("djs");
			this.dhbj = json.getString("dhbj");
			this.hkr = json.getString("hkr");
			this.yhbj = json.getString("yhbj");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 我的散标-详情
	public void initMakeData_my_listInfo(JSONObject json) {
		try {
			// 列表
			// initMakeData_list(json, "");
			// initMakeData_listInfo(json, "");

			this.pId = json.getString("id");
			this.tbArray = json.getJSONArray("tb");
			this.bdbt = json.getString("bdbt");
			this.dsbx = json.getString("dsbx");
			this.nll = json.getString("nll");

			this.hkqx = json.getString("hkqx");
			this.rzjd = json.getString("rzjd");

			this.jllx = json.getString("jllx");
			this.jlll = json.getString("jlll");
			this.pId = json.getString("id");
			this.jkqx = json.getString("jkqx");
			this.jlje = json.getString("jlje");

			// 详情
			this.dsbx = json.getString("dsbx");
			this.syqs = json.getString("syqs");
			this.jkfs = json.getString("jkfs");
			this.xyhkr = json.getString("xyhkr");
			// this.jd = json.getString("jd");
			this.tzje = json.getString("tzje");
			this.yzje = json.getString("yzje");
			this.jqrq = json.getString("jqrq");
			this.zccjfs = json.getString("zccjfs");
			this.zcsjsr = json.getString("zcsjsr");
			this.zcjyfy = json.getString("zcjyfy");
			this.zczryk = json.getString("zczryk");

			this.tzje = json.getString("tzje");
			this.bdtype = json.getString("bdtype");
			
			this.hsje = json.getString("hsje");

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 一些特殊的方法处理

	// 判断是否可以点击投标的按钮
	public boolean isJudgment_bid_butonPress() {
		if (this.zt.equals("敬请期待")) {
			return false;
		}
		if (this.zt.equals("已满标")) {
			return false;
		}
		if (this.zt.equals("还款中")) {
			return false;
		}
		if (this.zt.equals("已流标")) {
			return false;
		}
		if (this.zt.equals("已结清")) {
			return false;
		}
		if (this.zt.equals("立即投标")) {
			return true;
		}
		return true;
	}

	// 设置图标
	public List<Map<String, String>> tuBiaoList() {
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		for (int i = 0; i < this.tbArray.length(); i++) {
			try {
				Map<String, String> map = new HashMap<String, String>();
				String tb = this.tbArray.getString(i);
				if (tb.equals("0")) {
					map.put("sx", "企");
					map.put("xq", "企业融资");
					list.add(map);
				}
				if (tb.equals("1")) {
					map.put("sx", "保");
					map.put("xq", "机构担保");
					list.add(map);
				}
				if (tb.equals("2")) {
					map.put("sx", "信");
					map.put("xq", "信用担保");
					list.add(map);
				}
				if (tb.equals("3")) {
					map.put("sx", "实");
					map.put("xq", "实地认证");
					list.add(map);
				}

			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		return list;
	}

	// 标的总额
	public String show_list_one() {
		if (this.getBdze().equals("")) {
			this.bdze = "0.00";
		}
		// 标的总额
		if (Double.valueOf(this.getBdze()) < 10000) {
			return this.getBdze() + "元";
		} else if (Double.valueOf(this.getBdze()) > 1000000000) {
			double zonge = Double.valueOf(this.getBdze()) / 1000000000;
			return zonge + "" + "亿";
		} else {
			double zonge = Double.valueOf(this.getBdze()) / 10000;
			return zonge + "" + "万";
		}
	}

	// 我的投标
	public String show_my_list_one() {

		if (this.getTzje().equals("")) {
			this.tzje = "0.00";
		}
		// 投资额
		if (Double.valueOf(this.getTzje()) < 10000) {
			return this.getTzje()+"元";
		} else if (Double.valueOf(this.getTzje()) > 1000000000) {
			double zonge = Double.valueOf(this.getTzje()) / 1000000000;
			return zonge + "亿";
		} else {
			double zonge = Double.valueOf(this.getTzje()) / 10000;
			return zonge + "万";
		}
	}

	// 年利率
	public String show_list_two() {
		if (this.getJlll().equals("-1")) {
			return this.nll + "%";
		}
		return this.nll + "%";
	}

	// 还款期限
	public String show_list_three() {
		if (this.jkfs.equals("0"))
			return this.hkqx + "个月";
		if (this.jkfs.equals("1"))
			return this.hkqx + "天";
		if (this.jkfs.equals("2"))
			return this.hkqx + "秒标";
		return "";
	}

	// 转换成html
	private String exchangeStringToHtml_list(String string, String danwei,
			String name) {

		StringBuffer strBuf = new StringBuffer();
		if (name.equals("年利率")) {
			strBuf.append("<div align='center'>");
			strBuf.append(String.format(
					"<font size=15 face='HelveticaNeue'>%s</font>", string));

			if (danwei.length() == 0) {

			} else {
				strBuf.append(String
						.format("<font size=12 color='#F2B008' face='HelveticaNeue'>+%s</font>",
								danwei));
			}
			strBuf.append(String
					.format("<br/><font size =11 color='#8B8B8B' face='HelveticaNeue'>%s</font>",
							name));
			strBuf.append("</div>");
		} else {
			strBuf.append("<div align='center'>");
			strBuf.append(String.format(
					"<font size=15 face='HelveticaNeue'>%s</font>", string));
			strBuf.append(String.format(
					"<font size=12 face='HelveticaNeue'>%s</font>", danwei));
			strBuf.append(String
					.format("<br><font size =11 color='#8B8B8B' face='HelveticaNeue'>%s</font>",
							name));
			strBuf.append("</div>");
		}
		return new String(strBuf);
	}

	// 散标详情
	public ArrayList<Map<String, String>> make_sanInfo_1() {

		ArrayList<Map<String, String>> list = new ArrayList<Map<String, String>>();
		if (this.getZt().endsWith("还款中")) {
			make_map(list, this.hkfs, "还款方式", this.hkfs);
			make_map(list, this.syqs, "剩余期数", this.syqs).put("yanse", "y");
			make_map(list, this.dhbj, "待还本金总额", this.dhbj).put("yanse", "y");
			;
			String xiayigehuikuanri = "";
			if (this.getXyhkr().length() > 11) {
				xiayigehuikuanri = this.getXyhkr().substring(0, 11);
			} else {
				xiayigehuikuanri = this.getXyhkr();
			}
			make_map(list, xiayigehuikuanri, "下个还款日", xiayigehuikuanri).put(
					"yanse", "y");
			;
			make_map(list, this.mbsj, "满标用时", this.mbsj);

		} else if (this.getZt().endsWith("已经结清")) {
			make_map(list, this.hkfs, "还款方式", this.hkfs);
			make_map(list, this.syqs, "剩余期数", this.syqs).put("yanse", "y");
			make_map(list, this.yhbj, "已还本金总额", this.yhbj).put("yanse", "y");
			make_map(list, this.jqrq, "结清日期", this.jqrq).put("yanse", "y");
			make_map(list, this.mbsj, "满标用时", this.mbsj);

		} else {
			make_map(list, this.hkfs, "还款方式", this.hkfs);
			make_map(list, this.yhbx, "月还本息", this.yhbx + "元");
			make_map(list, this.tbxe, "投标限额", this.tbxe);
			make_map(list, "满标后当日计息", "起息时间", "满标后当日计息");
			make_map(list, this.rzsysj, "剩余时间", this.rzsysj);
		}

//		make_map(list, this.bdze, "标的总额",
//				exchangeStringToHtml_info_2(this.bdze, "元"));
//		make_map(list, this.nll, "年利率", exchangeStringToHtml_info_1(this.nll
//				+ "％"));
//		// 还款期限
//		if (this.jkfs.equals("0"))
//			make_map(list, this.hkqx, "还款期限",
//					exchangeStringToHtml_info_2(this.hkqx, "个月"));
//		if (this.jkfs.equals("1"))
//			make_map(list, this.hkqx, "还款期限",
//					exchangeStringToHtml_info_2(this.hkqx, "天"));
//		if (this.jkfs.equals("2"))
//			make_map(list, this.hkqx, "还款期限",
//					exchangeStringToHtml_info_2(this.hkqx, "秒标"));
//		make_map(list, this.bzfs, "保障方式",
//				exchangeStringToHtml_info_1(this.bzfs));
//		make_map(list, this.tqhkfl, "提前还款费率",
//				exchangeStringToHtml_info_1(this.tqhkfl));
//		make_map(list, this.hkfs, "还款方式",
//				exchangeStringToHtml_info_1(this.hkfs));
//		make_map(list, this.yhbx, "月还本息",
//				exchangeStringToHtml_info_2(this.yhbx, "元"));
//		make_map(list, this.tbjd, "投标进度", this.tbjd);
//		make_map(list, this.jlll, "投标奖励",
//				exchangeStringToHtml_info_2(this.jlll + "%", this.jllx));
//		make_map(list, this.grtbdcs, "累计投标次数",
//				exchangeStringToHtml_info_2(this.grtbdcs, "次"));
//		make_map(list, this.rzsysj, "剩余时间",
//				exchangeStringToHtml_info_1(this.rzsysj));
//		make_map(list, this.mbsj, "满标用时",
//				exchangeStringToHtml_info_1(this.mbsj));
//		make_map(list, this.tbxe, "投标限额",
//				exchangeStringToHtml_info_1(this.tbxe));
		return list;
	}

	// URL介绍
	public List<Map<String, String>> make_sanInfo_2() {
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		make_map(list, this.bdxq_url, "标的详情", this.bdxq_url);
		make_map(list, this.xgzl_url, "相关资料", this.xgzl_url);
		make_map(list, this.jlgz_url, "奖励规则", this.jlgz_url);
		make_map(list, this.tbjl_url, "投标记录", this.tbjl_url);
		make_map(list, this.hkjl_url, "还款记录", this.hkjl_url);
		make_map(list, this.zqxx_url, "债权信息", this.zqxx_url);
		make_map(list, this.zrjl_url, "转让记录", this.zrjl_url);
		make_map(list, this.jlmd_url, "奖励名单", this.jlmd_url);
		return list;
	}

	// 创建map
	private Map<String, String> make_map(List<Map<String, String>> list,
			String value, String left, String right) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("left", left);
		if (value == null) {
			return map;
		}
		if (!value.equals("-1")) {
			map.put("right", right);
			list.add(map);
		}
		return map;
	}

	private String exchangeStringToHtml_info_1(String name) {
		StringBuffer strBuf = new StringBuffer();
		strBuf.append("<div align='left'>");
		strBuf.append(String.format(
				"<font size =14 face='HelveticaNeue'>%s</font>", name));
		strBuf.append("</div>");
		return new String(strBuf);
	}

	private String exchangeStringToHtml_info_2(String name, String vlaue) {
		StringBuffer strBuf = new StringBuffer();
		strBuf.append("<div align='left'>");
		strBuf.append(String
				.format("<font size =14 face='HelveticaNeue' color='#F08F00'>%s</font>",
						name));
		strBuf.append(String.format(
				"<font size =14 face='HelveticaNeue'>%s</font>", vlaue));
		strBuf.append("</div>");
		return new String(strBuf);
	}

	// 我的散标投标--列表(回收中)
	public Map<String, String> my_san_huishouzhong_list() {
		String xiayigehuikuanri = "";
		if (this.getXyhkr().length() > 11) {
			xiayigehuikuanri = this.getXyhkr().substring(0, 11);
		} else {
			xiayigehuikuanri = this.getXyhkr();
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("1", my_exchage_html(this.dsbx, "待收本息"));

		StringBuffer strBuf = new StringBuffer();
		strBuf.append("<div align='center'>");
		strBuf.append(String.format(
				"<font size =8 face='HelveticaNeue'>%s</font>", this.nll));
		strBuf.append(String
				.format("<br/><font size =10 face='HelveticaNeue' color='#8B8B8B'>%s</font>",
						"年利率"));
		strBuf.append("</div>");

		map.put("2", new String(strBuf));
		map.put("3", my_exchage_html(this.syqs, "剩余期数"));
		map.put("4", my_exchage_html(xiayigehuikuanri, "下个还款日"));

		return map;
	}

	// 我的散标投标--列表(投标中)
	public Map<String, String> my_san_toubiaozhong_list() {
		return null;
	}

	// 我的散标投标--列表(已结清)
	public Map<String, String> my_san_yijieqing_list() {
		Map<String, String> map = new HashMap<String, String>();
		map.put("1", my_exchage_html(this.tzje, "投资金额"));
		map.put("2", my_exchage_html(this.nll, "年利率"));
		map.put("3", my_exchage_html(this.yzje, "已赚金额"));
		map.put("4", my_exchage_html(this.jqrq, "结清日期"));
		return map;
	}

	// 我的散标投标--列表(已转出)
	public Map<String, String> my_san_yizhuanchu_list() {
		Map<String, String> map = new HashMap<String, String>();
		map.put("1", my_exchage_html(this.zccjfs, "成交份数"));
		map.put("2", my_exchage_html(this.zcsjsr, "实际收入"));
		map.put("3", my_exchage_html(this.zcjyfy, "交易费用"));
		map.put("4", my_exchage_html(this.zczryk, "转让盈亏"));
		return map;
	}

	// 我的列表的html
	private String my_exchage_html(String string, String name) {
		StringBuffer strBuf = new StringBuffer();
		strBuf.append("<div align='center'>");
		strBuf.append(String.format(
				"<font size =11 face='HelveticaNeue'>%s</font>", string));
		strBuf.append(String
				.format("<br/><font size =10 face='HelveticaNeue' color='#8B8B8B'>%s</font>",
						name));
		strBuf.append("</div>");
		return new String(strBuf);
	}

	public String getJlje() {
		return jlje;
	}

	public void setJlje(String jlje) {
		this.jlje = jlje;
	}

	public String getpId() {
		return pId;
	}

	public void setpId(String pId) {
		this.pId = pId;
	}

	public JSONArray getTbArray() {
		return tbArray;
	}

	public void setTbArray(JSONArray tbArray) {
		this.tbArray = tbArray;
	}

	public String getBdbt() {
		return bdbt;
	}

	public void setBdbt(String bdbt) {
		this.bdbt = bdbt;
	}

	public String getJllx() {
		return jllx;
	}

	public void setJllx(String jllx) {
		this.jllx = jllx;
	}

	public String getRzjd() {
		return rzjd;
	}

	public void setRzjd(String rzjd) {
		this.rzjd = rzjd;
	}

	public String getBdze() {
		return bdze;
	}

	public void setBdze(String bdze) {
		this.bdze = bdze;
	}

	public String getNll() {
		return nll;
	}

	public void setNll(String nll) {
		this.nll = nll;
	}

	public String getJlll() {
		return jlll;
	}

	public void setJlll(String jlll) {
		this.jlll = jlll;
	}

	public String getHkqx() {
		return hkqx;
	}

	public void setHkqx(String hkqx) {
		this.hkqx = hkqx;
	}

	public String getJkfs() {
		return jkfs;
	}

	public void setJkfs(String jkfs) {
		this.jkfs = jkfs;
	}

	public String getZt() {
		return zt;
	}

	public void setZt(String zt) {
		this.zt = zt;
	}

	public String getSyje() {
		return syje;
	}

	public void setSyje(String syje) {
		this.syje = syje;
	}

	public String getXydj() {
		return xydj;
	}

	public void setXydj(String xydj) {
		this.xydj = xydj;
	}

	public String getBzfs() {
		return bzfs;
	}

	public void setBzfs(String bzfs) {
		this.bzfs = bzfs;
	}

	public String getTqhkfl() {
		return tqhkfl;
	}

	public void setTqhkfl(String tqhkfl) {
		this.tqhkfl = tqhkfl;
	}

	public String getHkfs() {
		return hkfs;
	}

	public void setHkfs(String hkfs) {
		this.hkfs = hkfs;
	}

	public String getYhbx() {
		return yhbx;
	}

	public void setYhbx(String yhbx) {
		this.yhbx = yhbx;
	}

	public String getGrtbdcs() {
		return grtbdcs;
	}

	public void setGrtbdcs(String grtbdcs) {
		this.grtbdcs = grtbdcs;
	}

	public String getRzsysj() {
		return rzsysj;
	}

	public void setRzsysj(String rzsysj) {
		this.rzsysj = rzsysj;
	}

	public String getTbxe() {
		return tbxe;
	}

	public void setTbxe(String tbxe) {
		this.tbxe = tbxe;
	}

	public String getFbsj() {
		return fbsj;
	}

	public void setFbsj(String fbsj) {
		this.fbsj = fbsj;
	}

	public String getCbqx() {
		return cbqx;
	}

	public void setCbqx(String cbqx) {
		this.cbqx = cbqx;
	}

	public String getBdxq_url() {
		return bdxq_url;
	}

	public void setBdxq_url(String bdxq_url) {
		this.bdxq_url = bdxq_url;
	}

	public String getXgzl_url() {
		return xgzl_url;
	}

	public void setXgzl_url(String xgzl_url) {
		this.xgzl_url = xgzl_url;
	}

	public String getJlgz_url() {
		return jlgz_url;
	}

	public void setJlgz_url(String jlgz_url) {
		this.jlgz_url = jlgz_url;
	}

	public String getTbjl_url() {
		return tbjl_url;
	}

	public void setTbjl_url(String tbjl_url) {
		this.tbjl_url = tbjl_url;
	}

	public String getHkjl_url() {
		return hkjl_url;
	}

	public void setHkjl_url(String hkjl_url) {
		this.hkjl_url = hkjl_url;
	}

	public String getZqxx_url() {
		return zqxx_url;
	}

	public void setZqxx_url(String zqxx_url) {
		this.zqxx_url = zqxx_url;
	}

	public String getZrjl_url() {
		return zrjl_url;
	}

	public void setZrjl_url(String zrjl_url) {
		this.zrjl_url = zrjl_url;
	}

	public String getJlmd_url() {
		return jlmd_url;
	}

	public void setJlmd_url(String jlmd_url) {
		this.jlmd_url = jlmd_url;
	}

	public String getDsbx() {
		return dsbx;
	}

	public void setDsbx(String dsbx) {
		this.dsbx = dsbx;
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

	public String getXyhkr() {
		return xyhkr;
	}

	public void setXyhkr(String xyhkr) {
		this.xyhkr = xyhkr;
	}

	public String getJd() {
		return jd;
	}

	public void setJd(String jd) {
		this.jd = jd;
	}

	public String getTzje() {
		return tzje;
	}

	public void setTzje(String tzje) {
		this.tzje = tzje;
	}

	public String getYzje() {
		return yzje;
	}

	public void setYzje(String yzje) {
		this.yzje = yzje;
	}

	public String getJqrq() {
		return jqrq;
	}

	public void setJqrq(String jqrq) {
		this.jqrq = jqrq;
	}

	public String getZccjfs() {
		return zccjfs;
	}

	public void setZccjfs(String zccjfs) {
		this.zccjfs = zccjfs;
	}

	public String getZcsjsr() {
		return zcsjsr;
	}

	public void setZcsjsr(String zcsjsr) {
		this.zcsjsr = zcsjsr;
	}

	public String getZcjyfy() {
		return zcjyfy;
	}

	public void setZcjyfy(String zcjyfy) {
		this.zcjyfy = zcjyfy;
	}

	public String getZczryk() {
		return zczryk;
	}

	public void setZczryk(String zczryk) {
		this.zczryk = zczryk;
	}

	public String getTbjd() {
		return zczryk;
	}

	public void setTbjd(String tbjd) {
		this.tbjd = tbjd;
	}

}
