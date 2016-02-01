package com.hoson.util;

import com.hoson.*;

import java.sql.*;
import java.util.*;

import com.hoson.app.*;

import javax.servlet.http.*;




public class JspAction{
	
	public static void getRealDataList(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		String sql = null;
		String m_time = null;
		List list = null;
		
		m_time = request.getParameter("m_time");
		sql = "select * from t_monitor_real_minute where m_time>='"+m_time+"' and m_time<'"+m_time+" 23:59:59'";
		list = RealDataUtil.getRealData(sql);
		request.setAttribute("data",list);
		
	}
		
	
	
	//----------

	public static void hour_today_form(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		
		String stationTypeOption = null;
		String areaOption = null;
		String valleyOption = null;
		Connection cn = null;
		String station_type = null;
		String area_id = null;
		String valley_id = null;
		
		
		
		try{
			
			station_type = request.getParameter("station_type");
			if(StringUtil.isempty(station_type)){
				station_type=App.get("default_station_type","5");
				
			}
			area_id = request.getParameter("area_id");
			valley_id = request.getParameter("valley_id");
			
		cn = DBUtil.getConn();
		if(f.empty(area_id)){
			area_id=App.getAreaId();
		}
		stationTypeOption = JspPageUtil.getStationTypeOption(cn,station_type);
		areaOption = JspPageUtil.getAreaOption(cn,area_id);
		valleyOption = JspPageUtil.getValleyOption(cn,valley_id);
		
	
		request.setAttribute("stationTypeOption",stationTypeOption);
		request.setAttribute("areaOption",areaOption);
		request.setAttribute("valleyOption",valleyOption);
	
		}catch(Exception e){
			
			throw e;
		}finally{
			DBUtil.close(cn);
		}
		
	
	}
	
	//-----------
	
	public static void jx_report_day_form(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		String columnOption = null;
		String stationTypeOption = null;
		String areaOption = null;
		String valleyOption = null;
		Connection cn = null;
		String station_type = null;
		String area_id = null;
		String valley_id = null;
		String m_time = null;
		
		
		try{
			m_time = JspUtil.getParameter(request,"m_time",StringUtil.getNowDate()+"");
			station_type = request.getParameter("station_type");
			if(StringUtil.isempty(station_type)){
				station_type=App.get("default_station_type","5");
				
			}
			area_id = request.getParameter("area_id");
			valley_id = request.getParameter("valley_id");
			
		cn = DBUtil.getConn();
		columnOption = JspPageUtil.getInfectantColumnOption(cn,station_type);
		stationTypeOption = JspPageUtil.getStationTypeOption(cn,station_type);
		areaOption = JspPageUtil.getAreaOption(cn,area_id);
		valleyOption = JspPageUtil.getValleyOption(cn,valley_id);
		
		request.setAttribute("columnOption",columnOption);
		request.setAttribute("stationTypeOption",stationTypeOption);
		request.setAttribute("areaOption",areaOption);
		request.setAttribute("valleyOption",valleyOption);
		request.setAttribute("m_time",m_time);
		}catch(Exception e){
			
			throw e;
		}finally{
			DBUtil.close(cn);
		}
		
	}
	
	//-----------
	
	public static void jx_report_day(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		String sql = null;
		Map map = null;
		Map stationMap = null;
		String col = null;
		String m_time = null;
		String station_type=null;
		String area_id = null;
		String valley_id = null;
		List list = null;
		int i =0;
		int num =0;
		String station_name = null;
		String station_id = null;
		String v = null;
		StringBuffer sb = new StringBuffer();
		
		
		col = request.getParameter("infectant_column");
		if(StringUtil.isempty(col)){
			
			throw new Exception("请选择一个监测指标");
		}
		station_type = request.getParameter("station_type");
		
		if(StringUtil.isempty(station_type)){
			
			throw new Exception("请选择监测类别");
		}
		
		m_time = request.getParameter("m_time");
		if(StringUtil.isempty(m_time)){
			
			m_time = StringUtil.getNowDate()+"";
		}
		
		
		area_id = request.getParameter("area_id");
		valley_id = request.getParameter("valley_id");
		
		sql = "select station_id,"+col+" as v from t_monitor_real_day where "
		+ "  m_time='"+m_time+"' and station_id in ("
		+ "select station_id from t_cfg_station_info where "
		+ "station_type='"+station_type+"' "
		
		;
		
		if(!StringUtil.isempty(area_id)){
			sql=sql+" and area_id like '"+area_id+"%' "; 
		}
		if(!StringUtil.isempty(valley_id)){
			sql=sql+" and valley_id like '"+valley_id+"%' "; 
		}
		sql = sql+")";
		
		list = DBUtil.query(sql,null,request);
		sql = "select station_id,station_desc from t_cfg_station_info where station_type='"+station_type+"'";
		stationMap = DBUtil.getMap(sql);
		
		num = list.size();
		
		for(i=0;i<num;i++){
			map = (Map)list.get(i);
			station_id = (String)map.get("station_id");
			station_name = (String)stationMap.get(station_id);
			if(StringUtil.isempty(station_name)){
				continue;
			}
			v = (String)map.get("v");
			v = App.getValueStr(v);
			sb.append("<tr>\n");
			sb.append("<td>").append(station_name).append("</td>\n");
			sb.append("<td>").append(v).append("</td>\n");
			sb.append("</tr>\n");
			
		}
	       request.setAttribute("data",sb.toString());
		
	}
	
	public static void getStation(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		String station_type = request.getParameter("station_type");
		String area_id = request.getParameter("area_id");
		String valley_id = request.getParameter("valley_id");
		List list = null;
		int i =0;
		int num =0;
		String s ="";
		
		Connection cn = null;
		try{
		cn = DBUtil.getConn();
		list = JspPageUtil.getStationList(cn,station_type,area_id,valley_id,request);
		num = list.size();
		for(i=0;i<num;i++){
			s=s+list.get(i)+"<br>\n";
		}
		request.setAttribute("data",s);
		}catch(Exception e){
			
			throw e;
		}finally{DBUtil.close(cn);}
		
	}
	
	//------------
	
	public static void hour_today(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		String station_type = null;
		String area_id = null;
		String valley_id = null;
		List info = null;
		List stationList = null;
		List dataList = null;
		List colList = null;
		Map stationMap = null;
		Map map = null;
		
		Connection cn = null;
		String sql = null;
		int num =0;
		int i =0;
		int colNum = 0;
		int j =0;
		
		String station_name = null;
		String station_id = null;
		String v = null;
		StringBuffer sb = new StringBuffer();
		String col = null;
		Map infectantInfoMap = null;
		
		station_type = request.getParameter("station_type");
		if(StringUtil.isempty(station_type)){
			throw new Exception("请选择监测类别");
		}
		area_id = request.getParameter("area_id");
		valley_id = request.getParameter("valley_id");
		sql = JspPageUtil.getHourTodaySql();
			
		
		
		try{
		cn = DBUtil.getConn();
		//info = JspPageUtil.getInfectantInfo(cn,station_type);
		infectantInfoMap = JspPageUtil.getInfectantInfoMap(cn,station_type);
		//System.out.println(infectantInfoMap);
		String title = (String)infectantInfoMap.get("title");

		request.setAttribute("title",title);
		/*
		num = info.size();
		if(num<1){
			throw new Exception("请配置监测指标");
		}
		*/
		stationList = JspPageUtil.getStationList(cn,station_type,area_id,valley_id,request);
		num = stationList.size();
		if(num<1){return;}
		dataList = DBUtil.query(cn,sql);
		}catch(Exception e){
			throw e;
		}finally{DBUtil.close(cn);}
		
		
		stationMap = new HashMap();
		for(i=0;i<num;i++){
			map = (Map) stationList.get(i);
			station_name = (String)map.get("station_desc");
			station_id = (String)map.get("station_id");
			stationMap.put(station_id,station_name);
		}
		
		
		
		
		//colList = JspPageUtil.getColumnList(info);
		colList = (List)infectantInfoMap.get("col");
		
		colNum = colList.size();
		
		num = dataList.size();
		for(i=0;i<num;i++){
			map = (Map)dataList.get(i);
			station_id = (String)map.get("station_id");
			station_name = (String)stationMap.get(station_id);
			if(StringUtil.isempty(station_name)){
				continue;
			}
			
			//sb.append("<tr>\n").append("<td>"+(i+1)+"</td>\n");
			sb.append("<td>").append(station_name).append("</td>\n");
			sb.append("<td>").append(map.get("row_num")).append("</td>\n");
			sb.append("<td>").append(map.get("m_time")).append("</td>\n");
			for(j=0;j<colNum;j++){
				col = (String)colList.get(j);
				v = (String)map.get(col);
				v = App.getValueStr(v);
				sb.append("<td>").append(v).append("</td>\n");
				
			}//end for j
			
			//sb.append("<td></td>\n");
			sb.append("</tr>\n");
		}//end for i
		
		
		request.setAttribute("data",sb.toString());
		
		
		
		
	}
	//---------
	
	
	public static void data_report(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		Connection cn = null;
		List list = null;
		int i =0;
		int num =0;
		Map map = null;
		
		Map minuteMap = null;
		Map hourMap = null;
		StringBuffer sb = new StringBuffer();
		String v = null;
		String station_id = null;
		String station_name = null;
		Map m =null;
		int m_num = 0;
		int h_num =0;
		
		try{
		cn = DBUtil.getConn();
		/*
		Cache cache = new DataReportCache();
		map = (Map)cache.get(50,null);
		*/
		map = JspPageUtil.getDataReportMap();
		minuteMap = (Map)map.get("minute");
		hourMap = (Map)map.get("hour");
		list = JspPageUtil.getStationList(cn,request);
		num = list.size();
		for(i=0;i<num;i++){
			
			m_num = 0;
			h_num =0;
			sb.append("<tr>\n");
			map = (Map)list.get(i);
			station_id=(String)map.get("station_id");
			station_name = (String)map.get("station_desc");
			
			sb.append("<td>").append(station_name).append("</td>\n");
			m = (Map)minuteMap.get(station_id);
			if(m==null){
				
				sb.append("<td>0</td>\n").append("<td></td>\n");
			}else{
				v = (String)m.get("row_num");
				m_num = StringUtil.getInt(v,0);
				sb.append("<td>").append(m_num).append("</td>\n");
				sb.append("<td>").append(m.get("m_time")).append("</td>\n");
				
			}
		
			m = (Map)hourMap.get(station_id);
			if(m==null){
				
				sb.append("<td>0</td>\n").append("<td></td>\n");
			}else{
				v = (String)m.get("row_num");
				h_num = StringUtil.getInt(v,0);
				sb.append("<td>").append(h_num).append("</td>\n");
				sb.append("<td>").append(m.get("m_time")).append("</td>\n");
				
			}
		sb.append("<td>");
		if(m_num>0){
			
			sb.append("<a href=javascript:f_view_minute('"+station_id+"','"+station_name+"')>查看实时数据</a>");
		}
		sb.append("</td>\n");
		
		sb.append("<td>");
		if(h_num>0){
			
			sb.append("<a href=javascript:f_view_hour('"+station_id+"','"+station_name+"')>查看时均值</a>");
		}
		sb.append("</td>\n");
		
		
		//sb.append("<td>查看时均值</td>\n");
		}
		
		
		request.setAttribute("data",sb.toString());
		
		
		}catch(Exception e){
			
			throw e;
		}finally{DBUtil.close(cn);}
		
	}
	
	public static void hour_view(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		String station_id = null;
		String station_type = null;
		String sql = null;
		String station_name = null;
		Map map = null;
		Connection cn = null;
		List list = null;
		int i =0;
		int num =0;
		int colNum = 0;
		int j =0;
		StringBuffer sb = new StringBuffer();
		List colList = null;
		String title = null;
		String col = null;
		String v = null;
		
		station_id = request.getParameter("station_id");
		if(StringUtil.isempty(station_id)){
			throw new Exception("station_id为空");
		}
		sql = "select station_desc,station_type from t_cfg_station_info where station_id='"+station_id+"'";
		try{
		cn = DBUtil.getConn();
		map = DBUtil.queryOne(cn,sql,null);
		if(map==null){
			throw new Exception("记录不存在 station_id="+station_id);
		}
		station_name= (String)map.get("station_desc");
		station_type = (String)map.get("station_type");
		map = JspPageUtil.getInfectantInfoMap(cn,station_type);
		colList = (List)map.get("col");
		title = (String)map.get("title");
		sql = "select * from view_hour_today where station_id='"+station_id+"' order by m_time desc";
		list = DBUtil.query(cn,sql);
		num = list.size();
		colNum = colList.size();
		
		for(i=0;i<num;i++){
			map = (Map)list.get(i);
			sb.append("<tr>\n");
			sb.append("<td>").append(map.get("m_time")).append("</td>\n");
			for(j=0;j<colNum;j++){
				col = (String)colList.get(j);
				v = (String)map.get(col);
				//if(v==null){v="";}
				v = App.getValueStr(v);
				
				sb.append("<td>").append(v).append("</td>\n");
				
			}//end for j 
			sb.append("</tr>\n");
			
		}//end for i
		
		request.setAttribute("data",sb.toString());
		request.setAttribute("title",title);
		request.setAttribute("station_name",station_name);
		}catch(Exception e){
			
			throw e;
		}finally{
			DBUtil.close(cn);
		}
		
	}
	
	public static void q(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		Map map = JspUtil.getRequestModel(request);
		String sql = (String)map.get("sql");
		String v = null;
		Connection cn = null;
		ResultSet rs = null;
		Statement stmt = null;
		ResultSetMetaData rsmd = null;
		StringBuffer sb = new StringBuffer();
		int colNum = 0;
		int i =0;
		String col = null;
		String cols = "";
		String sql2 = null;
		int num =0;
		if(StringUtil.isempty(sql)){
			//throw new Exception("sql is null");
			return;
		}
		v = (String)map.get("num");
		num = StringUtil.getInt(v,50);
		if(num<0 ||num>1000){
			num = 1000;
		}
		sql2 = sql.toLowerCase();
		
		if(sql2.indexOf("delete")>=0 ||sql2.indexOf("drop")>=0||sql2.indexOf("truncate")>=0){
			throw new Exception("can not execute sql<br>"+sql);
		}
		
		
		try{
		cn = DBUtil.getConn();
		stmt = cn.createStatement();
		stmt.setMaxRows(num);
		rs = stmt.executeQuery(sql);
		rsmd = rs.getMetaData();
		colNum = rsmd.getColumnCount();
		
		sb.append("<tr class=title>\n");
		
		for(i=1;i<=colNum;i++){
			col = rsmd.getColumnName(i);
			col=col.toLowerCase();
			sb.append("<td>").append(col).append("</td>\n");
			if(i>1){cols=cols+",";}
			cols=cols+col;
		}
		sb.append("</tr>\n");
		
		while(rs.next()){
			
			sb.append("<tr>\n");
			for(i=1;i<=colNum;i++){
				sb.append("<td>").append(rs.getString(i)).append("</td>\n");
				
			}
			sb.append("</tr>\n");
			
		}
		
		
		request.setAttribute("data",sb.toString());
		request.setAttribute("sql",sql);
		request.setAttribute("num",num+"");
		request.setAttribute("cols",cols);
		
		}catch(Exception e){
			
			throw new Exception(e+"<br><br>"+sql);
		}finally{
			
			DBUtil.close(rs,stmt,cn);
		}
		
		
	}
		//-----
	public static void toc(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
	Connection cn = null;
	String station_type = request.getParameter("station_type");
	String col =  request.getParameter("col");
	String m_time =  request.getParameter("m_time");
	String area_id =  request.getParameter("area_id");
	String up_limit =  request.getParameter("up_limit");
	List list = null;
	int i,num,j=0;
	StringBuffer sb = new StringBuffer();
	StringBuffer sb2 = new StringBuffer();
	
	
	Map data = null;
	Map m = null;
	String key = null;
	String station_id = null;
	String station_name = null;
	String v = null;
	String[]arr = null;
	String ss="";
	String sql = null;
	String area_name = null;
	double dup_limit = StringUtil.getDouble(up_limit,0);
	double dv = 0;
	
	double[][] arr1= null;
	double[][] arr2 = null;
	
    //System.out.println(dup_limit);
	
	
	try{
	cn = DBUtil.getConn();
	list = JspPageUtil.getStationList(cn,request);
	data = JspPageUtil.getTocDayReportData(cn,m_time,col);
	sql = "select area_name from t_cfg_area where area_id='"+area_id+"'";
	m = DBUtil.queryOne(cn,sql,null);
	if(m==null){area_name = "";}
	area_name = (String)m.get("area_name");
	
	//System.out.println(data);
	num = list.size();
	arr = new String[num];
	arr1 = new double[24][num];
	arr2 = new double[8][num];
	
	
	for(i=0;i<num;i++){
		m = (Map)list.get(i);
		//System.out.println(m);
		station_id=(String)m.get("station_id");
		station_name=(String)m.get("station_desc");
		arr[i]=station_id;
		ss=ss+"<td>"+station_name+"</td>\n";
	}
	
	for(i=0;i<24;i++){
		
		//sb.append("<tr>\n");
		//sb.append("<td>").append(i).append("</td>\n");
		
		for(j=0;j<num;j++){
			//m = (Map)list.get(j);
			station_id=arr[j];
			//station_name=(String)m.get("station_desc");
			
			key = station_id+"_"+i;
			v = (String)data.get(key);
			if(v==null){v="";}
			dv = StringUtil.getDouble(v,0);
			arr1[i][j]=dv;
			/*
			sb.append("<td");
			if(dup_limit>0 && dv>dup_limit){
				
				sb.append(" class=alert");
			}
			
			sb.append(">").append(v).append("</td>\n");
			*/
			
		}//end for j 
		//sb.append("</tr>\n");
	}//end for i
	
	for(i=0;i<num;i++){
		
		for(j=0;j<24;j++){
			dv = arr1[j][i];
			if(dv>0){
				arr2[0][i]=arr2[0][i]+dv;
				arr2[1][i]=arr2[1][i]+1;
				if(dup_limit>0 && dv>dup_limit){arr2[2][i]=arr2[2][i]+1;}
				
			}
			
		}
	}
	double dv2 = 0;
	
	for(i=0;i<num;i++){
		
		dv = arr2[0][i];
		dv2 = arr2[1][i];
		if(dv>0){
			arr2[3][i]=dv/dv2;
		}
		
		dv = arr2[2][i];
		if(dv>1){
			
			arr2[4][i]=(dv/dv2)*100;
		}
		
		
		
	}
	
	
	
for(i=0;i<24;i++){
		
		sb.append("<tr>\n");
		sb.append("<td>").append(i).append("</td>\n");
		
		for(j=0;j<num;j++){
	
			dv = arr1[i][j];
		
			sb.append("<td");
			if(dup_limit>0 && dv>dup_limit){
				
				sb.append(" class=alert");
			}
			
			sb.append(">");
			if(dv>0){
			sb.append(dv);
			}
			sb.append("</td>\n");
			
			
		}//end for j 
		sb.append("</tr>\n");
	}//end for i
	




	sb2.append("<tr>\n");
	sb2.append("<td>平均值</td>\n");
	
    for(i=0;i<num;i++){
	
	dv = arr2[3][i];
	sb2.append("<td");
	
	
	if(dup_limit>0 && dv > dup_limit){
		
		sb2.append(" class=alert");
	}
	sb2.append(">");
	//System.out.println(dv+","+dup_limit+(dv>dup_limit)+(dv>0 &&dv>dup_limit));
	
	if(dv>0){
		sb2.append(StringUtil.format(dv+"","#.##"));
		//System.out.println(dv+","+dup_limit);
	}
	
	sb2.append("</td>\n");
	
    }
    sb2.append("</tr>\n");
    
    
    
    
    sb2.append("<tr>\n");
	sb2.append("<td>超标数</td>\n");
	
    for(i=0;i<num;i++){
	
	dv = arr2[2][i];
	sb2.append("<td>");
	if(dv>0){
		sb2.append(StringUtil.format(dv+"","#"));
		
	}
	sb2.append("</td>\n");
	
    }
    sb2.append("</tr>\n");
    
    
    
    
    
    
    sb2.append("<tr>\n");
	sb2.append("<td>实得数</td>\n");
	
    for(i=0;i<num;i++){
	
	dv = arr2[1][i];
	sb2.append("<td>");
	if(dv>0){
		//sb2.append(dv);
		sb2.append(StringUtil.format(dv+"","#"));
	}
	sb2.append("</td>\n");
	
    }
    sb2.append("</tr>\n");
    
    
    
    
    
    
    
    
    
    sb2.append("<tr>\n");
	sb2.append("<td>超标率</td>\n");
	
    for(i=0;i<num;i++){
	
	dv = arr2[4][i];
	sb2.append("<td>");
	if(dv>0){
		//sb2.append(dv);
		sb2.append(StringUtil.format(dv+"","#.##"));
	}
	sb2.append("</td>\n");
	
    }
    sb2.append("</tr>\n");
    
  


	
	request.setAttribute("title",ss);
	request.setAttribute("data",sb+"");
	request.setAttribute("data2",sb2+"");
	//request.setAttribute("data",sb+"");
	
	
	request.setAttribute("map",data);
	request.setAttribute("m_time",m_time);
	request.setAttribute("area_name",area_name);
	}catch(Exception e){
		
		throw e;
	}finally{
		DBUtil.close(cn);
	}
	
	
	
	
		
		
		
	}
	
	//------------------
	public static void minute_day(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		String station_id = request.getParameter("station_id");
		String infectant_id = request.getParameter("infectant_id");
		String m_time = request.getParameter("m_time");
		String v = null;
		String sql = null;
		List list = null;
		int i,num=0;
		Map map = null;
		StringBuffer sb = new StringBuffer();
		

		
		
		sql = "select m_time,m_value from t_monitor_real_minute "
			+" where station_id='"+station_id+"' "
			+" and infectant_id='"+infectant_id+"' "
			+" and m_time>='"+m_time+"' "
			+" and m_time<'"+m_time+" 23:59:59' "
			+"order by m_time desc"
			;
		
		list = DBUtil.query(sql,request);
		num = list.size();
		//System.out.println(num);
		for(i=0;i<num;i++){
			map =(Map)list.get(i);
			sb.append("<tr>\n");
			sb.append("<td>");
			v = (String)map.get("m_time");
			
			v = v.substring(0,19);
			sb.append(v);
			sb.append("</td>\n<td>");
			v = (String)map.get("m_value");
			if(v==null){v="";}
			if(v.startsWith(".")){v="0"+v;}
			sb.append(v);
			sb.append("</td>\n</tr>\n");
		}
		//System.out.println(sb);
		request.setAttribute("data",sb.toString());
		
	}
	
	public static void rpt(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		//q 34,toc 31
		String sql = null;
		List q_list = null;
		List toc_list = null;
		Connection cn = null;
		int i,num=0;
		Map map ,map2= null;
		Map q_map = new HashMap();
		Map toc_map = new HashMap();
		
		Map q_low_map = new HashMap();
		Map q_up_map = new HashMap();
		Map toc_value_map = new HashMap();
		
		List station_list = null;
		StringBuffer sb = new StringBuffer();
		String key_col = "station_id";
		String v = null;
		String station_name = null;
		String station_id = null;
		v = request.getParameter("q_low_limit");
		double q_low_limit = StringUtil.getDouble(v,5);
		if(q_low_limit<=0){q_low_limit=5;}
		
		sql = "select station_id,max(m_value) as q_max,min(m_value) as q_min,count(1) as q_num,max(m_time) as q_time from view_minute_today where infectant_id='34'  group by station_id";
		
		
		try{
		cn = DBUtil.getConn();
		q_list = DBUtil.query(cn,sql);
		sql = "select station_id,max(m_value) as toc_max,min(m_value) as toc_min,count(1) as toc_num,max(m_time) as toc_time from view_minute_today where infectant_id='31'  group by station_id";
		toc_list = DBUtil.query(cn,sql);
		
		sql = "select station_id,count(1) as q_low_num,max(m_time) as q_low_time from view_minute_today where infectant_id='34' and m_value<"+q_low_limit+"  group by station_id";
		
		q_low_map = JspPageUtil.getMap(DBUtil.query(cn,sql),key_col);
		
		sql = "select station_id,count(1) as q_up_num,max(m_time) as q_up_time from view_minute_today where infectant_id='34' and m_value>="+q_low_limit+"  group by station_id";
		
		q_up_map = JspPageUtil.getMap(DBUtil.query(cn,sql),key_col);
		
			 
		sql = "	select a.station_id,a.m_value from view_minute_today a,"
			+ "(select station_id,max(m_time) as m_time from view_minute_today where infectant_id='31' group by station_id) b "
			 + "  where a.station_id=b.station_id and a.m_time=b.m_time "
			 
			;
		toc_value_map = JspPageUtil.getMap(DBUtil.query(cn,sql),key_col);
		
		
		station_list = JspPageUtil.getStationList(cn,request);
		
		}catch(Exception e){
			throw e;
		}finally{DBUtil.close(cn);}
		
		

		q_map = JspPageUtil.getMap(q_list,key_col);
		toc_map = JspPageUtil.getMap(toc_list,key_col);
		
		
		//System.out.println(q_map);
		//System.out.println(toc_map);
		
		num = station_list.size();
		for(i=0;i<num;i++){
			map = (Map)station_list.get(i);
			station_id = (String)map.get("station_id");
			station_name = (String)map.get("station_desc");
			if(StringUtil.isempty(station_name)){continue;}
			
			sb.append("<tr>\n");
			sb.append("<td>").append(station_name).append("</td>\n");
			
			map = (Map)q_map.get(station_id);
			
			if(map==null){map=new HashMap();}
			v = (String)map.get("q_num");
			if(v==null){v="";}
			sb.append("<td>").append(v).append("</td>\n");
			
			v = (String)map.get("q_max");
			if(v==null){v="";}
			sb.append("<td>").append(v).append("</td>\n");
			
			v = (String)map.get("q_min");
			if(v==null){v="";}
			sb.append("<td>").append(v).append("</td>\n");
			
			map2 = (Map)q_low_map.get(station_id);
			if(map2==null){map2=new HashMap();}
			v = (String)map2.get("q_low_num");
			if(v==null){v="";}
			
			sb.append("<td>").append(v).append("</td>\n");
			
			
			map2 = (Map)q_up_map.get(station_id);
			if(map2==null){map2=new HashMap();}
			v = (String)map2.get("q_up_time");
			if(v==null){v="";}
			
			sb.append("<td>").append(v).append("</td>\n");
			
			
			
			
			
			v = (String)map.get("q_time");
			if(v==null){v="";}
			sb.append("<td>").append(v).append("</td>\n");
			
			
			
			map = (Map)toc_map.get(station_id);
			
			if(map==null){map=new HashMap();}
			v = (String)map.get("toc_num");
			if(v==null){v="";}
			sb.append("<td>").append(v).append("</td>\n");
			
			v = (String)map.get("toc_max");
			if(v==null){v="";}
			sb.append("<td>").append(v).append("</td>\n");
			
			v = (String)map.get("toc_min");
			if(v==null){v="";}
			sb.append("<td>").append(v).append("</td>\n");
			
			map2 = (Map)toc_value_map.get(station_id);
			if(map2==null){map2=new HashMap();}
			v = (String)map2.get("m_value");
			if(v==null){v="";}
			
			sb.append("<td>").append(v).append("</td>\n");
			
			
			v = (String)map.get("toc_time");
			if(v==null){v="";}
			sb.append("<td>").append(v).append("</td>\n");
			
			sb.append("</tr>\n");
		}
		
		request.setAttribute("data",sb.toString());
		
		
		
		
		
	}
	
	
	public static void rpt_form(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		Connection cn = null;
		String areaOption = null;
		String area_id=request.getParameter("area_id");
		try{
		cn = DBUtil.getConn();
		areaOption = JspPageUtil.getAreaOption(cn,area_id);
		request.setAttribute("areaOption",areaOption);
		}catch(Exception e){
			throw e;
		}finally{DBUtil.close(cn);}
		
	}
	
	public static void station_report_day(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		String station_id = request.getParameter("station_id");
		String m_time =  request.getParameter("m_time");
		Connection cn = null;
		String s = null;
		
		try{
		cn = DBUtil.getConn();
		s = SiteReport.getDayReportData(cn,station_id,m_time,request);
		request.setAttribute("data",s);
		}catch(Exception e){
			throw e;
			
		}finally{DBUtil.close(cn);}
		
		
		
	}
		
	
	public static void station_report_month(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		String station_id = request.getParameter("station_id");
		String m_time =  request.getParameter("m_time");
		Connection cn = null;
		String s = null;
		
		try{
		cn = DBUtil.getConn();
		s = SiteReport.getMonthReportData(cn,station_id,m_time,request);
		request.setAttribute("data",s);
		}catch(Exception e){
			throw e;
			
		}finally{DBUtil.close(cn);}
		
		
		
	}
		
	
	
	public static void station_report_year(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		String station_id = request.getParameter("station_id");
		String m_time =  request.getParameter("m_time");
		Connection cn = null;
		String s = null;
		
		try{
		cn = DBUtil.getConn();
		s = SiteReport.getYearReportData(cn,station_id,m_time,request);
		request.setAttribute("data",s);
		}catch(Exception e){
			throw e;
			
		}finally{DBUtil.close(cn);}
		
		
		
	}
		
	
	public static void area_info(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		HttpSession session = request.getSession();
		String system_type = request.getParameter("system_type");
		String system_type_in_session = (String)session.getAttribute("area_info_system_type");
		String area_id = request.getParameter("area_id");
		String area_name = null;
		Map map = null;
		Connection cn = null;
		List list = null;
		int i,num=0;
		String[] types = null;
		String sql = null;
		String info = null;
		
		
		//System.out.println(system_type+","+system_type_in_session);
		
		if(StringUtil.isempty(area_id)){area_id="33";}
		
		if(StringUtil.isempty(system_type) && !StringUtil.isempty(system_type_in_session)){
			
			system_type = system_type_in_session;
		}
		
		if(StringUtil.isempty(system_type)){
			system_type="1";
		}
		
		
		if(!StringUtil.equals(system_type,system_type_in_session)){
			
			session.setAttribute("area_info_system_type",system_type);
		}
		
		
		if(system_type.equals("2")){
			
			types = new String[]{"1","2","3"};
		}else{
			
			types = new String[]{"5","6","7"};
			
		}
		
		if(system_type.equals("2")){
			request.setAttribute("flag1","");
			request.setAttribute("flag2"," checked");
			
			request.setAttribute("name1","污水");
			request.setAttribute("name2","烟气");
			
		
		}else{
			
			request.setAttribute("flag1"," checked");
			request.setAttribute("flag2","");
			
			
			request.setAttribute("name1","地表水");
			request.setAttribute("name2","大气");
			
		
		}
		
		//System.out.println(system_type+","+system_type_in_session);
		
		try{
		cn = DBUtil.getConn();
		//sql = "select station_id from t_cfg_station_info where station_type";
		
		
		sql = "select area_name from t_cfg_area where area_id='"+area_id+"'";
		area_name = DBUtil.getString(cn,sql);
		
		if(StringUtil.isempty(area_name)){
			area_name="";
			return;
			
		}
		
		//map = JspPageUtil.getRealDataInfoMap();
		map = (Map)CacheUtil.getAreaInfoDataMap();
		num = types.length;
		for(i=0;i<num;i++){
			sql = "select station_id from t_cfg_station_info where station_type='"+types[i]+"' and area_id like '"+area_id+"%'";
			list = DBUtil.getList(cn,sql);
			info = JspPageUtil.getRealDataInfo(map,list);
			request.setAttribute(i+"",info);
		}
		
		
		request.setAttribute("area_name",area_name);
		request.setAttribute("area_id",area_id);
		
		
		
		
		}catch(Exception e){
			throw e;
		}finally{DBUtil.close(cn);}
		
		
		
		
	}
		
	public static void area_info_zuj(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		HttpSession session = request.getSession();
		String system_type = request.getParameter("system_type");
		String system_type_in_session = (String)session.getAttribute("area_info_system_type");
		String area_id = request.getParameter("area_id");
		String area_name = null;
		Map map = null;
		Connection cn = null;
		List list = null;
		int i,num=0;
		String[] types = null;
		String sql = null;
		String info = null;
		
		
		//System.out.println(system_type+","+system_type_in_session);
		
		if(StringUtil.isempty(area_id)){area_id="33";}
		
		if(StringUtil.isempty(system_type) && !StringUtil.isempty(system_type_in_session)){
			
			system_type = system_type_in_session;
		}
		
		if(StringUtil.isempty(system_type)){
			system_type="1";
		}
		
		
		if(!StringUtil.equals(system_type,system_type_in_session)){
			
			session.setAttribute("area_info_system_type",system_type);
		}
		
		/*
		if(system_type.equals("2")){
			
			types = new String[]{"1","2","3"};
		}else{
			
			types = new String[]{"5","6","7"};
			
		}
		
		if(system_type.equals("2")){
			request.setAttribute("flag1","");
			request.setAttribute("flag2"," checked");
			
			request.setAttribute("name1","污水");
			request.setAttribute("name2","烟气");
			
		
		}else{
			
			request.setAttribute("flag1"," checked");
			request.setAttribute("flag2","");
			
			
			request.setAttribute("name1","地表水");
			request.setAttribute("name2","大气");
			
		
		}
		*/
		
		
		
		
		//System.out.println(system_type+","+system_type_in_session);
		types =  new String[]{"1","2","5","6"};
		
		
		try{
		cn = DBUtil.getConn();
		//sql = "select station_id from t_cfg_station_info where station_type";
		
		
		sql = "select area_name from t_cfg_area where area_id='"+area_id+"'";
		area_name = DBUtil.getString(cn,sql);
		
		if(StringUtil.isempty(area_name)){
			area_name="";
			return;
			
		}
		
		//map = JspPageUtil.getRealDataInfoMap();
		map = (Map)CacheUtil.getAreaInfoDataMap();
		num = types.length;
		for(i=0;i<num;i++){
			sql = "select station_id from t_cfg_station_info where station_type='"+types[i]+"' and area_id like '"+area_id+"%'";
			list = DBUtil.getList(cn,sql);
			//info = JspPageUtil.getRealDataInfo(map,list);
			info = getAreaInfo_zuj(map,list);
			request.setAttribute(i+"",info);
		}
		
		
		request.setAttribute("area_name",area_name);
		request.setAttribute("area_id",area_id);
		
		
		
		
		}catch(Exception e){
			throw e;
		}finally{DBUtil.close(cn);}
		
		
		
		
	}
		
	
	public static String getAreaInfo_zuj(Map map,List list)
	throws Exception{
		String s = "";
		int i,num=0;
		int warnNum,hourNum,minuteNum =0;
		int warnCount=0;
		int hourCount=0;
		int minuteCount=0;
		int onNum=0;
		int offNum =0;
		
		Map warn,minute,hour=null;
		String id = null;
		
		
		warn = (Map)map.get("warn");
		minute = (Map)map.get("minute");
		hour = (Map)map.get("hour");
		
		num = list.size();
		
		for(i=0;i<num;i++){
			id=(String)list.get(i);
			if(StringUtil.isempty(id)){continue;}
			
			warnNum = StringUtil.getInt(warn.get(id)+"",0);
			minuteNum = StringUtil.getInt(minute.get(id)+"",0);
			hourNum = StringUtil.getInt(hour.get(id)+"",0);
			
			if(warnNum>0 || minuteNum>0 || hourNum>0){
				onNum++;
			}else{
				offNum++;
			}
			warnCount = warnCount+warnNum;
			hourCount = hourCount+hourNum;
			minuteCount = minuteCount+minuteNum;
		}
		
		
		s = s + "监测点数 " + num + "<br>\n"
		+ "脱机数 " + offNum + "<br>\n"
		+ "联机数 " + onNum + "<br>\n"
		+ "报警记录数 " + warnCount + "<br>\n"
		+ "实时记录数 " + minuteCount + "<br>\n"
		+ "时均值记录数 " + hourCount + "<br>\n"
		;
		return s;
		
	}
	
	
	
	public static void data_report2_form(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		Connection cn = null;
		String area_id=request.getParameter("area_id");
		
		try{
		cn = DBUtil.getConn();
		String areaOption = JspPageUtil.getAreaOption(cn,area_id);
		request.setAttribute("areaOption",areaOption);
		//System.out.println(areaOption);
		}catch(Exception e){
			throw e;
		}finally{DBUtil.close(cn);}
	}
	
	
	public static void data_report2_action(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		Connection cn = null;
		String area_id=request.getParameter("area_id");
		String q=request.getParameter("q");
		String toc=request.getParameter("toc");
		String station_type=request.getParameter("station_type");
		String m_time=request.getParameter("m_time");
		int toc_time = JspUtil.getInt(request,"toc_time",1);
		
		
		
		String sql = null;
		Map map = null;
		List stationList = null;
		String station_id = null;
		String station_name = null;
		int i,num =0;
		StringBuffer sb = new StringBuffer();
		int q_all_num = JspUtil.getInt(request,"q_all_num",288);
		int toc_all_num = JspUtil.getInt(request,"toc_all_num",24);
		int q_min = JspUtil.getInt(request,"q_min",5);
		
		int toc_all_num2 = toc_all_num/toc_time;
		
		
		int q_num =0;
		int toc_num =0;
		
		Map q_map = null;
		Map toc_map = null;
		String v = null;
		double dv = 0;
		int q_min_num =0;
		
		
		
		try{
		cn = DBUtil.getConn();
		//String areaOption = JspPageUtil.getAreaOption(cn,area_id);
		//request.setAttribute("areaOption",areaOption);
		//System.out.println(areaOption);
		
		stationList = JspPageUtil.getStationList(cn,request);
		num = stationList.size();
		
		//System.out.println(num);
		
		if(num<1){return;}
		
		//sql = "select station_id,count(1) as q_num from t_monitor_real_minute where infectant_id='"+q+"' and m_time>='"+m_time+"' and m_time<'"+m_time+" 23:59:59' and m_value>"+q_min+" group by station_id";
		sql = "select station_id,count(1) as q_num from t_monitor_real_minute where infectant_id='"+q+"' and m_time>='"+m_time+"' and m_time<'"+m_time+" 23:59:59' group by station_id";
		
		
		q_map = DBUtil.getMap(cn,sql);
		//sql = "select station_id,count(1) as toc_num from view_minute_today where infectant_id='"+toc+"' group by station_id,m_value";
		
		sql = "select station_id,count(distinct m_value)  as toc_num from  t_monitor_real_minute  where infectant_id='"+toc+"' and m_time>='"+m_time+"' and m_time<'"+m_time+" 23:59:59' group by station_id";
		
		
		toc_map = DBUtil.getMap(cn,sql);
		//System.out.println(q_map);
		//System.out.println(toc_map);
		
		sql = "select station_id,count(1) as q_num from t_monitor_real_minute where infectant_id='"+q+"' and m_time>='"+m_time+"' and m_time<'"+m_time+" 23:59:59' and m_value<"+q_min+" group by station_id";
		Map q_min_map = DBUtil.getMap(cn,sql);
		
		for(i=0;i<num;i++){
			map = (Map)stationList.get(i);
			station_id=(String)map.get("station_id");
			station_name=(String)map.get("station_desc");
			
			sb.append("<tr>\n");
			sb.append("<td>").append(station_name).append("</td>\n");
			sb.append("<td>").append(q_all_num).append("</td>\n");
			
			v = (String)q_min_map.get(station_id);
			q_min_num = StringUtil.getInt(v,0);
			sb.append("<td>").append(q_min_num).append("</td>\n");
			
			
			v = (String)q_map.get(station_id);
			
			/*
			if(StringUtil.isempty(v)){
				sb.append("<td></td>\n");
				sb.append("<td></td>\n");
			}else{
				
				
				
				q_num = StringUtil.getInt(v,0);
				dv = (q_num*100.0)/q_all_num;
				
				sb.append("<td>").append(q_num).append("</td>\n");
				sb.append("<td>").append(StringUtil.format(dv+"","#")).append("%</td>\n");
				
			}
			*/

			q_num = StringUtil.getInt(v,0);
			dv = (q_num*100.0)/q_all_num;
			
			
			
			sb.append("<td>").append(q_num).append("</td>\n");
			sb.append("<td>").append(StringUtil.format(dv+"","#")).append("%</td>\n");
			
			
			//toc_all_num = ((q_num-q_min_num)*5)/60;
			toc_all_num = ((q_num-q_min_num)*5)/(60*toc_time);
			//System.out.println(toc_all_num);
			
			sb.append("<td>").append(toc_all_num).append("</td>\n");
			
            v = (String)toc_map.get(station_id);
			/*
			if(StringUtil.isempty(v)){
				sb.append("<td></td>\n");
				sb.append("<td></td>\n");
			}else{
				toc_num = StringUtil.getInt(v,0);
				if(toc_all_num>0){
				dv = (toc_num*100.0)/toc_all_num;
				}else{
					dv=0;
				}
				if(dv>100){dv=100;}
				sb.append("<td>").append(toc_num).append("</td>\n");
				sb.append("<td>").append(StringUtil.format(dv+"","#")).append("%</td>\n");
				
			}
			*/
            toc_num = StringUtil.getInt(v,0);
			if(toc_all_num>0){
			dv = (toc_num*100.0)/toc_all_num;
			}else{
				dv=100;
			}
			if(dv>100){dv=100;}
			sb.append("<td>").append(toc_num).append("</td>\n");
			sb.append("<td>").append(StringUtil.format(dv+"","#")).append("%</td>\n");
			
            
            
			sb.append("</tr>\n");
			
			
		}//end for
		
		
		
		request.setAttribute("data",sb+"");
		
		}catch(Exception e){
			throw e;
		}finally{DBUtil.close(cn);}
	}
	
	
	
	public static void rpt_01_action(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		String q = request.getParameter("q");
		String toc = request.getParameter("toc");
		String cod = request.getParameter("cod");
		String cod_up_limit = request.getParameter("cod_up_limit");
		String m_time = request.getParameter("m_time");
		
		
		Map q_map = null;
		Map toc_map = null;
		Map cod_map = null;
		Map up_map = null;
		
		
		String sql_q = null;
		String sql_toc = null;
		String sql_cod = null;
		String sql_up = null;
		
		
		String time_where_str = null;
		Connection cn = null;
		
		time_where_str = " m_time>='"+time_where_str+"' and m_time<'"+m_time+" 23:59:59'  ";
		
		
		sql_q = "select station_id,max(m_value) as max_v,min(m_value) as min_v,avg(m_time) avg_v,sum(m_value) as sum_v "
			+" from t_monitor_real_minute where infectant_id='"+q+"' "
			+" and "+ time_where_str+" group by station_id";
		
		

		sql_toc = "select station_id,max(m_value) as max_v,min(m_value) as min_v,avg(m_time) avg_v,sum(m_value) as sum_v "
			+" from t_monitor_real_minute where infectant_id='"+toc+"' "
			+" and "+ time_where_str+" group by station_id";
		

		sql_cod = "select station_id,max(m_value) as max_v,min(m_value) as min_v,avg(m_time) avg_v,sum(m_value) as sum_v "
			+" from t_monitor_real_minute where infectant_id='"+cod+"' "
			+" and "+ time_where_str+" group by station_id";
		
		
		sql_up = "select station_id,sum(m_value) as sum_v "
			+" from t_monitor_real_minute where infectant_id='"+cod+"' "
			+" and "+ time_where_str+" group by station_id";
		
		
		
		cn = DBUtil.getConn();
		q_map = DBUtil.getMap(cn,sql_q);
		
		
		
		
		
		
	}
	
	
	//query for jx

	public static void jx_query_form(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		//System.out.println(StringUtil.getNowTime());
		
		String station_type = null;
		Connection cn = null;
		String stationTypeOption = null;
		String areaOption = null;
		String area_id = null;
		String top_area_id = App.get("area_id","33");
		String stationOption = null;
		String sql = null;
		String now = StringUtil.getNowDate()+"";
		String tableOption = null;
		String vs = "minute,t_monitor_real_hour,t_monitor_real_day,t_monitor_real_month,t_monitor_real_year";
		//String ls = "原始数据,时均值,日均值,月均值,年均值";
		String ls = "分均值,时均值,日均值,月均值,年均值";
		String date1 = JspUtil.getParameter(request,"date1",now);
		String date2 = JspUtil.getParameter(request,"date2",now);
		String table = JspUtil.getParameter(request,"data_table","minute");
		tableOption = JspUtil.getOption(vs,ls,table);
		
		//System.out.println(now);
		//System.out.println(App.get("default_station_type","5"));
		//station_type = JspUtil.get(request,"station_type",App.get("default_station_type","5"));
		station_type = request.getParameter("station_type");
		if(StringUtil.isempty(station_type)){
			
			station_type = App.get("default_station_type","1");
		}
		
		//System.out.println(station_type);
		try{
		cn = DBUtil.getConn();
		//area_id = JspUtil.getParameter(request,"area_id",JspPageUtil.getAreaIdByPid(cn,top_area_id));
		area_id = JspUtil.getParameter(request,"area_id",App.get("default_area_id","3301"));
		
		
		//area_id = JspUtil.getParameter(request,"area_id",top_area_id);
		

		stationTypeOption = JspPageUtil.getStationTypeOption(cn,station_type);
		areaOption = JspPageUtil.getAreaOption(cn,area_id);
		sql = "select station_id,station_desc from t_cfg_station_info where station_type='"+station_type+"' and area_id like '"+area_id+"%' ";
		sql = sql+DataAclUtil.getStationIdInString(request,station_type,"station_id");
		sql = sql + " order by station_desc";
		stationOption = JspUtil.getOption(cn,sql,null);
		
		//System.out.println(station_type+"\n"+sql);
		
		}catch(Exception e){
			
			throw e;
		}finally{DBUtil.close(cn);}
		
		
		request.setAttribute("stationTypeOption",stationTypeOption);
		request.setAttribute("areaOption",areaOption);
		request.setAttribute("stationOption",stationOption);
		request.setAttribute("tableOption",tableOption);
		request.setAttribute("now",now);
		
		request.setAttribute("date1",date1);
		request.setAttribute("date2",date2);
	}
		
	public static void jx_query_action(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		
		
		
		
	}
	public static void jx_rpt_01_form(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		
		
		
		
	}
	
	public static void jx_rpt_01_action(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		
		
		
		
	}
	
	public static void jx_rpt_02_form(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		
		
		
		
	}
	
	public static void jx_rpt_02_action(
			HttpServletRequest request
			//,HttpServletResponse response
	)
	throws Exception{
		
		
		Connection cn = null;
		List stationList = null;
		int i,num=0;
		Map map = null;
		List list1 = null;
		List list2 = null;
		Map map1,map2 = null;
		StringBuffer sb = new StringBuffer();
		
		
		String sql = null;
		String area_id = request.getParameter("area_id");
		String m_time = request.getParameter("m_time");
		String station_type = request.getParameter("station_type");
		try{
		cn = DBUtil.getConn();
		stationList = JspPageUtil.getStationList(cn,request);
		}catch(Exception e){
			throw e;
		}finally{DBUtil.close(cn);}
		
		sql = "select station_id,m_time,val01,val02,val04 from t_monitor_real_hour where m_time>='"+m_time+"' "
		+" and m_time<'"+m_time+" 23:59:59' and station_id in ("
		
		+"select station_id from t_cfg_station_info where station_type='"+station_type+"' "
		+" and area_id like '"+area_id+"%')"
		;
		
		
		map = JxReportUtil.getUpReport(sql);
		
		list1 = (List)map.get("1");
		list2 = (List)map.get("2");
		
		map1 = JxReportUtil.getMap(list1,"station_id");
		map2 = JxReportUtil.getMap(list2,"station_id");
		//System.out.println(map1+"\n\n"+map2);
		
		num = stationList.size();
		String v = null;
		String station_id = null;
		String station_name = null;
		Map m = null;
		Map m1 = null;
		Map m2 = null;
		String q1 = null;
		String q = null;
		double d_q1 = 0;
		double d_q = 0;
		double dv = 0;
		sb.append("<tr>\n");
		for(i=0;i<num;i++){
			
			
			sb.append("<td>").append(i+1).append("</td>\n");
			
			m = (Map)stationList.get(i);
			station_id = (String)m.get("station_id");
			station_name = (String)m.get("station_desc");
			
			sb.append("<td>").append(station_name).append("</td>\n");
			//sb.append("<td>").append("正常").append("</td>\n");
			
			
			
			
			
			m1 = (Map)map1.get(station_id);
			
			if(m1==null){m1=new HashMap();}
			
			v = (String)m1.get("q_sum");
			v = StringUtil.format(v,"#.#");
			sb.append("<td>").append(v).append("</td>");
			
			v = (String)m1.get("q_max");
			v = StringUtil.format(v,"#.#");
			sb.append("<td>").append(v).append("</td>");
			
			v = (String)m1.get("q_min");
			v = StringUtil.format(v,"#.#");
			sb.append("<td>").append(v).append("</td>");
			
			v = (String)m1.get("q_avg");
			v = StringUtil.format(v,"#.#");
			sb.append("<td>").append(v).append("</td>");
			
			v = (String)m1.get("q_count");
			v = StringUtil.format(v,"#.#");
			sb.append("<td>").append(v).append("</td>");
			
			
			v = (String)m1.get("cod_max");
			v = StringUtil.format(v,"#.#");
			sb.append("<td>").append(v).append("</td>");
			

			v = (String)m1.get("cod_min");
			v = StringUtil.format(v,"#.#");
			sb.append("<td>").append(v).append("</td>");
			

			v = (String)m1.get("cod_avg");
			v = StringUtil.format(v,"#.#");
			sb.append("<td>").append(v).append("</td>");
			
			
			//-----toc--
			

			v = (String)m1.get("toc_max");
			v = StringUtil.format(v,"#.#");
			sb.append("<td>").append(v).append("</td>");
			

			v = (String)m1.get("toc_min");
			v = StringUtil.format(v,"#.#");
			sb.append("<td>").append(v).append("</td>");
			

			v = (String)m1.get("toc_avg");
			v = StringUtil.format(v,"#.#");
			sb.append("<td>").append(v).append("</td>");
			
			
			//-------end toc
			
			
			//sb.append("<td></td>");
			
			m2 = (Map)map2.get(station_id);
			//System.out.println(m1+"\n"+m2+"\n\n-----------");
            if(m2==null){m2=new HashMap();}		
            
            d_q1 = StringUtil.getDouble((String)m2.get("q_100_sum"),0);
            d_q = StringUtil.getDouble((String)m1.get("q_sum"),0);
            
            if(d_q==0){
            	dv=0;
            }else{dv=d_q1*100/d_q;}
          
         /*   
            
		if(dv==0){
			sb.append("<td>").append("").append("</td>");
			
		}else{
			
			sb.append("<td>").append(StringUtil.format(dv+"","#.#")+"%").append("</td>");
		}
         */
            
            
		sb.append("<td>").append("").append("</td>");
		
		sb.append("</tr>\n\n\n");
		}//end for
		
		
		
		request.setAttribute("data",sb+"");
	}
	
}//end class
