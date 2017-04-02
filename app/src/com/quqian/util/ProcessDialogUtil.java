	package com.quqian.util;

import com.example.quqian.R;

import android.app.Dialog;
import android.content.Context;
import android.view.Gravity;
import android.view.Window;
import android.view.WindowManager;


public class ProcessDialogUtil extends Dialog{

	public ProcessDialogUtil(Context context) {
		super(context, R.style.dialog);
		setContentView(R.layout.dialog_process);	
		setCancelable(false);
		
		Window window = getWindow();
		WindowManager.LayoutParams layoutParams = window.getAttributes();
		layoutParams.width = (int) (WindowManager.LayoutParams.MATCH_PARENT);
		layoutParams.height = (int) (WindowManager.LayoutParams.WRAP_CONTENT);
		layoutParams.gravity = Gravity.CENTER;
		window.setAttributes(layoutParams);
	}
	
}
