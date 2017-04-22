package com.quqian.activity.index;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

import android.R.integer;
import android.annotation.SuppressLint;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
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
import android.widget.BaseAdapter;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.quqian.activity.LoginActivity;
import com.quqian.activity.invert.LiJiTouBiaoActivity;
import com.quqian.base.BaseActivity;
import com.quqian.been.SanProject;
import com.quqian.been.UserMode;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.listview.XListView;
import com.quqian.listview.XListView.IXListViewListener;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.Tool;
/**
 * 快赚宝控制器
 * @author Administrator
 *
 */
public class KuaizhuanBaoActivity extends BaseActivity implements
		OnClickListener, IXListViewListener, HttpResponseInterface {

	// list<object>集合
	private List<Object> allList = new ArrayList<Object>();
	// 下拉刷新
	private XListView mListView = null;
	// 自定义适配器
	private MyAdapter mAdapter = null;
	// 记录当前刷新页
	private int curPage = 1;

	ProcessDialogUtil juhua = null;

	BroadcastReceiver mBroadcastReceiver = null;

	@Override
	protected int layoutId() {
		return R.layout.main_index_kuaizhuanbao;
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
		setTitle("快赚宝");
		showBack();

		juhua = new ProcessDialogUtil(KuaizhuanBaoActivity.this);

		// initList();
		mListView = (XListView) findViewById(R.id.index_kuaizhuanbao_listview);
		mListView.setPullLoadEnable(false);
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
					UserMode user = Tool.getUser(KuaizhuanBaoActivity.this);
					if (user == null) {
						startActivity(new Intent(KuaizhuanBaoActivity.this,
								LoginActivity.class));
					} else {
						SanProject san = (SanProject) allList.get(position - 1);
						Intent intent = new Intent(KuaizhuanBaoActivity.this,
								SanInfoActivity.class);
						Bundle bundle = new Bundle();
						bundle.putString("pId", san.getpId());
						// bundle.putSerializable("sanProject", test);
						intent.putExtras(bundle);
						Log.v("qbz", "-----pid----" + san.getpId());
						startActivity(intent);

					}
					anim_right_in();
				} else {
					return;
				}
			}
		});

		loadHttp();

		// 接受广播
		mBroadcastReceiver = new BroadcastReceiver() {
			@Override
			public void onReceive(Context arg0, Intent arg1) {
				// TODO Auto-generated method stub
				// Intent intent = getIntent();
				onRefresh();
			}
		};
		IntentFilter intentFilter = new IntentFilter();
		intentFilter.addAction("sanbiao_reloadata");
		registerReceiver(mBroadcastReceiver, intentFilter);
	}

	@Override
	protected void onDestroy() {
		super.onDestroy();
		unregisterReceiver(mBroadcastReceiver);
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
			KuaizhuanBaoActivity.this.finish();
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
				convertView = LayoutInflater.from(KuaizhuanBaoActivity.this)
						.inflate(R.layout.main_index_kuaizhuanbao_item, null);
				holder.tv1 = (TextView) convertView
						.findViewById(R.id.bao_listview_item_tv1);
				holder.tv2 = (TextView) convertView
						.findViewById(R.id.bao_listview_item_tv2);
				holder.tv3 = (TextView) convertView
						.findViewById(R.id.bao_listview_item_tv3);
				holder.tv4 = (TextView) convertView
						.findViewById(R.id.bao_listview_item_tv4);
				holder.tv_btn = (TextView) convertView
						.findViewById(R.id.bao_listview_item_tv_btn);
				holder.pb = (ProgressBar) convertView
						.findViewById(R.id.bao_listview_item_pb);
				holder.tv_jindu = (TextView) convertView
						.findViewById(R.id.bao_listview_item_tv_jindu);
				holder.tv_i1 = (TextView) convertView
						.findViewById(R.id.bao_listview_item_tv_i11);
				holder.tv_i2 = (TextView) convertView
						.findViewById(R.id.bao_listview_item_tv_i21);
				holder.tv_i3 = (TextView) convertView
						.findViewById(R.id.bao_listview_item_tv_i31);

				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}
			final SanProject san = (SanProject) allList.get(position);

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
				holder.tv_btn.setEnabled(true);
			} else {
				holder.tv_btn.setTextColor(getResources().getColor(
						R.color.main_text_gray));
				holder.tv_btn
						.setBackgroundResource(R.drawable.button_kuang_gray);
				holder.tv_btn.setEnabled(false);
			}
			holder.tv_btn.setText(san.getZt());

			holder.pb.setProgress(Integer.valueOf(san.getRzjd()));
			holder.tv_jindu.setText(san.getRzjd() + "%");
			holder.tv_i1.setText(Html.fromHtml(san.show_list_one()));
			holder.tv_i2.setText(Html.fromHtml(san.show_list_two()));
			holder.tv_i3.setText(Html.fromHtml(san.show_list_three()));

			holder.tv_btn.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View arg0) {
					// TODO Auto-generated method stub
					UserMode user = Tool.getUser(KuaizhuanBaoActivity.this);
					if (user == null) {
						startActivity(new Intent(KuaizhuanBaoActivity.this,
								LoginActivity.class));
					} else {

						SanProject san = (SanProject) allList.get(position);

						Intent intent = new Intent(KuaizhuanBaoActivity.this,
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
					}
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

			juhua.cancel();

			switch (msg.what) {
			case 0:
				Toast.makeText(KuaizhuanBaoActivity.this,
						msg.getData().getString("errMsg"), 1000).show();
				onStopLoad();
				break;
			case 1:

				//json = (JSONObject) msg.getData().get("json");
				List<Object> list = (List<Object>) msg.getData().get("list");
				if (curPage == 1) {
					allList.clear();
				}
				allList.addAll(list);
				mAdapter.notifyDataSetChanged();
				 
				onStopLoad();
				getPage();

				break;
			case 2:
				
				
				Toast.makeText(KuaizhuanBaoActivity.this,
						msg.getData().getString("msg"), 1000).show();
				// onStopLoad();
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

		juhua.show();

		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		// 请求的参数如下
		map.put("page", curPage + "");
		RequestThreadAbstract thread = RequestFactory.createRequestThread(48,
				map, KuaizhuanBaoActivity.this, mHandler);
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
