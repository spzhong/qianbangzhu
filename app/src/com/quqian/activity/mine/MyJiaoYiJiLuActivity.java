package com.quqian.activity.mine;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.annotation.SuppressLint;
import android.app.Dialog;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.Parcelable;
import android.text.Html;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.View.OnClickListener;
import android.widget.Adapter;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.AdapterView.OnItemSelectedListener;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.ProgressBar;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.base.BaseActivity;
import com.quqian.been.SanProject;
import com.quqian.been.TiYanProject;
import com.quqian.http.API;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.listview.XListView;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;

public class MyJiaoYiJiLuActivity extends BaseActivity implements
		OnClickListener, HttpResponseInterface {

	// list<object>集合
	private ArrayList<Map<String, String>> allList = null;
	// 下拉刷新
	private ListView mListView = null;
	// 自定义适配器
	private MyAdapter mAdapter = null;

	// spinner
	private Spinner spinner_leixin = null;
	private Spinner spinner_time = null;

	private List<String> list1 = null;
	private List<String> list2 = null;

	private ArrayList<Map<String, String>> json_spinner1 = new ArrayList<Map<String, String>>();
	private ArrayList<Map<String, String>> json_spinner2 = new ArrayList<Map<String, String>>();

	// spinner选中状态
	private String state1 = "0";
	private String state2 = "0";

	// private boolean loadhttp = false;

	private Dialog juhua = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_mine_jiaoyijilu;
	}

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("交易记录");
		showBack();

		juhua = new ProcessDialogUtil(MyJiaoYiJiLuActivity.this);

		// json_spinner1 = new JSONObject();
		// json_spinner2 = new JSONObject();

		spinner_leixin = (Spinner) findViewById(R.id.spinner1);
		spinner_time = (Spinner) findViewById(R.id.spinner2);

		allList = new ArrayList<Map<String, String>>();

		list1 = new ArrayList<String>();
		list1.add("交易类型");
		list2 = new ArrayList<String>();
	    list2.add("今天");

		// spinner_leixin.setScrollBarDefaultDelayBeforeFade(scrollBarDefaultDelayBeforeFade)

		mListView = (ListView) findViewById(R.id.mine_jiaoyijilu_listview);
		mAdapter = new MyAdapter();
		mListView.setAdapter(mAdapter);

		loadHttp1();
	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub

		switch (arg0.getId()) {
		case R.id.title_bar_back:
			MyJiaoYiJiLuActivity.this.finish();
			anim_right_out();
			break;
		default:
			break;
		}
	}

	/** 适配器 **/
	class MyAdapter extends BaseAdapter {

		@Override
		public int getCount() {
			return allList != null ? allList.size() : 0;
		}

		@Override
		public Object getItem(int position) {
			return null;
		}

		@Override
		public long getItemId(int position) {
			return position;
		}

		ViewHolder holder;

		@SuppressLint("ResourceAsColor")
		@Override
		public View getView(final int position, View convertView,
				ViewGroup parent) {

			holder = new ViewHolder();

			if (convertView == null) {
				convertView = LayoutInflater.from(MyJiaoYiJiLuActivity.this)
						.inflate(R.layout.main_mine_jiaoyijilu_item, null);
				holder.tv1 = (TextView) convertView
						.findViewById(R.id.main_mine_jiaoyi_item1);
				holder.tv2 = (TextView) convertView
						.findViewById(R.id.main_mine_jiaoyi_item2);
				holder.tv3 = (TextView) convertView
						.findViewById(R.id.main_mine_jiaoyi_item3);

				holder.tv1.setText(allList.get(position).get("jylx"));
				holder.tv2.setText(allList.get(position).get("jyje"));
				holder.tv3.setText(allList.get(position).get("jysj"));

				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}

			return convertView;
		}

		final class ViewHolder {
			TextView tv1;
			TextView tv2;
			TextView tv3;
		}
	}

	// 解析spinner的json数据
	private void toSpinner() {
 
		for (int i = 0; i < json_spinner1.size(); i++) {
			Map<String, String> map = json_spinner1.get(i);
			list1.add(map.get("name"));
		}
		
		list2.clear();
		for (int i = 0; i < json_spinner2.size(); i++) {
			Map<String, String> map = json_spinner2.get(i);
			list2.add(map.get("name"));
		}
		 

		ArrayAdapter<String> adapter1 = new ArrayAdapter<String>(
				MyJiaoYiJiLuActivity.this,
				android.R.layout.simple_spinner_item, list1);
		adapter1.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);

		ArrayAdapter<String> adapter2 = new ArrayAdapter<String>(
				MyJiaoYiJiLuActivity.this,
				android.R.layout.simple_spinner_item, list2);
		adapter2.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);

		spinner_leixin.setAdapter(adapter1);
		spinner_leixin.setSelection(Integer.valueOf(state1));

		spinner_time.setAdapter(adapter2);
		spinner_time.setSelection(Integer.valueOf(state2));

		spinner_leixin.setOnItemSelectedListener(new OnItemSelectedListener() {

			@Override
			public void onItemSelected(AdapterView<?> arg0, View arg1,
					int arg2, long arg3) {
				// TODO Auto-generated method stub
				TextView tv = (TextView) arg1;
				tv.setTextColor(getResources().getColor(R.color.main_blue));

				loadHttp2(spinner_leixin.getSelectedItem().toString(),
						spinner_time.getSelectedItem().toString());
			}

			@Override
			public void onNothingSelected(AdapterView<?> arg0) {
				// TODO Auto-generated method stub

			}
		});

		spinner_time.setOnItemSelectedListener(new OnItemSelectedListener() {

			@Override
			public void onItemSelected(AdapterView<?> arg0, View arg1,
					int arg2, long arg3) {
				// TODO Auto-generated method stub
				TextView tv = (TextView) arg1;
				tv.setTextColor(getResources().getColor(R.color.main_blue));

				loadHttp2(spinner_leixin.getSelectedItem().toString(),
						spinner_time.getSelectedItem().toString());
			}

			@Override
			public void onNothingSelected(AdapterView<?> arg0) {
				// TODO Auto-generated method stub

			}
		});
	}

	private void toList(JSONObject json) {
		allList.clear();
		if (json != null) {
			try {
				if (!"".equals(json.getJSONArray("rvalue"))
						|| json.getJSONArray("rvalue") != null) {
					JSONArray jsonArr = json.getJSONArray("rvalue");
					for (int i = 0; i < jsonArr.length(); i++) {
						JSONObject jsonObj = (JSONObject) jsonArr.get(i);
						Map<String, String> map = new HashMap<String, String>();
						map.put("leixing", jsonObj.getString("jylx"));
						map.put("jiner", jsonObj.getString("jyje"));
						map.put("time", jsonObj.getString("jysj"));
						allList.add(map);
					}
				} else {
					Toast.makeText(MyJiaoYiJiLuActivity.this, "暂无数据",
							Toast.LENGTH_SHORT).show();
				}

			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				Toast.makeText(MyJiaoYiJiLuActivity.this, "数据异常",
						Toast.LENGTH_SHORT).show();
			}
		} else {
			return;
		}
	}

	private void loadHttp1() {

		juhua.show();

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁

		RequestThreadAbstract thread = RequestFactory.createRequestThread(25,
				map, MyJiaoYiJiLuActivity.this, mHandler);
		RequestPool.execute(thread);

	}

	private void loadHttp2(String leixing, String time) {

		juhua.show();

		 
		for (int i = 0; i < json_spinner1.size(); i++) {
			Map<String, String> map = json_spinner1.get(i);
			if(map.get("name").equals(leixing)){
				leixing = map.get("id");
				break;
			}
		}
	
		for (int i = 0; i < json_spinner2.size(); i++) {
			Map<String, String> map = json_spinner2.get(i);
			if(map.get("name").equals(time)){
				time = map.get("id");
				break;
			}
		}
		  
		

		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "2");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		// 请求的参数如下
		map.put("jylx", leixing);// 交易类型
		map.put("jysj", time);// 交易时间

		RequestThreadAbstract thread = RequestFactory.createRequestThread(26,
				map, MyJiaoYiJiLuActivity.this, mHandler);
		RequestPool.execute(thread);

	}

	private Handler mHandler = new Handler() {

		@SuppressWarnings("unchecked")
		@Override
		public void handleMessage(Message msg) {
			// TODO Auto-generated method stub
			super.handleMessage(msg);

			juhua.cancel();

			switch (msg.what) {
			case 0:
				Toast.makeText(MyJiaoYiJiLuActivity.this,
						msg.getData().getString("errMsg"), 1000).show();
				// onStopLoad();
				break;
			case 1:

				json_spinner1 = (ArrayList<Map<String,String>>) msg.getData().get("list");
				json_spinner2 = (ArrayList<Map<String,String>>) msg.getData().get("list1");
				toSpinner();

				break;
			case 3:
				allList.clear();
				allList.addAll( (ArrayList<Map<String,String>>) msg.getData().get("list"));
				
				//toList(json_spinner2);
				mAdapter.notifyDataSetChanged();

				break;
			case 2:
				Toast.makeText(MyJiaoYiJiLuActivity.this,
						msg.getData().getString("msg"), 1000).show();
				// onStopLoad();
				break;
			default:
				break;
			}
		}
	};

	// 把所有的网络请求放到最下面
	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub

		if (map.get("urlTag").equals("1")) {
			ArrayList<Map<String, String>> listnew = new ArrayList<Map<String, String>>();
			ArrayList<Map<String, String>> listnew1 = new ArrayList<Map<String, String>>();

			JSONObject json = (JSONObject) jsonObj;
			try {
				JSONArray jsonArray = json.getJSONArray("rvalue");
				for (int i = 0; i < jsonArray.length(); i++) {
					JSONObject newjson = jsonArray.getJSONObject(i);
					JSONArray oneJsonArray = newjson.getJSONArray("type");

					for (int j = 0; j < oneJsonArray.length(); j++) {
						
						JSONObject newjson1 =  oneJsonArray.getJSONObject(j);
						 
						if (newjson.getString("selecttype").equals("0")) {
							Map<String, String> onemap = new HashMap<String, String>();
							onemap.put("id", newjson1.getString("key"));
							onemap.put("name", newjson1.getString("value"));
							listnew.add(onemap);
						} else if (newjson.getString("selecttype").equals("1")) {
							Map<String, String> onemap = new HashMap<String, String>();
							onemap.put("id", newjson1.getString("key"));
							onemap.put("name", newjson1.getString("value"));
							listnew1.add(onemap);
						}
					}

				}
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			Bundle b = new Bundle();
			b.putParcelableArrayList("list",
					(ArrayList<? extends Parcelable>) listnew);
			b.putParcelableArrayList("list1",
					(ArrayList<? extends Parcelable>) listnew1);
			Message msg1 = new Message();
			msg1.setData(b);
			msg1.what = 1;
			mHandler.sendMessage(msg1);
		} else {

			ArrayList<Map<String, String>> listnew = new ArrayList<Map<String, String>>();

			JSONObject json = (JSONObject) jsonObj;
			try {
				JSONArray jsonArray = json.getJSONArray("rvalue");
				for (int i = 0; i < jsonArray.length(); i++) {
					JSONObject newjson = jsonArray.getJSONObject(i);
					Map<String, String> onemap = new HashMap<String, String>();
					onemap.put("jylx", newjson.getString("jylx"));
					onemap.put("jyje", newjson.getString("jyje"));
					onemap.put("jysj", newjson.getString("jysj"));
					listnew.add(onemap);
				}
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			Bundle b = new Bundle();
			b.putParcelableArrayList("list",
					(ArrayList<? extends Parcelable>) listnew);
			Message msg1 = new Message();
			msg1.setData(b);
			msg1.what = 3;
			mHandler.sendMessage(msg1);
		}

	}

	@Override
	public void httpResponse_fail(Map<String, String> map, String msg,
			Object jsonObj) {
		// TODO Auto-generated method stub
		Message msg2 = new Message();
		msg2.what = 2;
		Bundle bundle = new Bundle();
		bundle.putString("msg", msg);
		msg2.setData(bundle);
		mHandler.sendMessage(msg2);

	}
}
