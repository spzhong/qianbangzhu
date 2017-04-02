package com.quqian.been;

import java.io.Serializable;

import org.json.JSONException;
import org.json.JSONObject;

public class Chongzhi implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public String rechargeFactorage;
	public String freeFactorageAmount;
	public String rechargeMin;
	public String rechargeMax;
	public String isOk;
	public String bankNumber;
	public String bankName;
	public String city;
	public String cityId;
	public String bankCardId;
	public String isFull;
	public String isBound;

	public String withdrawFactorage_1;
	public String withdrawFactorage_2;
	public String withdrawMin;
	public String withdrawMax;

	public String money;
	public String shouxufei;
	public String shjikouchu;
	public String password;

	// 绑定银行卡
	public String title;
	public String type;// 0是绑定，1是修改，2是完善

	// 绑定银行卡

	// 银行卡信息
	public String bankId;
	public String subbranch;

	// 充值
	public void initMakeData_chongzhi(JSONObject json) {

		try {

			json = json.getJSONObject("rvalue");

			this.setRechargeFactorage(json.getString("rechargeFactorage"));
			this.setFreeFactorageAmount(json.getString("freeFactorageAmount"));
			this.setRechargeMin(json.getString("rechargeMin"));
			this.setRechargeMax(json.getString("rechargeMax"));
			this.setIsOk(json.getString("isOk"));
			this.setBankNumber(json.getString("bankNumber"));
			this.setBankName(json.getString("bankName"));
			this.setBankCardId(json.getString("bankCardId"));
			this.setIsFull(json.getString("isFull"));
			this.setIsBound(json.getString("isBound"));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	// 提款
	public void initMakeData_tixian(JSONObject json) {

		try {

			json = json.getJSONObject("rvalue");

			this.setWithdrawFactorage_1(json.getString("withdrawFactorage_1"));
			this.setWithdrawFactorage_2(json.getString("withdrawFactorage_2"));
			this.setWithdrawMin(json.getString("withdrawMin"));
			this.setWithdrawMax(json.getString("withdrawMax"));
			this.setIsOk(json.getString("isOk"));
			this.setBankNumber(json.getString("bankNumber"));
			this.setBankName(json.getString("bankName"));
			this.setBankCardId(json.getString("bankCardId"));
			this.setIsFull(json.getString("isFull"));
			this.setIsBound(json.getString("isBound"));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	// 银行卡信息
	public void initMakeData_bankInfo(JSONObject json) {

		try {

			json = json.getJSONObject("rvalue");

			this.setBankCardId(json.getString("bankCardId"));
			this.setBankId(json.getString("bankId"));
			this.setBankName(json.getString("bankName"));
			this.setCity(json.getString("city"));
			this.setCityId(json.getString("cityId"));
			this.setSubbranch(json.getString("subbranch"));
			this.setBankNumber(json.getString("bankNumber"));
			this.setBankName(json.getString("bankName"));
			this.setIsBound(json.getString("isBound"));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	

	public String getBankId() {
		return bankId;
	}

	public void setBankId(String bankId) {
		this.bankId = bankId;
	}

	public String getSubbranch() {
		return subbranch;
	}

	public void setSubbranch(String subbranch) {
		this.subbranch = subbranch;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getMoney() {
		return money;
	}

	public void setMoney(String money) {
		this.money = money;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getShouxufei() {
		return shouxufei;
	}

	public void setShouxufei(String shouxufei) {
		this.shouxufei = shouxufei;
	}

	public String getShjikouchu() {
		return shjikouchu;
	}

	public void setShjikouchu(String shjikouchu) {
		this.shjikouchu = shjikouchu;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getWithdrawFactorage_1() {
		return withdrawFactorage_1;
	}

	public void setWithdrawFactorage_1(String withdrawFactorage_1) {
		this.withdrawFactorage_1 = withdrawFactorage_1;
	}

	public String getWithdrawFactorage_2() {
		return withdrawFactorage_2;
	}

	public void setWithdrawFactorage_2(String withdrawFactorage_2) {
		this.withdrawFactorage_2 = withdrawFactorage_2;
	}

	public String getWithdrawMin() {
		return withdrawMin;
	}

	public void setWithdrawMin(String withdrawMin) {
		this.withdrawMin = withdrawMin;
	}

	public String getWithdrawMax() {
		return withdrawMax;
	}

	public void setWithdrawMax(String withdrawMax) {
		this.withdrawMax = withdrawMax;
	}

	public String getRechargeFactorage() {
		return rechargeFactorage;
	}

	public void setRechargeFactorage(String rechargeFactorage) {
		this.rechargeFactorage = rechargeFactorage;
	}

	public String getFreeFactorageAmount() {
		return freeFactorageAmount;
	}

	public void setFreeFactorageAmount(String freeFactorageAmount) {
		this.freeFactorageAmount = freeFactorageAmount;
	}

	public String getRechargeMin() {
		return rechargeMin;
	}

	public void setRechargeMin(String rechargeMin) {
		this.rechargeMin = rechargeMin;
	}

	public String getRechargeMax() {
		return rechargeMax;
	}

	public void setRechargeMax(String rechargeMax) {
		this.rechargeMax = rechargeMax;
	}

	public String getIsOk() {
		return isOk;
	}

	public void setIsOk(String isOk) {
		this.isOk = isOk;
	}

	public String getBankNumber() {
		return bankNumber;
	}

	public void setBankNumber(String bankNumber) {
		this.bankNumber = bankNumber;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCityId() {
		return cityId;
	}

	public void setCityId(String cityId) {
		this.cityId = cityId;
	}

	public String getBankCardId() {
		return bankCardId;
	}

	public void setBankCardId(String bankCardId) {
		this.bankCardId = bankCardId;
	}

	public String getIsFull() {
		return isFull;
	}

	public void setIsFull(String isFull) {
		this.isFull = isFull;
	}

	public String getIsBound() {
		return isBound;
	}

	public void setIsBound(String isBound) {
		this.isBound = isBound;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

}
