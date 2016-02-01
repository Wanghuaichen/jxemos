package com.hoson.util;

import java.util.*;
import com.hoson.f;
import javax.servlet.http.*;
import com.hoson.JspUtil;
import com.hoson.FileUtil;
import java.sql.*;


public class DBUpdateUtil{
	
	public static void run(HttpServletRequest req)throws Exception{
		String file = null;
		String sqls = null;
		String sql = null;
		List list = new ArrayList();
		String[]arr=null;
		int i,num=0;
		String msg = null;
		int rnum=0;
		Connection cn = null;
		Map m = null;
		
		try{
		file = JspUtil.getAppPath(req)+"WEB-INF/doc/sql_update.txt";
		sqls = FileUtil.readFromFile(file);
		if(f.empty(sqls)){f.error("sql is empty");}
		arr = sqls.split(";");
		num=arr.length;
		
		cn = f.getConn();
		for(i=0;i<num;i++){
			sql = arr[i];
			msg="";
			if(f.empty(sql)){continue;}
			try{
			rnum=f.update(cn,sql,null);
			}catch(Exception ee){
				msg=ee+"";
			}
			m = new HashMap();
			m.put("sql",sql);
			m.put("num",rnum+"");
			m.put("msg",msg);
			list.add(m);
			
			
		}
		
		
		
		req.setAttribute("file",file);
		req.setAttribute("list",list);
		req.setAttribute("time",f.time());
		
		
		}catch(Exception e){
			throw e;
		}finally{f.close(cn);}
		
		
	}
	
	
	
}

