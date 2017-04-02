package com.quqian.http;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;

import com.quqian.been.Notification;
import com.quqian.been.SanProject;
import com.quqian.been.TiYanProject;
import com.quqian.been.UserMode;
import com.quqian.been.ZhaiQuanProject;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.Tool;

public class Data {
    
    public String urlNum = "";
    public Object resultObj = null;
    public List<Object> list = new ArrayList<Object>();
    public HttpResponseInterface activity;
    
    
    public HttpResponseInterface getActivity() {
		return activity;
	}

	public void setActivity(HttpResponseInterface activity) {
		this.activity = activity;
	}

	public String getUrlNum() {
		return urlNum;
	}

	public void setUrlNum(String urlNum) {
		this.urlNum = urlNum;
	}

	public Object getResultObj() {
		return resultObj;
	}

	public void setResultObj(Object resultObj) {
		this.resultObj = resultObj;
	}

	public List<Object> getList() {
		return list;
	}

	public void setList(List<Object> list) {
		this.list = list;
	}

	//初始化方法
    public Data(String urlNum,Object resultObj,HttpResponseInterface activity) {
        // TODO Auto-generated constructor stub
        this.urlNum = urlNum;
        this.resultObj = resultObj;
        this.activity = activity;
    }
    
    //添加数据到数组中
    public void addDataToList(){
        
        if(this.urlNum=="1"){//登录
            API_LOGIN_1_2_3();
        }else if(this.urlNum=="2"){//获取个人信息
            API_LOGIN_1_2_3();
        }else if(this.urlNum=="3"){//注册
            API_LOGIN_1_2_3();
        }else if(this.urlNum=="8"){//散标投资列表
            API_SBTZLIST_8();
        }else if(this.urlNum=="9"){//散标投资详情
            API_SBTZGET_9();
        }else if(this.urlNum=="11"){//理财体验列表
            API_LCTYLIST_11();
        }else if(this.urlNum=="12"){//理财体验详情
            API_LCTYGET_12();
        }else if(this.urlNum== "16"){//债权转让列表
            API_ZQZRLIST_16();
        }else if(this.urlNum== "17"){//债权转让详情
            API_ZQZRGET_17();
        }else if(this.urlNum=="27"){//我的散标投标
            API_USRSBTZLIST_27();
        }else if(this.urlNum=="28"){//我的理财体验
            API_USRSLCTYLIST_28();
        }else if(this.urlNum=="29"){//我的通知消息
            API_USRXXGLLIST_29();
        }else if(this.urlNum=="48"){//快赚宝列表
            API_USRXXGLLIST_48();
        }
        
    }
    
    //添加数据到数组中--登录
    private void API_LOGIN_1_2_3(){
        JSONObject json = (JSONObject) this.resultObj;
        String yhzh = "";
        try {
			yhzh = json.getString("yhzh");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        String bendi = Tool.readData((Context) this.getActivity(), "user", "yhzh");
        //判断是否相等网络 本地
        if(yhzh.equals(bendi)){
        	UserMode user = Tool.get_bendi_User((Context)this.getActivity());
        	user.initMakeData(json);
        	user.saveUserToDB((Context) activity);
            this.list.add(user);//加入list中
        }else{
        	 UserMode user = new UserMode();
             user.initMakeData(json);//model 赋予数据
             user.saveUserToDB((Context) activity);
             this.list.add(user);//加入list中
        }
        
       
    }
    
    //添加数据到数组中--散标投资列表
    private void API_SBTZLIST_8(){
        JSONArray jsonArray = (JSONArray) this.resultObj;
        JSONObject json;
        for (int i = 0; i < jsonArray.length(); i++) {
            try {
                json = jsonArray.getJSONObject(i);
                SanProject san = new SanProject();
                san.initMakeData_list(json,"liebiao");
                this.list.add(san);//加入list中
            } catch (JSONException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }
    
    //添加数据到数组中--散标投资详情
    private void API_SBTZGET_9(){
        JSONObject json = (JSONObject) this.resultObj;
        SanProject san = new SanProject();
        san.initMakeData_listInfo(json,"");
        this.list.add(san);//加入list中
    }
    
    //添加数据到数组中--理财体验列表
    private void API_LCTYLIST_11(){
        JSONArray jsonArray = (JSONArray) this.resultObj;
        JSONObject json;
        for (int i = 0; i < jsonArray.length(); i++) {
            try {
                json = jsonArray.getJSONObject(i);
                TiYanProject tiyan =  new TiYanProject();
                tiyan.initMakeData_list(json);
                this.list.add(tiyan);//加入list中
            } catch (JSONException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }
    
    //添加数据到数组中--理财体验详情
    private void API_LCTYGET_12(){
        JSONObject json = (JSONObject) this.resultObj;
        TiYanProject tiyan = new TiYanProject();
        tiyan.initMakeData_listInfo(json);
        this.list.add(tiyan);//加入list中
    }
    
    //添加数据到数组中--债权转让列表
    public void API_ZQZRLIST_16(){
        JSONArray jsonArray = (JSONArray) this.resultObj;
        JSONObject json;
        for (int i = 0; i < jsonArray.length(); i++) {
            try {
                json = jsonArray.getJSONObject(i);
                ZhaiQuanProject zhaiquan =  new ZhaiQuanProject();
                zhaiquan.initMakeData_list(json);
                this.list.add(zhaiquan);//加入list中
            } catch (JSONException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }
    
    //添加数据到数组中--理财体验详情
    private void API_ZQZRGET_17(){
        JSONObject json = (JSONObject) this.resultObj;
        ZhaiQuanProject zhaiquan = new ZhaiQuanProject();
        zhaiquan.initMakeData_listInfo(json);
        this.list.add(zhaiquan);//加入list中
    }
    
    
    //添加数据到数组中--我的散标投标
    private void API_USRSBTZLIST_27(){
        JSONArray jsonArray = (JSONArray) this.resultObj;
        JSONObject json;
        for (int i = 0; i < jsonArray.length(); i++) {
            try {
                json = jsonArray.getJSONObject(i);
                SanProject san =  new SanProject();
                san.initMakeData_my_listInfo(json);
                this.list.add(san);//加入list中
            } catch (JSONException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }
    
    
    //添加数据到数组中--我的理财体验
    private void API_USRSLCTYLIST_28(){
        JSONArray jsonArray = (JSONArray) this.resultObj;
        JSONObject json;
        for (int i = 0; i < jsonArray.length(); i++) {
            try {
                json = jsonArray.getJSONObject(i);
                TiYanProject tiyan =  new TiYanProject();
                tiyan.initMakeData_my_listInfo(json);
                this.list.add(tiyan);//加入list中
            } catch (JSONException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    }
    
    //添加数据到数组中--我的通知消息
    private void API_USRXXGLLIST_29(){
    	JSONObject result = (JSONObject)this.resultObj;
        JSONArray jsonArray = null;
        JSONObject json = null;
		try {
			jsonArray = result.getJSONArray("lists");
			for (int i = 0; i < jsonArray.length(); i++) {
	            try {
	                json = jsonArray.getJSONObject(i);
	                Notification notification =  new Notification();
	                notification.initMakeData_listInfo(json);
	                notification.initMakeData_listInfo1(result);
	                this.list.add(notification);//加入list中
	            } catch (JSONException e) {
	                // TODO Auto-generated catch block
	                e.printStackTrace();
	            }
	        }
		} catch (JSONException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		}

	  //添加数据到数组中--快赚宝列表
    	private void API_USRXXGLLIST_48(){
    	  JSONArray jsonArray = (JSONArray) this.resultObj;
          JSONObject json;
          for (int i = 0; i < jsonArray.length(); i++) {
              try {
                  json = jsonArray.getJSONObject(i);
                  SanProject san = new SanProject();
                  san.initMakeData_list(json,"liebiao");
                  this.list.add(san);//加入list中
              } catch (JSONException e) {
                  // TODO Auto-generated catch block
                  e.printStackTrace();
              }
          }
}
    
    
}
