package com.hoson.action;

import java.sql.Connection;
import java.util.Map;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.hoson.DBUtil;
import com.hoson.PropUtil;

import javax.servlet.http.HttpServletRequest;

import com.hoson.DBUtil;

public class ViewHCNetViewActiveX_action {

	private HttpServletRequest request = null;

	private String strStation_id = "";
		
	public ViewHCNetViewActiveX_action(HttpServletRequest request)
	{
		this.request = request;
		this.setStrStation_id(request.getParameter("station_id"));
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public String getStrStation_id() {
		return strStation_id;
	}

	public void setStrStation_id(String strStation_id) {
		this.strStation_id = strStation_id;
	}
	
	public String getIP() throws Exception
	{
		String strResult = "";
		
		String strSqlOracle = "select station_ip from t_cfg_station_info where station_id = '"+this.strStation_id+"'";
	
		Connection cn = null;

		try {
			cn = DBUtil.getConn(request);// 获取数据库连接
			Map lstRealData = DBUtil.queryOne(cn, strSqlOracle, null);
			if (lstRealData != null) 
			{
				strResult = lstRealData.get("station_ip")+"";
			}
		} finally {
			DBUtil.close(cn);
		}
		
		return strResult.trim();
	}
}
