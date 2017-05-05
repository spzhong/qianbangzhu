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
import com.quqian.activity.mine.TongZhiActivity;
import com.quqian.activity.mine.TongZhiInfoActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.Notification;
import com.quqian.been.SanProject;
import com.quqian.been.TiYanProject;
import com.quqian.been.UserMode;
import com.quqian.http.API;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.listview.XListView;
import com.quqian.listview.XListView.IXListViewListener;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.Tool;

public class XiaoXiTongZhi extends BaseActivity implements OnClickListener,
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

	// 站内信
	private RadioButton rb1 = null;
	// 平台公告
	private RadioButton rb2 = null;

	// imageView
	private ImageView fanhui = null;
	private ImageView more = null;

	// 单选按钮下面的选中条
	private TextView tvrb1 = null;
	private TextView tvrb2 = null;

	// 记录当前刷新页
	private int curPage = 1;

	ProcessDialogUtil juhua = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.mine_new_xiaoxitongzhi;
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

		juhua = new ProcessDialogUtil(XiaoXiTongZhi.this);

		rg = (RadioGroup) findViewById(R.id.xxtz_rg);
		rb1 = (RadioButton) findViewById(R.id.xxtz_rb1);
		rb2 = (RadioButton) findViewById(R.id.xxtz_rb2);

		// 返回，菜单按钮
		fanhui = (ImageView) findViewById(R.id.xx_bar_back);
		more = (ImageView) findViewById(R.id.xx_bar_menu);

		// 单选按钮下面的选中条
		tvrb1 = (TextView) findViewById(R.id.xxtz_tvrb1);
		tvrb2 = (TextView) findViewById(R.id.xxtz_tvrb2);

		mListView = (XListView) findViewById(R.id.xxtz_listview);
		mListView.setPullLoadEnable(false);
		mAdapter1 = new MyAdapter1();
		mAdapter2 = new MyAdapter2();

		mListView.setXListViewListener(this);
		mListView.setAdapter(mAdapter1);

		// diao接口
		loadHttp0();
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
		fanhui.setOnClickListener(this);
		more.setOnClickListener(this);
		rb1.setOnClickListener(this);
		rb2.setOnClickListener(this);
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub

		switch (arg0.getId()) {
		case R.id.xx_bar_back:
			XiaoXiTongZhi.this.finish();
			anim_right_out();
			break;
		case R.id.xx_bar_menu:
			// 弹出全部删除，全部已读

			break;
		case R.id.xxtz_rb1:
			// 站内信
			tvrb1.setBackgroundColor(getResources().getColor(
					R.color.main_radio_blue));
			tvrb2.setBackgroundColor(getResources().getColor(R.color.white));

			// 请求数据
			curPage = 1;
			mListView.setAdapter(mAdapter1);
			// mAdapter1.notifyDataSetChanged();
			loadHttp0();
			break;
		case R.id.xxtz_rb2:
			// 平台公告
			tvrb1.setBackgroundColor(getResources().getColor(R.color.white));
			tvrb2.setBackgroundColor(getResources().getColor(
					R.color.main_radio_blue));

			// 请求数据
			curPage = 1;
			mListView.setAdapter(mAdapter2);
			// mAdapter2.notifyDataSetChanged();
			loadHttp1();
			break;
		default:
			break;
		}
	}

	/** 适配器 ---站内信 **/
	class MyAdapter1 extends BaseAdapter {

		private int currentItem = -1;

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
				convertView = LayoutInflater.from(XiaoXiTongZhi.this).inflate(
						R.layout.mine_new_xiaoxitongzhi_item, null);

				holder.tubiao = (TextView) convertView
						.findViewById(R.id.xx_item_du);
				holder.biaoti = (TextView) convertView
						.findViewById(R.id.xx_item_biaoti);
				holder.anniu = (LinearLayout) convertView
						.findViewById(R.id.xx_item_btn);
				holder.layout = (LinearLayout) convertView
						.findViewById(R.id.xx_item_layout);
				holder.neirong = (TextView) convertView
						.findViewById(R.id.xx_item_neirong);

				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}

			final Notification notify = (Notification) allList1.get(position);
			holder.biaoti.setText(notify.getTitle());
			holder.neirong.setText(notify.getContent());
			if ("0".equals(notify.getStatus())) {
				holder.tubiao.setVisibility(View.VISIBLE);
			} else if ("1".equals(notify.getStatus())) {
				holder.tubiao.setVisibility(View.GONE);
			} else if ("".equals(notify.getStatus())) {
				holder.tubiao.setVisibility(View.GONE);
			}

			holder.anniu.setTag(position);
			if (currentItem == position) {
				holder.layout.setVisibility(View.VISIBLE);
			} else {
				holder.layout.setVisibility(View.GONE);
			}

			holder.anniu.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View view) {
					// TODO Auto-generated method stub
					int tag = (Integer) view.getTag();
					if (tag == currentItem) { // 再次点击
						currentItem = -1; // 给 currentItem 一个无效值
					} else {
						currentItem = tag;
					}
					// 通知adapter数据改变需要重新加载
					notifyDataSetChanged(); // 必须有的一步

					// 判读是否未读，
					// holder.tubiao.setVisibility(View.GONE);
					// if ("0".equals(notify.getStatus())) {
					// loadHttp2(notify.gettId());
					// }
				}
			});

			return convertView;
		}

		final class ViewHolder {

			TextView tubiao;
			TextView biaoti;
			LinearLayout anniu;
			LinearLayout layout;
			TextView neirong;
		}
	}

	/** 适配器 ---平台公告 **/
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
				convertView = LayoutInflater.from(XiaoXiTongZhi.this).inflate(
						R.layout.mine_new_xiaoxitongzhi1_item, null);

				holder.tv1 = (TextView) convertView
						.findViewById(R.id.xx_item1_biaoti1);

				holder.btn = (RelativeLayout) convertView
						.findViewById(R.id.xx_item_btn1);

				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}

			final Notification notify = (Notification) allList2.get(position);
				holder.tv1.setText(notify.getGgtitle());
			holder.btn.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View arg0) {
					// TODO Auto-generated method stub
					// 跳转到详情信息页面
					Intent intent = new Intent(XiaoXiTongZhi.this,
							TongZhiInfoActivity.class);
					intent.putExtra("title", notify.getGgcontent());
					intent.putExtra("time", notify.getGgcredittiem());
					intent.putExtra("content", notify.getGgcontent());
					startActivity(intent);
					// finish();
					anim_right_in();
				}
			});

			return convertView;
		}

		final class ViewHolder {

			TextView tv1;
			RelativeLayout btn;
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
			loadHttp0();
		} else if (rb2.isChecked()) {
			loadHttp1();
		}
	}

	@Override
	public void onLoadMore() {
		// TODO Auto-generated method stub
		if (rb1.isChecked()) {
			curPage++;
			loadHttp0();
		} else if (rb2.isChecked()) {
			curPage++;
			loadHttp1();
		}

	}

	private void loadHttp0() {

		juhua.show();

		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		// 请求的参数如下

		map.put("page", curPage + "");

		RequestThreadAbstract thread = RequestFactory.createRequestThread(29,
				map, XiaoXiTongZhi.this, mHandler);
		RequestPool.execute(thread);

	}

	private void loadHttp1() {

		juhua.show();

		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		// 请求的参数如下

		map.put("page", curPage + "");

		RequestThreadAbstract thread = RequestFactory.createRequestThread(371,
				map, XiaoXiTongZhi.this, mHandler);
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
				Toast.makeText(XiaoXiTongZhi.this,
						msg.getData().getString("errMsg"), 1000).show();
				onStopLoad();
				break;
			case 1:

				// json = (JSONObject) msg.getData().get("json");
				List<Object> list = (List<Object>) msg.getData().get("list");
				if (curPage == 1) {
					allList1.clear();
				}
				allList1.addAll(list);
				mAdapter1.notifyDataSetChanged();

				//Notification notify = (Notification) allList1.get(0);
				onStopLoad();
				getPage();

				break;
			case 3:

				// json = (JSONObject) msg.getData().get("json");
				List<Object> list1 = (List<Object>) msg.getData().get("list");
				if (curPage == 1) {
					allList2.clear();
				}
				allList2.addAll(list1);
				mAdapter2.notifyDataSetChanged();

				//Notification notify1 = (Notification) allList2.get(0);
				onStopLoad();
				getPage();

				break;
			case 2:
				Toast.makeText(XiaoXiTongZhi.this,
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
		Bundle b = new Bundle();
		b.putParcelableArrayList("list", (ArrayList<? extends Parcelable>) list);
		// b.putParcelable("json", (Parcelable) json);
		if (rb1.isChecked()) {
			Message msg1 = new Message();
			msg1.setData(b);
			msg1.what = 1;
			mHandler.sendMessage(msg1);
		} else if (rb2.isChecked()) {
			Message msg3 = new Message();
			msg3.setData(b);
			msg3.what = 3;
			mHandler.sendMessage(msg3);
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

	// 当点击每一条未读消息的时候，调接口通知该消息已读
	private void loadHttp2(String pid) {

		juhua.show();

		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "2");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		// 请求的参数如下

		map.put("id", pid);

		RequestThreadAbstract thread = RequestFactory.createRequestThread(37,
				map, XiaoXiTongZhi.this, mHandler);
		RequestPool.execute(thread);

	}

}
