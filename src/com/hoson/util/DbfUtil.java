package com.hoson.util;

import java.util.*;
import java.io.File;
import java.sql.*;
import com.hoson.app.*;
import javax.servlet.http.HttpServletRequest;

import com.hoson.*;

public class DbfUtil{
	
	static int max_dbf_num = 100;
	static String dbf_select_sql = "";
	static String dbf_cols="t,ph,do,ec,tb,imn,toc,nh3n";
	static String  emos_cols="val01,val02,val03,val04,val05,val06,val10,val07";
	static Map stationIdMap = new HashMap();
	
	static{
		
		stationIdMap.put("wfk","104");
		stationIdMap.put("wjk","330150");
		stationIdMap.put("wjh","330103");
		stationIdMap.put("wjj","330101");
		stationIdMap.put("wwj","333262");
		stationIdMap.put("wyl","102");
		stationIdMap.put("wjx","103");
		
	}
	
	
	
	private DbfUtil(){}
	

    public static void createDbfDir(HttpServletRequest req)throws Exception{
		String f = null;
		File file = null;
		String msg = null;
		
		try{
		f = JspUtil.getAppPath(req)+"WEB-INF/dbf";
		file = new File(f);
		
		if(!file.exists()){
			file.mkdir();
		}
		}catch(Exception e){
			
			msg = "创建DBF目录时出错,"+e;
			throw new Exception(msg);
		}
		
	}
    
    
    public static String getDbf(javax.servlet.ServletRequest req)throws Exception{
    	String s = "";
    	String app = JspUtil.getAppPath(req);
    	String dbf = app+"WEB-INF/dbf";
    	File f = null;
    	File f2 = null;
    	int i =0;
    	int num = 0;
    	f = new File(dbf);
    	File[]ff = f.listFiles();
    	num = ff.length;
    	for(i=0;i<num;i++){s = s + ff[i].getName()+"/";}
    	num = s.length();
    	s=s.trim();
    	if(num>0){s=s.substring(0,num-1);}
    	return s;
    	}
    
    
    public static Connection getDbfConn(HttpServletRequest req)throws Exception{
    	String app = JspUtil.getAppPath(req);
    	String driver = "com.hxtt.sql.dbf.DBFDriver";
    	String f = null;
    	String url = null;
    	String user="";
    	String pwd="";
    	if(app.indexOf("/")!=0){f = "jdbc:dbf:/";}else{f = "jdbc:dbf:///";}
    	url = f+app+"WEB-INF/dbf";

    	Connection cn = null;
    	try{
    	createDbfDir(req);
    	cn = DBUtil.getConn(driver,url,user,pwd);
    	return cn;
    	}catch(Exception e){
    		
    		throw new Exception("获取DBF数据库连接时出错 \n"+e);
    	}

    	}
    
    

    public static String getDbfInfo(HttpServletRequest req)throws Exception{
    	String s = "";
    	String app = JspUtil.getAppPath(req);
    	String dbf = app+"WEB-INF/dbf";
    	String dir = null;
    	File[]arrFile=null;
    	File file = null;
    	int i =0;
    	int num =0;
    	String name = null;
    	String name2 = null;
    	String dbf_name = null;
    	String msg = null;
    	int j =0;
    	
    	//name2 is low case,name2=name.toLowerCase()
    	
    	createDbfDir(req);
    	
    	file = new File(dbf);
    	
    	arrFile = file.listFiles();
    	num = arrFile.length;
    	for(i=0;i<num;i++){
    		file = arrFile[i];
    		name=file.getName();
    		name2=name.toLowerCase();
    		if(name2.endsWith(".dbf")){
    			//dbf_name=name.substring(0,name.length()-4);
    			j=j+1;
    			if(j>max_dbf_num){break;}
    			
    			
    			s=s+"<tr class=tr"+(j%2)+">\n";
    			s=s+"<td>"+j+"</td><td>"+name+"</td><td>"+file.lastModified()+"</tr>";
    			s=s+"<td>"+"<input type=button value='查看' onclick=f_view('"+name+"') class=btn> </td>";
    			s=s+"<td>"+"<input type=button value='导入' onclick=f_import('"+name+"') class=btn> </td>";
    			s=s+"<td>"+"<input type=button value='删除' onclick=f_del('"+name+"') class=btn> </td>";
    			s=s+"\n</tr>\n";
    			
    		}
    		
    	}
    	req.setAttribute("num",num+"");
    	req.setAttribute("max",max_dbf_num+"");
    	return s;
    	}
    
    public static void delDbfFile(HttpServletRequest req,
    		String dbf){
    	
    	File file = null;
    	
    	
    	  try{ 	
    	dbf =  JspUtil.getAppPath(req)+"WEB-INF/dbf/"+dbf;
    	file = new File(dbf);
    	file.delete();
    	  }catch(Exception e){
    		  
    		  
    	  }
    	
    }
    
    
    public static List getDataList(Connection cn,String dbf)
    throws Exception{
    	
    	List list = null;
    	String sql = "";
    	
    	
    	return list;
    }
    
    
    public static int dataImport(HttpServletRequest req,String dbf)
    throws Exception{
    	
    	List list = null;
    	int i =0;
    	int num =0;
    	String station_id = null;
    	String m_time = null;
    	String msg = null;
    	Connection cn = null;
    	Connection cn_dbf = null;
    	Map map = null;
    	String sqlq = null;
        int j =0;
        
    	
    	
    	String table = "t_monitor_real_hour";
    	String cols = "station_id,m_time,"+emos_cols;
    	
    	try{
    	
    	
    	sqlq = getDbfQuerySql(dbf);
    	
    	//System.out.println(sqlq);
    	
    	cn = DBUtil.getConn();
    	cn_dbf=DbfUtil.getDbfConn(req);
    	
    	try{
    	list = DBUtil.query(cn_dbf,sqlq,null);
    	}catch(Exception e){
    		msg = "数据文件格式不正确,读取数据时发生错误 \n"+e;
    		throw new Exception(msg);
    	}
    	
    	num = list.size();
    	
    	for(i=0;i<num;i++){
    		
    		map = (Map)list.get(i);
    		//System.out.println(map);
    		try{
    		DBUtil.insert(cn,table,cols,0,map);
    		j=j+1;
    		}catch(Exception e){}
    		
    		
    	}
    	
    	
    	return j;
    	
    	}catch(Exception ee){
    		
    		throw ee;
    	}finally{
    		DBUtil.close(cn);
    		DBUtil.close(cn_dbf);
    	}
    	
    }
    
    public static Map getColMap(String dbf,String emos)
    throws Exception{
    	Map map = new HashMap();
    	
    	if(StringUtil.isempty(dbf)||StringUtil.isempty(emos)){
    		
    		throw new Exception("数据列为空");
    	}
    	
    	String[]dbfArr=dbf.split(",");
    	String[]emosArr=emos.split(",");
    	int i =0;
    	int num =0;
    	
    	num = dbfArr.length;
    	if(num!=emosArr.length){
    		
    		throw new Exception("数据列数量不匹配");
    	}
    	
    	
    	
    	
    	return map;    	   	
    }
    
    public static String getDbfQuerySql(String dbf)
    throws Exception{
    	
    	String s = "";
    	String dbf2 = null;
    	String msg = null;
    	String station_id = null;
    	
    	
    	if(dbf==null){dbf="";}
    	dbf2=dbf.toLowerCase();
    	
    	
    	if(dbf2.length()<8 || !dbf2.endsWith(".dbf")){
    		
    		msg = "DBF数据文件名格式不正确";
    		throw new Exception(msg);
    	}
    	
    	
        station_id = dbf.substring(0,3);
    	
    	station_id = (String)stationIdMap.get(station_id);
    	
    	if(station_id==null){
    		
    		msg = "站位编号与数据文件名不匹配";
    		throw new Exception(msg);
    	}
    	
    	
    	
    	dbf = dbf.substring(0,dbf.length()-4);
if(StringUtil.isempty(dbf_cols)||StringUtil.isempty(emos_cols)){
    		
    		throw new Exception("数据列为空");
    	}
    	
    	String[]dbfArr=dbf_cols.split(",");
    	String[]emosArr=emos_cols.split(",");
    	int i =0;
    	int num =0;
    	
    	num = dbfArr.length;
    	if(num!=emosArr.length){
    		
    		throw new Exception("数据列数量不匹配");
    	}
    	
    	
    	s=s+"select "+station_id +" as station_id,";
    	s=s+"yyyy+'-'+mm+'-'+dd as m_time,";
    	
    	for(i=0;i<num;i++){
    		
    		s=s+dbfArr[i]+" as "+emosArr[i]+",";
    		
    	}
    	s=s+"0 as check_flag ";
    	s=s+" from "+dbf;
    	
    	return s;
    }
    
    
    
	
}