package com.hoson.app;

import java.sql.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import com.hoson.*;

public class AppVersion{

	private static String sysType = null;

	private static Map sysTypeSqlMap = null;

	private static String sysTypeSql = null;

	private static String sqlInStr = null;	
	//-------------------------------------------
	private AppVersion(){}
	
	//---------------------------------------
	static {
		

		sysTypeSqlMap = new HashMap();
		sysTypeSql = "select parameter_value,parameter_name from t_cfg_parameter ";
		sysTypeSql = sysTypeSql
				+ " where parameter_type_id='monitor_type' and parameter_value in ";

		sqlInStr = "'1','2','3','4'";
		sysTypeSqlMap.put("wry", sysTypeSql + "(" + sqlInStr + ")");

		sqlInStr = "'5','6','7','8'";
		sysTypeSqlMap.put("hjzl", sysTypeSql + "(" + sqlInStr + ")");

		sqlInStr = "'A','B','C','D'";
		sysTypeSqlMap.put("cgjc", sysTypeSql + "(" + sqlInStr + ")");
		
		sysTypeSqlMap.put("all", sysTypeSql);
		
	}
	//------------------------------------------------------
	
	// ---------------
	public static String getTreeSql(HttpServletRequest req) throws Exception {

		String type = getSysType(req);
		/*
		String msg = checkSysType(req);
		if (!StringUtil.isempty(msg)) {
			throw new Exception(msg);
		}
		*/
		String[] arrType = { "wry", "hjzl", "cgjc","all"};
		if (StringUtil.containsValue(arrType, type) < 1) {
			type="all";
		}
		return (String) sysTypeSqlMap.get(type);
	}

	// ----------------------
	public static String checkSysType(HttpServletRequest req) throws Exception {
		String type = null;
		String msg = null;
		msg = "请在db.txt中配置sys_type参数\n";
		msg = msg + "污染源wry,环境质量hjzl,常规监测cgjc,全部all";
		type = getSysType(req);
		if (StringUtil.isempty(type)) {
			return msg;
		}
		String[] arrType = { "wry", "hjzl", "cgjc","all"};
		if (StringUtil.containsValue(arrType, type) < 1) {
			return msg;
		}
		return "";
	}

	// ------------------
	public static String getSysType(HttpServletRequest req) throws Exception {

		if (!StringUtil.isempty(sysType)) {
			return sysType;
		}
		Properties prop = null;
		prop = PropUtil.getProp(req, "db.txt");
		return prop.getProperty("sys_type");
	}

	// -----------------------------
	
	
	
}//end class