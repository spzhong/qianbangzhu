package com.quqian.activity.mine;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

import android.annotation.SuppressLint;
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
import com.quqian.activity.index.IndexActivity;
import com.quqian.activity.index.LiCaiInfoActivity;
import com.quqian.activity.index.LiCaiTiYanActivity;
import com.quqian.activity.index.LiJiShenQingActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.SanProject;
import com.quqian.been.TiYanProject;
import com.quqian.http.API;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.listview.XListView;
import com.quqian.listview.XListView.IXListViewListener;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;

public class MyLiCaiActivity extends BaseActivity implements OnClickListener,
		IXListViewListener, HttpResponseInterface {

	// list<object>集合
	private List<Object> allList1 = new ArrayList<Object>();
	private List<Object> allList2 = new ArrayList<Object>();
	private List<Object> allList3 = new ArrayList<Object>();
	// 下拉刷新
	private XListView mListView = null;
	// 自定义适配器
	private MyAdapter1 mAdapter1 = null;
	private MyAdapter2 mAdapter2 = null;
	private MyAdapter3 mAdapter3 = null;
	// radioGroup
	private RadioGroup rg = null;

	// 申请中radioButton
	private RadioButton rb1 = null;
	// 参与中
	private RadioButton rb2 = null;
	// 已截止
	private RadioButton rb3 = null;

	// 记录当前刷新页
	private int curPage = 1;

	ProcessDialogUtil juhua = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_mine_mylicai;
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
		setTitle("我的理财体验");
		showBack();

		juhua = new ProcessDialogUtil(MyLiCaiActivity.this);

		rg = (RadioGroup) findViewById(R.id.mine_mylicai_rg);
		rb1 = (RadioButton) findViewById(R.id.mine_mylicai_rb1);
		rb1.setChecked(true);
		rb2 = (RadioButton) findViewById(R.id.mine_mylicai_rb2);
		rb3 = (RadioButton) findViewById(R.id.mine_mylicai_rb3);

		mListView = (XListView) findViewById(R.id.mine_mylicai_listview1);
		mListView.setPullLoadEnable(false);
		mAdapter1 = new MyAdapter1();
		mAdapter2 = new MyAdapter2();
		mAdapter3 = new MyAdapter3();

		mListView.setAdapter(mAdapter1);
		mListView.setXListViewListener(this);

		mListView.setOnItemClickListener(new OnItemClickListener() {

			@SuppressLint("ShowToast")
			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1,
					int position, long arg3) {

				// TODO Auto-generated method stub
				if (position != 0) {
					
					TiYanProject licai = null;
					if(rb1.isChecked()){
						 licai = (TiYanProject) allList1
								.get(position - 1);
					}else if(rb2.isChecked()){
						licai = (TiYanProject) allList2
								.get(position - 1);
					}else if(rb3.isChecked()){
						licai = (TiYanProject) allList3
								.get(position - 1);
					} 
					
					
					
					Intent intent = new Intent(MyLiCaiActivity.this,
							LiCaiInfoActivity.class);
					intent.putExtra("pId", licai.getpId());
					Log.v("quqian", "-----pid----" + licai.getpId()
							+ "-----position" + position);
					startActivity(intent);
					anim_right_in();
				} else {
					return;
				}
			}
		});

		// diao接口
		loadHttp("0");

	}

	@Override
	protected void initViewListener() {
		// TODO Auto-generated method stub
		super.initViewListener();
		titleBarBack.setOnClickListener(this);
		rb1.setOnClickListener(this);
		rb2.setOnClickListener(this);
		rb3.setOnClickListener(this);
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub

		switch (arg0.getId()) {
		case R.id.title_bar_back:
			MyLiCaiActivity.this.finish();
			anim_right_out();
			break;
		case R.id.mine_mylicai_rb1:
			// 申请中
			curPage = 1;
			mListView.setAdapter(mAdapter1);
			// mAdapter1.notifyDataSetChanged();
			loadHttp("0");
			break;
		case R.id.mine_mylicai_rb2:
			// 参与中
			curPage = 1;
			mListView.setAdapter(mAdapter2);
			// mAdapter2.notifyDataSetChanged();
			loadHttp("1");
			break;
		case R.id.mine_mylicai_rb3:
			// 已截止
			curPage = 1;
			mListView.setAdapter(mAdapter3);
			// mAdapter3.notifyDataSetChanged();
			loadHttp("2");
			break;
		default:
			break;
		}
	}

	/** 适配器 ---申请中 **/
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
				convertView = LayoutInflater.from(MyLiCaiActivity.this)
						.inflate(R.layout.main_index_licai_item, null);

				holder.tv3 = (TextView) convertView
						.findViewById(R.id.licai_listview_item_tv3);

				holder.tv_btn = (TextView) convertView
						.findViewById(R.id.licai_listview_item_tv_btn);

				holder.tv_i1 = (TextView) convertView
						.findViewById(R.id.licai_listview_item_tv_i11);
				holder.tv_i2 = (TextView) convertView
						.findViewById(R.id.licai_listview_item_tv_i21);
				holder.tv_i3 = (TextView) convertView
						.findViewById(R.id.licai_listview_item_tv_i31);

				RelativeLayout realation = (RelativeLayout)convertView
						.findViewById(R.id.licai_listview_item_pb_aaa);
					realation.setVisibility(View.VISIBLE);
					
					holder.pb = (ProgressBar) convertView
							.findViewById(R.id.licai_listview_item_pb);
					holder.tv_jindu = (TextView) convertView
							.findViewById(R.id.licai_listview_item_tv_jindu);
				
					
				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}
			final TiYanProject licai = (TiYanProject) allList1.get(position);

			holder.tv3.setText(licai.getBt());

			if (licai.isJudgment_bid_butonPress()) {
				holder.tv_btn.setTextColor(getResources().getColor(
						R.color.main_text_blue));
				holder.tv_btn
						.setBackgroundResource(R.drawable.button_kuang_blue);
			} else {
				holder.tv_btn.setTextColor(getResources().getColor(
						R.color.main_text_gray));
				holder.tv_btn
						.setBackgroundResource(R.drawable.button_kuang_gray);
				holder.tv_btn.setEnabled(false);
			}
			
			holder.pb.setProgress(Integer.valueOf(licai.getRzjd()));
			holder.tv_jindu.setText(licai.getRzjd() + "%");
			 
			
			holder.tv_btn.setTextColor(getResources().getColor(
					R.color.main_text_blue));
			holder.tv_btn.setEnabled(true);
			holder.tv_btn.setText(licai.getZt());
			holder.tv_i1.setText(Html.fromHtml(licai.show_my_list_one()));
			holder.tv_i2.setText(Html.fromHtml(licai.show_list_two()));
			holder.tv_i3.setText(Html.fromHtml(licai.show_list_three()));

			holder.tv_btn.setText("继续申请");
			holder.tv_btn.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View arg0) {
					// TODO Auto-generated method stub
					Intent intent = new Intent(MyLiCaiActivity.this,
							LiJiShenQingActivity.class);
					Bundle bundle = new Bundle();
					bundle.putString("pId", licai.getpId());
					intent.putExtras(bundle);
					startActivity(intent);
					anim_right_in();
				}
			});

			return convertView;
		}

		final class ViewHolder {

			TextView tv3;
			TextView tv_btn;
			TextView tv_i1;
			TextView tv_i2;
			TextView tv_i3;
			ProgressBar pb;
			TextView tv_jindu;

		}
	}

	/** 适配器 ---参与中 **/
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
				convertView = LayoutInflater.from(MyLiCaiActivity.this)
						.inflate(R.layout.main_index_licai_item, null);

				holder.tv3 = (TextView) convertView
						.findViewById(R.id.licai_listview_item_tv3);

				holder.tv_btn = (TextView) convertView
						.findViewById(R.id.licai_listview_item_tv_btn);
				holder.tv_btn.setVisibility(View.GONE);

				holder.tv_i1 = (TextView) convertView
						.findViewById(R.id.licai_listview_item_tv_i11);
				holder.tv_i2 = (TextView) convertView
						.findViewById(R.id.licai_listview_item_tv_i21);
				holder.tv_i3 = (TextView) convertView
						.findViewById(R.id.licai_listview_item_tv_i31);

				holder.line = (View) convertView
						.findViewById(R.id.licai_listview_item_v3);
				holder.layout = (LinearLayout) convertView
						.findViewById(R.id.licai_listview_layout);
				holder.tv_i4 = (TextView) convertView
						.findViewById(R.id.licai_listview_item_tv_i41);

				RelativeLayout realation = (RelativeLayout)convertView
					.findViewById(R.id.licai_listview_item_pb_aaa);
				realation.setVisibility(View.GONE);
				
				
				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}
			final TiYanProject licai = (TiYanProject) allList2.get(position);

			Map<String, String> mapInfo = licai.my_tiyan_canyuzhong_list();

			holder.tv3.setText(licai.getBt());

			holder.tv_i1.setText(Html.fromHtml(mapInfo.get("1")));
			holder.tv_i2.setText(Html.fromHtml(mapInfo.get("2")));
			holder.tv_i3.setText(Html.fromHtml(mapInfo.get("3")));

			holder.line.setVisibility(View.VISIBLE);
			holder.layout.setVisibility(View.VISIBLE);
			holder.tv_i4.setText(Html.fromHtml(mapInfo.get("4")));

			return convertView;
		}

		final class ViewHolder {

			TextView tv3;

			TextView tv_btn;

			TextView tv_i1;
			TextView tv_i2;
			TextView tv_i3;

			View line;
			LinearLayout layout;
			TextView tv_i4;

		}
	}

	/** 适配器 ---已截止 **/
	class MyAdapter3 extends BaseAdapter {

		@Override
		public int getCount() {
			return allList3 != null ? allList3.size() : 0;
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
				convertView = LayoutInflater.from(MyLiCaiActivity.this)
						.inflate(R.layout.main_index_licai_item, null);

				holder.tv3 = (TextView) convertView
						.findViewById(R.id.licai_listview_item_tv3);

				holder.tv_btn = (TextView) convertView
						.findViewById(R.id.licai_listview_item_tv_btn);
				holder.tv_btn.setVisibility(View.GONE);

				holder.tv_i1 = (TextView) convertView
						.findViewById(R.id.licai_listview_item_tv_i11);
				holder.tv_i2 = (TextView) convertView
						.findViewById(R.id.licai_listview_item_tv_i21);
				holder.tv_i3 = (TextView) convertView
						.findViewById(R.id.licai_listview_item_tv_i31);

				holder.line = (View) convertView
						.findViewById(R.id.licai_listview_item_v3);
				holder.layout = (LinearLayout) convertView
						.findViewById(R.id.licai_listview_layout);
				holder.tv_i4 = (TextView) convertView
						.findViewById(R.id.licai_listview_item_tv_i41);

				RelativeLayout realation = (RelativeLayout)convertView
						.findViewById(R.id.licai_listview_item_pb_aaa);
					realation.setVisibility(View.GONE);
					
					
				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}
			final TiYanProject licai = (TiYanProject) allList3.get(position);

			Map<String, String> mapInfo = licai.my_tiyan_yijiezhi_list();

			holder.tv3.setText(licai.getBt());

			holder.tv_i1.setText(Html.fromHtml(mapInfo.get("1")));
			holder.tv_i2.setText(Html.fromHtml(mapInfo.get("2")));
			holder.tv_i3.setText(Html.fromHtml(mapInfo.get("3")));

			holder.line.setVisibility(View.VISIBLE);
			holder.layout.setVisibility(View.VISIBLE);
			holder.tv_i4.setText(Html.fromHtml(mapInfo.get("4")));

			return convertView;
		}

		final class ViewHolder {

			TextView tv3;

			TextView tv_btn;

			TextView tv_i1;
			TextView tv_i2;
			TextView tv_i3;

			View line;
			LinearLayout layout;
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
		} else if (rb3.isChecked()) {
			loadHttp("2");
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
		} else if (rb3.isChecked()) {
			curPage++;
			loadHttp("2");
		}
	}

	private void loadHttp(String status) {

		juhua.show();

		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		// 请求的参数如下
		map.put("status", status);// 0申请中，1是参与中，2是已截止
		map.put("page", curPage + "");// 当前页码

		RequestThreadAbstract thread = RequestFactory.createRequestThread(28,
				map, MyLiCaiActivity.this, mHandler);
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
				Toast.makeText(MyLiCaiActivity.this,
						msg.getData().getString("errMsg"), 1000).show();
				onStopLoad();
				break;
			case 1:

				//json = (JSONObject) msg.getData().get("json");
				if (msg.getData().get("status").equals("0")) {

					List<Object> list = (List<Object>) msg.getData()
							.get("list");
					if (curPage == 1) {
						allList1.clear();
					}
					allList1.addAll(list);
					mAdapter1.notifyDataSetChanged();

				} else if (msg.getData().get("status").equals("1")) {

					List<Object> list = (List<Object>) msg.getData()
							.get("list");
					if (curPage == 1) {
						allList2.clear();
					}
					allList2.addAll(list);
					mAdapter2.notifyDataSetChanged();

				} else if (msg.getData().get("status").equals("2")) {

					List<Object> list = (List<Object>) msg.getData()
							.get("list");
					if (curPage == 1) {
						allList3.clear();
					}
					allList3.addAll(list);

					mAdapter3.notifyDataSetChanged();

				}

				onStopLoad();
				getPage();

				break;
			case 2:
				Toast.makeText(MyLiCaiActivity.this,
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

		json = (JSONObject)jsonObj;
		
		Bundle b = new Bundle();
		b.putParcelableArrayList("list", (ArrayList<? extends Parcelable>) list);
		//b.putParcelable("json", (Parcelable) json);
		b.putString("status", map.get("status"));
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
