package com.quqian.http;

import java.util.Map;

import android.util.Log;

import com.quqian.util.HttpResponseInterface;
import com.quqian.util.Tool;

public class API {

	// 本地测试环境
	//public static String HTTP = "http://192.168.1.87:9111/app/";

	// 测试环境
	public static String HTTP = "http://test.qbzvip.com/app/";

	public static String HTTP_WEB = "http://test.qbzvip.com";
	// 正式环境
	// public static String HTTP = "http://wwww.quqian.com/app/";

	// 我的账户
	public static String LOGIN = HTTP + "login.htm"; // 1,登录
	public static String GETUSER = HTTP + "getUser.htm"; // 2,获取用户信息
	public static String REGISTER = HTTP + "register.htm"; // 3,注册
	public static String LOGOUT = HTTP + "logout.htm"; // 4,退出
	public static String SENDREGISTERMSG = HTTP + "sendMsg.htm";// 5,获取短信
	public static String SENDZHMMMSG = HTTP + "verifyMsg.htm";// 6,验证短信
	public static String YJFK = HTTP + "yjfk.htm"; // 7,意见反馈
	// 散标
	public static String SBTZLIST = HTTP + "sbtz/list.htm"; // 8,散标投资列表
	// 快赚宝
	public static String KZBLIST = HTTP + "kzb/list.htm"; // 48,快赚宝列表
	public static String SBTZGET = HTTP + "sbtz/get.htm"; // 9,散标详情
	public static String SBTZTB = HTTP + "sbtz/tb.htm"; // 10,散标投资投标
	// 理财体验
	public static String LCTYLIST = HTTP + "lcty/list.htm"; // 11,理财体验列表
	public static String LCTYGET = HTTP + "lcty/get.htm"; // 12,理财体验详情
	public static String LCTYJR = HTTP + "lcty/jr.htm"; // 13,用户加入理财体验
	public static String LCTYTYQS = HTTP + "lcty/tyqs.htm"; // 14,用户理财体验券列表
	public static String LCTYHQ = HTTP + "lcty/hq.htm"; // 15,用户获取体验券
	// 债权转让
	public static String ZQZRLIST = HTTP + "zqzr/list.htm"; // 16,债权转让列表
	public static String ZQZRGET = HTTP + "zqzr/get.htm"; // 17,债权转让详情
	public static String ZQZRGM = HTTP + "zqzr/gm.htm"; // 18,用户购买债权
	// 用户中心账户安全
	public static String USRZHAQSMRZ = HTTP + "user/zhaq/smrz.htm"; // 19,实名认证
	public static String USRZHAQTXMM = HTTP + "user/zhaq/sztxmm.htm"; // 20,提现密码
	public static String USRZHAQXGSJOLD = HTTP + "user/zhaq/xgsjOld.htm"; // 21,修改手机老手机
	public static String USRZHAQXGSJNEW = HTTP + "user/zhaq/xgsjNew.htm"; // 22,修改手机新手机
	public static String USRZHAQXGTXMM = HTTP + "user/zhaq/xgtxmm.htm"; // 23,修改提现密码
	public static String USRZHAxgtxmmyz = HTTP + "user/zhaq/xgtxmmYz.htm"; // 24,修改提现密码验证
	// 用户交易记录FF
	public static String USRJYJLPARAMETERS = HTTP + "user/jyjl/parameters.htm";// 25,获取交易类型和交易时间
	public static String USRJYJLLIST = HTTP + "user/jyjl/list.htm"; // 26,获取交易列表
	// 其它
	public static String USRSBTZLIST = HTTP + "user/sbtz/list.htm"; // 27,我的散标投资列表
	public static String USRSLCTYLIST = HTTP + "user/lcty/list.htm"; // 28,我的理财体验列表
	public static String USRXXGLLIST = HTTP + "user/xxgl/list.htm"; // 29,我的消息列表
	public static String USRXXGLINFO = HTTP + "user/xxgl/list.htm"; // 37,我的消息详情

	// public static String USRXXGLLIST = HTTP +"user/xxgl/list.htm"; //30,充值
	// public static String USRXXGLLIST =HTTP + "user/xxgl/list.htm"; //31,提款
	// public static String USRXXGLLIST =HTTP + "user/xxgl/list.htm";
	// //32,绑定银行卡
	public static String BANNERBOX = HTTP + "bannerBox.htm";// 33,获取广告栏目
	public static String ZHMMSET = HTTP + "zhmmSet.htm";// 34,找回设置密码
	public static String VERSION = HTTP + "version.htm";// 35,获取版本

	public static String sjxgtxmm = HTTP + "user/zhaq/sjxgtxmm.htm";// 36,重置提款密码

	// 新增
	public static String getrecharge = HTTP + "user/deal/getrecharge.htm";// 38,充值判断信息
	// public static String pay = HTTP + "user/deal/pay.htm";// 39,充值
	public static String pay = HTTP + "user/deal/appKjPay.htm";// 39,快捷充值
	public static String getwithdraw = HTTP + "user/deal/getwithdraw.htm";// 40,提款判断信息
	public static String checkWpassword = HTTP + "checkWpassword.htm";// 41,验证提款密码
	// public static String withdraw = HTTP + "user/deal/withdraw.htm";// 42,提款
	public static String withdraw = HTTP + "user/deal/appWithdraw.htm";// 42,提款
	public static String bankcard = HTTP + "user/bankcard/get.htm";// 43,获取银行卡信息资料
	public static String getbank = HTTP + "user/bankcard/getbank.htm";// 44,获取所有银行
	public static String region = HTTP + "user/bankcard/region.htm";// 45,获取所有的银行区域
	public static String addorupdate = HTTP + "user/bankcard/addorupdate.htm";// 46,绑定和修改银行信息

	public static String androidRegion = HTTP
			+ "user/bankcard/androidRegion.htm";// 47,获取省，市，区

	// 4月号新增
	public static String YysjCount = HTTP + "yysjCount.htm";// 100,统计数据

	// 4月21号新增
	public static String woyaojiekuan = HTTP + "wyjk.htm";// 101,我要借款

	// 获取加息卡列表
	public static String getJxkList = HTTP + "sbtz/getJxkList.htm";// 102,获取加息卡类标

	public API() {
		// TODO Auto-generated constructor stub
	}

	// 登录
	public static String API_LOGIN_1(Map<String, String> map,
			HttpResponseInterface activity) {
		// 数据的有效判断
		String userName = map.get("userName");
		String password = map.get("password");
		// 判断信息
		if (userName.length() == 0) {
			return "请输入账号";
		}
		if (userName.length() < 6 || userName.length() > 18) {
			return "账号长度为6-18个字符";
		}
		if (password.length() == 0) {
			return "请输入密码";
		}
		if (password.length() < 6 || password.length() > 16) {
			return "密码长度为6-16个字符";
		}
		// 有效数据判断通过
		// 添加URL
		map.put("url", LOGIN);
		map.put("urlNum", "1");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 获取用户信息
	public static String API_GETUSER_2(Map<String, String> map,
			HttpResponseInterface activity) {
		// 添加URL
		map.put("url", GETUSER);
		map.put("urlNum", "2");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 注册
	public static String API_REGISTER_3(Map<String, String> map,
			HttpResponseInterface activity) {

		// 数据的有效判断
		String phone = map.get("phone");
		String password = map.get("password");
		String newPassword = map.get("newPassword");
		String messageCode = map.get("verifyCode");
		// String code = map.get("code");//选填

		// 手机号码
		if (!Tool.isMobileNO(phone)) {
			return "请输入正确的手机号";
		}
		// 密码
		if (password.length() < 6 || password.length() > 16) {
			return "密码长度为6-16个字符";
		}
		if (!password.equals(newPassword)) {
			return "你两次输入的密码不一致";
		}
		if (messageCode.length() == 0) {
			return "请输入验证码";
		}

		// 添加URL
		map.put("url", REGISTER);
		map.put("urlNum", "3");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 登出
	public static String API_LOGOUT_4(Map<String, String> map,
			HttpResponseInterface activity) {
		// 添加URL
		map.put("url", LOGOUT);
		map.put("urlNum", "4");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 获取短信
	public static String API_SENDREGISTERMSG_5(Map<String, String> map,
			HttpResponseInterface activity) {
		// 数据的有效判断
		String phone = map.get("phone");
		String type = map.get("type");
		// 判断信息
		if (!Tool.isMobileNO(phone)) {
			return "请输入正确的手机号";
		}
		// 有效数据判断通过
		// 添加URL
		map.put("url", SENDREGISTERMSG);
		map.put("urlNum", "5");
		// 发起网络请求
		Http.POST(map, activity);
		return "";

	}

	// 验证短信
	public static String API_SENDZHMMMSG_6(Map<String, String> map,
			HttpResponseInterface activity) {
		// 数据的有效判断
		String phone = map.get("phone");
		String code = map.get("code");
		String type = map.get("type");
		// 判断信息
		if (!Tool.isMobileNO(phone)) {
			return "请输入正确的手机号";
		}
		// 密码
		if (code.length() == 0) {
			return "请输入短信验证码";
		}

		// 有效数据判断通过
		// 添加URL
		map.put("url", SENDZHMMMSG);
		map.put("urlNum", "6");
		// 发起网络请求
		Http.POST(map, activity);
		return "";

	}

	// 意见反馈
	public static String API_YJFK_7(Map<String, String> map,
			HttpResponseInterface activity) {
		// 数据的有效判断
		String yjnr = map.get("yjnr");
		String lxfs = map.get("lxfs");
		if (yjnr.length() == 0) {
			return "请输入反馈信息";
		}

		if (yjnr.length() < 200 & yjnr.length() > 10) {

		} else {
			return "反馈信息字数在10到200个字之间";
		}
		if (lxfs.length() == 0) {
			// return "请输入联系方式QQ/手机/邮箱";
		}
		// 有效数据判断通过
		// 添加URL
		map.put("url", YJFK);
		map.put("urlNum", "7");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 散标投资列表
	public static String API_SBTZLIST_8(Map<String, String> map,
			HttpResponseInterface activity) {
		String page = map.get("page");
		if (page.length() == 0) {
			return "请上传页码";
		}
		// 添加URL
		map.put("url", SBTZLIST);
		map.put("urlNum", "8");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 散标详情
	public static String API_SBTZGET_9(Map<String, String> map,
			HttpResponseInterface activity) {
		// String pid = map.get("id");
		// if (pid.length() == 0) {
		// return "请上传散标的id";
		// }
		// 添加URL
		map.put("url", SBTZGET);
		map.put("urlNum", "9");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 散标投资投标
	public static String API_SBTZTB_10(Map<String, String> map,
			HttpResponseInterface activity) {
		String pid = map.get("id");
		String fs = map.get("fs");
		if (pid.length() == 0) {
			return "请上传散标的id";
		}
		if (fs.length() == 0) {
			return "请上传份数";
		}
		// 添加URL
		map.put("url", SBTZTB);
		map.put("urlNum", "10");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 理财体验列表
	public static String API_LCTYLIST_11(Map<String, String> map,
			HttpResponseInterface activity) {
		String page = map.get("page");
		if (page.length() == 0) {
			return "请上传页码";
		}
		// 添加URL
		map.put("url", LCTYLIST);
		map.put("urlNum", "11");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 理财体验详情
	public static String API_LCTYGET_12(Map<String, String> map,
			HttpResponseInterface activity) {
		String pid = map.get("id");
		if (pid.length() == 0) {
			return "请上传散标的id";
		}
		// 添加URL
		map.put("url", LCTYGET);
		map.put("urlNum", "12");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 加入理财体验
	public static String API_LCTYJR_13(Map<String, String> map,
			HttpResponseInterface activity) {
		String pid = map.get("id");
		String qh = map.get("qh");
		if (pid.length() == 0) {
			return "请上传散标的id";
		}
		if (qh.length() == 0) {
			return "请上传券号数组";
		}
		// 添加URL
		map.put("url", LCTYJR);
		map.put("urlNum", "13");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 用户理财体验券列表
	public static String API_LCTYTYQS_14(Map<String, String> map,
			HttpResponseInterface activity) {
		// 添加URL
		map.put("url", LCTYTYQS);
		map.put("urlNum", "14");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 用户获取体验券
	public static String API_LCTYHQ_15(Map<String, String> map,
			HttpResponseInterface activity) {
		String qh = map.get("qh");
		if (qh.length() == 0) {
			return "请上传券号";
		}
		// 添加URL
		map.put("url", LCTYHQ);
		map.put("urlNum", "15");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 债权转让列表
	public static String API_ZQZRLIST_16(Map<String, String> map,
			HttpResponseInterface activity) {
		String page = map.get("page");
		if (page.length() == 0) {
			return "请上传页码";
		}
		// 添加URL
		map.put("url", ZQZRLIST);
		map.put("urlNum", "16");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 债权转让详情
	public static String API_ZQZRGET_17(Map<String, String> map,
			HttpResponseInterface activity) {
		String pid = map.get("id");
		if (pid.length() == 0) {
			return "请上传散标的id";
		}
		// 添加URL
		map.put("url", ZQZRGET);
		map.put("urlNum", "17");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 用户购买债权
	public static String API_ZQZRGM_18(Map<String, String> map,
			HttpResponseInterface activity) {
		String pid = map.get("id");
		String fs = map.get("fs");
		if (pid.length() == 0) {
			return "请上传散标的id";
		}
		if (fs.length() == 0) {
			return "请上传份数";
		}
		// 添加URL
		map.put("url", ZQZRGM);
		map.put("urlNum", "18");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 实名认证
	public static String API_USRZHAQSMRZ_19(Map<String, String> map,
			HttpResponseInterface activity) {
		String zsxm = map.get("zsxm");
		String sfzh = map.get("sfzh");
		if (zsxm.length() == 0) {
			return "请输入真实姓名";
		}
		if (sfzh.length() == 0) {
			return "请输入身份证号";
		}
		if (sfzh.length() != 18) {
			return "身份证号错误";
		}
		// 添加URL
		map.put("url", USRZHAQSMRZ);
		map.put("urlNum", "19");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 提现密码
	public static String API_USRZHAQTXMM_20(Map<String, String> map,
			HttpResponseInterface activity) {
		String mm = map.get("mm");
		String cmm = map.get("cmm");
		if (cmm.length() == 0) {
			return "请输入提款密码";
		}
		if (cmm.length() == 0) {
			return "请输入确认提款密码";
		}
		if (!mm.equals(cmm)) {
			return "两次输入的密码不一样";
		}
		// 添加URL
		map.put("url", USRZHAQTXMM);
		map.put("urlNum", "20");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 修改手机老手机
	public static String API_USRZHAQXGSJOLD_21(Map<String, String> map,
			HttpResponseInterface activity) {
		// String yzm = map.get("yzm");
		// if (yzm.length() == 0) {
		// return "请输入短信验证码";
		// }
		// 添加URL
		map.put("url", USRZHAQXGSJOLD);
		map.put("urlNum", "21");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 修改手机新手机
	public static String API_USRZHAQXGSJNEW_22(Map<String, String> map,
			HttpResponseInterface activity) {
		String yzm = map.get("yzm");
		String sjh = map.get("sjh");
		if (yzm.length() == 0) {
			return "请输入短信验证码";
		}
		if (!Tool.isMobileNO(sjh)) {
			return "请输入正确的手机号";
		}
		// 添加URL
		map.put("url", USRZHAQXGSJNEW);
		map.put("urlNum", "22");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 修改提现密码
	public static String API_USRZHAQXGTXMM_23(Map<String, String> map,
			HttpResponseInterface activity) {
		String lmm = map.get("lmm");
		String xmm = map.get("xmm");
		String cmm = map.get("cmm");
		if (lmm.length() == 0) {
			return "请输入老的提现密码";
		}
		if (xmm.length() == 0) {
			return "请输入新的提现密码";
		}
		if (!xmm.equals(cmm)) {
			return "两次输入的密码不一致";
		}
		// 添加URL
		map.put("url", USRZHAQXGTXMM);
		map.put("urlNum", "23");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 修改提现密码验证
	public static String API_USRZHAxgtxmmyz_24(Map<String, String> map,
			HttpResponseInterface activity) {
		// String yzm = map.get("yzm");
		// if (yzm.length() == 0) {
		// return "请输入验证码";
		// }
		// 添加URL
		map.put("url", USRZHAxgtxmmyz);
		map.put("urlNum", "24");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 获取交易类型和交易时间
	public static String API_USRJYJLPARAMETERS_25(Map<String, String> map,
			HttpResponseInterface activity) {
		// 添加URL
		map.put("url", USRJYJLPARAMETERS);
		map.put("urlNum", "25");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 获取交易列表
	public static String API_USRJYJLLIST_26(Map<String, String> map,
			HttpResponseInterface activity) {
		String jylx = map.get("jylx");
		String jysj = map.get("jysj");
		if (jylx.length() == 0) {
			return "请上传交易类型";
		}
		if (jysj.length() == 0) {
			return "请上传交易时间";
		}
		// 添加URL
		map.put("url", USRJYJLLIST);
		map.put("urlNum", "26");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 我的散标投资列表
	public static String API_USRSBTZLIST_27(Map<String, String> map,
			HttpResponseInterface activity) {
		String status = map.get("status");
		if (status.length() == 0) {
			return "请上传状态";
		}
		// 添加URL
		map.put("url", USRSBTZLIST);
		map.put("urlNum", "27");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 我的理财体验列表
	public static String API_USRSLCTYLIST_28(Map<String, String> map,
			HttpResponseInterface activity) {
		String status = map.get("status");
		if (status.length() == 0) {
			return "请上传状态";
		}
		// 添加URL
		map.put("url", USRSLCTYLIST);
		map.put("urlNum", "28");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 我的消息列表
	public static String API_USRXXGLLIST_29(Map<String, String> map,
			HttpResponseInterface activity) {
		String page = map.get("page");
		if (page.length() == 0) {
			return "请上传页面";
		}
		// 添加URL
		map.put("url", USRXXGLLIST);
		map.put("urlNum", "29");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 我的消息详情
	public static String API_USRXXGLINFO_37(Map<String, String> map,
			HttpResponseInterface activity) {
		String pId = map.get("id");
		if (pId.length() == 0) {
			return "请上传页面";
		}
		// 添加URL
		map.put("url", USRXXGLINFO);
		map.put("urlNum", "37");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 我的广告消息
	public static String API_BANNERBOX_33(Map<String, String> map,
			HttpResponseInterface activity) {
		// 添加URL
		map.put("url", BANNERBOX);
		map.put("urlNum", "33");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 找回设置密码
	public static String API_ZHMMSET_34(Map<String, String> map,
			HttpResponseInterface activity) {

		String phone = map.get("phone");
		// 手机号码
		if (!Tool.isMobileNO(phone)) {
			return "请输入正确的手机号";
		}
		String password = map.get("password");
		String cpassword = map.get("cpassword");
		String key = map.get("key");
		String type = map.get("type");// type 1

		// 添加URL
		map.put("url", ZHMMSET);
		map.put("urlNum", "34");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 获取版本号
	public static String API_VERSION_35(Map<String, String> map,
			HttpResponseInterface activity) {
		// 添加URL
		map.put("url", VERSION);
		map.put("urlNum", "35");
		map.put("type", "android");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 重置提款密码
	public static String API_sjxgtxmm_36(Map<String, String> map,
			HttpResponseInterface activity) {
		// 添加URL
		map.put("url", sjxgtxmm);
		map.put("urlNum", "36");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 判断充值
	public static String API_getrecharge_38(Map<String, String> map,
			HttpResponseInterface activity) {
		// 添加URL
		map.put("url", getrecharge);
		map.put("urlNum", "38");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 充值
	public static String API_pay_39(Map<String, String> map,
			HttpResponseInterface activity) {
		// 添加URL
		map.put("url", pay);
		map.put("urlNum", "39");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 判断提现
	public static String API_getwithdraw_40(Map<String, String> map,
			HttpResponseInterface activity) {
		// 添加URL
		map.put("url", getwithdraw);
		map.put("urlNum", "40");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 验证提款密码
	public static String API_checkWpassword_41(Map<String, String> map,
			HttpResponseInterface activity) {
		// 添加URL
		map.put("url", checkWpassword);
		map.put("urlNum", "41");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 提现
	public static String API_withdraw_42(Map<String, String> map,
			HttpResponseInterface activity) {
		// 添加URL
		map.put("url", withdraw);
		map.put("urlNum", "42");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 获取银行卡信息
	public static String API_bankcard_43(Map<String, String> map,
			HttpResponseInterface activity) {
		// 添加URL
		map.put("url", bankcard);
		map.put("urlNum", "43");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 获取所有的银行
	public static String API_getbank_44(Map<String, String> map,
			HttpResponseInterface activity) {
		// 添加URL
		map.put("url", getbank);
		map.put("urlNum", "44");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 获取所有的银行的区域地址
	public static String API_region_45(Map<String, String> map,
			HttpResponseInterface activity) {
		// 添加URL
		map.put("url", region);
		map.put("urlNum", "45");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 绑定银行
	public static String API_addorupdate_46(Map<String, String> map,
			HttpResponseInterface activity) {
		// 添加URL
		map.put("url", addorupdate);
		map.put("urlNum", "46");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 获取省市区
	public static String API_androidRegion_47(Map<String, String> map,
			HttpResponseInterface activity) {
		// 添加URL
		map.put("url", androidRegion);
		map.put("urlNum", "47");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 快赚宝列表
	public static String API_KZBLIST_48(Map<String, String> map,
			HttpResponseInterface activity) {
		String page = map.get("page");
		if (page.length() == 0) {
			return "请上传页码";
		}
		// 添加URL
		map.put("url", KZBLIST);
		map.put("urlNum", "48");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 统计数据
	public static String APIYysjCount_100(Map<String, String> map,
			HttpResponseInterface activity) {
		// 添加URL
		map.put("url", YysjCount);
		map.put("urlNum", "100");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 我要借款
	public static String APIwoyaojiekuan_101(Map<String, String> map,
			HttpResponseInterface activity) {
		// 添加URL
		map.put("url", woyaojiekuan);
		map.put("urlNum", "101");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

	// 获取加息卡李列表
	public static String APIgetJxkList_102(Map<String, String> map,
			HttpResponseInterface activity) {
		// 添加URL
		map.put("url", getJxkList);
		map.put("urlNum", "102");
		// 发起网络请求
		Http.POST(map, activity);
		return "";
	}

}
