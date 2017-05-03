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

public class TuiGuangJiLu extends BaseActivity implements OnClickListener,
		IXListViewListener, HttpResponseInterface {

	// list<object>集合
	private List<Object> allList1 = new ArrayList<Object>();
	// 下拉刷新
	private XListView mListView = null;
	// 自定义适配器
	private MyAdapter1 mAdapter1 = null;

	// 交易时间
	private TextView zhuangtai = null;

	private String[] strItems = new String[] { "全部", "已开通", "未开通", };

	// 记录当前刷新页
	private int curPage = 1;

	ProcessDialogUtil juhua = null;

	private Dialog dialog = null;

	@Override
	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.mine_new_tuiguangjilu;
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
		setTitle("推广记录");
		showBack();

		juhua = new ProcessDialogUtil(TuiGuangJiLu.this);

		zhuangtai = (TextView) findViewById(R.id.tui_cunguanzhuangtai);

		mListView = (XListView) findViewById(R.id.tui_listview);
		mListView.setPullLoadEnable(false);
		mAdapter1 = new MyAdapter1();
		mListView.setAdapter(mAdapter1);

		// diao接口
		loadHttp("");
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

		zhuangtai.setOnClickListener(this);
	}

	@Override
	public void onClick(View arg0) {
		// TODO Auto-generated method stub

		switch (arg0.getId()) {
		case R.id.title_bar_back:
			TuiGuangJiLu.this.finish();
			anim_right_out();
			break;
		case R.id.tui_cunguanzhuangtai:
			 
//			// 交易类型选择
//			dialog = new AlertDialog.Builder(TuiGuangJiLu.this)
//					.setSingleChoiceItems(strItems, 0,
//							new DialogInterface.OnClickListener() {
//
//								@Override
//								public void onClick(DialogInterface arg0,
//										int arg1) {
//									// TODO Auto-generated method stub
//									dialog.cancel();
//									// 调接口，查询相应的数据
//									
//									String tay = "";
//									if(arg1==1){
//										tay = "";
//									}else if(arg1==2){
//										tay = "";
//									} 
//									curPage = 1;
//									loadHttp(tay);
//									
//								}
//							}).create();
//			dialog.show();
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
				convertView = LayoutInflater.from(TuiGuangJiLu.this).inflate(
						R.layout.mine_new_tuiguangjilu_item, null);

				holder.tv1 = (TextView) convertView.findViewById(R.id.tui_tv1);

				holder.tv2 = (TextView) convertView.findViewById(R.id.tui_tv2);

				holder.tv3 = (TextView) convertView.findViewById(R.id.tui_tv3);

				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}

			JSONObject json = (JSONObject) allList1.get(position);
			try {
				holder.tv1.setText(json.getString("sjh"));
				holder.tv2.setText(json.getString("zcsj"));
				holder.tv3.setText(json.getString("cgzt"));
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
		loadHttp("0");
	}

	@Override
	public void onLoadMore() {
		// TODO Auto-generated method stub
		curPage++;
		loadHttp("0");
	}

	private void loadHttp(String status) {

		juhua.show();

		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		// 请求的参数如下
		map.put("status", status);// 
		map.put("page", curPage + "");// 当前页码

		RequestThreadAbstract thread = RequestFactory.createRequestThread(112,
				map, TuiGuangJiLu.this, mHandler);
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
				Toast.makeText(TuiGuangJiLu.this,
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

				onStopLoad();
				getPage();

				break;
			case 2:
				Toast.makeText(TuiGuangJiLu.this,
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
