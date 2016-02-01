package com.hoson.util;


import java.io.*;
import java.sql.*;
import java.util.*;
import com.hoson.*;


public class PBean{
	
	
	
	
	
	
	
	public static String get_sql_insert(String table,String[]col){
		String s1 = "";
		String s2 = "";
		int i,num=0;
		num = col.length;
		for(i=0;i<num;i++){
			 if(i>0){
				 
				 s1=s1+",";
				 s2=s2+",";
			 }
			 
			 s1=s1+col[i];
			 s2=s2+"?";
			
		}
		String sql = null;
		sql = "insert into "+table+"("+s1+") values("+s2+")";
		LogUtil.debug(sql);
		return sql;
	}
	
	public static String get_sql_update(String table,String[]col,int pk_num){
		
		int i,num=0;
		String s1="";
		String s2= "";
		num=col.length;
		
		for(i=0;i<pk_num;i++){
			if(i>0){
				s1=s1+" and ";
			}
			s1=s1+col[i]+"=?";
		}
		
		for(i=pk_num;i<num;i++){
			if(i>pk_num){
				s2=s2+",";
			}
			s2=s2+col[i]+"=?";
		}
		
		String sql = null;
		sql = "update "+table+" set "+s2+" where "+s1;
		LogUtil.debug(sql);
		return sql;
	}
	
	
	
	
	
	public static int insert(Connection cn,String table,String[]col,int auto_pk,Map model)
	throws Exception{
		long id = 0;
		if(auto_pk>0){
		id=DBUtil.getNextId(cn,table,col[0]);
		model.put(col[0],id+"");
		}
		String sql = null;
		String v = null;
		
		sql = get_sql_insert(table,col);
		
		PreparedStatement ps = null;
		int i,num=0;
		String c = null;
		
		try{
		ps = cn.prepareStatement(sql);
		num=col.length;
		for(i=0;i<num;i++){
			/*
			v = (String)model.get(col[i]);
			if(K.empty(v)){v=null;}
			ps.setString(i+1,v);
			*/
			c = col[i];
			v = (String)model.get(c);
			
			setp(ps ,i+1, v);
			
		}
		return ps.executeUpdate();
		}catch(Exception e){
			
			//throw new Exception(e+"\n"+sql);
			throw new Exception(e);
		}finally{
			
			DBUtil.close(ps);
		}
		
		
	}
	
	public static int insert(Connection cn,String table,String cols,int auto_pk,Map model)
	throws Exception{
		String[]col=cols.split(",");
		return insert(cn,table,col,auto_pk,model);
		
	}
	public static int insert(String table,String cols,int auto_pk,Map model)
	throws Exception{
		
		Connection cn=null;
		
		try{
		cn = DBUtil.getConn();
		
		return insert(cn,table,cols,auto_pk,model);
		}catch(Exception e){
			throw e;
		}finally{DBUtil.close(cn);}
		
	}
	
	
	
	
	
	
	public static int save(Connection cn,String table,String[]col,int pk_num,Map model)
	throws Exception{
	
		
		
		String sql = null;
		//int pk_num = get_pk_num(table);
		//String[]col=cols.split(",");
		
		sql = get_sql_update(table,col,pk_num);
		
		//System.out.println("¸üÐÂÓï¾äµÄsql£º"+sql);
		
		
		PreparedStatement ps = null;
		int i,num=0;
		String[]p=null;
		String v = null;
		String c =null;
		int j=0;
		
		try{
			num=col.length;
			p = new String[num];
			
			for(i=pk_num;i<num;i++){
				
				p[i-pk_num]=(String)model.get(col[i]);
			}
			for(i=0;i<pk_num;i++){
				
				p[num-pk_num+i]=(String)model.get(col[i]);
			}
			
			
		ps = cn.prepareStatement(sql);
		
		for(i=0;i<num;i++){
			/*
			v = (String)p[i];
			if(K.empty(v)){v=null;}
			ps.setString(i+1,v);
			*/
			j=i+pk_num;
			if(j>=num){j=j-num;}
			
			
			c = col[j];
			
			v = (String)p[i];
			
			setp(ps ,i+1, v);
		}
		return ps.executeUpdate();
		}catch(Exception e){
			
			//throw new Exception(e+"\n"+sql);
			throw new Exception(e);
		}finally{
			
			DBUtil.close(ps);
		}
		
		
	}
	
	
	public static int save(Connection cn,String table,String cols,int pk_num,Map model)
	throws Exception{
		
		String[]col=cols.split(",");
		return save(cn,table,col,pk_num,model);
	}
	
	public static int save(String table,String cols,int pk_num,Map model)
	throws Exception{
		
		Connection cn = null;
		try{
		cn = DBUtil.getConn();
		return save(cn,table,cols,pk_num,model);
		}catch(Exception e){
			throw e;
		}finally{DBUtil.close(cn);}
	}
	
	

	

	
	
	
	
	
	
	
	
	
	
	public static void setp(PreparedStatement ps ,int index,String v)
	throws Exception{
		
		
		
			if(StringUtil.isempty(v)){v=null;}
			ps.setString(index,v);
		
		
		
		
		
	}
	
	
}