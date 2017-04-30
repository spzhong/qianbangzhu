package com.quqian.activity.invert;

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
import com.quqian.activity.index.SanBiaoTouZiActivity;
import com.quqian.activity.index.SanInfoActivity;
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

public class Invert extends BaseActivity implements OnClickListener,
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

	// 申请中radioButton
	private RadioButton rb1 = null;
	// 参与中
	private RadioButton rb2 = null;

	// 记录当前刷新页
	private int curPage = 1;

	ProcessDialogUtil juhua = null;

	private String licaitab = null;
	
	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_invert;
	}

	@Override
	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
		if (getIntent().getExtras() != null) {
			licaitab = getIntent().getExtras().getString("licaitab");
			Log.v("tab----", licaitab);
		}
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle("理财");
		showBack();

		juhua = new ProcessDialogUtil(Invert.this);

		rg = (RadioGroup) findViewById(R.id.mine_invert_rg);
		rb1 = (RadioButton) findViewById(R.id.mine_invert_rb1);
		rb2 = (RadioButton) findViewById(R.id.mine_invert_rb2);

		mListView = (XListView) findViewById(R.id.mine_invert_listview);
		mListView.setPullLoadEnable(false);
		mAdapter1 = new MyAdapter1();
		mAdapter2 = new MyAdapter2();

		if(licaitab == "2"){
			rb2.setChecked(true);
			mListView.setAdapter(mAdapter2);
		}else{
			rb1.setChecked(true);
			mListView.setAdapter(mAdapter1);
		}
		
		
		mListView.setXListViewListener(this);

		mListView.setOnItemClickListener(new OnItemClickListener() {

			@SuppressLint("ShowToast")
			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1,
					int position, long arg3) {

				// TODO Auto-generated method stub
				if (position != 0) {

					UserMode user = Tool.getUser(Invert.this);
					if (user == null) {
						startActivity(new Intent(Invert.this,
								LoginActivity.class));
					} else {
						SanProject san = (SanProject) allList1.get(position - 1);
						Intent intent = new Intent(Invert.this,
								InvertInfoActivity.class);
						Bundle bundle = new Bundle();
						bundle.putString("pId", san.getpId());
						// bundle.putSerializable("sanProject", test);
						intent.putExtras(bundle);
						Log.v("quqian", "-----pid----" + san.getpId());
						startActivity(intent);
					}
					anim_right_in();
					
 
				} else {
					return;
				}
			}
		});
		// diao接口
		if(licaitab == "2"){
			loadHttp("1");
		}else{
			loadHttp("0");
		}
	}
	
	@Override
	protected void onResume() {
		// TODO Auto-generated method stub
		super.onResume();
		if(licaitab == "2"){
			loadHttp("1");
		}else{
			loadHttp("0");
		}
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
			Invert.this.finish();
			anim_right_out();
			break;
		case R.id.mine_invert_rb1:
			// 精选理财
			curPage = 1;
			mListView.setAdapter(mAdapter1);
			// mAdapter1.notifyDataSetChanged();
			loadHttp("0");
			break;
		case R.id.mine_invert_rb2:
			// 存管理财
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
				convertView = LayoutInflater.from(Invert.this)
						.inflate(R.layout.main_invert_item, null);

				holder.tv1 = (TextView) convertView
						.findViewById(R.id.inert_licai_tv1);

				holder.tv2 = (TextView) convertView
						.findViewById(R.id.inert_licai_tv2);

				holder.tv3 = (TextView) convertView
						.findViewById(R.id.inert_licai_tv3);

				holder.tv_btn = (TextView) convertView
						.findViewById(R.id.inert_licai_tv4);
				
				holder.tv_i1 = (TextView) convertView
						.findViewById(R.id.inert_licai_tv5);
				holder.tv_i2 = (TextView) convertView
						.findViewById(R.id.inert_licai_tv6);
				holder.tv_i3 = (TextView) convertView
						.findViewById(R.id.inert_licai_tv7);
				holder.tv_i4 = (TextView) convertView
						.findViewById(R.id.inert_licai_tv8);

				holder.layout = (LinearLayout)  convertView
						.findViewById(R.id.licai_layout_gongsi);
				
				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}
			final SanProject san = (SanProject) allList1.get(position);
			 
			 			
			if(san.bdtype == "0"){
				holder.tv1.setVisibility(View.VISIBLE);	
				holder.tv2.setVisibility(View.GONE);
			}else{
				holder.tv2.setVisibility(View.VISIBLE);
				holder.tv1.setVisibility(View.GONE);
			}
			 
			holder.tv3.setText(san.getBdbt());
			if (san.isJudgment_bid_butonPress()) {
				holder.tv_btn.setTextColor(getResources().getColor(
						R.color.main_text_blue));
				holder.tv_btn
						.setBackgroundResource(R.drawable.chengsebiankuang);
				holder.tv_btn.setEnabled(true);
			} else {
				holder.tv_btn.setTextColor(getResources().getColor(
						R.color.main_text_gray));
				holder.tv_btn
						.setBackgroundResource(R.drawable.button_kuang_gray);
				holder.tv_btn.setEnabled(false);
			}
			holder.tv_btn.setText(san.getZt());
  
			

			holder.tv_i1.setText(san.show_list_one());
			holder.tv_i2.setText(san.show_list_two());
			holder.tv_i3.setText(san.show_list_three());
			if(san.tjf.length()==0){
				holder.layout.setVisibility(View.GONE);
			}else{
				holder.layout.setVisibility(View.VISIBLE);
				holder.tv_i4.setText(san.tjf +" 推荐");
			}
			
			
			holder.tv_btn.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View arg0) {
					// TODO Auto-generated method stub
 
					UserMode user = Tool.getUser(Invert.this);
					if (user == null) {
						startActivity(new Intent(Invert.this,
								LoginActivity.class));
					} else {

						SanProject san = (SanProject) allList1.get(position);

						Intent intent = new Intent(Invert.this,
								LiJiTouBiaoActivity.class);
						Bundle bundle = new Bundle();
						bundle.putString("pId", san.getpId());
						bundle.putString("shengyu", san.getSyje());// 剩余金额
						bundle.putString("huankuanqixian", san.getHkqx());// 还款期限
						bundle.putString("nianlilv", san.getNll());// 年利率
						bundle.putString("jiangli", san.getJlll());// 奖励利率
						bundle.putString("jiekuan", san.getJkfs());// 借款方式
						bundle.putString("huankuanfangshi", san.getHkfs());// 还款方式
						bundle.putString("bdtype", san.getBdtype());//标的类型
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
			TextView tv_btn;
			TextView tv_i1;
			TextView tv_i2;
			TextView tv_i3;
			TextView tv_i4;
			LinearLayout layout;

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
				convertView = LayoutInflater.from(Invert.this)
						.inflate(R.layout.main_invert_item, null);

				holder.tv1 = (TextView) convertView
						.findViewById(R.id.inert_licai_tv1);

				holder.tv2 = (TextView) convertView
						.findViewById(R.id.inert_licai_tv2);

				holder.tv3 = (TextView) convertView
						.findViewById(R.id.inert_licai_tv3);

				holder.tv_btn = (TextView) convertView
						.findViewById(R.id.inert_licai_tv4);
				
				holder.tv_i1 = (TextView) convertView
						.findViewById(R.id.inert_licai_tv5);
				holder.tv_i2 = (TextView) convertView
						.findViewById(R.id.inert_licai_tv6);
				holder.tv_i3 = (TextView) convertView
						.findViewById(R.id.inert_licai_tv7);
				holder.tv_i4 = (TextView) convertView
						.findViewById(R.id.inert_licai_tv8);
				holder.layout = (LinearLayout)  convertView
						.findViewById(R.id.licai_layout_gongsi);
				
				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}
			final SanProject san = (SanProject) allList2.get(position);
			
			 
			if(san.bdtype == "0"){
				holder.tv1.setVisibility(View.VISIBLE);	
				holder.tv2.setVisibility(View.GONE);
			}else{
				holder.tv2.setVisibility(View.VISIBLE);
				holder.tv1.setVisibility(View.GONE);
			}
			
			holder.tv3.setText(san.getBdbt());
			 
			if (san.isJudgment_bid_butonPress()) {
				holder.tv_btn.setTextColor(getResources().getColor(
						R.color.main_text_blue));
				holder.tv_btn
						.setBackgroundResource(R.drawable.chengsebiankuang);
				holder.tv_btn.setEnabled(true);
			} else {
				holder.tv_btn.setTextColor(getResources().getColor(
						R.color.main_text_gray));
				holder.tv_btn
						.setBackgroundResource(R.drawable.button_kuang_gray);
				holder.tv_btn.setEnabled(false);
			}
			holder.tv_btn.setText(san.getZt());
 
			
			holder.tv_i1.setText(san.show_list_one());
			holder.tv_i2.setText(san.show_list_two());
			holder.tv_i3.setText(san.show_list_three());
			if(san.tjf.length()==0){
				holder.layout.setVisibility(View.GONE);
			}else{
				holder.layout.setVisibility(View.VISIBLE);
				holder.tv_i4.setText(san.tjf +" 推荐");
			}
			
			
			holder.tv_btn.setOnClickListener(new OnClickListener() {

				@Override
				public void onClick(View arg0) {
					// TODO Auto-generated method stub
				
					UserMode user = Tool.getUser(Invert.this);
					if (user == null) {
						startActivity(new Intent(Invert.this,
								LoginActivity.class));
					} else {

						SanProject san = (SanProject) allList2.get(position);

						Intent intent = new Intent(Invert.this,
								LiJiTouBiaoActivity.class);
						Bundle bundle = new Bundle();
						bundle.putString("pId", san.getpId());
						bundle.putString("shengyu", san.getSyje());// 剩余金额
						bundle.putString("huankuanqixian", san.getHkqx());// 还款期限
						bundle.putString("nianlilv", san.getNll());// 年利率
						bundle.putString("jiangli", san.getJlll());// 奖励利率
						bundle.putString("jiekuan", san.getJkfs());// 借款方式
						bundle.putString("huankuanfangshi", san.getHkfs());// 还款方式
						bundle.putString("bdtype", san.getBdtype());//标的类型
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
			TextView tv_btn;
			TextView tv_i1;
			TextView tv_i2;
			TextView tv_i3;
			TextView tv_i4;
			LinearLayout layout;
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
		
		map.put("bdlx", status);// 0精选理财，1是存管理财，
		map.put("page", curPage + "");// 当前页码

		RequestThreadAbstract thread = RequestFactory.createRequestThread(8,
				map, Invert.this, mHandler);
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
				Toast.makeText(Invert.this,
						msg.getData().getString("errMsg"), 1000).show();
				onStopLoad();
				break;
			case 1:

				//json = (JSONObject) msg.getData().get("json");
				if (msg.getData().get("bdlx").equals("0")) {

					List<Object> list = (List<Object>) msg.getData()
							.get("list");
					if (curPage == 1) {
						allList1.clear();
					}
					allList1.addAll(list);
					mAdapter1.notifyDataSetChanged();

				} else if (msg.getData().get("bdlx").equals("1")) {

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
				Toast.makeText(Invert.this,
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
		b.putString("bdlx", map.get("bdlx"));
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
