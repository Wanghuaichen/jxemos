package com.hoson.util;


import com.hoson.*;


import java.util.*;
import java.sql.*;

import javax.servlet.http.*;
import java.io.*;



public class TianJinDataFile{
	private static String data_file = null;
	private static String data_file_dir = "tianjin/file/";
	private static Map code_map = null;
	
	
	public static String getDataFile(HttpServletRequest req)throws Exception{
		 if(data_file!=null){return data_file;}
		 String s = JspUtil.getAppPath(req);
		 
		if(!s.endsWith("/")){s=s+"/";}
		s=s+data_file_dir;
		
		 data_file = s;
		 return data_file;
		 
	}
	
	private  synchronized  static Map getCodeMap_()throws Exception{
		if(code_map!=null){return code_map;}
		
		String sql = "select m_id,m_name from t_tj_file_code ";
		//List list = f.query(sql,null);
		Map m = f.getMap(sql);
		code_map=m;
		 return code_map;
	}
	
	public static Map getCodeMap()throws Exception{
		if(code_map!=null){return code_map;}
		return getCodeMap_();
	}
	
	public static void clearCodeMap()throws Exception{
		code_map=null;
	}
	
	public static List getFileList(HttpServletRequest req)throws Exception{
		List list = new ArrayList();
		String df = getDataFile(req);
		File file = null;
		File[]fs=null;
		Map m = null;
		int i,num=0;
		String path,m_time,name=null;
		long lms = 0;
		Timestamp t = null;
		
		
		
		
	    //f.sop(df);
			file = new File(df);
			if(!file.exists()){
				file.mkdirs();
			}
			fs = file.listFiles();
		num=fs.length;
		
		for(i=0;i<num;i++){
			file=fs[i];
			if(file.isDirectory()){continue;}
			//path=file.getPath();
			lms=file.lastModified();
			t = new Timestamp(lms);
		    name = file.getName();
			m = new HashMap();
			m.put("name",name);
			m.put("update",t+"");
			list.add(m);
			
		}
			
			
			
		
			
		return list;
		
	}
	

	public static void makeFileList(List list,Map codeMap)throws Exception{
		int i,num=0;
		Map m = null;
		num=list.size();
		for(i=0;i<num;i++){
			m=(Map)list.get(i);
			makeFileInfo(m,codeMap);
			
		}
		
	}
	
	
	public static String name(String s){
		if(f.empty(s)){return "";}
		int pos = s.indexOf(".");
		if(pos<1){return "";}
		s = f.sub(s,0,pos);
		return s;
		
		
	}
	
	public static String str(String s,Map codeMap){
		if(f.empty(s)){return "null";}
		if(is_long(s)){return s;}
		String s1 = (String)codeMap.get(s);
		if(f.empty(s1)){return s;}
		return s1;
		
	}
	
	public static String name(String s,Map codeMap){
		if(f.empty(s)){return "";}
		String[]arr=s.split("-");
		int i,num=0;
		String s1=null;
		String ss="";

		
		num=arr.length;
		
		for(i=0;i<num;i++){
			s1=arr[i];
			
			s1 = str(s1,codeMap);
				
			if(i>0){ss=ss+"-";}
			ss=ss+s1;
			
			
			
		}
		
		
		return ss;
		
		}
	
	
	private static boolean is_long(String s){
		try{
			Long.parseLong(s);
			return true;
		}catch(Exception e){return false;}
	}
	
	public static void makeFileInfo(Map m,Map codeMap){
		    String name,time;
		    name = (String)m.get("name");
		    time = time(name);
		    
		    name = name(name);
		    m.put("name2",name);
		    name = name(name,codeMap);
		    m.put("name3",name);
		    
		    if(!f.empty(time)){m.put("time",time);}
		    //f.sop(m);
		    
	}
	
	
	public static String time(String s){
		if(f.empty(s)){return null;}
		String[]arr=s.split("-");
		int i,num=0;
		num=arr.length;
		for(i=0;i<num;i++){
			s=arr[i];
			if(is_long(s)){
				 if(s.length()==8){return s;}
            }
			
		}
		return null;
	}
	
	public static String date_str(String s)throws Exception{
		 Timestamp  time = f.time(s,null);
		 if(time==null){f.error("日期格式不正确");}
		 s = f.time(s)+"";
		 s=f.sub(s,0,10);
		 s=s.replaceAll("-","");
		 return s;
		 
		 
	}
	
	public static void list(HttpServletRequest req)throws Exception{
		String data_type = req.getParameter("data_type");
		String date1 = req.getParameter("date1");
		String date2 = req.getParameter("date2");
		int flag = 0;
		//f.sop(date1+","+date2+",1111111111");
		date1 = date_str(date1);
		date2 = date_str(date2);
		
		//f.sop(date1+","+date2+",22222222222");
		
		flag = date1.compareTo(date2);
		if(flag>0){
			f.error("开始时间不能大于结束时间");
		}
		
		
		
		
		List list = null;
		Map codeMap = null;
		list = getFileList(req);
		codeMap = getCodeMap();
		makeFileList(list,codeMap);
		list = getList(list,data_type,date1,date2);
		req.setAttribute("list",list);
		
	}
	
	public static List getList(List list,String type,String date1,String date2){
		int i,num=0;
		List list2 = new ArrayList();
		Map m = null;
		String name,time = null;
		int flag = 0;
		
		num=list.size();
		//f.sop(type+","+date1+","+date2);
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			name = (String)m.get("name");
			//f.sop(m);
			if(!f.empty(type) && !name.startsWith(type)){continue;}
			time = (String)m.get("time");
			flag = time.compareTo(date1);
			if(flag<0){continue;}
			flag = time.compareTo(date2);
			if(flag>0){continue;}
			list2.add(m);
			
		}
		return list2;
	}
	
	//20090506
	public static String getTypeOption()throws Exception{
		String s = "";
		String sql = "select * from t_tj_file_code where m_pid in ('0','water','air','sound') order by m_pid";
		List list = null;
		int i,num=0;
		Map m = null;
		String id,pid,name,v = null;
		
		list = f.query(sql,null);
		num=list.size();
		
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			id = (String)m.get("m_id");
			pid = (String)m.get("m_pid");
			name=(String)m.get("m_name");
			
			if(f.eq(pid,"0")){v=id;}else{v=pid+"-"+id;}
			
			s=s+"<option value='"+v+"'>"+name+"\n";
			
		}
		
		
		return s;
	}
	
	
	
}