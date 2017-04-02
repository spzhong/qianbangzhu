package com.quqian.activity.mine;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.LoginActivity;
import com.quqian.activity.MainActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.Notification;
import com.quqian.been.SanProject;
import com.quqian.http.API;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.listview.XListView;
import com.quqian.listview.XListView.IXListViewListener;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.StaticVariable;

public class TongZhiActivity extends BaseActivity implements OnClickListener,
		IXListViewListener, HttpResponseInterface {

	// list<object>集合
	private List<Object> allList = new ArrayList<Object>();
	// 下拉刷新
	private XListView mListView = null;
	// 自定义适配器
	private MyAdapter mAdapter = null;

	// 消息
	private TextView xiaoxi = null;
	// 未读消息
	private TextView weidu = null;

	// private Dialog jindu = null;

	// 当前页
	private int curPage = 1;

	private String number = "";
	
	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_mine_tongzhi;
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
		setTitle("通知");
		showBack();

		// jindu = new ProcessDialogUtil(TongZhiActivity.this);

		xiaoxi = (TextView) findViewById(R.id.mine_tongzhi_xiaoxi);
		weidu = (TextView) findViewById(R.id.mine_tongzhi_weidu);

		mListView = (XListView) findViewById(R.id.mine_tongzhi_listview);
		mListView.setPullLoadEnable(true);
		mAdapter = new MyAdapter();
		mListView.setAdapter(mAdapter);
		mListView.setXListViewListener(this);

		mListView.setOnItemClickListener(new OnItemClickListener() {

			@SuppressLint("ShowToast")
			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1,
					int position, long arg3) {

				// TODO Auto-generated method stub
				if (position != 0) {
					Notification notify = (Notification) allList
							.get(position - 1);
					Intent intent = new Intent(TongZhiActivity.this,
							TongZhiInfoActivity.class);
					intent.putExtra("title", notify.getTitle());
					intent.putExtra("time", notify.getSendTime());
					intent.putExtra("content", notify.getContent());
					intent.putExtra("pid", notify.gettId());
					startActivity(intent);
					finish();
					anim_right_in();

				} else {
					return;
				}
			}
		});

		loadHttp();

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
			backTo();
			break;
		default:
			break;
		}
	}

	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		// TODO Auto-generated method stub
		if (keyCode == KeyEvent.KEYCODE_BACK && event.getRepeatCount() == 0) {
			backTo();
		}
		return false;
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
				convertView = LayoutInflater.from(TongZhiActivity.this)
						.inflate(R.layout.main_mine_tongzhi_item, null);
				holder.iv = (ImageView) convertView
						.findViewById(R.id.tongzhi_item_image);
				holder.tv1 = (TextView) convertView
						.findViewById(R.id.tongzhi_item_title);
				holder.tv2 = (TextView) convertView
						.findViewById(R.id.tongzhi_item_time);

				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}
			final Notification notify = (Notification) allList.get(position);
			holder.tv1.setText(notify.getTitle());
			holder.tv2.setText(notify.getSendTime());
			if ("0".equals(notify.getStatus())) {
				holder.iv.setImageDrawable(getResources().getDrawable(
						R.drawable.xiaoxi1));
			} else if ("1".equals(notify.getStatus())) {
				holder.iv.setImageDrawable(getResources().getDrawable(
						R.drawable.xiaoxi2));
			} else if ("".equals(notify.getStatus())) {
				holder.iv.setImageDrawable(getResources().getDrawable(
						R.drawable.xiaoxi2));
			}

			return convertView;
		}

		final class ViewHolder {

			ImageView iv;
			TextView tv1;
			TextView tv2;
		}
	}

	// 返回键事件
	private void backTo() {

		number = weidu.getText().toString();
		Intent intent3 = new Intent(this, MainActivity.class);
		StaticVariable.put(StaticVariable.xiaoxi, number);
		StaticVariable.put(StaticVariable.sv_toMine, "2");
		startActivity(intent3);
		finish();
		anim_right_out();

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
		loadHttp();
	}

	@Override
	public void onLoadMore() {
		// TODO Auto-generated method stub
		curPage++;
		loadHttp();
	}

	private Handler mHandler = new Handler() {

		@Override
		public void handleMessage(Message msg) {
			// TODO Auto-generated method stub
			super.handleMessage(msg);
			// jindu.cancel();
			onStopLoad();
			switch (msg.what) {
			case 0:
				Toast.makeText(TongZhiActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1:

				//json = (JSONObject) msg.getData().get("json");
				List<Object> list = (List<Object>) msg.getData().get("list");
				if (curPage == 1) {
					allList.clear();
				}
				allList.addAll(list);
				mAdapter.notifyDataSetChanged();

				Notification notify = (Notification) allList.get(0);
				xiaoxi.setText(notify.getTotal());
				weidu.setText(notify.getUnRead());

				onStopLoad();
				getPage();

				break;
			case 2:
				Toast.makeText(TongZhiActivity.this,
						msg.getData().getString("msg"), 1000).show();
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

	private void loadHttp() {

		// jindu.show();

		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		// 请求的参数如下

		map.put("page", curPage + "");

		RequestThreadAbstract thread = RequestFactory.createRequestThread(29,
				map, TongZhiActivity.this, mHandler);
		RequestPool.execute(thread);

	}

	// 把所有的网络请求放到最下面
	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		
		json = (JSONObject)jsonObj;
		
		// TODO Auto-generated method stub
		Bundle b = new Bundle();
		b.putParcelableArrayList("list", (ArrayList<? extends Parcelable>) list);
		//b.putParcelable("json", (Parcelable) json);
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
