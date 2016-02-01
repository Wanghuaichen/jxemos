package com.hoson.util;


import com.hoson.*;
import com.hoson.app.*;
import com.hoson.hello.CheckEmos;

import java.util.*;
import java.sql.*;

import javax.servlet.http.*;



public class SupportUtil{
	/*
	static CheckEmos checkEmos = new CheckEmos();
	
	static {
		if(checkEmos==null){checkEmos = new CheckEmos();}
	}
	
	*/
	
	public static void u(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		String code = request.getParameter("code");
		String split = JspUtil.getParameter(request,"split",";");
		String sqls = JspUtil.getParameter(request,"sql","");
		String msg = "";
		Connection cn = null;
		String s = "";
		int k= 0;
		String sql = null;
		StringBuffer sb = new StringBuffer();
		
		request.setAttribute("sql",sqls);
		request.setAttribute("code",code);
		
		if(StringUtil.isempty(sqls)){return;}
		

		if(code==null){code="";}
		if(!getCode().equals(code)){
			request.setAttribute("msg","error code");
			return;
			}
		
		
		String[]arr=sqls.split(split);
		int i,num=0;
		
		num=arr.length;
		try{
		cn = DBUtil.getConn();
		
		for(i=0;i<num;i++){
			sql = arr[i];
			if(StringUtil.isempty(sql)){continue;}
			
			try{
			k = DBUtil.update(cn,sql,null);
			//s = s+i+","+k+","+sql+"\n<br>";
			//s=s+"<tr><td>"+i+"</td><td>"+k+"</td><td>"+StringUtil.encodeHtml(sql)+"</td></tr>\n";
			sb.append("<tr><td>").append(i+"</td><td>").append(k).append("</td><td>").append(StringUtil.encodeHtml(sql)).append("</td></tr>\n");
			}catch(Exception e){
				
				//s=s+i+","+sql+",<font color=red>"+e+"</font>\n<br>";
				//s=s+"<tr><td>"+i+"</td><td>"+""+"</td><td class=error>"+StringUtil.encodeHtml(e+"")+"</td></tr>\n";
			sb.append("<tr><td>").append(i).append("</td><td>").append("</td><td class=error>").append(StringUtil.encodeHtml(e+"")).append("</td></tr>\n");
			}
			
		}//end for
		
		request.setAttribute("msg",sb+"");
		
		}catch(Exception e){
			//throw e;
			request.setAttribute("msg",e+"");
			
		}finally{DBUtil.close(cn);}
		
		
		
	}
	
	public static String getCode(){
		
		java.sql.Date d = StringUtil.getNowDate();
		Timestamp t = StringUtil.getNowTime();
		
		String s = d+"$"+t.getHours()+"$hoson$cjxtgly";
		
		return s;
	}
		
	public static List dataCheck(List list)throws Exception{
		if(2>1){return list;}
		String check_flag = App.get("check","0");
		//System.out.println(check_flag+","+list.size());
		if(!StringUtil.equals(check_flag,"1")){
			return list;
		}
		int i,num=0;
		Map map = null;
		num = list.size();
		String m_value = null;
		String vd = null;
		
		int flag = 0;
		List list2 = new ArrayList();
		for(i=0;i<num;i++){
			map = (Map)list.get(i);
			m_value=(String)map.get("m_value");
			
			if(StringUtil.isempty(m_value)){continue;}
			m_value = StringUtil.format(m_value,"0.0000");
			vd = (String)map.get("vd");
			
			//System.out.println(map);
			
			if(vd==null){continue;}
			flag = CheckEmos.check(m_value,vd);
			
			//System.out.println(m_value+","+vd+","+flag);
			if(flag>0){
				list2.add(map);
				}
			
		}
		
		return list2;
	}
	
	public static String avgDataRowCheck(Map map)throws Exception{
		String v = null;
		String s = "";
		String vd = null;
		int flag = 0;
		v = (String)map.get("val01");
		if(v!=null){s=s+v;}
		v = (String)map.get("val02");
		if(v!=null){s=s+v;}
		v = (String)map.get("val03");
		if(v!=null){s=s+v;}
		s=s.trim();
		
		s=f.sub(s,0,8);
		
		vd = (String)map.get("vd");
		
		//System.out.println(map);
		
		if(vd==null){return "0";}
		
		flag = CheckEmos.check(s,vd);
		return flag+","+s+","+vd;
	}
	
	
	public static List hourDataCheck(List list)throws Exception{
		
		if(2>1){return list;}
		
		String check_flag = App.get("check","0");
		//System.out.println(check_flag+","+list.size());
		if(!StringUtil.equals(check_flag,"1")){
			return list;
		}
		int i,num=0;
		Map map = null;
		num = list.size();
		String m_value = null;
		String vd = null;
		String v = null;
		String s = "";
		int flag = 0;
		List list2 = new ArrayList();
		for(i=0;i<num;i++){
			map = (Map)list.get(i);
			//m_value=(String)map.get("m_value");
			
			//if(StringUtil.isempty(m_value)){continue;}
			//m_value = StringUtil.format(m_value,"0.0000");
			s="";//note!!!!!
			v = (String)map.get("val01");
			if(v!=null){s=s+v;}
			v = (String)map.get("val02");
			if(v!=null){s=s+v;}
			v = (String)map.get("val03");
			if(v!=null){s=s+v;}
			s=s.trim();
			
			s=f.sub(s,0,8);
			
			vd = (String)map.get("vd");
			
			//System.out.println(map);
			
			if(vd==null){continue;}
			flag = CheckEmos.check(s,vd);
			//System.out.println(flag+","+s+","+vd);
			//System.out.println(m_value+","+vd+","+flag);
			if(flag>0){
				list2.add(map);
				}
			
		}
		
		return list2;
	}
	
	
	public static void q(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		Map map = JspUtil.getRequestModel(request);
		String sql = (String)map.get("sql");
		String v = null;
		Connection cn = null;
		ResultSet rs = null;
		Statement stmt = null;
		ResultSetMetaData rsmd = null;
		StringBuffer sb = new StringBuffer();
		int colNum = 0;
		int i =0;
		String col = null;
		String cols = "";
		String sql2 = null;
		int num =0;
		if(StringUtil.isempty(sql)){
			//throw new Exception("sql is null");
			return;
		}
		v = (String)map.get("num");
		num = StringUtil.getInt(v,50);
		if(num<0 ||num>1000){
			num = 1000;
		}
		sql2 = sql.toLowerCase();
		
		if(sql2.indexOf("delete")>=0 ||sql2.indexOf("drop")>=0||sql2.indexOf("truncate")>=0){
			throw new Exception("can not execute sql<br>"+sql);
		}
		
		
		try{
		cn = DBUtil.getConn();
		stmt = cn.createStatement();
		stmt.setMaxRows(num);
		rs = stmt.executeQuery(sql);
		rsmd = rs.getMetaData();
		colNum = rsmd.getColumnCount();
		
		sb.append("<tr class=title>\n");
		
		for(i=1;i<=colNum;i++){
			col = rsmd.getColumnName(i);
			col=col.toLowerCase();
			sb.append("<td>").append(col).append("</td>\n");
			if(i>1){cols=cols+",";}
			cols=cols+col;
		}
		sb.append("</tr>\n");
		
		while(rs.next()){
			
			sb.append("<tr>\n");
			for(i=1;i<=colNum;i++){
				sb.append("<td>").append(rs.getString(i)).append("</td>\n");
				
			}
			sb.append("</tr>\n");
			
		}
		
		
		request.setAttribute("data",sb.toString());
		request.setAttribute("sql",sql);
		request.setAttribute("num",num+"");
		request.setAttribute("cols",cols);
		
		}catch(Exception e){
			
			throw new Exception(e+"<br><br>"+sql);
		}finally{
			
			DBUtil.close(rs,stmt,cn);
		}
		
		
	}
		//-----
	
	
}