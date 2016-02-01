package com.hoson.search;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.hoson.DBUtil;
import com.hoson.StringUtil;
import com.hoson.f;

public class Log {
//	Connection cn = null;
	public static void insertLog(String msg,HttpServletRequest req){
//		Date d = new Date();
		try {
//		    cn = DBUtil.getConn();
//		    cn.setAutoCommit(false);
//		    PreparedStatement ps = cn.prepareStatement("insert into t_sys_log (operation_date,user_name,memo,ip) values(?,?,?,?)");
//		    ps.setTimestamp(1,StringUtil.getTimestamp(d));
//		    ps.setString(2,username);
//		    ps.setString(3,msg);
//		    ps.setString(4,Ip);
//		    ps.executeUpdate();
//		    cn.commit();
			HttpSession session=req.getSession();
		    String t = "t_sys_sh_log";
			 String cols = "id,operation_date,user_name,memo,ip,type";
			 Map m = new HashMap();
			 String time = f.time()+"";
			 time = f.sub(time,0,19);
			 m.put("operation_date",time);
			 m.put("user_name",(String)session.getAttribute("user_name")+"");
			 m.put("memo",msg+"");
			 m.put("ip",req.getRemoteAddr()+"");
			 String type=req.getParameter("type");
			 if("".equals(type) || type==null)type=(String)req.getAttribute("type");
			 m.put("type", type);
			 f.insert(t,cols,1,m);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		finally{
//			DBUtil.close(cn);
//		}
	}
}
