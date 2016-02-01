package com.hoson.util;

import java.sql.*;
import com.hoson.*;
import java.util.*;


public class JdbcUtil{
	
	public static int[] getJdbcType(){
	
		int[]type=new int[50];
		
		return type;
		
		
	}
	
	public static Object getValue(ResultSet rs,int index,int[]types)
	throws Exception{
		
		int type = 0;
		
		
		type=types[index];
		if(type==0){return rs.getString(index+1);}
		
		if(type==1){return rs.getObject(index+1);}
		if(type==2){return rs.getDate(index+1);}
		if(type==3){return rs.getTimestamp(index+1);}
		
		return rs.getString(index+1);
		
	}
	
	
	public static List query(Connection cn,String sql,Object[]params,int[]types)
	throws Exception{
		
		List list = new ArrayList();
		int i =0;
		int num =0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		Object[]data = null;
		
		pstmt = cn.prepareStatement(sql);
		DBUtil.setParam(pstmt,params);
		rs = pstmt.executeQuery();
		rsmd = rs.getMetaData();
		num = rsmd.getColumnCount();
		
		while(rs.next()){
			
			data = new Object[num];
			for(i=0;i<num;i++){
				data[i]=getValue(rs,i,types);
			}
			list.add(data);
		}
		
		
		
		
		
		
		
		return list;
		
		
		
	}
	
	
	
	
	
	
}//end class