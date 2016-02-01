package com.hoson.app;

import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.hoson.*;

public class AppAcl {
	// ---------------

	public static String getUserMenuTree(HttpServletRequest req)
			throws Exception {
		Connection cn = null;
		Map map = null;
		HttpSession session = req.getSession();
		String user_id = null;
		String user_name = null;
		String role_id = null;
		String resids = null;
		String sql = null;
		String js = null;
		role_id = (String) session.getAttribute("role_id");
		user_name = (String) session.getAttribute("user_name");

		if (StringUtil.isEmpty(user_name) > 0) {
			return "";
		}
		if (StringUtil.isEmpty(role_id) > 0 && !user_name.equals("admin")) {
			return "";
		}

		try {
			sql = "select res_ids from t_sys_role_resource where role_id="
					+ role_id;
			cn = DBUtil.getConn(req);
			if (user_name.equals("admin")) {
				js = AclUtil.getMenuTreeAll(cn, req);
				return js;
			}
			map = DBUtil.queryOne(cn, sql, null);
			if (map == null) {
				resids = "";
			} else {
				resids = (String) map.get("res_ids");
			}
			js = AclUtil.getMenuTree(cn, resids, req);
			return js;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}

	// -------
	public static String getMenuTreeAll(Connection cn, HttpServletRequest req)
			throws Exception {
		StringBuffer s = new StringBuffer();
		// Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "select * from t_sys_resource where is_menu=1 and  res_id>1";

		String menu_id = null;
		String menu_pid = null;
		String menu_name = null;
		String menu_url = null;
		String menu_target = null;

		int urlFlag = 0;
		String ctx = null;
		ctx = JspUtil.getContextName(req);
		try {
			// cn = DBUtil.getConn(req);
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				menu_id = rs.getString("res_id");
				menu_id = "node" + menu_id;
				menu_pid = "node" + rs.getString("res_pid");
				menu_name = rs.getString("res_name");
				menu_url = rs.getString("res_url");

				menu_target = rs.getString("res_target");
				urlFlag = StringUtil.isEmpty(menu_url);

				if (urlFlag < 1) {
					if (menu_url.startsWith("/")) {
						menu_url = "/" + ctx + menu_url;
					}

					s.append("d.add('").append(menu_id).append("','").append(
							menu_pid).append("','").append(menu_name).append(
							"',");
					s.append("'").append(menu_url).append("',")
							.append("false,").append("true").append(
									",'','','','").append(menu_target).append(
									"');\n");
				} else {
					s.append("d.add('").append(menu_id).append("','").append(
							menu_pid).append("','").append(menu_name).append(
							"',");
					s
							.append("'',")
							.append("false,")
							.append("true")
							.append(
									",'./js_tree/image/close.gif','./js_tree/image/open.gif');\n");
				}
			}// end while

			String s2 = "d = new TreeView('d','node1');\n" + s
					+ "document.write(d);\n";
			return s2;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
		}
	}

	// ------------
	public static String getMenuTreeAll(HttpServletRequest req)
			throws Exception {
		Connection cn = null;
		String s = null;
		try {
			cn = DBUtil.getConn(req);
			s = getMenuTreeAll(cn, req);
			return s;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}

	// -----------
	public static String getMenuTree(Connection cn, String resids,
			HttpServletRequest req) throws Exception {

		if (resids == null) {
			resids = "";
		}
		resids = resids.trim();
		if (resids.length() < 1) {
			resids = "666666";
		}

		StringBuffer s = new StringBuffer();
		// Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "select * from t_sys_resource where is_menu=1 and is_url=0 and res_id>1";
		sql = sql + " union ";
		sql = sql
				+ "select * from t_sys_resource where is_menu=1 and is_url=1 and res_id>1 and res_id in ("
				+ resids + ")";

		String menu_id = null;
		String menu_pid = null;
		String menu_name = null;
		String menu_url = null;
		String menu_target = null;

		int urlFlag = 0;

		String ctx = null;
		ctx = JspUtil.getContextName(req);

		try {
			// cn = DBUtil.getConn(req);
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				menu_id = rs.getString("res_id");
				menu_id = "node" + menu_id;
				menu_pid = "node" + rs.getString("res_pid");
				menu_name = rs.getString("res_name");
				menu_url = rs.getString("res_url");

				menu_target = rs.getString("res_target");
				urlFlag = StringUtil.isEmpty(menu_url);

				if (urlFlag < 1) {
					if (menu_url.startsWith("/")) {
						menu_url = "/" + ctx + menu_url;
					}
					s.append("d.add('").append(menu_id).append("','").append(
							menu_pid).append("','").append(menu_name).append(
							"',");
					s.append("'").append(menu_url).append("',")
							.append("false,").append("true").append(
									",'','','','").append(menu_target).append(
									"');\n");
				} else {
					s.append("d.add('").append(menu_id).append("','").append(
							menu_pid).append("','").append(menu_name).append(
							"',");
					s
							.append("'',")
							.append("false,")
							.append("true")
							.append(
									",'./js_tree/image/close.gif','./js_tree/image/open.gif');\n");
				}
			}// end while

			String s2 = "d = new TreeView('d','node1');\n" + s
					+ "document.write(d);\n";
			return s2;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
		}
	}

	// --------------
	// ------------
	public static String getAclTree(Connection cn, String resIds,
			HttpServletRequest req) throws Exception {
		StringBuffer s = new StringBuffer();
		// Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "select * from t_sys_resource order by res_id asc";
		String menu_id = null;
		String menu_pid = null;
		String menu_name = null;
		String checkedFlag = null;

		if (resIds == null) {
			resIds = "";
		}
		resIds = "," + resIds + ",";

		String sid = null;

		try {
			// cn = DBUtil.getConn(req);
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				menu_id = rs.getString("res_id");
				sid = "," + menu_id + ",";
				if (resIds.indexOf(sid) >= 0) {
					checkedFlag = "true";
				} else {
					checkedFlag = "false";
				}

				menu_id = "node" + menu_id;
				menu_pid = "node" + rs.getString("res_pid");
				menu_name = rs.getString("res_name");
				s.append("d.add('").append(menu_id).append("','").append(
						menu_pid).append("','").append(menu_name).append("',");
				s.append("'',").append("false,").append(checkedFlag).append(
						");\n");

			}// end while

			String s2 = "d = new TreeView('d','node0','','resids','form1',true);\n"
					+ s + "document.write(d);\n";
			return s2;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
		}
	}

	// --------------
	public static String getAclTree(String resIds, HttpServletRequest req)
			throws Exception {
		Connection cn = null;
		String s = null;
		try {
			cn = DBUtil.getConn(req);
			s = getAclTree(cn, resIds, req);
			return s;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}

	// -------------
	public static String getMenuTree(String resids, HttpServletRequest req)
			throws Exception {
		Connection cn = null;
		String s = null;
		try {
			cn = DBUtil.getConn(req);
			s = getMenuTree(cn, resids, req);
			return s;
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}

	// -----------------
	// -------------------20060504-----------updateRoleRes-----------
	// ------------
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

	// --------------
	public static void updateRoleRes(Connection cn, String role_id,
			String resids) throws Exception {
		String sqlq = "select role_id from t_sys_role_resource where role_id="
				+ role_id;
		String sqli = "insert into  t_sys_role_resource(role_id,res_ids) values("
				+ role_id + ",'" + resids + "')";
		String sqlu = "update t_sys_role_resource set res_ids='" + resids
				+ "' where role_id=" + role_id;
		Map map = null;
		try {
				map = DBUtil.queryOne(cn, sqlq, null);
				if (map == null) {
					DBUtil.update(cn, sqli, null);
				} else {
					DBUtil.update(cn, sqlu, null);
				}
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}

	// --------------
	public static void updateRoleRes(String role_id, String resids,
			HttpServletRequest req) throws Exception {
		String sqlq = "select role_id from t_sys_role_resource where role_id="
				+ role_id;
		String sqli = "insert into  t_sys_role_resource(role_id,res_ids) values("
				+ role_id + ",'" + resids + "')";
		String sqlu = "update t_sys_role_resource set res_ids='" + resids
				+ "' where role_id=" + role_id;
		Map map = null;
		Connection cn = null;
		try {
			cn = DBUtil.getConn(req);
			map = DBUtil.queryOne(cn, sqlq, null);
			if (map == null) {
				DBUtil.update(cn, sqli, null);
			} else {
				DBUtil.update(cn, sqlu, null);
			}
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
	}

	// --------------
	public static void updateRoleRes(HttpServletRequest req) throws Exception {
		String role_id = req.getParameter("role_id");
		String resids = getResIds(req);
		updateRoleRes(role_id, resids, req);
	}
	// --------------
	//-----------20060620 user res---------
	public static String getAclTreeByUserId(Connection cn, String user_id,
			HttpServletRequest req) throws Exception {
		
	String res_ids = null;
	String  sql = null;
	Map map = null;
	String js = null;
	sql = "select res_ids from t_sys_user_res where user_id='"+user_id+"' ";
		map=DBUtil.queryOne(cn,sql,null);
		if(map==null){
			res_ids = "";
			}else{
		res_ids = (String)map.get("res_ids");
			}
		if(res_ids==null){res_ids="";}
		//System.out.println("res_ids="+res_ids);
		js= getAclTree(cn,res_ids,req);
		return js;
		
	}	
//-----------------------------------
	public static String getAclTreeByUserId(String user_id,
			HttpServletRequest req) 
	throws Exception {
		
		Connection cn = null;
		try{
		cn = DBUtil.getConn();
		return getAclTreeByUserId(cn,user_id,req);
		}catch(Exception e){
			throw e;
			}finally{
				DBUtil.close(cn);
				}
	
	}	
//-----------------------------------
	public static void updateUserRes(HttpServletRequest req)
	throws Exception{
		String res_ids = null;
		String sqlq = null;
		String sqli = null;
		String sqlu = null;
		String user_id = null;
		Map map = null;
		
		user_id = req.getParameter("user_id");
		
		if(f.empty(user_id)){
			f.error("ÇëÑ¡ÔñÓÃ»§");
		}
		
		res_ids = getResIds(req);
		
		sqlq = "select user_id from t_sys_user_res where user_id='"+user_id+"' ";
		sqli = "insert into t_sys_user_res(user_id,res_ids) values('"+user_id+"','"+res_ids+"')";
		sqlu="update t_sys_user_res set user_id='"+user_id+"',res_ids='"+res_ids+"'";
		sqlu=sqlu+"where user_id='"+user_id+"'";
		map=DBUtil.queryOne(sqlq,null,req);
		if(map==null){
			DBUtil.update(sqli,null,req);
		}else{
			DBUtil.update(sqlu,null,req);
		}
		req.setAttribute("user_id",user_id);
		//f.sop("user_id="+user_id);
	}
//	-----------------------------------
	public static String getUserMenuTreeNew(HttpServletRequest req)
	throws Exception {
		String s = null;
		Connection cn = null;
		String resids = null;
		String sql = null;
		Map map = null;
		String user_name = null;
		String user_id = null;
		HttpSession session = req.getSession();
		
		try{
			user_id = (String)session.getAttribute("user_id");
			user_name = (String)session.getAttribute("user_name");
			if(StringUtil.equals(user_name,"admin")){
				
				return getMenuTreeAll(req);
			}
			
		cn = DBUtil.getConn();
		
		sql="select res_ids from t_sys_user_res where user_id='"+user_id+"' ";
		map=DBUtil.queryOne(cn,sql,null);
		if(map==null){
			return "";
		}
		resids=(String)map.get("res_ids");
		if(StringUtil.isempty(resids)){
			
			return "";
		}
		
		s = getMenuTree(cn, resids,
				 req); 
		
		
		return s;
		}catch(Exception e){
			throw e;
		}finally{
			DBUtil.close(cn);
		}
	}
	//------------------
	//--------20090313
	
	public static void user_res_view(HttpServletRequest req)throws Exception{
		
		
		
	}
	
	
	
}// end class
