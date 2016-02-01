package com.hoson.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.hoson.f;

//20090327 新的权限控制工具类 

public class SysAclUtil{
	
	private static Map user_res_map = new HashMap();
	private static Map acl_map = null;
	private static Map user_station_map = new HashMap();
	private static String no_acl_key = "no_acl_key_0123456789";
	private static String res_name_key = "sys_acl_res_name_key_0123456789";
	private static String acl_alert_flag_key = "acl_alert_flag";

	
	public static void acl_map_reset(HttpServletRequest req){
		//req.setAttribute(no_acl_key,"1");
		//return req.getParameter(acl_alert_flag_key);
		acl_map=null;
		
	}
	
	
	
	public static String getAclAlertFlag(HttpServletRequest req){
		//req.setAttribute(no_acl_key,"1");
		return req.getParameter(acl_alert_flag_key);
		
		
	}
	
	public static void setResName(HttpServletRequest req,String res_name){
		//req.setAttribute(no_acl_key,"1");
		if(f.empty(res_name)){return;}
		req.setAttribute(res_name_key,res_name);
		
	}
	
	public static String getResName(HttpServletRequest req){
		//req.setAttribute(no_acl_key,"1");
		//if(f.empty(res_name)){return;}
		return (String)req.getAttribute(res_name_key);
		
	}
	
	
	
	public static void setNoAcl(HttpServletRequest req){
		req.setAttribute(no_acl_key,"1");
	}
	public static String getNoAclFlag(HttpServletRequest req){
		String s = (String)req.getAttribute(no_acl_key);
		return s;
	}
	public static void setUserRes(String user_name,String res_ids){
		if(f.empty(user_name)){return;}
		if(f.empty(res_ids)){return;}
		res_ids = ","+res_ids+",";
		//f.sop("res_ids="+res_ids);
		
		user_res_map.put(user_name,res_ids);
		
	}
	
	public static void setUserStation(String user_id)throws Exception{
		if(f.empty(user_id)){return;}
		String ids;
		ids = getUserStationIds(user_id);
		
		if(f.empty(ids)){return;}
		ids=","+ids+",";
		//f.sop("station_ids="+ids);
		user_station_map.put(user_id,ids);
		
	}
	
	public static List getAclList()throws Exception{
		List list=null;
		String sql=null;
		
		sql = "select * from t_sys_res_new ";
		list = f.query(sql,null);
		
		return list;		
	}
	
	
	private  synchronized  static Map getAclMap_()throws Exception{
				List list;
				int i,num=0;
				Map m = null;
				Map map = new HashMap();
				String res_url = null;
				
				list = getAclList();
				num = list.size();
				//f.sop("acl size="+num);
				for(i=0;i<num;i++){
					m = (Map)list.get(i);
					//f.sop("acl size="+num);
					res_url = (String)m.get("res_url");
					//f.sop("res_url="+res_url);
					if(f.empty(res_url)){continue;}
					map.put(res_url,m);
					
				}
				return map;
	}
	
	
	
	public  static Map getAclMap()throws Exception{
		if(acl_map!=null){return acl_map;}
		acl_map = getAclMap_();
		return acl_map;
		
	}
	
	public static void user_res_view(HttpServletRequest req) throws Exception {
		String user_id = req.getParameter("objectid");
		String sql = "select user_name from t_sys_user where  user_id=?";
		String msg = null;
		String user_name;
		List<?> list = null;
		String res_ids = null;
		String page_url = null;
		Map<?, ?> map = null;

		if (f.empty(user_id)) {
			f.error("请选择用户");
		}
		map = f.queryOne(sql, new Object[] { user_id });
		if (map == null) {
			// out.println("指定的记录不存在 objectid="+user_id);
			msg = "指定的记录不存在 objectid=" + user_id;
			f.error(msg);
		}

		user_name = (String) map.get("user_name");
		if (f.eq(user_name, "admin")) {
			msg = "用户admin拥有所有权限,不需要进行任何配置";
			f.error(msg);
		}

		sql = "select * from t_sys_res_new order by res_order";
		list = f.query(sql, null);

		sql = "select * from t_sys_ures where user_id='" + user_id + "'";
		map = f.queryOne(sql, null);
		if (map != null) {
			res_ids = (String) map.get("res_ids");
			page_url = (String) map.get("page_url");
		}
		if (res_ids == null) {
			res_ids = "";
		}
		if (page_url == null) {
			page_url = "";
		}

		res_ids = "," + res_ids + ",";

		req.setAttribute("user_id", user_id);
		req.setAttribute("res_ids", res_ids);
		req.setAttribute("page_url", page_url);
		req.setAttribute("list", list);
	}
	
	public static void user_res_update(HttpServletRequest req) throws Exception {
		String res_ids = null;
		String sqlq = null;
		String sqli = null;
		String sqlu = null;
		String user_id = null;
		Map<?, ?> map = null;

		user_id = req.getParameter("user_id");

		if (f.empty(user_id)) {
			f.error("请选择用户");
		}

		res_ids = getResIds(req);

		sqlq = "select user_id from t_sys_ures where user_id='" + user_id
				+ "' ;";
		sqli = "insert into t_sys_ures(user_id,res_ids) values('" + user_id
				+ "','" + res_ids + "') ;";
		sqlu = "update t_sys_ures set user_id='" + user_id + "',res_ids='"
				+ res_ids + "' ";
		sqlu = sqlu + "where user_id='" + user_id + "' ;";
		map = f.queryOne(sqlq, null);
		if (map == null) {
			f.update(sqli, null);
		} else {
			f.update(sqlu, null);
		}
		req.setAttribute("user_id", user_id);
		// f.sop("user_id="+user_id);
	}
	
	public static void user_page_update(HttpServletRequest req)
			throws Exception {
		String page_url = null;
		String sqlq = null;
		String sqli = null;
		String sqlu = null;
		String user_id = null;
		Map<?, ?> map = null;

		user_id = req.getParameter("user_id");

		if (f.empty(user_id)) {
			f.error("请选择用户");
		}

		page_url = req.getParameter("page_url");

		sqlq = "select user_id from t_sys_ures where user_id='" + user_id
				+ "' ;";
		sqli = "insert into t_sys_ures(user_id,page_url) values('" + user_id
				+ "','" + page_url + "') ;";
		sqlu = "update t_sys_ures set user_id='" + user_id + "',page_url='"
				+ page_url + "' ";
		sqlu = sqlu + "where user_id='" + user_id + "' ;";
		map = f.queryOne(sqlq, null);
		if (map == null) {
			f.update(sqli, null);
		} else {
			f.update(sqlu, null);
		}
		req.setAttribute("user_id", user_id);
		// f.sop("user_id="+user_id);
	}
	
	public static String getResIds(HttpServletRequest req) throws Exception {
		String s = "";
		String[] arrId = null;
		String id = null;
		arrId = req.getParameterValues("resids");
		if (arrId == null) {
			return "";
		}
		int i = 0;
		int num = 0;
		int flag = 0;
		// int len =0;
		num = arrId.length;
		flag = num - 1;
		for (i = 0; i < num; i++) {
			id = arrId[i];
			//id = id.substring(4);
			if (i < flag) {
				s = s + id + ",";
			} else {
				s = s + id;
			}
		}
		return s;
	}

	
	public static String getUserStationIds(String user_id)throws Exception{
		if(f.empty(user_id)){return "";}
		List list;
		String sql = "select station_id from t_sys_user_station where user_id='"+user_id+"'";
		StringBuffer sb = new StringBuffer();
		int i,num=0;
		Map m = null;
		list = f.query(sql,null);
		num=list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			sb.append(m.get("station_id")).append(",");
		}
		return sb.toString();
		
	}
	
	public static int check(HttpServletRequest req,HttpSession session)throws Exception{
		String flag = getNoAclFlag(req);
		if(f.eq(flag,"1")){return 0;}
		String user_name = (String)session.getAttribute("user_name");
		if(f.eq(user_name,"admin")){return 0;}
		//String url = req.getRequestURL().toString();
		String url = req.getServletPath();
		//f.sop(url);
		String url2 = null;
		Map m,m2;
		int pos=0;
		Map m_acl_map = getAclMap();
		String user_id = null;
	    String res_ids = null;
		boolean b =false;
		
		pos = url.lastIndexOf("/");
		if(pos<0){throw new Exception("URL格式错误,url="+url);}
		pos=pos+1;
		url2=url.substring(0,pos); 

		//f.sop(url+","+url2);
		
		m = (Map)m_acl_map.get(url);
		
		
		m2 = (Map)m_acl_map.get(url2);
		
		
		
		//f.sop("acl_map="+m_acl_map);
		//f.sop(m+","+m2+",-----");
		if(m==null &&m2==null){return 0;}
		
		if(acl_flag_is_0(m)){return 0;}
		if(acl_flag_is_0(m2)){return 0;}
		
		
		
		
//		user_id = (String)session.getAttribute("user_id");
//		
//		if(f.empty(user_id)){
//			//ErrorMsg.no_login();
//			return 1;
//		}
		
		res_ids = (String)user_res_map.get(user_name);
		
		String res_name = getResName(m,m2);
		setResName(req,res_name);
		b = has_acl(m,m2,res_ids);
		if(b==false){return 2;}
		//f.sop("res_name="+res_name);
		
		//req.setAttribute("sys_acl_res_name",res_name);
		
		return 3;
		
		
	}
	
	public static boolean acl_flag_is_0(Map m){
		
		String flag=null;
		if(m!=null){flag=(String)m.get("flag_acl");}
		if(f.eq(flag,"0")){return true;}
		
		
		return false;
	}
	
	public static String getResName(Map m,Map m2){
		if(m!=null){return (String)m.get("res_name");}
		if(m2!=null){return (String)m2.get("res_name");}
		return "";
	}
	
	public static boolean has_acl(Map m,Map m2,String res_ids){
		if(f.empty(res_ids)){return false;}
		String res_id = null;
		if(m!=null){
			res_id = (String)m.get("res_id");
			if(res_id==null){res_ids=",null,";}
			if(res_ids.indexOf(res_id)>=0){return true;}
		}
		
		
		if(m2!=null){
			res_id = (String)m2.get("res_id");
			if(res_id==null){res_ids=",null,";}
			if(res_ids.indexOf(res_id)>=0){return true;}
		}
		
		
		return false;
	}
	
	
}