package com.quqian.been;

import org.json.JSONException;
import org.json.JSONObject;

public class Notification {

	public String tId; // 消息ID
	public String title; // 标题
	public String sj; // 时间
	public String content; // 内容
	public String status; // 0是未读，1是读

	public String total; // 消息总数
	public String unRead;// 未读消息
	
	public String ggtitle;//平台公告标题
	public String ggcredittiem;//平台公告创建时间
	public String ggcontent;//平台公告内容

	public String getGgtitle() {
		return ggtitle;
	}

	public void setGgtitle(String ggtitle) {
		this.ggtitle = ggtitle;
	}

	public String getGgcredittiem() {
		return ggcredittiem;
	}

	public void setGgcredittiem(String ggcredittiem) {
		this.ggcredittiem = ggcredittiem;
	}

	public String getGgcontent() {
		return ggcontent;
	}

	public void setGgcontent(String ggcontent) {
		this.ggcontent = ggcontent;
	}

	public Notification() {
		// TODO Auto-generated constructor stub
	}

	// 通知消息-列表
	public void initMakeData_listInfo(JSONObject json) {
		try {
			this.tId = json.getString("id");
			this.title = json.getString("title");
			this.sj = json.getString("sendTime");
			this.content = json.getString("content");
			this.status = json.getString("status");

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 平台公告-列表
	public void initMakeData_listInfo2(JSONObject json) {
		try {
			this.ggtitle = json.getString("title");
			this.ggcredittiem = json.getString("creditTime");
			this.ggcontent = json.getString("content");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 消息的总数和未读条数
	public void initMakeData_listInfo1(JSONObject json) {
		try {
			this.total = json.getString("toalNumber");
			this.unRead = json.getString("unreadNumber");

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}

	public String getUnRead() {
		return unRead;
	}

	public void setUnRead(String unRead) {
		this.unRead = unRead;
	}

	public String gettId() {
		return tId;
	}

	public void settId(String tId) {
		this.tId = tId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSj() {
		return sj;
	}

	public void setSj(String sj) {
		this.sj = sj;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
