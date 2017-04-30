package com.quqian.http;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.Map;

import com.quqian.util.HttpResponseInterface;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;

public class RequestThreadImp extends RequestThreadAbstract {
	protected RequestThreadImp(int i, Map<String, String> map,
			HttpResponseInterface context, Handler handler) {
		super(i, map, context, handler);
	}

	@Override
	public void run() {
		switch (i) {
		case 1:
			String errMsg1 = API.API_LOGIN_1(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg1.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg1);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 2:
			String errMsg2 = API.API_GETUSER_2(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg2.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg2);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 3:
			String errMsg3 = API.API_REGISTER_3(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg3.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg3);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 4:
			String errMsg4 = API.API_LOGOUT_4(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg4.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg4);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 5:
			String errMsg5 = API.API_SENDREGISTERMSG_5(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg5.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg5);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 6:
			String errMsg6 = API.API_SENDZHMMMSG_6(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg6.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg6);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 7:
			String errMsg7 = API.API_YJFK_7(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg7.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg7);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 8:
			String errMsg8 = API.API_SBTZLIST_8(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg8.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg8);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 9:
			String errMsg9 = API.API_SBTZGET_9(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg9.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg9);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 10:
			String errMsg10 = API.API_SBTZTB_10(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg10.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg10);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;

		case 11:
			String errMsg11 = API.API_LCTYLIST_11(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg11.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg11);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;

		case 12:
			String errMsg12 = API.API_LCTYGET_12(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg12.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg12);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 13:
			String errMsg13 = API.API_LCTYJR_13(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg13.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg13);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 14:
			String errMsg14 = API.API_LCTYTYQS_14(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg14.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg14);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 15:
			String errMsg15 = API.API_LCTYHQ_15(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg15.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg15);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;

		case 16:
			String errMsg16 = API.API_ZQZRLIST_16(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg16.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg16);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 17:
			String errMsg17 = API.API_ZQZRGET_17(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg17.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg17);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 18:
			String errMsg18 = API.API_ZQZRGM_18(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg18.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg18);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 19:
			String errMsg19 = API.API_USRZHAQSMRZ_19(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg19.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg19);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 20:
			String errMsg20 = API.API_USRZHAQTXMM_20(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg20.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg20);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 22:
			String errMsg22 = API.API_USRZHAQXGSJNEW_22(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg22.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg22);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 23:
			String errMsg23 = API.API_USRZHAQXGTXMM_23(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg23.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg23);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 25:
			String errMsg25 = API.API_USRJYJLPARAMETERS_25(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg25.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg25);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 26:
			String errMsg26 = API.API_USRJYJLLIST_26(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg26.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg26);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 27:
			String errMsg27 = API.API_USRSBTZLIST_27(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg27.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg27);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 28:
			String errMsg28 = API.API_USRSLCTYLIST_28(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg28.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg28);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 29:
			String errMsg29 = API.API_USRXXGLLIST_29(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg29.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg29);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 37:
			String errMsg37 = API.API_USRXXGLINFO_37(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg37.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg37);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 33:
			String errMsg33 = API.API_BANNERBOX_33(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg33.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg33);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 34:
			String errMsg34 = API.API_ZHMMSET_34(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg34.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg34);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 35:
			String errMsg35 = API.API_VERSION_35(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg35.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg35);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 36:
			String errMsg36 = API.API_sjxgtxmm_36(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg36.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg36);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 38:
			String errMsg38 = API.API_getrecharge_38(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg38.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg38);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 39:
			String errMsg39 = API.API_pay_39(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg39.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg39);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 40:
			String errMsg40 = API.API_getwithdraw_40(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg40.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg40);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 41:
			String errMsg41 = API.API_checkWpassword_41(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg41.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg41);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 42:
			String errMsg42 = API.API_withdraw_42(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg42.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg42);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 43:
			String errMsg43 = API.API_bankcard_43(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg43.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg43);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 44:
			String errMsg44 = API.API_getbank_44(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg44.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg44);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 45:
			String errMsg45 = API.API_region_45(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg45.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg45);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 46:
			String errMsg46 = API.API_addorupdate_46(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg46.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg46);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 47:
			String errMsg47 = API.API_androidRegion_47(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg47.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg47);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 48:
			String errMsg48 = API.API_KZBLIST_48(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg48.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg48);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 100:
			String errMsg100 = API.APIYysjCount_100(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg100.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg100);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 101:
			String errMsg101 = API.APIwoyaojiekuan_101(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg101.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg101);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 102:
			String errMsg102 = API.APIgetJxkList_102(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg102.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg102);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 103:
			String errMsg103 = API.APIgetYhkgl_103(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg103.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg103);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 104:
			String errMsg104 = API.APIDealpay_104(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg104.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg104);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 105:
			String errMsg105 = API.APIWithdraw_105(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg105.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg105);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 106:
			String errMsg106 = API.BankcardRegCg_106(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg106.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg106);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 107:
			String errMsg107 = API.payRecord_107(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg107.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg107);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 108:
			String errMsg108 = API.withdrawRecord_108(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg108.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg108);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 109:
			String errMsg109 = API.bankcardregJin_109(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg109.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg109);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		case 110:
			String errMsg110 = API.jyjlzhzl_110(map, context);
			// 说明有错误的信息－－网络没有发送
			if (errMsg110.length() > 0) {
				Message msg = new Message();
				msg.what = 0;
				Bundle bundle = new Bundle();
				bundle.putString("errMsg", errMsg110);
				msg.setData(bundle);
				handler.sendMessage(msg);
			}
			break;
		default:
			break;
		}
	}

	public static InputStream StringTOInputStream(String in) throws Exception {
		ByteArrayInputStream is = new ByteArrayInputStream(
				in.getBytes("ISO-8859-1"));
		return is;
	}

}
