package com.hoson.util;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.hoson.zdxupdate.zdxUpdate;

import com.hoson.XBean;
import com.hoson.f;





public class Login{
	 public static void saveCookie(HttpServletRequest req,
			  HttpServletResponse res,
			  String user_name,String user_pwd)
			   throws Exception{
			   
			   String flag = req.getParameter("save_pwd_flag");
			   if(f.eq(flag,"1")){
			   
			   Cookie c = null;
			   
			   c = new Cookie("user_name",user_name);
			   c.setMaxAge(10*24*60*60); 
			   res.addCookie(c); 
			   /*
			   c = new Cookie("user_pwd",user_pwd);
			     c.setMaxAge(10*24*60*60); 
			   res.addCookie(c);
			   */
			   }
			   
			   
			   }
	 public static int login(HttpServletRequest req,HttpServletResponse res)throws Exception{
		 
			 String user_name = null;
				String user_id = null;
				String user_pwd = null;
				String sql = null;
				Map map = null;
				Map model;
				XBean b = null;
			
				String msg = null;
				String res_ids = null;

				String zh_user_name,zh_user_pwd;
				HttpSession session=req.getSession();
				String view_all_station = "0";
				
				model = f.model(req);
				b = new XBean(model);
				
				user_id = b.get("user_id");
				user_name = b.get("user_name");
//			    user_pwd = b.get("user_pwd");
//			    
//			    
//			    zh_user_name = (String)req.getAttribute("zh_user_name");
//			    zh_user_pwd = (String)req.getAttribute("zh_user_pwd");
//			    
//			    if(!f.empty(zh_user_name)){
//			    	user_name=zh_user_name;
//			    	view_all_station="1";
//			    }
//			    if(!f.empty(zh_user_pwd)){user_pwd=zh_user_pwd;}
			    if(user_name==null||user_name.equals("null")){
			    	msg = "用户名不能为空！";
			    	req.setAttribute("msg", msg);
				    return 0;
			    }
//			    sql="select * from t_sys_user where user_name=?";
//			
//			    Object[]p=new Object[]{user_name};
//			    map=f.queryOne(sql,p);
//			    if(map==null){
//			    	msg = "用户名密码不正确";
//					req.setAttribute("msg", msg);
//			    return 0;
//			
//			    }
//			    user_id=(String)map.get("user_id");
//			    String yw_role = (String)map.get("yw_role");
//			    String area_id = (String)map.get("area_id");
//			    sql="delete from t_sys_ures where user_id not in ";
//			    sql=sql+"(select user_id from t_sys_user)";
//			    f.update(sql,null);
//			   
//			    
//			    sql="select res_ids from t_sys_ures where user_id='"+user_id+"'";
//			    map=f.queryOne(sql,null);
//			    if(map==null){
//			    res_ids="";
//			    }else{
//			    res_ids=(String)map.get("res_ids");
//			    }
//			    session.setAttribute("user_id",user_id);
			    String session_id = b.get("session_id");
				session.setAttribute("session_id",session_id);
			    session.setAttribute("user_name",user_name);
			    
			    //查询区域id
			    String area_id = zdxUpdate.getAearID(user_name, session_id);
			    
			    session.setAttribute("area_id", area_id);
//			    session.setAttribute("view_all_station",view_all_station);
//			    session.setAttribute("yw_role",yw_role);
//			    session.setAttribute("area_id",area_id);
			    
			    //SysAclUtil.setUserRes(user_name,res_ids);
			    //SysAclUtil.setUserStation(user_id);
			    return 1;
		 }
	 public static int wwlogin(HttpServletRequest req,HttpServletResponse res)throws Exception{
		 
		 String user_name = null;
			String user_id = null;
			String user_pwd = null;
			String sql = null;
			Map map = null;
			Map model;
			XBean b = null;
		
			String msg = null;

			HttpSession session=req.getSession();
			
			model = f.model(req);
			b = new XBean(model);
			
			user_id = b.get("user_id");
			user_name = b.get("user_name");
		    user_pwd = b.get("user_pwd");
		    
		    if(user_name==null||user_name.equals("null")){
		    	msg = "用户名不能为空！";
		    	req.setAttribute("msg", msg);
			    return 0;
		    }
		    sql="select * from t_sys_ww_user where user_name=? and user_pwd=?";
		
		    Object[]p=new Object[]{user_name,user_pwd};
		    map=f.queryOne(sql,p);
		    if(map==null){
		    	msg = "用户名密码不正确";
				req.setAttribute("msg", msg);
		    return 0;
		    }
		    session.setAttribute("user_id",(String)map.get("user_id"));
		    session.setAttribute("user_name",user_name);
		    return 1;
	 }	
	 
//	 public static int login(HttpServletRequest req, HttpServletResponse res)
//		throws Exception
//	{
//		String user_name = null;
//		String user_id = null;
//		String user_pwd = null;
//		String sql = null;
//		Map map = null;
//		XBean b = null;
//		String msg = null;
//		String res_ids = null;
//		String station_ids = null;
//		HttpSession session = req.getSession();
//		String view_all_station = "0";
//		Map model = f.model(req);
//		b = new XBean(model);
//		user_id = b.get("user_id");
//		user_name = b.get("user_name");
//		user_pwd = b.get("user_pwd");
//		String zh_user_name = (String)req.getAttribute("zh_user_name");
//		String zh_user_pwd = (String)req.getAttribute("zh_user_pwd");
//		if (!f.empty(zh_user_name))
//		{
//			user_name = zh_user_name;
//			view_all_station = "1";
//		}
//		if (!f.empty(zh_user_pwd))
//			user_pwd = zh_user_pwd;
//		String md5 = f.cfg("md5", "0");
//		if (f.eq(md5, "1"))
//			user_pwd = f.md5(user_pwd);
//		sql = "select * from t_sys_user where user_name=? and user_pwd=?";
//		Object p[] = {
//			user_name, user_pwd
//		};
//		map = f.queryOne(sql, p);
//		if (map == null)
//		{
//			msg = "用户名密码不正确";
//			req.setAttribute("msg", msg);
//			return 0;
//		}
//		user_id = (String)map.get("user_id");
//		String yw_role = (String)map.get("yw_role");
//	    String area_id = (String)map.get("area_id");
//		sql = "delete from t_sys_ures where user_id not in ";
//		sql = sql + "(select user_id from t_sys_user)";
//		f.update(sql, null);
//		sql = "select res_ids from t_sys_ures where user_id='" + user_id + "'";
//		map = f.queryOne(sql, null);
//		if (map == null)
//			res_ids = "";
//		else
//			res_ids = (String)map.get("res_ids");
//		session.setAttribute("user_id", user_id);
//		session.setAttribute("user_name", user_name);
//		session.setAttribute("view_all_station", view_all_station);
//		session.setAttribute("yw_role",yw_role);
//	    session.setAttribute("area_id",area_id);
//		SysAclUtil.setUserRes(user_id, res_ids);
//		SysAclUtil.setUserStation(user_id);
//		return 1;
//	}
	
}