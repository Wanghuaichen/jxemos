package com.hoson.action;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.hoson.StringUtil;
import com.hoson.XBean;
import com.hoson.f;
import com.hoson.app.App;
import com.hoson.search.Log;
import com.hoson.util.CacheUtil;
import com.hoson.util.DataAclUtil;
import com.hoson.util.JspPageUtil;
import com.hoson.util.WarnUtil;
import com.hoson.zdxupdate.StyleUtil;

public class WarnAction extends BaseAction {

	public String form() throws Exception {
		String station_type = null;
		String stationTypeOption = null;
		String areaOption = null;

		if (station_type == null) {
			station_type = App.getDefStationId(request);
		}

		stationTypeOption = App.getStationTypeOption(station_type, request);

		getConn();
		String area_id = App.getAreaId();
		areaOption = JspPageUtil.getAreaOption(conn, area_id);

		seta("stationTypeOption", stationTypeOption);
		seta("areaOption", areaOption);

		return null;
	}

	public String today() throws Exception {

		String station_type = p("station_type", "1");
		String area_id = p("area_id", f.cfg("area_id", "33"));
		String station_name = p("station_name");
		
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date2");
		
		List list = null;
		List infectantList = null;
		Map warnData = null;
		List warnDataList = new ArrayList();//该对象包含了主要实时的报警数据，包含了站位名称、总报警次数，各监测因子的报警次数，如果要实现排序功能，要从这一下手
		int i, num = 0;
		Map m = null;
		String station_id, station_desc = null;
		
		
		Map row = null;//

		getConn();
		list = JspPageUtil.getStationList(conn, station_type, area_id, null,
				station_name, request);//所有的站位信息
		infectantList = f.getInfectantList(conn, station_type);//所属station_type的监测因子
		close();

		//warnData = CacheUtil.getWarnDataMap();//黄宝修改
		warnData = WarnUtil.getWarnNumData(date1, date2);
		
		
		
		num = list.size();
		for (i = 0; i < num; i++) {
			m = (Map) list.get(i);
			station_id = (String) m.get("station_id");
			station_desc = (String) m.get("station_desc");
			row = (Map) warnData.get(station_id);
			if (row == null) {
				row = new HashMap();
			}
			row.put("station_id", station_id);
			row.put("station_desc", station_desc);
			warnDataList.add(row);

		}
		
		
		//下面是对异常数据的排序
	      
        Comparator<Map> comparator = new Comparator<Map>() {
            public int compare(Map o1, Map o2) {
                Object map1 = o1.get("total");
                Object map2 = o2.get("total");
                if(map1 == null ) map1 = "0";
                if(map2 == null ) map2 = "0";
                return Integer.valueOf(map2.toString()) - Integer.valueOf((map1.toString()));
            }
        };
        
        Collections.sort(warnDataList,comparator);
		
		seta("list", list);
		seta("infectantList", infectantList);
		seta("warn", warnDataList);
		return null;
	}

	public String view() throws Exception {
		String station_id = p("station_id");
		if (f.empty(station_id)) {
			throw new Exception("请选择站位");
		}
		String now = StringUtil.getNowDate() + "";
		String date1 = p("date1");
		String date2 = p("date2");

		String station_desc = null;
		Map m = null;
		String sql = null;

		if (f.empty(date1)) {
			date1 = now;
		}
		if (f.empty(date2)) {
			date2 = now;
		}
 		sql = "select station_desc from t_cfg_station_info where station_id='"
				+ station_id + "'";
		getConn();
		m = f.queryOne(conn, sql, null);
		if (m == null) {
			throw new Exception("记录不存在");
		}
		station_desc = (String) m.get("station_desc");

		List list = null;
		List infectantList = null;
		sql = "select * from t_monitor_real_hour where m_time>='" + date1
				+ "' ";
		sql = sql + " and m_time<='" + date2 + " 23:59:59'";
		sql = sql + " and station_id='" + station_id + "'";
		sql = sql + " order by m_time desc";

		list = f.query(conn, sql, null);
		infectantList = WarnUtil.getInfectantList(conn, station_id);
		close();
		list = WarnUtil.getWarnDataList(list, infectantList);

		seta("data", list);
		seta("infectant", infectantList);
		seta("date1", date1);
		seta("date2", date2);
		seta("station_id", station_id);
		seta("station_desc", station_desc);

		return null;
	}

	public String his() throws Exception {

		String station_type = p("station_type", "1");
		String area_id = p("area_id", f.cfg("area_id", "33"));
		String station_name = p("station_name");
		String sql = null;
		String option = null;
		String now = StringUtil.getNowDate() + "";
		String date1, date2 = null;
		date1 = now;
		date2 = now;
		sql = "select station_id,station_desc from t_cfg_station_info ";
		sql = sql + " where station_type='" + station_type + "' ";
		sql = sql + " and area_id like '" + area_id + "%' ";
		if (!f.empty(station_name)) {
			sql = sql + " and station_desc like '%" + station_name + "%'";
			sql = sql
					+ DataAclUtil.getStationIdInString(request, station_type,
							"station_id");
		}

		sql = sql + " order by area_id,station_desc";

		option = f.getOption(sql, null);

		seta("option", option);
		seta("date1", date1);
		seta("date2", date2);
		seta("sql", sql);

		return null;
	}

	public String hisq() throws Exception {
		
		//黄宝添加
		String data_type = null;
		String t = null;
		data_type = request.getParameter("data_type");
		//t = App.getChartTypeTable(data_type);
		t = data_type;
		if (request.getParameter("sh_flag").equals("1")) {
			t = t + "_v";
		}
		///结束
		
		
		String date1 = p("date1");
		String date2 = p("date2");
		String station_id = p("station_id");
		String sql = null;
		List list = null;
		List infectantList = null;

		if (f.empty(station_id)) {
			throw new Exception("请选择一个站位");
		}

		//sql = "select * from t_monitor_real_hour where m_time>='" + date1
		sql = "select * from "+t+" where m_time>='" + date1
				+ "' ";
		sql = sql + " and m_time<='" + date2 + " 23:59:59'";
		sql = sql + " and station_id='" + station_id + "'";
		sql = sql + " order by m_time";
		getConn();
		list = f.query(conn, sql, null);
		infectantList = WarnUtil.getInfectantList(conn, station_id);
		close();
		list = WarnUtil.getWarnDataList(list, infectantList);

		seta("data", list);
		seta("infectant", infectantList);

		return null;
	}

	public String msg() throws Exception {
		String station_id = p("station_id");
		String m_time = p("m_time");
		String sql = null;
		Map row = null;
		Map station = null;
		List infectantList = null;
		List list = new ArrayList();
		String msg = "";
		String col, v, name, unit = null;
		int i, num = 0;
		Map m = null;

		m_time = f.sub(m_time, 0, 19);

		sql = "select * from t_monitor_real_hour where station_id='"
				+ station_id + "'";
		sql = sql + " and m_time='" + m_time + "'";
		getConn();
		row = f.queryOne(conn, sql, null);
		if (row == null) {
			throw new Exception("记录不存在");
		}
		sql = "select station_id,station_desc from t_cfg_station_info where station_id='"
				+ station_id + "'";
		station = f.queryOne(conn, sql, null);
		if (row == null) {
			throw new Exception("记录不存在");
		}
		infectantList = WarnUtil.getInfectantList(conn, station_id);
		close();
		list.add(row);

		list = WarnUtil.getWarnDataList(list, infectantList);
		if (list.size() < 1) {
			throw new Exception("没有报警数据");
		}

		row = (Map) list.get(0);

		num = infectantList.size();
		for (i = 0; i < num; i++) {
			m = (Map) infectantList.get(i);
			col = (String) m.get("infectant_column");
			if (f.empty(col)) {
				continue;
			}
			v = (String) row.get(col);
			if (f.empty(v)) {
				continue;
			}
			v = f.format(v, "#.####");

			name = (String) m.get("infectant_name");
			msg = msg + name + " " + v + " ";
		}
		String station_name = (String) station.get("station_desc");
		msg = station_name + " " + m_time + " " + msg;

		seta("msg", msg);
		seta("station_id", station_id);
		seta("m_time", m_time);
		return null;
	}

	public String send_msg() throws Exception {
		String mobile = p("mobile");
		String content = p("content");
		if (f.empty(mobile)) {
			throw new Exception("请填写手机号");
		}
		mobile = mobile.trim();
		if (mobile.length() < 11) {
			throw new Exception("请填写正确的手机号");
		}
		String sql = "insert into sms_send(id,mobile,content)values(sms_seq.nextval,?,?)";
		getConn();
		f.update(conn, sql, new Object[] { mobile, content });
		return null;
	}

	static void timecheck(String date1, String date2) throws Exception {
		Timestamp t1 = f.time(date1);
		Timestamp t2 = f.time(date2);
		long dif = 0;

		dif = t2.getTime() - t1.getTime();
		dif = dif / (1000 * 24 * 60 * 60);
		if (dif > 50) {
			throw new Exception("时间间隔不能超过50天");
		}
	}
	
	public String getWarnData() throws Exception
	{
		String sql = getWarnSql(model);
		String type = model.get("type").toString();
		String title = model.get("title").toString();
		List dataList = f.query(sql,null);
		List list = new ArrayList();
		Map pm = getParamMap(model,request);
		String station_type = model.get("station_type").toString();
		sql = "select * from t_cfg_infectant_base where station_type='"+station_type+"' and (infectant_type='1' or infectant_type='2')";
		List infectant = f.query(sql,null);
		Map map,dp=null;
		String mark = "";
		for(int i=0;i<dataList.size();i++)
		{
			map = (Map)dataList.get(i);
			dp = WarnAction.getWarnDataMap(infectant,type,map,pm);
			mark = dp.get("mark").toString();
			if(mark.equals("1"))
			{
				list.add(dp);
			}
		}
		seta("data",list);
		seta("infectant",infectant);
		seta("title",title);
		return null;
	}
	
	public String getBulu() throws Exception
	{
		String sql = getBuluSql(model);
		//String type = model.get("type").toString();
		String title = model.get("title").toString();
		List dataList = f.query(sql,null);
//		List list = new ArrayList();
//		Map pm = getParamMap(model,request);
		String station_type = model.get("station_type").toString();
		sql = "select * from t_cfg_infectant_base where station_type='"+station_type+"' and (infectant_type='1' or infectant_type='2')";
		List infectant = f.query(sql,null);
//		Map map,dp=null;
//		String mark = "";
//		for(int i=0;i<dataList.size();i++)
//		{
//			map = (Map)dataList.get(i);
//			dp = WarnAction.getWarnDataMap(infectant,type,map,pm);
//			mark = dp.get("mark").toString();
//			if(mark.equals("1"))
//			{
//				list.add(dp);
//			}
//		}
		seta("data",dataList);
		seta("infectant",infectant);
		seta("title",title);
		return null;
	}
	
	public String getWuXiaoYuBulu() throws Exception
	{
		String sql = getWuXiaoYuBuluSql(model);
		//String type = model.get("type").toString();
		String title = model.get("title").toString();
		List dataList = f.query(sql,null);
//		List list = new ArrayList();
//		Map pm = getParamMap(model,request);
		String station_type = model.get("station_type").toString();
		sql = "select * from t_cfg_infectant_base where station_type='"+station_type+"' and (infectant_type='1' or infectant_type='2')";
		List infectant = f.query(sql,null);
//		Map map,dp=null;
//		String mark = "";
//		for(int i=0;i<dataList.size();i++)
//		{
//			map = (Map)dataList.get(i);
//			dp = WarnAction.getWarnDataMap(infectant,type,map,pm);
//			mark = dp.get("mark").toString();
//			if(mark.equals("1"))
//			{
//				list.add(dp);
//			}
//		}
		seta("data",dataList);
		seta("infectant",infectant);
		seta("title",title);
		return null;
	}
	
	public String getWuxiaoTj() throws Exception
	{
		String type = model.get("type").toString();
		String sql = getWuXiaoTjSql(model);
		String title = model.get("title").toString();
		List dataList = f.query(sql,null);
		seta("data",dataList);
		seta("title",title);
		return null;
	}
	public String getXgxx() throws Exception
	{
		String sql = getXgxxSql(model);
		String title = model.get("title").toString();
		List dataList = f.query(sql,null);
		seta("data",dataList);
		seta("title",title);
		return null;
	}
	/* 
	 * 对已修改的数据重新计算
	 */
	public String scshsj() throws Exception
	{
		String sql = getXgxxSql(model);
		XBean b = new XBean(model);
		String date1 = b.get("date1");
		String date2 = b.get("date2");
		String title = model.get("title").toString();
		List dataList = f.query(sql,null);
		String station_type = model.get("station_type").toString();
		sql = "select * from t_cfg_infectant_base where station_type='"+station_type+"' and (infectant_type='1' or infectant_type='2')";
		List infectant = f.query(sql,null);
		for(int i=0;i<dataList.size();i++){
			Map map = (Map)dataList.get(i);
			String station_id = (String)map.get("station_id");
			js(station_id,date1,date2,infectant);
		}
		seta("data",dataList);
		seta("title",title);
		return null;

	}
	public void js(String station_id,String date1,String date2,List infectant) throws Exception{
//		DateFormat   format=new   SimpleDateFormat("yyyy-MM-dd");
//		Date d1 = format.parse(date1);
//		Date d2 = format.parse(date2);
//		Timestamp ts1 = new Timestamp(d1.getTime());
//		Timestamp ts2 = new Timestamp(d2.getTime());
		//String sql = "select distinct convert(varchar(10),M_TIME,120) time from T_MONITOR_REAL_HOUR_V where v_flag in ('5','6','7') and " +//黄宝修改，5代表无效数据
		String sql = "select distinct convert(varchar(10),M_TIME,120) time from T_MONITOR_REAL_HOUR_V where  " +
				"station_id='"+station_id+"' and M_TIME>='"+date1+"' and M_TIME<='"+date2+"'";
		List dateList = f.query(sql,null);
		for(int i=0;i<dateList.size();i++){
			Map map = (Map)dateList.get(i);
			jsDay(station_id,map.get("time").toString(),infectant);
			jsMonth(station_id,map.get("time").toString().substring(0,7),infectant);
		}
//		while(ts2.getTime()>ts1.getTime()){
//			js(station_id,ts1.toString().substring(0,10),infectant);
//			ts1 = f.dateAdd(ts1,"day",1);
//		}
	}
	/* 
	 * 计算日均值
	 */
	public void jsDay(String station_id,String date,List infectant) throws Exception{
		String sql = "select * from T_MONITOR_REAL_HOUR_V where v_flag !='5' and STATION_ID='"+station_id+"' and convert(varchar(10),M_TIME,120)='"+date+"'";
		List dataList = f.query(sql,null);
		
		Map mapCol = new HashMap();
		String updateCol = "";
		Map temp_col = new HashMap();
		String col_save = "";
		for(int j=0;j<infectant.size();j++){
			Map mapInfectant = (Map)infectant.get(j);
			String col = mapInfectant.get("infectant_column").toString();
			col_save = (String)temp_col.get(col); 
			if(col_save==null || "".equals(col_save)){
				temp_col.put(col, col);
				updateCol = updateCol+col+"=?,";
			}
			
			if(mapInfectant.get("infectant_name").toString().indexOf("流量")==0 || mapInfectant.get("infectant_name").toString().indexOf("标况流量")==0){
				jsCol(col.toLowerCase(),mapCol,dataList,false);
			}else{
				jsCol(col.toLowerCase(),mapCol,dataList,true);
			}
		}
		String sqlUpdate = "update T_MONITOR_REAL_DAY_V set "+updateCol.substring(0,updateCol.length()-1)+" where STATION_ID='"+station_id+"' and convert(varchar(10),M_TIME,120)='"+date+"'";
		//System.out.println("sql====="+sqlUpdate);
		String cols[] = updateCol.split(",");
		Object[] ps = new Object[cols.length];
		
		for(int i=0;i<cols.length;i++){
			String col1 = cols[i].toLowerCase().substring(0,cols[i].length()-2);
			String val = mapCol.get("avg_"+col1).toString();
			ps[i] = val;
		}
		//System.out.println(sqlUpdate);
		f.update(sqlUpdate, ps);
		//request.setAttribute("type","cxjs");//黄宝添加
		//Log.insertLog("编号为："+station_id+"的站位，"+date+"时间的日均值数据被重新计算", request);
		temp_col = null;
	}
	/* 
	 * 计算月均值
	 */
	public void jsMonth(String station_id,String date,List infectant) throws Exception{
		String sql = "select * from T_MONITOR_REAL_DAY_V where v_flag!='5' and STATION_ID='"+station_id+"' and convert(varchar(7),M_TIME,120)='"+date+"'";
		List dataList = f.query(sql,null);
		
		Map mapCol = new HashMap();
		String updateCol = "";
		Map temp_col = new HashMap();
		String col_save = "";
		for(int j=0;j<infectant.size();j++){
			Map mapInfectant = (Map)infectant.get(j);
			String col = mapInfectant.get("infectant_column").toString();
			col_save = (String)temp_col.get(col); 
			if(col_save==null || "".equals(col_save)){
				temp_col.put(col, col);
				updateCol = updateCol+col+"=?,";
			}
			if(mapInfectant.get("infectant_name").toString().indexOf("流量")==0 || mapInfectant.get("infectant_name").toString().indexOf("标况流量")==0){
				jsCol(col.toLowerCase(),mapCol,dataList,false);
			}else{
				jsCol(col.toLowerCase(),mapCol,dataList,true);
			}
		}
		String sqlUpdate = "update T_MONITOR_REAL_MONTH_V set "+updateCol.substring(0,updateCol.length()-1)+" where STATION_ID='"+station_id+"' and convert(varchar(7),M_TIME,120)='"+date+"'";
		//System.out.println("sql====="+sqlUpdate);
		String cols[] = updateCol.split(",");
		Object[] ps = new Object[cols.length];
		
		for(int i=0;i<cols.length;i++){
			String col1 = cols[i].toLowerCase().substring(0,cols[i].length()-2);
			String val = mapCol.get("avg_"+col1).toString();
			ps[i] = val;
		}
		f.update(sqlUpdate, ps);
		//request.setAttribute("type", "cxjs");
		//Log.insertLog("编号为："+station_id+"的站位，"+date+"时间的月均值数据被重新计算", request);
	}
	/*
	 * 计算每个因子的均值，流量做累加
	 */
	public void jsCol(String col,Map mapCol,List dataList,boolean flag) throws Exception{
		Map map = null;
		double value = 0;
		for(int i=0;i<dataList.size();i++){
			map = (Map)dataList.get(i);
			if(!map.get(col).toString().equals("")&&map.get(col).toString()!=null){
				value = value + Double.parseDouble(f.v(map.get(col).toString()));
			}
		}
		if(flag&&dataList.size()!=0){
			value = value/dataList.size();
		}
		value = Double.parseDouble(f.format(value,"0.##"));
		mapCol.put("avg_"+col, value);
		//System.out.println("avg_"+col+":"+value);
	}
	
	public static Map getParamMap(Map model,HttpServletRequest req) throws Exception
	{
		model.put("cols","station_id,station_desc");
		model.put("order_cols","area_id,station_desc");
		Map pm = new HashMap();
		Map map = null;
		String station_id,col="";
		String sql = "select * from t_cfg_monitor_param order by station_id";
		List list = f.query(sql,null);
		for(int i=0;i<list.size();i++)
		{
			map = (Map)list.get(i);
			station_id = map.get("station_id").toString();
			col = map.get("infectant_column").toString().toLowerCase();
			pm.put(station_id+col,map);
		}
		return pm;
	}
	
	public static String getWarnSql(Map model) throws Exception
	{
		XBean b = new XBean(model);
		String station_type,area_id,trade_id,valley_id,ctl_type,date1,date2,hour1,hour2,sql;
		
		station_type = b.get("station_type");
		area_id = b.get("area_id");
		trade_id = b.get("trade_id");
		valley_id = b.get("valley_id");
		ctl_type = b.get("ctl_type");
		date1 = b.get("date1");
		date2 = b.get("date2");
		hour1 = b.get("hour1");
		hour2 = b.get("hour2");
		date1 = date1 +" "+hour1+":00:00";
		date2 = date2 +" "+hour2+":59:59";
		
		String table = "T_MONITOR_REAL_HOUR";
		
		String sh_flag = b.get("sh_flag");
		
		if (sh_flag.equals("1")) {
			table = table + "_v";
		}
		//sql = "select st.STATION_ID,st.STATION_DESC,st.STATION_BZ,rh.* from T_CFG_STATION_INFO st left join T_MONITOR_REAL_HOUR rh on st.STATION_ID=rh.STATION_ID where rh.M_TIME is not null and st.STATION_TYPE='"+station_type+"' and st.AREA_ID like '"+area_id+"%'";
		  //sql = "select st.STATION_ID,st.STATION_DESC,st.STATION_BZ,rh.* from T_CFG_STATION_INFO st left join "+table+" rh on st.STATION_ID=rh.STATION_ID where rh.M_TIME is not null and st.STATION_TYPE='"+station_type+"' and st.AREA_ID like '"+area_id+"%'";//黄宝修改过
		sql = "select st.STATION_ID,st.STATION_DESC,st.STATION_BZ,rh.* from T_CFG_STATION_INFO st left join "+table+" rh on st.STATION_ID=rh.STATION_ID where st.show_flag !='1' and rh.M_TIME is not null and st.STATION_TYPE='"+station_type+"' and st.AREA_ID like '"+area_id+"%'";//黄宝修改过
		if(!f.empty(valley_id))
		{
			sql = sql + " and st.VALLEY_ID='"+valley_id+"'";
		}
		if(!f.empty(trade_id))
		{
			//sql = sql + " and st.TRADE_ID='"+trade_id+"'";黄宝修改
			sql = sql + " and st.TRADE_ID like '"+trade_id+"%'";
		}
		if(!f.empty(ctl_type))
		{
			//sql = sql + " and st.CTL_TYPE>='"+ctl_type+"'";
			sql = sql + " and st.CTL_TYPE ='"+ctl_type+"'";//黄宝  修改
		}
		sql = sql + " and rh.M_TIME>='"+date1+"' and rh.M_TIME<='"+date2+"' order by st.STATION_ID,st.AREA_ID,rh.M_TIME desc";
		return sql;
	}
	
	public static String getBuluSql(Map model) throws Exception
	{
		XBean b = new XBean(model);
		String station_type,area_id,trade_id,valley_id,ctl_type,date1,date2,hour1,hour2,sql;
		
		station_type = b.get("station_type");
		area_id = b.get("area_id");
		trade_id = b.get("trade_id");
		valley_id = b.get("valley_id");
		ctl_type = b.get("ctl_type");
		//String type = b.get("type");
		date1 = b.get("date1");
		date2 = b.get("date2");
		hour1 = b.get("hour1");
		hour2 = b.get("hour2");
		date1 = date1 +" "+hour1+":00:00";
		date2 = date2 +" "+hour2+":59:59";
		//sql = "select st.STATION_ID,st.STATION_DESC,st.STATION_BZ,rh.* from T_CFG_STATION_INFO st left join T_MONITOR_REAL_HOUR_V rh on st.STATION_ID=rh.STATION_ID where rh.M_TIME is not null and st.STATION_TYPE='"+station_type+"' and st.AREA_ID like '"+area_id+"%'";//黄宝修改
		sql = "select st.STATION_ID,st.STATION_DESC,st.STATION_BZ,rh.* from T_CFG_STATION_INFO st left join T_MONITOR_REAL_HOUR_V rh on st.STATION_ID=rh.STATION_ID where st.show_flag !='1' and rh.M_TIME is not null and st.STATION_TYPE='"+station_type+"' and st.AREA_ID like '"+area_id+"%'";
		if(!f.empty(valley_id))
		{
			sql = sql + " and st.VALLEY_ID='"+valley_id+"'";
		}
		if(!f.empty(trade_id))
		{
			//sql = sql + " and st.TRADE_ID='"+trade_id+"'";//黄宝  修改
			sql = sql + " and st.TRADE_ID like '"+trade_id+"%'";
		}
		if(!f.empty(ctl_type))
		{
			//sql = sql + " and st.CTL_TYPE>='"+ctl_type+"'";
			sql = sql + " and st.CTL_TYPE='"+ctl_type+"'";
		}
		sql = sql + " and rh.M_TIME>='"+date1+"' and rh.M_TIME<='"+date2+"' and (rh.v_flag='5' or rh.v_flag='7') order by st.STATION_ID,st.AREA_ID,rh.M_TIME desc";
		return sql;
	}
	
	public static String getWuXiaoYuBuluSql(Map model) throws Exception
	{
		XBean b = new XBean(model);
		String station_type,area_id,trade_id,valley_id,ctl_type,date1,date2,hour1,hour2,sql;
		
		station_type = b.get("station_type");
		area_id = b.get("area_id");
		trade_id = b.get("trade_id");
		valley_id = b.get("valley_id");
		ctl_type = b.get("ctl_type");
		String type = b.get("type");
		date1 = b.get("date1");
		date2 = b.get("date2");
		hour1 = b.get("hour1");
		hour2 = b.get("hour2");
		date1 = date1 +" "+hour1+":00:00";
		date2 = date2 +" "+hour2+":59:59";
		//sql = "select st.STATION_ID,st.STATION_DESC,st.STATION_BZ,rh.* from T_CFG_STATION_INFO st left join T_MONITOR_REAL_HOUR_V rh on st.STATION_ID=rh.STATION_ID where rh.M_TIME is not null and st.STATION_TYPE='"+station_type+"' and st.AREA_ID like '"+area_id+"%'";//黄宝修改
		sql = "select st.STATION_ID,st.STATION_DESC,st.STATION_BZ,rh.* from T_CFG_STATION_INFO st left join T_MONITOR_REAL_HOUR_V rh on st.STATION_ID=rh.STATION_ID where st.show_flag !='1' and rh.M_TIME is not null and st.STATION_TYPE='"+station_type+"' and st.AREA_ID like '"+area_id+"%'";
		if(!f.empty(valley_id))
		{
			sql = sql + " and st.VALLEY_ID='"+valley_id+"'";
		}
		if(!f.empty(trade_id))
		{
			//sql = sql + " and st.TRADE_ID='"+trade_id+"'";//黄宝  修改
			sql = sql + " and st.TRADE_ID like '"+trade_id+"%'";
		}
		if(!f.empty(ctl_type))
		{
			//sql = sql + " and st.CTL_TYPE>='"+ctl_type+"'";
			sql = sql + " and st.CTL_TYPE='"+ctl_type+"'";
		}
		//sql = sql + " and rh.M_TIME>='"+date1+"' and rh.M_TIME<='"+date2+"' and (rh.v_flag='5' or rh.v_flag='7') order by st.STATION_ID,st.AREA_ID,rh.M_TIME desc";//黄宝修改
		sql = sql + " and rh.M_TIME>='"+date1+"' and rh.M_TIME<='"+date2+"' and rh.v_flag='"+type+"' order by st.STATION_ID,st.AREA_ID,rh.M_TIME desc";
		return sql;
	}
	
	public static String getWuXiaoTjSql(Map model) throws Exception
	{
		XBean b = new XBean(model);
		String station_type,area_id,trade_id,valley_id,ctl_type,date1,date2,hour1,hour2,sql;
		
		station_type = b.get("station_type");
		area_id = b.get("area_id");
		trade_id = b.get("trade_id");
		valley_id = b.get("valley_id");
		ctl_type = b.get("ctl_type");
		String type = b.get("type");
		date1 = b.get("date1");
		date2 = b.get("date2");
		hour1 = b.get("hour1");
		hour2 = b.get("hour2");
		date1 = date1 +" "+hour1+":00:00";
		date2 = date2 +" "+hour2+":59:59";
		sql = "select st.STATION_DESC,t2.* from T_CFG_STATION_INFO st, ("+
			"select STATION_ID,COUNT(STATION_ID) num from T_MONITOR_REAL_HOUR_V where v_flag='"+type+"' and M_TIME>='"+date1+"' and M_TIME<='"+date2+"' group by STATION_ID) t2"+
			" where st.STATION_ID=t2.STATION_ID and st.STATION_TYPE='"+station_type+"' and st.AREA_ID like '"+area_id+"%'";
		if(!f.empty(valley_id))
		{
			sql = sql + " and st.VALLEY_ID='"+valley_id+"'";
		}
		if(!f.empty(trade_id))
		{
			sql = sql + " and st.TRADE_ID='"+trade_id+"'";
		}
		if(!f.empty(ctl_type))
		{
			//sql = sql + " and st.CTL_TYPE>='"+ctl_type+"'";//黄宝修改
			sql = sql + " and st.CTL_TYPE='"+ctl_type+"'";
		}
		//sql = sql + " and rh.M_TIME>='"+date1+"' and rh.M_TIME<='"+date2+"' and rh.v_flag='"+type+"' order by st.STATION_ID,st.AREA_ID,rh.M_TIME desc";
		return sql;
	}
	
	public static String getXgxxSql(Map model) throws Exception
	{
		XBean b = new XBean(model);
		String station_type,area_id,trade_id,valley_id,ctl_type,date1,date2,hour1,hour2,sql;
		
		station_type = b.get("station_type");
		area_id = b.get("area_id");
		trade_id = b.get("trade_id");
		valley_id = b.get("valley_id");
		ctl_type = b.get("ctl_type");
		date1 = b.get("date1");
		date2 = b.get("date2");
		hour1 = b.get("hour1");
		hour2 = b.get("hour2");
		date1 = date1 +" "+hour1+":00:00";
		date2 = date2 +" "+hour2+":59:59";
		sql = "select st.STATION_DESC,t2.* from T_CFG_STATION_INFO st, ("+
			//"select STATION_ID,COUNT(STATION_ID) num from T_MONITOR_REAL_HOUR_V where v_flag in ('5','6','7') and M_TIME>='"+date1+"' and M_TIME<='"+date2+"' group by STATION_ID) t2"+//黄宝修改，5代表无效数据
		"select STATION_ID,COUNT(STATION_ID) num from T_MONITOR_REAL_HOUR_V where v_flag !='5' and M_TIME>='"+date1+"' and M_TIME<='"+date2+"' group by STATION_ID) t2"+
			" where st.STATION_ID=t2.STATION_ID and st.STATION_TYPE='"+station_type+"' and st.AREA_ID like '"+area_id+"%'";//黄宝修改
		
		if(!f.empty(valley_id))
		{
			sql = sql + " and st.VALLEY_ID='"+valley_id+"'";
		}
		if(!f.empty(trade_id))
		{
			sql = sql + " and st.TRADE_ID='"+trade_id+"'";
		}
		if(!f.empty(ctl_type))
		{
			//sql = sql + " and st.CTL_TYPE>='"+ctl_type+"'";//黄宝修改
			sql = sql + " and st.CTL_TYPE='"+ctl_type+"'";
		}
		return sql;
	}
	
	public static Map getWarnDataMap(List paramList,String type,Map map,Map pm) throws Exception
	{
		String levlo = "lo";
		String levhi = "hi";
		if(type.equals("1"))
		{
			levlo = "lolo";//低报警
			levhi = "hihi";//高报警
		}
		if(type.equals("2"))
		{
			levlo = "lolololo";//量程下限
			levhi = "hihihihi";//量程上限
		}
		XBean db = new XBean(map);
		Map rp = new HashMap();
		rp.put("station_desc",db.get("station_desc"));
		rp.put("station_id",db.get("station_id"));
		String station_id = db.get("station_id");
		rp.put("v_flag", db.get("v_flag"));
		rp.put("mark","0");
		String col,lo,hi,v ="";
		for(int x=0;x<paramList.size();x++)
		{
			Map p = (Map)paramList.get(x);
			XBean xb = new XBean(p);
			col = xb.get("infectant_column").toLowerCase();
			Map mp = (Map)pm.get(station_id+col);
			if(mp==null){continue;}
			XBean pb = new XBean(mp);
			lo = pb.get(levlo);
			hi = pb.get(levhi);
			v = db.get(col);
			v = f.v(v);
			if(!StringUtil.isNum(v)&&!f.empty(v))
			{
				rp.put("m_time",db.get("m_time"));
				rp.put(col,v);
				rp.put("mark","1");
			}
			else if(StringUtil.isNum(v))
			{
				double d_v = Double.parseDouble(v);
				if(!f.empty(lo))
				{
					double d_lo = Double.parseDouble(lo);
					if(d_v>0&&d_v<d_lo&&d_lo!=0)
					{
						rp.put("m_time",db.get("m_time"));
						rp.put(col,v);
						rp.put("mark","1");
					}
				}
				if(!f.empty(hi))
				{
					double d_hi = Double.parseDouble(hi);
					if(d_v>0&&d_v>d_hi&&d_hi!=0)
					{
						rp.put("m_time",db.get("m_time"));
						rp.put(col,v);
						rp.put("mark","1");
					}
				}
			}
		}
		return rp;
	}
	public String w() throws Exception
	{
		String stationTypeOption = f.getStationTypeOption(null);
		String areaOption = f.getAreaOption(null);
		String tradeOption = f.getTradeOption(null);
		String valleyOption = f.getValleyOption(null);
		String ctlOption = f.getCtlTypeOption(null);
		String hour1Option = f.getHourOption("0");
		String hour2Option = f.getHourOption("23");
		seta("stationTypeOption",stationTypeOption);
		seta("areaOption",areaOption);
		seta("tradeOption",tradeOption);
		seta("valleyOption",valleyOption);
		seta("ctlOption",ctlOption);
		seta("hour1Option",hour1Option);
		seta("hour2Option",hour2Option);
		return null;
	}
	public String p_wh() throws Exception
	{
		XBean b = new XBean(model);
		String station_id = b.get("station_id");
		String sql = "select station_desc from t_cfg_station_info where station_id='"+station_id+"'";
		Map st = f.queryOne(sql,null);
		String station_desc = st.get("station_desc").toString();
		
		String date1 = b.get("date1");
		String date2 = b.get("date2");
		String hour1 = b.get("hour1");
		String hour2 = b.get("hour2");
		
		String d1 = date1+" "+hour1+":00:00.0";
		String d2 = date2+" "+hour2+":59:00.0";
		Timestamp t1 = f.time(d1);
		Timestamp t2 = f.time(d2);
		int hour = (int)((t2.getTime()-t1.getTime())/1000/60+1)/60;
		sql = "select tp.infectant_column,ti.infectant_name from t_cfg_monitor_param tp left join t_cfg_infectant_base ti on tp.infectant_id=ti.infectant_id where station_id='"+station_id+"'";
		List paramList = f.query(sql,null);
		Map pm = new HashMap();
		Map m = null;//黄宝修改的
		List ml = null;
		String col;
		int num=0;
		double n,p=0;
		String s = "";
		
		String table = "T_MONITOR_REAL_HOUR";
		String sh_flag = request.getParameter("sh_flag");
		if("".equals(sh_flag) || sh_flag == null)sh_flag="0";
		if (sh_flag.equals("1")) {
			table = table + "_v";
		}
		
		for(int i=0;i<paramList.size();i++)
		{
			m = (Map)paramList.get(i);
			col = m.get("infectant_column").toString();
			//sql = "select count(m_time) as num from T_MONITOR_REAL_HOUR where "+col+" is not null and "+col+"!='' and M_TIME>='"+d1+"' and M_TIME<='"+d2+"' and station_id='"+station_id+"'";
			//m = f.queryOne(sql,null);
			//num = m.get("num").toString();黄宝修改的
			sql = "select m_time as num from "+table+" where "+col+" is not null and "+col+"!='' and M_TIME>='"+d1+"' and M_TIME<='"+d2+"' and station_id='"+station_id+"'";
			ml = f.query(sql,null);
			num = ml.size();
			n = Double.parseDouble(String.valueOf(num));
			p = n/hour*100;
			p = StyleUtil.dformat(p);
			pm.put(col.toLowerCase(),p+"%");
			
			s = "";
			//已经存在的时间
			for(int k=0;k<ml.size();k++)
			 {
				 Map mp = (Map)ml.get(k);
				 XBean b1 = new XBean(mp);
				 String m_time = (String)b1.get("num");
				 s = s+m_time+",";
			 }

			//选择的时间
			String dateOption = "";
			int numHour = (int)((t2.getTime()-t1.getTime())/1000+1)/60/60;
			for(int j=0;j<=numHour;j++){
				String t = f.dateAdd(t1, "hour", j).toString();
				if(s.indexOf(t)==-1){
					dateOption=dateOption+"<option value='"+t+"'>"+t+"</option>\n";
				}
			}//只补录不存在的数据,有时间段的数据，不能补录
			//seta("dateOption",dateOption);
			pm.put("dateOption"+col.toLowerCase(),dateOption);
		}
		
		
		String title = date1+" "+hour1+"时 至 "+date2+" "+hour2+"时 "+station_desc+" 完好率";
		seta("station_id",station_id);
		seta("date1",date1);
		seta("hour1",hour1);
		seta("date2",date2);
		seta("hour2",hour2);
		seta("station_desc",station_desc);
		seta("title",title);
		seta("sh_flag",sh_flag);
		seta("pm",pm);
		seta("infectant",paramList);
		return null;
	}


}