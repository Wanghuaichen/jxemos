package com.hoson.util;

import java.sql.*;
import java.util.*;

import com.hoson.*;
import com.hoson.app.App;
import javax.servlet.http.*;

//20070430 paged query
//return pageBar and list


public class PagedQuery {

	static int default_max_rows = 2000;

	static String max_rows_key = "db_query_max_rows";
	static String default_page_size_option_values = "10,15,20";
	
	public static String getPageSizeOptionValues(){
		String s = null;
		
		s = App.get("page_size_option_values","");
		if(!StringUtil.isempty(s)){return s;}
		return default_page_size_option_values;
	}
	

	public static int get_max_rows(HttpServletRequest req) {

		int max_rows = 0;
		String v = null;

		max_rows = JspUtil.getInt(req, max_rows_key, 0);

		if (max_rows > 5) {
			return max_rows;
		}

		v = App.get(max_rows_key, "");
		max_rows = StringUtil.getInt(v, 0);

		if (max_rows > 5) {
			return max_rows;
		}

		return default_max_rows;
	}
	
	
	public static int get_page_size(HttpServletRequest req){
		
		String v = null;
		v = req.getParameter("page_size");
		
		if(StringUtil.isempty(v)){
			
			v = App.get("page_size","15");
		}
		return StringUtil.getInt(v,15);
		
	}
	

	public static Map query(Connection cn, String sql, Object[] params,
			HttpServletRequest req

	) throws Exception {

		if (cn == null) {
			throw new Exception("connection is null");
		}

		Map map = new HashMap();

		List list = null;
		List list2  = new ArrayList();
		

	
		int max_rows = 0;
		int row_num = 0;
		int page = 0;
		int page_size = 0;
		int page_num = 0;
		int mod = 0;
		int start = 0;
		int end = 0;
		int i=0;
		String bar = null;
		
		
		
		
		max_rows = get_max_rows(req);
		page = JspUtil.getInt(req,"page",1);
		//page_size = JspUtil.getInt(req,"page_size",10);
		page_size = get_page_size(req);
		list = query(cn,sql,params,max_rows);
		row_num = list.size();
		
		mod = row_num%page_size;
		page_num = row_num/page_size;
		
		if(mod>0){
			page_num=page_num+1;
			}
		if(page>page_num){
			page=page_num;
			}
		if(page<1){page=1;}
		
		start = (page-1)*page_size;
		end = start+page_size;
		if(end>row_num){
			end=row_num;
			}
		//System.out.println(end+","+start+","+page+","+page_size);
		for(i=start;i<end;i++){
			list2.add(list.get(i));
		}
		
		//System.out.println(list2.size());
		bar = PagedUtil.getPageBar(page,page_size,row_num,getPageSizeOptionValues());
		//System.out.println(bar);
		map.put("data",list2);
		map.put("bar",bar);
		
		
		return map;
		

	}
	
	
	public static Object get(ResultSet rs,int index,int type)
	throws Exception{
		
		  if(type==1){return rs.getObject(index);}
		  if(type==3){return rs.getTimestamp(index);}
		  return rs.getString(index);
		  
	}
	

	public static List rs2list(ResultSet rs, int skip, int page_size)
			throws Exception {
		List list = new ArrayList();

		if (rs == null) {
			return list;
		}
		String[] arrColName = null;
		String colName = null;
		int colNum = 0;
		int pos = 0;
		int i = 0;
		int j = 0;
		Map map = null;
		String v = null;
		Object obj = null;
		List col_info_list = null;
		int[]types = null;
		
		/*

		ResultSetMetaData rsmd = null;
		rsmd = rs.getMetaData();
		colNum = rsmd.getColumnCount();
		arrColName = new String[colNum];

		for (i = 1; i <= colNum; i++) {
			arrColName[i - 1] = rsmd.getColumnName(i).toLowerCase();
		}
		*/
		
		col_info_list = DBMetaData.getResultSetColumnInfo(rs);
		colNum = col_info_list.size();
		arrColName = new String[colNum];
		
		for(i=0;i<colNum;i++){
			
			map = (Map)col_info_list.get(i);
			colName = (String)map.get("column_name");
			arrColName[i]=colName;
			
			
		}
		
		types = DBMetaData.getResultSetColumnTypes(col_info_list);
		
		

		if (page_size == 0) {
			page_size = 10000000;
		}

		while ((rs.next()) && (j < page_size)) {

			if (pos < skip) {
				pos++;
				continue;
			}

			map = new HashMap();

			for (i = 0; i < colNum; i++) {
				/*
				v = rs.getString(i + 1);
				if (v == null) {
					v = "";
				}
				map.put(arrColName[i], v);
				*/
				obj = get(rs,i+1,types[i]);
				map.put(arrColName[i],obj);
			}

			j++;
			list.add(map);
		}// end while

		return list;

	}
	
	public static Map getResultSetColumnNameAndTypeArray(List list)
	throws Exception{
		if(list==null){
			
			throw new Exception("result set column info list is null");
		}
		
		Map map = new HashMap();
		
		int i,num =0;
		//List list = null;
		Map m = null;
		String col_name = null;
		String col_class_name = null;
		int type = 0;
		
		String[] cols = null;
		int[] types = null;
		
		num = list.size();
		
		cols = new String[num];
		types = new int[num];
		
		
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			col_name = (String)m.get("column_name");
			col_class_name = (String)m.get("column_class_name");
			type = DBMetaData.getColumnType(col_class_name);
			cols[i] = col_name;
			types[i] = type;
			//System.out.println(m);
		}
		
		
		map.put("name",cols);
		map.put("type",types);
		//System.out.println(map);
		return map;
		
	}
	
	public static String getPageBar(int row_num,int page,int page_size){
		String s = null;
		
		
		return s;
		
	}
	
	public static List query(Connection cn,String sql,Object[]params,int max_rows)
	throws Exception{
		
		List list = new ArrayList();
		Map map = null;
		
		ResultSet rs = null;
		//PreParedStatement ps = null;
		PreparedStatement ps = null;
		List col_info_list = null;
		int i,num=0;
		String[]cols = null;
		int[]types = null;
		Object obj = null;
		
		
		
		
		
		try{
		ps = cn.prepareStatement(sql);
		ps.setMaxRows(max_rows);
		
		DBUtil.setParam(ps,params);
		rs = ps.executeQuery();
		
		

		col_info_list = DBMetaData.getResultSetColumnInfo(rs);
		num = col_info_list.size();
		//System.out.println(num);
		if(num<1){
			throw new Exception("result set column num is <1");
		}
		
		
		map = getResultSetColumnNameAndTypeArray(col_info_list);
		
		cols = (String[])map.get("name");
		types =  (int[])map.get("type");
		
		//System.out.println(map);
		

		// v = Config.get("db_query_max_rows")

		while ((rs.next())) {

			
			map = new HashMap();

			for (i = 0; i < num; i++) {
				
				obj = get(rs,i+1,types[i]);
				map.put(cols[i],obj);
			}

			
			list.add(map);
		}// end while

		
		//System.out.println(list.size());

		return list;
		}catch(Exception e){
			
			throw e;
		}finally{DBUtil.close(rs,ps,null);}

		
		
		

		
	}
	

}