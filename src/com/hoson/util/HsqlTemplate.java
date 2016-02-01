package com.hoson.util;

import java.sql.*;
import java.util.*;
import com.hoson.*;



public class HsqlTemplate{
	
	String table = null;
	String create_table_sql = null;
	Connection cn = null;
	
	
	public HsqlTemplate(String table,String create_table_sql)throws Exception{
		 this.table = table;
		 this.create_table_sql = create_table_sql;
		 try{
		 cn = HsqlUtil.getHsqlConn();
		 DBUtil.update(cn,create_table_sql,null);
		 
		 }catch(Exception e){
			 throw e;
			 }finally{DBUtil.close(cn);}
	}
	
	
	public static Connection getHsqlConn()throws Exception{
		String driver = "org.hsqldb.jdbcDriver";
		String url = "jdbc:hsqldb:.";
		String user = "sa";
		String pwd = "";
		
		return DBUtil.getConn(driver,url,user,pwd);
		
	}
	
	
	
}