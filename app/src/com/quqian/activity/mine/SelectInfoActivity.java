package com.quqian.activity.mine;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.Parcelable;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.View.OnClickListener;
import android.view.animation.BounceInterpolator;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.example.quqian.R;
import com.example.quqian.R.layout;
import com.quqian.activity.LoginActivity;
import com.quqian.activity.index.LiCaiInfoActivity;
import com.quqian.activity.index.LiCaiTiYanActivity;
import com.quqian.activity.mine.MyJiaoYiJiLuActivity.MyAdapter;
import com.quqian.activity.mine.MyJiaoYiJiLuActivity.MyAdapter.ViewHolder;
import com.quqian.base.BaseActivity;
import com.quqian.been.Chongzhi;
import com.quqian.been.QuYu;
import com.quqian.been.TiYanProject;
import com.quqian.been.UserMode;
import com.quqian.http.RequestFactory;
import com.quqian.http.RequestPool;
import com.quqian.http.RequestThreadAbstract;
import com.quqian.util.HttpResponseInterface;
import com.quqian.util.ProcessDialogUtil;
import com.quqian.util.Tool;

public class SelectInfoActivity extends BaseActivity implements
		OnClickListener, HttpResponseInterface {

	public ArrayList<Map<String, String>> mapList = null;

	public ArrayList<QuYu> mapList1 = null;

	public int type;// 0是选择银行卡，1是选择开户所在地址

	public String sheng;
	public String shi;
	public String qu;

	public String shengid;
	public String shiid;
	public String quid;

	public String cityId;
	public int type_1;// 0是省，1是城市，2是区县

	ListView myselectView = null;

	MyAdapter mAdapter = null;

	ProcessDialogUtil juhua = null;

	public String title = "";

	ArrayList<Map<String, String>> arr_bank_map = new ArrayList<Map<String, String>>();

	protected void getIntentWord() {
		// TODO Auto-generated method stub
		super.getIntentWord();
		Intent intent = getIntent();

		title = intent.getStringExtra("title");
		type = Integer.parseInt(intent.getStringExtra("type"));
		if (type == 1) {
			type_1 = Integer.parseInt(intent.getStringExtra("type1"));
			if (type_1 == 0) {

			} else if (type_1 == 1) {

				sheng = intent.getStringExtra("sheng");
				shengid = intent.getStringExtra("shengid");

			} else if (type_1 == 2) {

				sheng = intent.getStringExtra("sheng");
				shengid = intent.getStringExtra("shengid");
				shi = intent.getStringExtra("shi");
				shiid = intent.getStringExtra("shiid");
			}
		}else{
			mapList = (ArrayList<Map<String, String>>) intent.getSerializableExtra("arr_bank_map");
		}
	}

	protected int layoutId() {
		// TODO Auto-generated method stub
		return R.layout.main_mine_select_list;
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
			SelectInfoActivity.this.finish();
			anim_right_out();
			break;
		default:
			break;
		}
	}

	@Override
	protected void initView() {
		// TODO Auto-generated method stub
		super.initView();
		setTitle(title);
		showBack();

		juhua = new ProcessDialogUtil(SelectInfoActivity.this);

		myselectView = (ListView) findViewById(R.id.mine_yinhang_listview);// 得到ListView对象的引用
		mAdapter = new MyAdapter();
		myselectView.setAdapter(mAdapter);

		myselectView.setOnItemClickListener(new OnItemClickListener() {

			@SuppressLint("ShowToast")
			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1,
					int position, long arg3) {

				// TODO Auto-generated method stub

				if (type == 0) {
					Map<String, String> map = mapList.get(position);

					Intent intent = new Intent();
					intent.setAction("xiugaiyinhanghangkashuxinshju");
					Bundle bundle = new Bundle();
					bundle.putString("type", "0");
					bundle.putString("bankName", map.get("bankName"));
					bundle.putString("bankId", map.get("bankId"));
					intent.putExtras(bundle);
					sendBroadcast(intent);

					SelectInfoActivity.this.finish();
					anim_right_out();

				} else {
					Map<String, String> map = arr_bank_map.get(position);

					if (type_1 == 0) {
						Intent intent2 = new Intent(SelectInfoActivity.this,
								SelectInfoActivity.class);
						intent2.putExtra("title", "选择城市");
						intent2.putExtra("shengid", map.get("id"));
						intent2.putExtra("sheng", map.get("name"));
						intent2.putExtra("type1", "1");
						intent2.putExtra("type", "1");
						SelectInfoActivity.this.finish();
						startActivity(intent2);
						anim_right_in();

					} else if (type_1 == 1) {

						Intent intent2 = new Intent(SelectInfoActivity.this,
								SelectInfoActivity.class);
						intent2.putExtra("title", "选择区县");
						intent2.putExtra("sheng", sheng);
						intent2.putExtra("shengid", shengid);
						intent2.putExtra("shiid", map.get("id"));
						intent2.putExtra("shi", map.get("name"));
						intent2.putExtra("type1", "2");
						intent2.putExtra("type", "1");
						SelectInfoActivity.this.finish();
						startActivity(intent2);
						anim_right_in();

					} else {
						// 返回，且加上通知

						Intent intent = new Intent();
						intent.setAction("xiugaiyinhanghangkashuxinshju");
						Bundle bundle = new Bundle();
						bundle.putString("type", "1");
						bundle.putString("city",
								sheng + " " + shi + " " + map.get("name"));
						bundle.putString("cityId", map.get("id"));
						bundle.putString("shengid", shengid);
						intent.putExtras(bundle);
						sendBroadcast(intent);

						SelectInfoActivity.this.finish();
						anim_right_out();

					}

				}

			}
		});

		// 获取银行开户行的信息
		if (type == 1) {
			if (type_1 == 0) {
				loadHttp_allYinhang("");
			} else if (type_1 == 1) {
				loadHttp_allYinhang(shengid);
			} else if (type_1 == 2) {
				loadHttp_allYinhang(shiid);
			}
		}

	}

	/** 适配器 **/
	class MyAdapter extends BaseAdapter {

		@Override
		public int getCount() {
			if (type == 0) {
				return mapList != null ? mapList.size() : 0;
			}
			return arr_bank_map != null ? arr_bank_map.size() : 0;
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
				convertView = LayoutInflater.from(SelectInfoActivity.this)
						.inflate(R.layout.main_mine_jiaoyijilu_item, null);
				holder.tv1 = (TextView) convertView
						.findViewById(R.id.main_mine_jiaoyi_item1);
				holder.tv2 = (TextView) convertView
						.findViewById(R.id.main_mine_jiaoyi_item2);
				holder.tv3 = (TextView) convertView
						.findViewById(R.id.main_mine_jiaoyi_item3);
				 
				holder.tv2.setVisibility(View.GONE);
				holder.tv3.setVisibility(View.GONE);

				convertView.setTag(holder);
			} else {
				holder = (ViewHolder) convertView.getTag();
			}

			if (type == 0) {
				holder.tv1.setText(mapList.get(position).get("bankName"));
			} else {

				Map<String, String> map = arr_bank_map.get(position);
				holder.tv1.setText(map.get("name"));
			}
			
			return convertView;
		}

		final class ViewHolder {
			TextView tv1;
			TextView tv2;
			TextView tv3;
		}
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getSheng() {
		return sheng;
	}

	public void setSheng(String sheng) {
		this.sheng = sheng;
	}

	public String getShi() {
		return shi;
	}

	public void setShi(String shi) {
		this.shi = shi;
	}

	public String getQu() {
		return qu;
	}

	public void setQu(String qu) {
		this.qu = qu;
	}

	public String getCityId() {
		return cityId;
	}

	public void setCityId(String cityId) {
		this.cityId = cityId;
	}

	public int getType_1() {
		return type_1;
	}

	public void setType_1(int type_1) {
		this.type_1 = type_1;
	}

	// 登录--网络请求
	private Handler mHandler = new Handler() {

		@Override
		public void handleMessage(Message msg) {
			// TODO Auto-generated method stub
			super.handleMessage(msg);

			juhua.cancel();

			switch (msg.what) {
			case 0:

				Toast.makeText(SelectInfoActivity.this,
						msg.getData().getString("errMsg"), 1000).show();

				break;
			case 1: // 获取银行卡信息
				arr_bank_map.addAll((ArrayList) msg.getData().get("list"));
				mAdapter.notifyDataSetChanged();
				break;
			case 2:

				SelectInfoActivity.this.finish();
				anim_right_out();
				Toast.makeText(SelectInfoActivity.this,
						msg.getData().getString("msg"), 1000).show();
				break;
			default:
				break;
			}
		}
	};

	// 获取银行开户行
	private void loadHttp_allYinhang(String id) {
		// TODO Auto-generated method stu
		juhua.show();
		Map<String, String> map = new HashMap<String, String>();
		map.put("urlTag", "1");// 可不传（区分一个activity多个请求）
		map.put("isLock", "0");// 0不锁，1是锁
		map.put("level", type_1 + "");
		map.put("id", id);
		RequestThreadAbstract thread = RequestFactory.createRequestThread(47,
				map, SelectInfoActivity.this, mHandler);
		RequestPool.execute(thread);
	}

	@Override
	public void httpResponse_success(Map<String, String> map,
			List<Object> list, Object jsonObj) {
		// TODO Auto-generated method stub

		ArrayList<Map<String, String>> listnew = new ArrayList<Map<String, String>>();

		JSONObject json = (JSONObject) jsonObj;
		try {
			JSONArray jsonArray = json.getJSONArray("rvalue");
			for (int i = 0; i < jsonArray.length(); i++) {
				JSONObject newjson = jsonArray.getJSONObject(i);
				Map<String, String> onemap = new HashMap<String, String>();
				onemap.put("id", newjson.getString("id"));
				onemap.put("name", newjson.getString("name"));
				listnew.add(onemap);
			}
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Bundle b = new Bundle();
		b.putParcelableArrayList("list",
				(ArrayList<? extends Parcelable>) listnew);
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
		bundle.putString("tag", map.get("urlTag"));
		bundle.putString("msg", msg);
		msg2.setData(bundle);
		mHandler.sendMessage(msg2);
	}

}
