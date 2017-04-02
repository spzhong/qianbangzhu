package com.quqian.util;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.example.quqian.R;

public class DialogUtil {

	public Context context;
	public Dialog dialog;

	public DialogUtil(Context context) {
		this.context = context;
	}

	public void showDialog(String title, String content, boolean showcancel,
			boolean showsubmit,boolean showline) {
		View view = LayoutInflater.from(context).inflate(R.layout.dialog_all,
				null);
		TextView tv_title = (TextView) view.findViewById(R.id.dialog_title);
		tv_title.setText(title);
		TextView tv_content = (TextView) view.findViewById(R.id.dialog_content);
		tv_content.setText(content);
		Button tv_cancel = (Button) view.findViewById(R.id.dialog_cancel);
		if (!showcancel) {
			tv_cancel.setVisibility(View.GONE);
		}
		Button tv_submit = (Button) view.findViewById(R.id.dialog_submit);
		if (!showsubmit) {
			tv_submit.setVisibility(View.GONE);
		}
		View v_line = (View)view.findViewById(R.id.line_view3);
		if (!showline) {
			v_line.setVisibility(View.GONE);
		}
		dialog = new AlertDialog.Builder(context).setView(view).create();
		dialog.show();
	}

	public void cancelDialog() {
		dialog.dismiss();
	}
}
