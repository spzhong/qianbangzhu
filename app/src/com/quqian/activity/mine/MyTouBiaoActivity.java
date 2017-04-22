package com.quqian.activity.mine;

import java.util.ArrayList;
import java.util.Currency;
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
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.index.SanBiaoTouZiActivity;
import com.quqian.activity.index.SanInfoActivity;
import com.quqian.activity.invert.LiJiTouBiaoActivity;
import com.quqian.activity.mine.MyLiCaiActivity.MyAdapter1;
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

public class MyTouBiaoActivity extends BaseActivity implements OnClickListener,
		IXListViewListener, HttpResponseInterface {

	// list<object>集合
	// private List<Object> allList = new ArrayList<Object>();
	private List<Object> allList1 = new ArrayList<Object>();
	private List<Object> allList2 = new ArrayList<Object>();
	private List<Object> allList3 = new ArrayList<Object>();
	private List<Object> allList4 = new ArrayList<Object>();
	// 下拉刷新
	private XListView mListView = null;
	// 自定义适配器
	private MyAdapter1 mAdapter1 = null;
	private MyAdapter2 mAdapter2 = null;
	private MyAdapter3 mAdapter3 = null;
	private MyAdapter4 mAdapter4 = null;
	// radioGroup
	private RadioGroup rg = null;

	// 回收中radioButton
	private RadioButton rb1 = null;
	// 投标中
	private RadioButton rb2 = null;
	// 已结清
	private RadioButton rb3 = null;
	// 已转出
	private RadioButton rb4 = null;

	// 记录当前刷新页
	private int curPage = 1;

	ProcessDialogUtil juhua = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_mine_mytoubiao;
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
		setTitle("我的投标");
		showBack();

		juhua = new ProcessDialogUtil(MyTouBiaoActivity.this);

		rg = (RadioGroup) findViewById(R.id.mine_mytoubiao_rg);
		rb1 = (RadioButton) findViewById(R.id.mine_mytoubiao_rb1);
		rb1.setChecked(true);
		rb2 = (RadioButton) findViewById(R.id.mine_mytoubiao_rb2);
		rb3 = (RadioButton) findViewById(R.id.mine_mytoubiao_rb3);
		rb4 = (RadioButton) findViewById(R.id.mine_mytoubiao_rb4);

		mListView = (XListView) findViewById(R.id.mine_mytoubiao_listview);
		mListView.setPullLoadEnable(false);
		mAdapter1 = new MyAdapter1();
		mAdapter2 = new MyAdapter2();
		mAdapter3 = new MyAdapter3();
		mAdapter4 = new MyAdapter4();
		mListView.setAdapter(mAdapter1);
		mListView.setXListViewListener(this);

		mListView.setOnItemClickListener(new OnItemClickListener() {

			@SuppressLint("ShowToast")
			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1,
					int position, long arg3) {

				// TODO Auto-generated method stub
				if (position != 0) {

					SanProject san = null;
					if (rb1.isChecked()) {
						san = (SanProject) allList1.get(position - 1);
					} else if (rb2.isChecked()) {
						san = (SanProject) allList2.get(position - 1);
					} else if (rb3.isChecked()) {
						san = (SanProject) allList3.get(position - 1);
					} else if (rb4.isChecked()) {
						san = (SanProject) allList4.get(position - 1);
					}

					Intent intent = new Intent(MyTouBiaoActivity.this,
							SanInfoActivity.class);
					Bundle bundle = new Bundle();
					bundle.putString("pId", san.getpId());
					// bundle.putSerializable("sanProject", san);
					intent.putExtras(bundle);
					Log.v("quqian", "-----pid----" + san.getpId()
							+ "----position" + position);
					startActivity(intent);
					anim_right_in();
				} else {
					return;
				}
			}
		});

		// 投标中接口
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
		rb4.setOnClickListener(this);

	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub

		switch (arg0.getId()) {
		case R.id.title_bar_back:
			MyTouBiaoActivity.this.finish();
			anim_right_out();
			break;
		case R.id.mine_mytoubiao_rb1:
			// 回收中
			curPage = 1;
			allList1.clear();
			mListView.setAdapter(mAdapter1);
			mAdapter1.notifyDataSetChanged();
			loadHttp("0");
			break;
		case R.id.mine_mytoubiao_rb2:
			// 投标中
			curPage = 1;
			allList2.clear();
			mListView.setAdapter(mAdapter2);
			mAdapter2.notifyDataSetChanged();
			loadHttp("1");
			break;
		case R.id.mine_mytoubiao_rb3:
			// 已结清
			curPage = 1;
			allList3.clear();
			mListView.setAdapter(mAdapter3);
			mAdapter3.notifyDataSetChanged();
			loadHttp("2");
			break;
		case R.id.mine_mytoubiao_rb4:
			// 已转出
			curPage = 1;
			allList4.clear();
			mListView.setAdapter(mAdapter4);
			mAdapter4.notifyDataSetChanged();
			loadHttp("3");
			break;

		default:
			break;
		}
	}

	/** 适配器 回收中 **/
	private class MyAdapter1 extends BaseAdapter {

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
				convertView = LayoutInflater.from(MyTouBiaoActivity.this)
						.inflate(R.layout.main_index_sanbiao_item, null);
				holder.tv1 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv1);
				holder.tv2 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv2);
				holder.tv3 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv3);

				holder.tv4 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv4);
				holder.tv4.setVisibility(View.GONE);
				holder.tv_btn = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_btn);
				holder.tv_btn.setVisibility(View.GONE);
				holder.pb = (ProgressBar) convertView
						.findViewById(R.id.san_listview_item_pb);
				holder.pb.setVisibility(View.GONE);
				holder.tv_jindu = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_jindu);
				holder.tv_jindu.setVisibility(View.GONE);

				holder.tv_i1 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_i11);
				holder.tv_i2 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_i21);
				holder.tv_i3 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_i31);

				holder.line = (View) convertView
						.findViewById(R.id.san_listview_item_v3);
				holder.layout = (LinearLayout) convertView
						.findViewById(R.id.san_listview_layout4);
				holder.tv_i4 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_i41);

				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}
			final SanProject san = (SanProject) allList1.get(position);

			Map<String, String> infoMap = san.my_san_huishouzhong_list();

			List<Map<String, String>> listMap = san.tuBiaoList();
			holder.tv1.setVisibility(View.VISIBLE);
			holder.tv2.setVisibility(View.VISIBLE);

			if (listMap.size() == 0) {
				holder.tv1.setVisibility(View.GONE);
				holder.tv2.setVisibility(View.GONE);
			} else if (listMap.size() == 1) {
				Map<String, String> map = listMap.get(0);
				holder.tv1.setText(map.get("sx"));
				holder.tv2.setVisibility(View.GONE);
			} else if (listMap.size() == 2) {
				holder.tv2.setText(listMap.get(0).get("sx"));
				holder.tv1.setText(listMap.get(1).get("sx"));
			}
			holder.tv3.setText(san.getBdbt());

			holder.tv_i1.setText(Html.fromHtml(infoMap.get("2")));
			holder.tv_i2.setText(Html.fromHtml(infoMap.get("1")));
			holder.tv_i3.setText(Html.fromHtml(infoMap.get("3")));

			holder.line.setVisibility(View.VISIBLE);
			holder.layout.setVisibility(View.VISIBLE);
			holder.tv_i4.setText(Html.fromHtml(infoMap.get("4")));

			return convertView;
		}

		final class ViewHolder {
			// 回收中
			TextView tv1;
			TextView tv2;
			TextView tv3;

			TextView tv4;
			TextView tv_btn;
			ProgressBar pb;
			TextView tv_jindu;

			TextView tv_i1;
			TextView tv_i2;
			TextView tv_i3;

			View line;
			LinearLayout layout;
			TextView tv_i4;

		}
	}

	/** 适配器 ---投标中 **/
	private class MyAdapter2 extends BaseAdapter {

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
				convertView = LayoutInflater.from(MyTouBiaoActivity.this)
						.inflate(R.layout.main_index_sanbiao_item, null);
				holder.tv1 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv1);
				holder.tv2 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv2);
				holder.tv3 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv3);
				holder.tv4 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv4);
				holder.tv_btn = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_btn);
				holder.pb = (ProgressBar) convertView
						.findViewById(R.id.san_listview_item_pb);
				holder.tv_jindu = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_jindu);
				holder.tv_i1 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_i11);
				holder.tv_i2 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_i21);
				holder.tv_i3 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_i31);

				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}
			final SanProject san = (SanProject) allList2.get(position);

			List<Map<String, String>> listMap = san.tuBiaoList();
			holder.tv1.setVisibility(View.VISIBLE);
			holder.tv2.setVisibility(View.VISIBLE);

			if (listMap.size() == 0) {
				holder.tv1.setVisibility(View.GONE);
				holder.tv2.setVisibility(View.GONE);
			} else if (listMap.size() == 1) {
				Map<String, String> map = listMap.get(0);
				holder.tv1.setText(map.get("sx"));
				holder.tv2.setVisibility(View.GONE);
			} else if (listMap.size() == 2) {
				holder.tv2.setText(listMap.get(0).get("sx"));
				holder.tv1.setText(listMap.get(1).get("sx"));
			}
			holder.tv3.setText(san.getBdbt());
			holder.tv4.setText(san.getJllx());
			if (san.isJudgment_bid_butonPress()) {
				holder.tv_btn.setTextColor(getResources().getColor(
						R.color.main_text_blue));
				holder.tv_btn
						.setBackgroundResource(R.drawable.button_kuang_blue);
			} else {
				holder.tv_btn.setTextColor(getResources().getColor(
						R.color.main_text_gray));
				holder.tv_btn
						.setBackgroundResource(R.drawable.button_kuang_gray);
			}
			holder.tv_btn.setText(san.getZt());

			String rongzijindu = "0";
			if (san.getRzjd() == null || "".equals(san.getRzjd())) {
				rongzijindu = "0";
			} else {
				rongzijindu = san.getRzjd();
			}
			holder.pb.setProgress(Integer.valueOf(rongzijindu));
			holder.tv_jindu.setText(san.getRzjd() + "%");
			holder.tv_i1.setText(Html.fromHtml(san.show_my_list_one()));
			holder.tv_i2.setText(Html.fromHtml(san.show_list_two()));
			holder.tv_i3.setText(Html.fromHtml(san.show_list_three()));

			holder.tv_btn.setText("继续投标");

			holder.tv_btn.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View arg0) {
					// TODO Auto-generated method stub
					SanProject san = (SanProject) allList2.get(position);

					Intent intent = new Intent(MyTouBiaoActivity.this,
							LiJiTouBiaoActivity.class);
					Bundle bundle = new Bundle();
					bundle.putString("pId", san.getpId());
					bundle.putString("shengyu", san.getSyje());// 剩余金额
					bundle.putString("huankuanqixian", san.getHkqx());// 还款期限
					bundle.putString("nianlilv", san.getNll());// 年利率
					bundle.putString("jiangli", san.getJlll());// 奖励利率
					bundle.putString("jiekuan", san.getJkfs());// 借款方式
					bundle.putString("huankuanfangshi", san.getHkfs());// 还款方式
					intent.putExtras(bundle);

					startActivity(intent);
					anim_right_in();
				}
			});

			return convertView;
		}

		final class ViewHolder {
			TextView tv1;
			TextView tv2;
			TextView tv3;
			TextView tv4;
			TextView tv_btn;
			ProgressBar pb;
			TextView tv_jindu;
			TextView tv_i1;
			TextView tv_i2;
			TextView tv_i3;
		}
	}

	/** 适配器 ---已结清 **/
	private class MyAdapter3 extends BaseAdapter {

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
				convertView = LayoutInflater.from(MyTouBiaoActivity.this)
						.inflate(R.layout.main_index_sanbiao_item, null);
				holder.tv1 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv1);
				holder.tv2 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv2);
				holder.tv3 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv3);

				holder.tv4 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv4);
				holder.tv4.setVisibility(View.GONE);
				holder.tv_btn = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_btn);
				holder.tv_btn.setVisibility(View.GONE);
				holder.pb = (ProgressBar) convertView
						.findViewById(R.id.san_listview_item_pb);
				holder.pb.setVisibility(View.GONE);
				holder.tv_jindu = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_jindu);
				holder.tv_jindu.setVisibility(View.GONE);

				holder.tv_i1 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_i11);
				holder.tv_i2 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_i21);
				holder.tv_i3 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_i31);

				holder.line = (View) convertView
						.findViewById(R.id.san_listview_item_v3);
				holder.layout = (LinearLayout) convertView
						.findViewById(R.id.san_listview_layout4);
				holder.tv_i4 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_i41);

				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}
			final SanProject san = (SanProject) allList3.get(position);

			Map<String, String> infoMap = san.my_san_yijieqing_list();

			List<Map<String, String>> listMap = san.tuBiaoList();
			holder.tv1.setVisibility(View.VISIBLE);
			holder.tv2.setVisibility(View.VISIBLE);

			if (listMap.size() == 0) {
				holder.tv1.setVisibility(View.GONE);
				holder.tv2.setVisibility(View.GONE);
			} else if (listMap.size() == 1) {
				Map<String, String> map = listMap.get(0);
				holder.tv1.setText(map.get("sx"));
				holder.tv2.setVisibility(View.GONE);
			} else if (listMap.size() == 2) {
				holder.tv2.setText(listMap.get(0).get("sx"));
				holder.tv1.setText(listMap.get(1).get("sx"));
			}
			holder.tv3.setText(san.getBdbt());

			holder.tv_i1.setText(Html.fromHtml(infoMap.get("1")));
			holder.tv_i2.setText(Html.fromHtml(infoMap.get("2")));
			holder.tv_i3.setText(Html.fromHtml(infoMap.get("3")));

			holder.line.setVisibility(View.VISIBLE);
			holder.layout.setVisibility(View.VISIBLE);
			holder.tv_i4.setText(Html.fromHtml(infoMap.get("4")));

			return convertView;
		}

		final class ViewHolder {
			// 已结清
			TextView tv1;
			TextView tv2;
			TextView tv3;

			TextView tv4;
			TextView tv_btn;
			ProgressBar pb;
			TextView tv_jindu;

			TextView tv_i1;
			TextView tv_i2;
			TextView tv_i3;

			View line;
			LinearLayout layout;
			TextView tv_i4;

		}
	}

	/** 适配器 ---已转出 **/
	private class MyAdapter4 extends BaseAdapter {

		@Override
		public int getCount() {
			return allList4 != null ? allList4.size() : 0;
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
				convertView = LayoutInflater.from(MyTouBiaoActivity.this)
						.inflate(R.layout.main_index_sanbiao_item, null);
				holder.tv1 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv1);
				holder.tv2 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv2);
				holder.tv3 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv3);

				holder.tv4 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv4);
				holder.tv4.setVisibility(View.GONE);
				holder.tv_btn = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_btn);
				holder.tv_btn.setVisibility(View.GONE);
				holder.pb = (ProgressBar) convertView
						.findViewById(R.id.san_listview_item_pb);
				holder.pb.setVisibility(View.GONE);
				holder.tv_jindu = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_jindu);
				holder.tv_jindu.setVisibility(View.GONE);

				holder.tv_i1 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_i11);
				holder.tv_i2 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_i21);
				holder.tv_i3 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_i31);

				holder.line = (View) convertView
						.findViewById(R.id.san_listview_item_v3);
				holder.layout = (LinearLayout) convertView
						.findViewById(R.id.san_listview_layout4);
				holder.tv_i4 = (TextView) convertView
						.findViewById(R.id.san_listview_item_tv_i41);

				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}
			final SanProject san = (SanProject) allList4.get(position);

			Map<String, String> infoMap = san.my_san_yizhuanchu_list();

			List<Map<String, String>> listMap = san.tuBiaoList();
			holder.tv1.setVisibility(View.VISIBLE);
			holder.tv2.setVisibility(View.VISIBLE);

			if (listMap.size() == 0) {
				holder.tv1.setVisibility(View.GONE);
				holder.tv2.setVisibility(View.GONE);
			} else if (listMap.size() == 1) {
				Map<String, String> map = listMap.get(0);
				holder.tv1.setText(map.get("sx"));
				holder.tv2.setVisibility(View.GONE);
			} else if (listMap.size() == 2) {
				holder.tv2.setText(listMap.get(0).get("sx"));
				holder.tv1.setText(listMap.get(1).get("sx"));
			}
			holder.tv3.setText(san.getBdbt());

			holder.tv_i1.setText(Html.fromHtml(infoMap.get("1")));
			holder.tv_i2.setText(Html.fromHtml(infoMap.get("2")));
			holder.tv_i3.setText(Html.fromHtml(infoMap.get("3")));

			holder.line.setVisibility(View.VISIBLE);
			holder.layout.setVisibility(View.VISIBLE);
			holder.tv_i4.setText(Html.fromHtml(infoMap.get("4")));

			return convertView;
		}

		final class ViewHolder {
			// 已转出
			TextView tv1;
			TextView tv2;
			TextView tv3;

			TextView tv4;
			TextView tv_btn;
			ProgressBar pb;
			TextView tv_jindu;

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

		if (rb1.isChecked()) {

			curPage = 1;
			loadHttp("0");
		} else if (rb2.isChecked()) {

			curPage = 1;
			loadHttp("1");
		} else if (rb3.isChecked()) {

			curPage = 1;
			loadHttp("2");
		} else if (rb4.isChecked()) {

			curPage = 1;
			loadHttp("3");
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
		} else if (rb4.isChecked()) {
			curPage++;
			loadHttp("3");
		}
	}

	private void loadHttp(String status) {

		juhua.show();

		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		// 请求的参数如下
		map.put("status", status);// 0是回收中，1是投标中，2是已结清，3是已转出
		map.put("page", curPage + "");// 当前页码

		RequestThreadAbstract thread = RequestFactory.createRequestThread(27,
				map, MyTouBiaoActivity.this, mHandler);
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
				Toast.makeText(MyTouBiaoActivity.this,
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

				} else if (msg.getData().get("status").equals("3")) {

					List<Object> list = (List<Object>) msg.getData()
							.get("list");
					if (curPage == 1) {
						allList4.clear();
					}
					allList4.addAll(list);

					mAdapter4.notifyDataSetChanged();

				}

				onStopLoad();
				getPage();

				break;
			case 2:
				Toast.makeText(MyTouBiaoActivity.this,
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
