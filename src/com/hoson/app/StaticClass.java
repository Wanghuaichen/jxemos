package com.hoson.app;

import com.hoson.*;

public class StaticClass {

	public static String getSql(String strSqlServer,String strOracleSql) throws Exception
	{
		String strType = PropUtil.getResProp("/app.properties").getProperty("db.type");
		if(strType.trim().compareTo("sqlserver") == 0)
			return strSqlServer;
		else
			return strOracleSql;
	}
}
