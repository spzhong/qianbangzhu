package com.quqian.activity;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;
import android.support.v4.view.ViewPager;
import android.util.Log;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;
import android.widget.TextView;

import com.example.quqian.R;
import com.quqian.base.BaseActivity;
import com.quqian.util.BitmapUtil;
import com.quqian.util.CommonUtil;

public class GuideActivity extends BaseActivity implements OnClickListener {

	// 引导图片
	private static final int[] resource = new int[] { R.drawable.yindao1,
			R.drawable.yindao2, R.drawable.yindao3 };

	// 引导页的标题
	private static final int[] titleRes = new int[] { R.string.sanbiaotouzi,
			R.string.wenzhuanbao, R.string.zhaiquanzhuanrang,
			R.string.licaitiyan };

	// 引导页的内容
	private static final int[] subtitleRes = new int[] {
			R.string.sanbiaotouzijieshi, R.string.wenzhuanbaojieshi,
			R.string.zhaiquanzhuanrangjieshi, R.string.licaitiyanjieshi };

	private ImageView[] dotImage;

	@Override
	protected int layoutId() {
		return R.layout.activity_guide;
	}

	@Override
	protected void doOtherThing() {
		super.doOtherThing();
		LinearLayout pointLinear = (LinearLayout) findViewById(R.id.indicator);
		final int pointLength = resource.length;
		dotImage = new ImageView[pointLength];
		for (int i = 0; i < pointLength; i++) {
			ImageView dotView = new ImageView(this);
			LayoutParams params = new LayoutParams(LayoutParams.WRAP_CONTENT,
					LayoutParams.WRAP_CONTENT);
			params.leftMargin = 10 ;
			params.rightMargin = 10;
			dotView.setLayoutParams(params);
			
			dotImage[i] = dotView;
			//setDotColor(0, i);
			dotView.setId(i);
			ImageView icon = (ImageView) findViewById(i);
			pointLinear.removeView(icon);
			pointLinear.addView(dotView);
		}

		MyFragmentStatePager adpter = new MyFragmentStatePager(
				getSupportFragmentManager());
		ViewPager viewPager = (ViewPager) findViewById(R.id.guide_viewPager);
		viewPager.setAdapter(adpter);
		
		/**
		 * 首先，你必须在 设置 Viewpager的 adapter 之后在调用这个方法 第二点，setmViewPager(ViewPager
		 * mViewPager,Object obj, int count, int... colors) 第一个参数 是 你需要传人的
		 * viewpager 第二个参数 是
		 * 一个实现了ColorAnimationView.OnPageChangeListener接口的Object,用来实现回调 第三个参数 是
		 * viewpager 的 孩子数量 第四个参数 int... colors ，你需要设置的颜色变化值~~ 如何你传人
		 * 空，那么触发默认设置的颜色动画
		 * */
		/**
		 * Frist: You need call this method after you set the Viewpager adpter;
		 * Second: setmViewPager(ViewPager mViewPager,Object obj， int count,
		 * int... colors) so,you can set any length colors to make the animation
		 * more cool! Third: If you call this method like below, make the colors
		 * no data, it will create a change color by default.
		 * */
	}

	private void setDotColor(int position, int j) {
		if (j == position) {
			dotImage[j].setBackgroundResource(R.drawable.dot_focused);
		} else {
			dotImage[j].setBackgroundResource(R.drawable.dot_normal);
		}
	}

	public class MyFragmentStatePager extends FragmentStatePagerAdapter {

		public MyFragmentStatePager(FragmentManager fragmentManager) {
			super(fragmentManager);
		}

		@Override
		public Fragment getItem(int position) {
			return new MyFragment().getInstance(position);
		}

		@Override
		public int getCount() {
			return resource.length;
		}
	}

	@SuppressLint("ValidFragment")
	public class MyFragment extends Fragment {
		private int position;

		public MyFragment() {
		}

		public MyFragment getInstance(int position) {
			MyFragment fileViewFragment = new MyFragment();
			fileViewFragment.position = position;
			return fileViewFragment;
		}

		@Override
		public View onCreateView(LayoutInflater inflater, ViewGroup container,
				Bundle savedInstanceState) {
			ImageView imageView;
			TextView title, subtitle, btn;

			View view = inflater.inflate(R.layout.activity_guide_item, null);
			imageView = (ImageView) view.findViewById(R.id.image);
			title = (TextView) view.findViewById(R.id.title);
			subtitle = (TextView) view.findViewById(R.id.subtitle);
			btn = (TextView) view.findViewById(R.id.btn);
			if (resource != null && resource.length > 0) {
				imageView.setImageBitmap(BitmapUtil.readBitMap(context,
						resource[position]));
				title.setText(titleRes[position]);
				subtitle.setText(subtitleRes[position]);
				if (position + 1 == resource.length) {
					btn.setVisibility(View.VISIBLE);
					btn.setOnClickListener(GuideActivity.this);
				}
			}

			return view;
		}
	}

	@Override
	public void onClick(View v) {
		toIntent();
	}

	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		// 先判断是否是返回键
		if (keyCode == KeyEvent.KEYCODE_BACK && event.getRepeatCount() == 0) {
			finish();
			anim_right_out();
		}
		return false;
	}

	// 此为第一次登录。所以应该直接跳转到登录界面，
	private void toIntent() {
		Intent intent = new Intent(GuideActivity.this, MainActivity.class);
		startActivity(intent);
		reviseFirstUse();
		finish();
		anim_right_in();
	}

	// 此为第一次登录。所以应该将sharedPreferences的firstUse标记修改成false
	private void reviseFirstUse() {
		CommonUtil.addConfigInfo(GuideActivity.this, "firstUse", "first", "",
				"");
		Log.v("quqian", "是否将标记写入呢？");
	}

}
