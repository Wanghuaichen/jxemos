package com.hoson.action;

import java.io.*;
import java.sql.*;
import java.util.*;
import com.hoson.*;
import com.hoson.util.*;

public class DataImportAction extends BaseAction{
	
	
	public String execute()throws Exception{
		
		if(StringUtil.equals(method,"create_dbf_dir")){
			
			return execute_create_dbf_dir();
		}
		

		if(StringUtil.equals(method,"get_dbf")){
			
			return execute_get_dbf();
		}
		

		if(StringUtil.equals(method,"del")){
			
			return execute_del();
		}
		


		if(StringUtil.equals(method,"view_dbf")){
			
			return execute_view_dbf();
		}
		

		if(StringUtil.equals(method,"import")){
			
			return execute_import();
		}
		
		return null;
	}
	
	
	public String execute_input()throws Exception{
		
		String stationTypeOption = null;
		String areaOption = null;
		conn = DBUtil.getConn();
		stationTypeOption = JspPageUtil.getStationTypeOption("",request);
		areaOption = JspPageUtil.getTopAreaOption(conn,"");
		model.put("stationTypeOption",stationTypeOption);
		model.put("areaOption",areaOption);
		
		
		return null;
	}
	
	

	public String execute_query()throws Exception{
		
		return null;
	}
	
	public String execute_get_dbf()throws Exception{
		String data = null;
		
		data = DbfUtil.getDbfInfo(request);
		model.put("data",data);
		
		
		return null;
	}
	
	

	public String execute_view_dbf()throws Exception{
		
		String sql = "select yyyy,mm,dd,t,ph,do,ec,tb,imn,toc,nh3n ";
		String dbf = (String)model.get("dbf");
		String[]arr=null;
		String msg = null;
		String data = null;
		String bar = null;
		dbf = dbf.substring(0,dbf.length()-4);
		
		sql =sql+" from "+dbf;
		conn = DbfUtil.getDbfConn(request);
		
		try{
		//arr=PagedUtil.query(conn,sql,1,request,0);
		data=PagedUtil.queryNoPaging(conn,sql);
		}catch(Exception e){
			
			msg = "数据格式不对,读取数据时发生错误 \n"+e;
			throw new Exception(msg);
		}
		model.put("data",data);
		model.put("bar",bar);
		
		return null;
	}
	

	public String execute_import()throws Exception{
		int num = 0;
		
		String dbf = null;
		dbf = (String)model.get("dbf");
		num = DbfUtil.dataImport(request,dbf);
		model.put("num",num+"");
		return null;
	}
	
    public String execute_create_dbf_dir()throws Exception{
		
    	createDbfDir();
    	
		return null;
	}

	public String execute_upload()throws Exception{
		
		return null;
	}
	
    public String execute_del()throws Exception{
		String dbf = request.getParameter("dbf");
    	DbfUtil.delDbfFile(request,dbf);
    	
		return "get_dbf_list.jsp";
	}
	
	
	
    void createDbfDir()throws Exception{
		String f = null;
		File file = null;
		String msg = null;
		
		try{
		f = JspUtil.getAppPath(request)+"WEB-INF/dbf";
		file = new File(f);
		
		if(!file.exists()){
			file.mkdir();
		}
		}catch(Exception e){
			
			msg = "创建DBF目录时出错,"+e;
			throw new Exception(msg);
		}
		
	}
	
	
	
	public  String getHide()throws Exception{
		
		String cols = "station_id,infectant_id,starth,endh,date1,date2";
		return JspUtil.getHiddenHtml(cols,request);
	}
	
	
}