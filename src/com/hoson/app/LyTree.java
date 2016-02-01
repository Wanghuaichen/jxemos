package com.hoson.app;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.*;

import javax.servlet.http.HttpServletRequest;

import com.hoson.DBUtil;
import com.hoson.JspUtil;
import com.hoson.StringUtil;
import com.hoson.util.DataAclUtil;

public class LyTree {

	// --------------------
	public static String getAreaTree(String station_type, HttpServletRequest req)
			throws Exception {
		StringBuffer s = new StringBuffer();

		Statement stmt = null;
		ResultSet rs = null;
		String sql = "select * from t_cfg_valley ";
		sql = sql + "where valley_id in(select parent_id from t_cfg_valley) ";
		sql = sql
				+ "or valley_id in(select valley_id from t_cfg_station_info where station_type='"
				+ station_type + "') ";
		sql = sql + "order by valley_id asc";

		String menu_id = null;
		String menu_pid = null;
		String menu_name = null;
		Connection cn = null;
		try {
			cn = DBUtil.getConn(req);
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				menu_id = rs.getString("valley_id");
				menu_id = "node" + menu_id;
				menu_pid = "node" + rs.getString("parent_id");
				menu_name = rs.getString("valley_name");

				s.append("d.add('").append(menu_id).append("','").append(
						menu_pid).append("','").append(menu_name).append("',");
				s
						.append("'',")
						.append("false,")
						.append("false")
						.append(
								",'./js_tree/image/close.gif','./js_tree/image/open.gif');\n");

			}// end while

			// String s2 = "d = new
			// TreeView('d','node0');\n"+s+"document.write(d);\n";
			return s.toString();
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs, stmt, cn);
		}
	}

	// ------------------------------------

	public static String getSiteTree(String station_type, String url,
			String target, HttpServletRequest req) throws Exception {
		StringBuffer s = new StringBuffer();
		Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "select station_id,valley_id,station_desc from t_cfg_station_info where station_type='"
				+ station_type + "'";
		

		sql = sql+DataAclUtil.getStationIdInString(req,station_type,"station_id");
			

		String menu_id = null;
		String menu_pid = null;
		String menu_name = null;
		String menu_url = null;
		String menu_target = null;
		String station_id = null;
		String ctx = null;
		ctx = JspUtil.getContextName(req);

		menu_target = target;

		Map dataMap = null;
		String dataSql = null;
		String dateNow = StringUtil.getNowDate() + "";
		dataSql = "select station_id,count(*) as row_num from t_monitor_real_hour ";
		dataSql = dataSql + " where m_time>='" + dateNow + "' ";
		dataSql = dataSql + "and station_id in (";
		dataSql = dataSql
				+ "select station_id from t_cfg_station_info where station_type='"
				+ station_type + "'";
		dataSql = dataSql + ") ";
		dataSql = dataSql + "group by station_id";

        
        dataSql = "select station_id,count(1) as row_num from v_view_hour group by station_id ";
        

		// System.out.println(dataSql);

		String row_num = null;

		try {
			cn = DBUtil.getConn(req);

			//dataMap = DBUtil.getMap(cn, dataSql);
			dataMap = new HashMap();

			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				station_id = rs.getString("station_id");

				menu_id = "site" + station_id;
				menu_pid = "node" + rs.getString("valley_id");
				menu_name = rs.getString("station_desc");
				if (menu_name == null) {
					menu_name = "";
				}
				menu_name = menu_name.trim();

				row_num = (String) dataMap.get(station_id);

				if (StringUtil.isempty(row_num)) {

					menu_name = "<font class=no_data>" + menu_name + "</font>";
				}

				menu_url = url + "?station_id=" + station_id + "&flag=1";

				s.append("d.add('").append(menu_id).append("','").append(
						menu_pid).append("','").append(menu_name).append("',");
				s.append("'").append(menu_url).append("',").append("false,")
						.append("true").append(",'','','','").append(
								menu_target).append("');\n");

			}
			return s.toString();
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
			DBUtil.close(cn);
		}

	}

	public static String getSiteTreeSP(String station_type, String url,
			String target, HttpServletRequest req) throws Exception {
		StringBuffer s = new StringBuffer();
		Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "select station_id,valley_id,station_desc from t_cfg_station_info where station_type='"
				+ station_type + "'";

		String menu_id = null;
		String menu_pid = null;
		String menu_name = null;
		String menu_url = null;
		String menu_target = null;
		String station_id = null;
		String ctx = null;
		ctx = JspUtil.getContextName(req);

		menu_target = target;

		Map dataMap = null;
		String dataSql = null;
		String dateNow = StringUtil.getNowDate() + "";
		dataSql = "select station_id,count(*) as row_num from t_monitor_real_hour ";
		dataSql = dataSql + " where m_time>='" + dateNow + "' ";
		dataSql = dataSql + "and station_id in (";
		dataSql = dataSql
				+ "select station_id from t_cfg_station_info where station_type='"
				+ station_type + "'";
		dataSql = dataSql + ") ";
		dataSql = dataSql + "group by station_id";

		  
        dataSql = "select station_id,count(1) as row_num from v_view_hour group by station_id ";
        

		// System.out.println(dataSql);

		String row_num = null;

		try {
			cn = DBUtil.getConn(req);

			dataMap = DBUtil.getMap(cn, dataSql);

			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				station_id = rs.getString("station_id");

				menu_id = "site" + station_id;
				menu_pid = "node" + rs.getString("valley_id");
				menu_name = rs.getString("station_desc");
				if (menu_name == null) {
					menu_name = "";
				}
				menu_name = menu_name.trim();

				row_num = (String) dataMap.get(station_id);

				if (StringUtil.isempty(row_num)) {

					menu_name = "<font color=red>" + menu_name + "</font>";
				}

				menu_url = url;

				s.append("d.add('").append(menu_id).append("','").append(
						menu_pid).append("','").append(menu_name).append("',");
				s.append("'").append(menu_url).append("',").append("false,")
						.append("false").append(",'','','','").append(
								menu_target).append("');\n");

			}
			return s.toString();
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
			DBUtil.close(cn);
		}
	}

	public static String getChannelTree(String station_type, String url,
			String target, HttpServletRequest req, String strUserID,
			String strPwd, String port) throws Exception {
		StringBuffer s = new StringBuffer();
		Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "select station_id,area_id,station_desc,station_ip,* from t_cfg_station_info where station_type='"
				+ station_type + "' and length(station_ip) > 0";

		String menu_id = null;
		String menu_pid = null;
		String menu_name = null;
		String menu_url = null;
		String menu_target = null;
		String station_id = null;
		String strStation_ip = null;
		String ctx = null;
		ctx = JspUtil.getContextName(req);
		Map dataMap = null;
		String dataSql = null;
		String dateNow = StringUtil.getNowDate() + "";

		menu_target = "";
		String row_num = null;
		try {
			cn = DBUtil.getConn(req);
			dataMap = DBUtil.getMap(cn, dataSql);

			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);
			int iCount = 1;
			while (rs.next()) {
				station_id = rs.getString("station_id");
				strStation_ip = rs.getString("station_ip");

				menu_id = station_id + "channel" + String.valueOf(iCount);
				menu_pid = "site" + rs.getString("station_id");

				menu_name = rs.getString("station_desc");
				row_num = (String) dataMap.get(station_id);
				/*
				 * if(!StringUtil.isempty(row_num)){
				 * 
				 * menu_name="<font color=red>"+menu_name+"</font>"; }
				 */

				if (StringUtil.isempty(row_num)) {

					menu_name = "<font color=red>" + menu_name + "</font>";
				}

				if (menu_name == null) {
					menu_name = "";
				}
				menu_name = menu_name.trim();

				String strNode1 = "d.add2('" + menu_id + "','" + menu_pid
						+ "','1','#','" + strStation_ip + "," + port + ",1,0,"
						+ strUserID + "," + strPwd
						+ ",101,',false,true,'','','','');";
				String strNode2 = "d.add2('" + menu_id + "','" + menu_pid
						+ "','2','#','" + strStation_ip + "," + port + ",2,0,"
						+ strUserID + "," + strPwd
						+ ",101,',false,true,'','','','');";
				String strNode3 = "d.add2('" + menu_id + "','" + menu_pid
						+ "','3','#','" + strStation_ip + "," + port + ",3,0,"
						+ strUserID + "," + strPwd
						+ ",101,',false,true,'','','','');";

				s.append(strNode1).append(strNode2).append(strNode3);
				iCount++;

			}
			return s.toString();
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
			DBUtil.close(cn);
		}
	}

	// --------------------------
	public static String getAreaAndSiteTreeSP(String station_type, String url,
			String target, HttpServletRequest req, String strUserID,
			String strPwd, String port) throws Exception {
		String s = null;
		s = getAreaTree(station_type, req)
				+ getSiteTreeSP(station_type, url, target, req)
				+ getChannelTree(station_type, url, target, req, strUserID,
						strPwd, port);
		// s = getAreaTree(req);
		s = "d = new TreeView('d','node0');\n" + s + "document.write(d);\n";
		return s;
	}

	// --------------------------
	public static String getAreaAndSiteTree(String station_type, String url,
			String target, HttpServletRequest req) throws Exception {
		String s = null;
		s = getAreaTree(station_type, req)
				+ getSiteTree(station_type, url, target, req);
		// s = getAreaTree(req);
		s = "d = new TreeView('d','node0');\n" + s + "document.write(d);\n";
		return s;
	}

	// ----------------------
	// ---------------------site tree with checkbox--

	public static String getSiteTreeWithCheckBox(String station_type,
			HttpServletRequest req) throws Exception {
		StringBuffer s = new StringBuffer();
		Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "select station_id,valley_id,station_desc from t_cfg_station_info where station_type='"
				+ station_type + "'";
		

		sql = sql+DataAclUtil.getStationIdInString(req,station_type,"station_id");
			

		String menu_id = null;
		String menu_pid = null;
		String menu_name = null;

		String station_id = null;

		try {
			cn = DBUtil.getConn(req);
			stmt = cn.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				station_id = rs.getString("station_id");

				menu_id = "site" + station_id;
				menu_pid = "node" + rs.getString("valley_id");
				menu_name = rs.getString("station_desc");
				if (menu_name == null) {
					menu_name = "";
				}
				menu_name = menu_name.trim();

				s.append("d.add('").append(menu_id).append("','").append(
						menu_pid).append("','").append(menu_name).append("',");
				s.append("'',").append("false,").append(false).append(");\n");

			}
			return s.toString();
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs);
			DBUtil.close(stmt);
			DBUtil.close(cn);
		}

	}

	// --------------------------
	public static String getAreaAndSiteTreeWithCheckBox(String station_type,
			HttpServletRequest req) throws Exception {
		String s = null;
		s = getAreaTree(station_type, req)
				+ getSiteTreeWithCheckBox(station_type, req);

		s = "d = new TreeView('d','node0','','station_ids','tree_form',true);\n"
				+ s + "document.write(d);\n";
		return s;
	}
	// ----------------------

}