package com.hoson.util;

import java.sql.*;
import java.util.*;
import com.hoson.*;



public class HsqlUtil{
	
	public static Connection getHsqlConn()throws Exception{
		String driver = "org.hsqldb.jdbcDriver";
		String url = "jdbc:hsqldb:.";
		String user = "sa";
		String pwd = "";
		
		return DBUtil.getConn(driver,url,user,pwd);
		
	}
	
	
	
}