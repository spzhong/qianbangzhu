package com.quqian.activity.mine.xin;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.quqian.http.API;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.listview.XListView;
import com.quqian.listview.XListView.IXListViewListener;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.Tool;

public class WoDeTouBiao extends BaseActivity implements OnClickListener,
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

	// 未使用
	private RadioButton rb1 = null;
	// 已使用
	private RadioButton rb2 = null;
	// 已过期
	private RadioButton rb3 = null;

	// 单选按钮下面的选中条
	private TextView tvrb1 = null;
	private TextView tvrb2 = null;
	private TextView tvrb3 = null;

	// 记录当前刷新页
	private int curPage = 1;

	ProcessDialogUtil juhua = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.mine_new_wodetoubiao;
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

		juhua = new ProcessDialogUtil(WoDeTouBiao.this);

		rg = (RadioGroup) findViewById(R.id.wdtb_rg);
		rb1 = (RadioButton) findViewById(R.id.wdtb_rb1);
		rb2 = (RadioButton) findViewById(R.id.wdtb_rb2);
		rb3 = (RadioButton) findViewById(R.id.wdtb_rb3);

		// 单选按钮下面的选中条
		tvrb1 = (TextView) findViewById(R.id.wdtb_tvrb1);
		tvrb2 = (TextView) findViewById(R.id.wdtb_tvrb2);
		tvrb3 = (TextView) findViewById(R.id.wdtb_tvrb3);

		mListView = (XListView) findViewById(R.id.wdtb_listview);
		mListView.setPullLoadEnable(false);
		mAdapter1 = new MyAdapter1();
		mAdapter2 = new MyAdapter2();
		mAdapter3 = new MyAdapter3();

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
		rb3.setOnClickListener(this);
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub

		switch (arg0.getId()) {
		case R.id.title_bar_back:
			WoDeTouBiao.this.finish();
			anim_right_out();
			break;
		case R.id.wdtb_rb1:
			// 未使用
			tvrb1.setBackgroundColor(getResources().getColor(
					R.color.main_radio_blue));
			tvrb2.setBackgroundColor(getResources().getColor(R.color.white));
			tvrb3.setBackgroundColor(getResources().getColor(R.color.white));

			// 请求数据
			curPage = 1;
			mListView.setAdapter(mAdapter1);
			// mAdapter1.notifyDataSetChanged();
			loadHttp("0");
			break;
		case R.id.wdtb_rb2:
			// 已使用
			tvrb1.setBackgroundColor(getResources().getColor(R.color.white));
			tvrb2.setBackgroundColor(getResources().getColor(
					R.color.main_radio_blue));
			tvrb2.setBackgroundColor(getResources().getColor(R.color.white));

			// 请求数据
			curPage = 1;
			mListView.setAdapter(mAdapter2);
			// mAdapter2.notifyDataSetChanged();
			loadHttp("1");
			break;
		case R.id.wdtb_rb3:
			// 已过期
			tvrb1.setBackgroundColor(getResources().getColor(R.color.white));
			tvrb2.setBackgroundColor(getResources().getColor(R.color.white));
			tvrb2.setBackgroundColor(getResources().getColor(
					R.color.main_radio_blue));

			// 请求数据
			curPage = 1;
			mListView.setAdapter(mAdapter3);
			// mAdapter2.notifyDataSetChanged();
			loadHttp("1");
			break;
		default:
			break;
		}
	}

	/** 适配器 ---回收中 **/
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
				convertView = LayoutInflater.from(WoDeTouBiao.this).inflate(
						R.layout.mine_new_wodetoubiao_item, null);

				holder.touzijine = (TextView) convertView
						.findViewById(R.id.wdtb_item_touzijine);
				holder.yuqinianhua = (TextView) convertView
						.findViewById(R.id.wdtb_item_yuqinianhua);
				holder.daishoubenxi = (TextView) convertView
						.findViewById(R.id.wdtb_item_daishoubenxi);

				holder.layoutbtn = (LinearLayout) convertView
						.findViewById(R.id.wdtb_item_btn);
				holder.layout = (LinearLayout) convertView
						.findViewById(R.id.wdtb_item_layout);

				holder.biaodeleixing = (TextView) convertView
						.findViewById(R.id.wdtb_item_biaodeleixing);
				holder.jiekuanbiaoti = (TextView) convertView
						.findViewById(R.id.wdtb_item_jiekuanbiaoti);
				holder.shengyuqishu = (TextView) convertView
						.findViewById(R.id.wdtb_item_shengyuqishu);
				holder.kaishijixishijian = (TextView) convertView
						.findViewById(R.id.wdtb_item_kaishijixishijian);
				holder.xiayigehuankuanri = (TextView) convertView
						.findViewById(R.id.wdtb_item_xiayigehuankuanri);
				holder.huankuanzhuangtai = (TextView) convertView
						.findViewById(R.id.wdtb_item_huankuanzhuangtai);

				holder.chakanhetong = (TextView) convertView
						.findViewById(R.id.wdtb_item_chakanhetong);
				holder.jiaoyicunzheng = (TextView) convertView
						.findViewById(R.id.wdtb_item_jiaoyicunzheng);
				holder.xiangmucunzheng = (TextView) convertView
						.findViewById(R.id.wdtb_item_xiangmucunzheng);

				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}
			// 设置显示布局按钮事件
			holder.layoutbtn.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View arg0) {
					// TODO Auto-generated method stub
					if (holder.layout.getVisibility() == View.GONE) {
						holder.layout.setVisibility(View.VISIBLE);
					} else {
						holder.layout.setVisibility(View.GONE);
					}
				}
			});

			//查看合同按钮
			holder.chakanhetong.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View arg0) {
					// TODO Auto-generated method stub
				}
			});
			
			//交易存正
			holder.jiaoyicunzheng.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View arg0) {
					// TODO Auto-generated method stub
				}
			});
			//项目存正
			holder.xiangmucunzheng.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View arg0) {
					// TODO Auto-generated method stub
				}
			});

			//设置回收中值
			holder.touzijine.setText("100000");
			holder.yuqinianhua.setText("10000000");
			holder.daishoubenxi.setText("充值成功");

			return convertView;
		}

		final class ViewHolder {

			TextView touzijine;
			TextView yuqinianhua;
			TextView daishoubenxi;

			LinearLayout layoutbtn;
			LinearLayout layout;

			TextView biaodeleixing;
			TextView jiekuanbiaoti;
			TextView shengyuqishu;
			TextView kaishijixishijian;
			TextView xiayigehuankuanri;
			TextView huankuanzhuangtai;

			TextView chakanhetong;
			TextView jiaoyicunzheng;
			TextView xiangmucunzheng;

		}
	}

	/** 适配器 ---投标中 **/
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
				convertView = LayoutInflater.from(WoDeTouBiao.this).inflate(
						R.layout.mine_new_wodetoubiao_item2, null);

				holder.touzijine = (TextView) convertView
						.findViewById(R.id.wdtb_item2_touzijine);
				holder.yuqinianhua = (TextView) convertView
						.findViewById(R.id.wdtb_item2_yuqinianhua);
				holder.qixian = (TextView) convertView
						.findViewById(R.id.wdtb_item2_daishoubenxi);

				holder.layoutbtn = (LinearLayout) convertView
						.findViewById(R.id.wdtb_item2_btn);
				holder.layout = (LinearLayout) convertView
						.findViewById(R.id.wdtb_item2_layout);

				holder.biaodeleixing = (TextView) convertView
						.findViewById(R.id.wdtb_item2_biaodeleixing);
				holder.jiekuanbiaoti = (TextView) convertView
						.findViewById(R.id.wdtb_item2_jiekuanbiaoti);
				holder.shengyuketou = (TextView) convertView
						.findViewById(R.id.wdtb_item2_shengyuqishu);
				holder.toubiaojindu = (TextView) convertView
						.findViewById(R.id.wdtb_item2_kaishijixishijian);
				holder.toubiaoshijian = (TextView) convertView
						.findViewById(R.id.wdtb_item2_huankuanzhuangtai);

				holder.jixutoubiao = (TextView) convertView
						.findViewById(R.id.wdtb_item2_chakanhetong);
				holder.chakancunzheng = (TextView) convertView
						.findViewById(R.id.wdtb_item2_jiaoyicunzheng);

				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}
			// 设置显示布局按钮事件
			holder.layoutbtn.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View arg0) {
					// TODO Auto-generated method stub
					if (holder.layout.getVisibility() == View.GONE) {
						holder.layout.setVisibility(View.VISIBLE);
					} else {
						holder.layout.setVisibility(View.GONE);
					}
				}
			});

			//查看合同按钮
			holder.jixutoubiao.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View arg0) {
					// TODO Auto-generated method stub
				}
			});
			
			//交易存正
			holder.chakancunzheng.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View arg0) {
					// TODO Auto-generated method stub
				}
			});

			//设置回收中值
			holder.touzijine.setText("100000");
			holder.yuqinianhua.setText("10000000");
			holder.qixian.setText("充值成功");

			return convertView;
		}

		final class ViewHolder {

			TextView touzijine;
			TextView yuqinianhua;
			TextView qixian;

			LinearLayout layoutbtn;
			LinearLayout layout;

			TextView biaodeleixing;
			TextView jiekuanbiaoti;
			TextView shengyuketou;
			TextView toubiaojindu;
			TextView toubiaoshijian;

			TextView jixutoubiao;
			TextView chakancunzheng;

		}

	}

	/** 适配器 ---存管理财 **/
	class MyAdapter3 extends BaseAdapter {

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
				convertView = LayoutInflater.from(WoDeTouBiao.this).inflate(
						R.layout.mine_new_wodetoubiao_item3, null);

				holder.touzijine = (TextView) convertView
						.findViewById(R.id.wdtb_item3_touzijine);
				holder.yuqinianhua = (TextView) convertView
						.findViewById(R.id.wdtb_item3_yuqinianhua);
				holder.huishoujine = (TextView) convertView
						.findViewById(R.id.wdtb_item3_daishoubenxi);

				holder.layoutbtn = (LinearLayout) convertView
						.findViewById(R.id.wdtb_item3_btn);
				holder.layout = (LinearLayout) convertView
						.findViewById(R.id.wdtb_item3_layout);

				holder.biaodeleixing = (TextView) convertView
						.findViewById(R.id.wdtb_item3_biaodeleixing);
				holder.jiekuanbiaoti = (TextView) convertView
						.findViewById(R.id.wdtb_item3_jiekuanbiaoti);
				holder.yizhuanjine = (TextView) convertView
						.findViewById(R.id.wdtb_item3_shengyuqishu);
				holder.jieqingriqi = (TextView) convertView
						.findViewById(R.id.wdtb_item3_huankuanzhuangtai);

				holder.jieqingriqi = (TextView) convertView
						.findViewById(R.id.wdtb_item3_chakanhetong);
				holder.chakancunzheng = (TextView) convertView
						.findViewById(R.id.wdtb_item3_jiaoyicunzheng);

				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}
			// 设置显示布局按钮事件
			holder.layoutbtn.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View arg0) {
					// TODO Auto-generated method stub
					if (holder.layout.getVisibility() == View.GONE) {
						holder.layout.setVisibility(View.VISIBLE);
					} else {
						holder.layout.setVisibility(View.GONE);
					}
				}
			});

			//查看合同按钮
			holder.jieqingriqi.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View arg0) {
					// TODO Auto-generated method stub
				}
			});
			
			//交易存正
			holder.chakancunzheng.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View arg0) {
					// TODO Auto-generated method stub
				}
			});

			//设置回收中值
			holder.touzijine.setText("100000");
			holder.yuqinianhua.setText("10000000");
			holder.huishoujine.setText("充值成功");

			return convertView;
		}

		final class ViewHolder {

			TextView touzijine;
			TextView yuqinianhua;
			TextView huishoujine;

			LinearLayout layoutbtn;
			LinearLayout layout;

			TextView biaodeleixing;
			TextView jiekuanbiaoti;
			TextView yizhuanjine;
			TextView jieqingriqi;

			TextView chakanhetong;
			TextView chakancunzheng;

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
		map.put("status", status);// 0精选理财，1是存管理财，
		map.put("page", curPage + "");// 当前页码

		RequestThreadAbstract thread = RequestFactory.createRequestThread(11,
				map, WoDeTouBiao.this, mHandler);
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
				Toast.makeText(WoDeTouBiao.this,
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
				Toast.makeText(WoDeTouBiao.this,
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
