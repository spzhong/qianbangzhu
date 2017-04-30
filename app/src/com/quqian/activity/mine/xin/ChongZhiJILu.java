package com.quqian.activity.mine.xin;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.opengl.Visibility;
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
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.ProgressBar;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.LoginActivity;
import com.quqian.activity.index.IndexActivity;
import com.quqian.activity.index.LiCaiInfoActivity;
import com.quqian.activity.index.LiCaiTiYanActivity;
import com.quqian.activity.index.LiJiShenQingActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.SanProject;
import com.quqian.been.TiYanProject;
import com.quqian.been.UserMode;
import com.quqian.been.ZhaiQuanProject;
import com.quqian.http.API;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.listview.XListView;
import com.quqian.listview.XListView.IXListViewListener;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.Tool;

public class ChongZhiJILu extends BaseActivity implements OnClickListener,
		IXListViewListener, HttpResponseInterface {

	// list<object>集合
	private List<Object> allList1 = new ArrayList<Object>();
	private List<Object> allList2 = new ArrayList<Object>();
	// 下拉刷新
	private XListView mListView = null;
	// 自定义适配器
	private MyAdapter1 mAdapter1 = null;
	private MyAdapter2 mAdapter2 = null;
	// radioGroup
	private RadioGroup rg = null;

	// 存管充值记录
	private RadioButton rb1 = null;
	// 普通充值记录
	private RadioButton rb2 = null;

	// 单选按钮下面的选中条
	private TextView tvrb1 = null;
	private TextView tvrb2 = null;

	// 记录当前刷新页
	private int curPage = 1;

	ProcessDialogUtil juhua = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.mine_new_chongzhijlu;
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
		setTitle("充值记录");
		showBack();

		juhua = new ProcessDialogUtil(ChongZhiJILu.this);

		rg = (RadioGroup) findViewById(R.id.czjl_rg);
		rb1 = (RadioButton) findViewById(R.id.czjl_rb1);
		rb2 = (RadioButton) findViewById(R.id.czjl_rb2);

		// 单选按钮下面的选中条
		tvrb1 = (TextView) findViewById(R.id.czjl_tvrb1);
		tvrb2 = (TextView) findViewById(R.id.czjl_tvrb2);

		mListView = (XListView) findViewById(R.id.czjl_listview);
		mListView.setPullLoadEnable(false);
		mAdapter1 = new MyAdapter1();
		mAdapter2 = new MyAdapter2();

		mListView.setAdapter(mAdapter1);

		// diao接口
		loadHttp("0");
	}

	@Override
	protected void onResume() {
		// TODO Auto-generated method stub
		super.onResume();
	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);
		rb1.setOnClickListener(this);
		rb2.setOnClickListener(this);
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub

		switch (arg0.getId()) {
		case R.id.title_bar_back:
			ChongZhiJILu.this.finish();
			anim_right_out();
			break;
		case R.id.czjl_rb1:
			// 存管充值记录
			// 修改状态条
			tvrb1.setBackgroundColor(getResources().getColor(
					R.color.main_radio_blue));
			tvrb2.setBackgroundColor(getResources().getColor(R.color.white));

			// 请求数据
			curPage = 1;
			mListView.setAdapter(mAdapter1);
			// mAdapter1.notifyDataSetChanged();
			loadHttp("0");
			break;
		case R.id.czjl_rb2:
			// 普通充值记录
			// 改变单选状态条
			tvrb1.setBackgroundColor(getResources().getColor(R.color.white));
			tvrb2.setBackgroundColor(getResources().getColor(
					R.color.main_radio_blue));

			// 请求数据
			curPage = 1;
			mListView.setAdapter(mAdapter2);
			// mAdapter2.notifyDataSetChanged();
			loadHttp("1");
			break;
		default:
			break;
		}
	}

	/** 适配器 ---精选理财 **/
	class MyAdapter1 extends BaseAdapter {

		@Override
		public int getCount() {
			return allList1 != null ? allList1.size() : 0;
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
				convertView = LayoutInflater.from(ChongZhiJILu.this).inflate(
						R.layout.mine_new_chongzhijlu_item, null);

				holder.tv1 = (TextView) convertView.findViewById(R.id.czjl_tv1);

				holder.tv2 = (TextView) convertView.findViewById(R.id.czjl_tv2);

				holder.tv3 = (TextView) convertView.findViewById(R.id.czjl_tv3);

				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}

			JSONObject json = (JSONObject) allList1.get(position);
			try {
				holder.tv1.setText(json.getString("time"));
				holder.tv2.setText(json.getString("je"));
				holder.tv3.setText(json.getString("zt"));
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			return convertView;
		}

		final class ViewHolder {

			TextView tv1;
			TextView tv2;
			TextView tv3;
		}
	}

	/** 适配器 ---存管理财 **/
	class MyAdapter2 extends BaseAdapter {

		@Override
		public int getCount() {
			return allList2 != null ? allList2.size() : 0;
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
				convertView = LayoutInflater.from(ChongZhiJILu.this).inflate(
						R.layout.mine_new_chongzhijlu_item, null);

				holder.tv1 = (TextView) convertView.findViewById(R.id.czjl_tv1);

				holder.tv2 = (TextView) convertView.findViewById(R.id.czjl_tv2);

				holder.tv3 = (TextView) convertView.findViewById(R.id.czjl_tv3);

				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}

			JSONObject json = (JSONObject) allList2.get(position);
			try {
				holder.tv1.setText(json.getString("time"));
				holder.tv2.setText(json.getString("je"));
				holder.tv3.setText(json.getString("zt"));
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			return convertView;
		}

		final class ViewHolder {

			TextView tv1;
			TextView tv2;
			TextView tv3;
			TextView tv_btn;
			TextView tv_i1;
			TextView tv_i2;
			TextView tv_i3;
			TextView tv_i4;

		}
	}

	private void onStopLoad() {
		mListView.stopRefresh();
		mListView.stopLoadMore();
		mListView.setRefreshTime(new Date().toLocaleString());
	}

	// listView下拉刷新，上拉加载
	@Override
	public void onRefresh() {
		// TODO Auto-generated method stub
		curPage = 1;
		if (rb1.isChecked()) {
			loadHttp("0");
		} else if (rb2.isChecked()) {
			loadHttp("1");
		}
	}

	@Override
	public void onLoadMore() {
		// TODO Auto-generated method stub
		if (rb1.isChecked()) {
			curPage++;
			loadHttp("0");
		} else if (rb2.isChecked()) {
			curPage++;
			loadHttp("1");
		}
	}

	private void loadHttp(String status) {

		juhua.show();

		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		// 请求的参数如下
		if (status.endsWith("0")) {
			map.put("type", "CGCZ");// 0存管充值，1是普通充值
		} else {
			map.put("type", "PTCZ");// 0存管充值，1是普通充值
		}
		map.put("page", curPage + "");// 当前页码
		RequestThreadAbstract thread = RequestFactory.createRequestThread(107,
				map, ChongZhiJILu.this, mHandler);
		RequestPool.execute(thread);

	}

	private Handler mHandler = new Handler() {

		@Override
		public void handleMessage(Message msg) {
			// TODO Auto-generated method stub
			super.handleMessage(msg);

			juhua.cancel();

			switch (msg.what) {
			case 0:
				Toast.makeText(ChongZhiJILu.this,
						msg.getData().getString("errMsg"), 1000).show();
				onStopLoad();
				break;
			case 1:

				// json = (JSONObject) msg.getData().get("json");
				if (msg.getData().get("type").equals("CGCZ")) {

					List<Object> list = (List<Object>) msg.getData()
							.get("list");
					if (curPage == 1) {
						allList1.clear();
					}
					allList1.addAll(list);
					mAdapter1.notifyDataSetChanged();

				} else if (msg.getData().get("type").equals("PTCZ")) {

					List<Object> list = (List<Object>) msg.getData()
							.get("list");
					if (curPage == 1) {
						allList2.clear();
					}
					allList2.addAll(list);
					mAdapter2.notifyDataSetChanged();

				}

				onStopLoad();
				getPage();

				break;
			case 2:
				Toast.makeText(ChongZhiJILu.this,
						msg.getData().getString("msg"), 1000).show();
				onStopLoad();
				break;
			default:
				break;
			}
		}
	};

	// 标记是否加载更多
	private JSONObject json = null;

	private void getPage() {
		if (json != null) {
			try {
				if (!"".equals(json.getString("totalpage"))
						|| json.getString("totalpage").length() != 0) {
					int totalPage = Integer
							.valueOf(json.getString("totalpage"));
					if (curPage < totalPage) {
						mListView.setPullLoadEnable(true);
					} else {
						mListView.setPullLoadEnable(false);
					}
				}
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	// 把所有的网络请求放到最下面
	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub

		json = (JSONObject) jsonObj;

		list = new ArrayList<Object>();
		 
		
		try {
			JSONArray jsonArray = (JSONArray) json.getJSONObject("rvalue")
					.getJSONArray("items");
			for (int i = 0; i < jsonArray.length(); i++) {
				JSONObject noejson = jsonArray.getJSONObject(i);
				list.add(noejson);// 加入list中
			}

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Bundle b = new Bundle();
		b.putParcelableArrayList("list", (ArrayList<? extends Parcelable>) list);
		// b.putParcelable("json", (Parcelable) json);
		b.putString("type", map.get("type"));
		Message msg1 = new Message();
		msg1.setData(b);
		msg1.what = 1;
		mHandler.sendMessage(msg1);

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
