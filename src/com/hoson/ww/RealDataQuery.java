package com.hoson.ww;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.hoson.DBUtil;
import com.hoson.f;

public class RealDataQuery {

	public static List getStationQuery(Map params,HttpServletRequest req)throws Exception{
		HttpSession session = req.getSession();
		String user_id = (String)session.getAttribute("user_id");
		String ids = getIds(user_id);
		if(ids.equals("")){
			return null;
		}
		Connection cn = f.getConn();
		List list = null;
		String sql = "select * from t_cfg_station_info where STATION_ID in("+ids+")";
		try {
			list = DBUtil.query(cn,sql,null);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
		return list;
	}
	public static Map getStationQuery(HttpServletRequest req,String user_id)throws Exception{
		String ids = getIds(user_id);
		if(ids.equals("")){
			return null;
		}
		Connection cn = f.getConn();
		Map map = null;
		String sql = "select station_id,station_desc from t_cfg_station_info where STATION_ID in("+ids+")";
		try {
			map = DBUtil.getMap(cn,sql);
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
		return map;
	}
	public static String getIds(String user_id) throws Exception{
		Connection cn = f.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String sql = "select station_ids from t_sys_ww_user where user_id=?";
		String ids = "";
		try {
			stmt = cn.prepareStatement(sql);
			stmt.setInt(1,Integer.parseInt(user_id));
			rs = stmt.executeQuery();
			while(rs.next()){
				if(rs.getString("station_ids")!=null){
					ids = rs.getString("station_ids");
				}
			}
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
		if(!ids.equals("")){
			ids = ids.substring(0,ids.length()-1);
			ids = "'"+ids.replaceAll(",","','")+"'";
		}
		return ids;
	}
}
