package com.quqian.activity.mine.xin;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.DialogInterface;
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
import com.quqian.http.API;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.listview.XListView;
import com.quqian.listview.XListView.IXListViewListener;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.Tool;

public class JiaoYIJiLu extends BaseActivity implements OnClickListener,
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

	// 存管账户交易记录
	private RadioButton rb1 = null;
	// 普通账户交易记录
	private RadioButton rb2 = null;

	// 单选按钮下面的选中条
	private TextView tvrb1 = null;
	private TextView tvrb2 = null;

	// danxuankuang
	private Dialog dialog1 = null;
	private Dialog dialog2 = null;

	// 交易类型
	private TextView leixing = null;
	// 交易时间
	private TextView shijian = null;

	private String[] strItems = new String[] { "充值", "投标成功", "招标成功", "成交服务费",
			"回收本息", "偿还本息", "提前还款违约金", "提前回收违约金" };
	private String[] strItems2 = new String[] { "今天", "昨天", "近一周", "近一个月",
			"近六个月" };

	// 记录当前刷新页
	private int curPage = 1;

	ProcessDialogUtil juhua = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.mine_new_jiaoyijilu;
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

		juhua = new ProcessDialogUtil(JiaoYIJiLu.this);

		rg = (RadioGroup) findViewById(R.id.jiao_rg);
		rb1 = (RadioButton) findViewById(R.id.jiao_rb1);
		rb2 = (RadioButton) findViewById(R.id.jiao_rb2);

		// 单选按钮下面的选中条
		tvrb1 = (TextView) findViewById(R.id.jiao_tvrb1);
		tvrb2 = (TextView) findViewById(R.id.jiao_tvrb2);

		leixing = (TextView) findViewById(R.id.jiao_jiaoyileixin);
		shijian = (TextView) findViewById(R.id.jiao_jiaoyishijian);

		mListView = (XListView) findViewById(R.id.jiao_listview);
		mListView.setPullLoadEnable(false);
		mAdapter1 = new MyAdapter1();
		mAdapter2 = new MyAdapter2();

		mListView.setAdapter(mAdapter1);

		// diao接口
		loadHttp("1");
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

		leixing.setOnClickListener(this);
		shijian.setOnClickListener(this);

	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub

		switch (arg0.getId()) {
		case R.id.title_bar_back:
			JiaoYIJiLu.this.finish();
			anim_right_out();
			break;
		case R.id.jiao_rb1:
			// 存管提现记录
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
		case R.id.jiao_rb2:
			// 普通提现记录
			// 修改状态条
			tvrb1.setBackgroundColor(getResources().getColor(R.color.white));
			tvrb2.setBackgroundColor(getResources().getColor(
					R.color.main_radio_blue));

			// 请求数据
			curPage = 1;
			mListView.setAdapter(mAdapter2);
			// mAdapter2.notifyDataSetChanged();
			loadHttp("1");
			break;
		case R.id.jiao_jiaoyileixin:
			// 交易类型选择
			dialog1 = new AlertDialog.Builder(JiaoYIJiLu.this)
					.setSingleChoiceItems(strItems, 0,
							new DialogInterface.OnClickListener() {

								@Override
								public void onClick(DialogInterface arg0,
										int arg1) {
									// TODO Auto-generated method stub
									dialog1.cancel();
									// 调接口，查询相应的数据
								}
							}).create();
			dialog1.show();
			break;
		case R.id.jiao_jiaoyishijian:
			// 交易时间选择
			dialog2 = new AlertDialog.Builder(JiaoYIJiLu.this)
					.setSingleChoiceItems(strItems2, 0,
							new DialogInterface.OnClickListener() {

								@Override
								public void onClick(DialogInterface arg0,
										int arg1) {
									// TODO Auto-generated method stub
									dialog2.cancel();
									// 调接口，查询相应的数据
								}
							}).create();
			dialog2.show();
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
				convertView = LayoutInflater.from(JiaoYIJiLu.this).inflate(
						R.layout.mine_new_jiaoyijilu_item, null);

				holder.tv1 = (TextView) convertView.findViewById(R.id.jiao_tv1);

				holder.tv2 = (TextView) convertView.findViewById(R.id.jiao_tv2);

				holder.tv3 = (TextView) convertView.findViewById(R.id.jiao_tv3);

				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}

			holder.tv3.setText("2017-01-10 19:30:02");
			holder.tv2.setText("10000000");
			holder.tv1.setText("充值成功");

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
				convertView = LayoutInflater.from(JiaoYIJiLu.this).inflate(
						R.layout.mine_new_jiaoyijilu_item, null);

				holder.tv1 = (TextView) convertView.findViewById(R.id.jiao_tv1);

				holder.tv2 = (TextView) convertView.findViewById(R.id.jiao_tv2);

				holder.tv3 = (TextView) convertView.findViewById(R.id.jiao_tv3);

				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}

			holder.tv3.setText("2017-01-10 19:30:02");
			holder.tv2.setText("10000000");
			holder.tv1.setText("充值成功");

			return convertView;
		}

		final class ViewHolder {

			TextView tv1;
			TextView tv2;
			TextView tv3;

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
		map.put("status", status);// 0精选理财，1是存管理财，
		map.put("page", curPage + "");// 当前页码

		RequestThreadAbstract thread = RequestFactory.createRequestThread(11,
				map, JiaoYIJiLu.this, mHandler);
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
				Toast.makeText(JiaoYIJiLu.this,
						msg.getData().getString("errMsg"), 1000).show();
				onStopLoad();
				break;
			case 1:

				// json = (JSONObject) msg.getData().get("json");
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

				}

				onStopLoad();
				getPage();

				break;
			case 2:
				Toast.makeText(JiaoYIJiLu.this, msg.getData().getString("msg"),
						1000).show();
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
