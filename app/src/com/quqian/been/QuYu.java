package com.quqian.been;

import java.util.ArrayList;

import org.json.JSONArray;

public class QuYu {

	private String id;
	private String name;
	private ArrayList<QuYu> list = null;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public ArrayList<QuYu> getList() {
		return list;
	}

	public void setList(ArrayList<QuYu> list) {
		this.list = list;
	}

}
