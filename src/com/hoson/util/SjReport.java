package com.hoson.util;

import java.util.*;

import com.hoson.StringUtil;
import com.hoson.f;
import javax.servlet.http.*;
import com.hoson.ErrorMsg;
import java.sql.Timestamp;
import com.hoson.XBean;

//20090316
//省局平台改进报表 
//监测数据报表 加上总量
//管理统计 联网率 有效数据获取率 报警次数 远程控制数 

public class SjReport{
	
	private static Map dataTableMap = new HashMap();
	static{
		dataTableMap.put("t_monitor_real_hour","小时数据");
		dataTableMap.put("t_monitor_real_day","日数据");
		dataTableMap.put("t_monitor_real_week","周均值");
		dataTableMap.put("t_monitor_real_month","月汇总数据");
		dataTableMap.put("T_MONITOR_REAL_TEN_MINUTE","十分钟数据");
		 
	}
	
   public static void getReportTitle(HttpServletRequest request)throws Exception{
		
		String station_type,station_id,date1,date2,data_table;
		Map m = null;
		String sql = null;
		String station_name,area_id,area_name = null;
		XBean b = null;
		
		station_type = f.p(request,"station_type");
		station_id = f.p(request,"station_id");
		date1 = f.p(request,"date1");
		date2 = f.p(request,"date2");
		data_table = f.p(request,"rpt_data_table");
		
		sql = "select station_desc,area_id from t_cfg_station_info where station_id='"+station_id+"'";
		m = f.queryOne(sql,null);
		b =new XBean(m);
		station_name = b.get("station_desc");
		area_id = b.get("area_id");
		
		sql = "select area_name from t_cfg_area where area_id='"+area_id+"'";
		m = f.queryOne(sql,null);
		b =new XBean(m);
		area_name = b.get("area_name");
		//f.sop(data_table);
		data_table = (String)dataTableMap.get(data_table);
		//f.sop(data_table+",2");
		
		request.setAttribute("station_id",station_id);
		request.setAttribute("station_name",station_name);
		request.setAttribute("area_name",area_name);
		request.setAttribute("date1",date1);
		request.setAttribute("date2",date2);
		request.setAttribute("data_table",data_table);
		
		
		
	}
	
	
	public static void form(HttpServletRequest request)throws Exception{
		
		
		
		
	}
	
	public static void getDataListOverZero(List list,String cols)throws Exception{
		String[]arr=cols.split(",");
		int i,colnum=0;
		colnum=arr.length;
		int j,num=0;
		Map m = null;
		Double obj = null;
		String col = null;
		
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			//obj = (Double)m.get(arr[])
			
			for(j=0;j<colnum;j++){
				col = arr[j];
				obj = (Double)m.get(col);
				if(obj==null){continue;}
				//if(obj.doubleValue()<=0){m.put(col,null);}//黄宝修改 报表0显示
				if(obj.doubleValue()<0){m.put(col,null);}
			}
		}
		
		
		
	}
	
	
	public static String tj_cols(String cols,String gross_cols){
		String[]arr=gross_cols.split(",");
		int i,num=0;
		String s="";
		num=arr.length;
		for(i=0;i<num;i++){
			if(i>0){s=s+",";}
			s=s+arr[i]+"_q";
		}
		s=cols+","+s;
		return s;
	}
	
	
    public static void water(HttpServletRequest request)throws Exception{
    	
    	get_report_info(request);
    	
    	
    	String data_table,r_data_table,station_id,date1,date2,hour1,hour2;
		String w_cols,w_gross_cols,w_q_col;
		String sql = null;
		Timestamp t1,t2;
		Object[]ps;;
		List list = null;
		Map tj = new HashMap();
		String tj_cols = null;
		
		//System.out.println("sh_flag11==="+request.getParameter("sh_flag"));
		
		//System.out.println(data_table);
		station_id = f.p(request,"station_id");
		date1 = f.p(request,"date1");
		date2 = f.p(request,"date2");
		hour1 = f.p(request,"hour1");
		hour2 = f.p(request,"hour2");
		
		w_cols = f.p(request,"w_cols");
		w_gross_cols = f.p(request,"w_gross_cols");
		w_q_col = f.p(request,"w_q_col");
		
		tj_cols = tj_cols(w_cols,w_gross_cols);
		
		java.text.NumberFormat  formater  =  java.text.DecimalFormat.getInstance();  
		formater.setMaximumFractionDigits(3);  
		formater.setMinimumFractionDigits(3);
		
		if(f.empty(station_id)){ErrorMsg.station_id_empty();}
		
		
		
		data_table = f.p(request,"rpt_data_table");
		r_data_table = data_table;
		
		sql = "select station_id,m_time,"+w_cols+" from "+data_table;//新增v_flag字段，就是把无效的数据抽取出来，黄宝 
		sql=sql+" where station_id=? ";
		sql=sql+" and  m_time>=? and m_time<=? ";
		sql=sql+" order by m_time asc ";
		
		if(request.getParameter("sh_flag").equals("1")){
			data_table = data_table+"_v";
			sql = "select station_id,m_time,v_flag,"+w_cols+" from "+data_table;//新增v_flag字段，就是把无效的数据抽取出来，黄宝 
			sql=sql+" where station_id=? ";
			sql=sql+" and  m_time>=? and m_time<=? ";
			sql=sql+" order by m_time asc ";
		}
		//sql = "select station_id,m_time,"+w_cols+" from "+data_table;
		
		
		//f.sop(sql);
		if(hour1!=null){
			t1 = f.time(date1+" "+hour1+":00:00");
			t2 = f.time(date2+" "+hour2+":59:59");
		}else{
			t1 = f.time(date1+" "+"00:00:00");
			t2 = f.time(date2+" "+"23:59:59");
		}
		ps = new Object[]{station_id,t1,t2};
		String data_type = f.p(request,"data_type");
		String rpt_data_table = f.p(request,"rpt_data_table");
		if(data_type == null){
			list = f.query(sql,ps);
			SxReportUtil.getDataList(list,w_cols);
			
			getDataListOverZero(list,w_cols);
			
			StdReportUtil.qs(list,w_q_col,w_gross_cols);
			StdReportUtil.hztjs(list,tj_cols,tj);
		}else{
			if(data_type.equals("normal") && rpt_data_table.equals("rendom_time")){
				sql = "select station_id,m_time,"+w_cols+" from t_monitor_real_day";
				sql=sql+" where station_id=? ";
				sql=sql+" and  m_time>=? and m_time<=? ";
				sql=sql+" order by m_time asc ";
				list = f.query(sql,ps);
				
				SxReportUtil.getDataList(list,w_cols);
				
				getDataListOverZero(list,w_cols);
				
				StdReportUtil.qs(list,w_q_col,w_gross_cols);
				StdReportUtil.hztjs(list,tj_cols,tj);
				
				w_cols = w_cols+",val01_q,val02_q,val03_q,val04_q,val05_q,val06_q,val07_q,val08_q,val16_q,val17_q";
				String cols[] = w_cols.split(",");
				Map map = new HashMap();
				Map map2 = new HashMap();
				double value = 0.0;
				int num =list.size();
				for(int i=0;i<num;i++){
					map = (Map)list.get(i);
					for(int n=0;n<cols.length;n++){
						if(map.get(cols[n])!=null&&!map.get(cols[n]).toString().equals("")){
							if(map2.get(cols[n])!=null&&!map2.get(cols[n]).toString().equals("")){
								value = StringUtil.getDouble(map2.get(cols[n]).toString(),0)+StringUtil.getDouble(map.get(cols[n]).toString(),0);
								if(i==num-1){
									String s = String.valueOf(value/num);
									map2.put(cols[n], s);
								}else{
									map2.put(cols[n], String.valueOf(value));
								}
							}else{
								map2.put(cols[n], (map.get(cols[n])));
							}
						}
					}
				}
				map2.put("m_time", "从"+date1+"到"+date2);
				list.clear();
				list.add(map2);
				request.setAttribute("len",Integer.valueOf("25"));
				
			}else if(data_type.equals("normal")){
				list = f.query(sql,ps);
			}else if(data_type.equals("warning")){
				list = getWarnExcpList(w_cols,ps,"0");
			}else if(data_type.equals("exception")){
				list = getWarnExcpList(w_cols,ps,"1");
			}
			if(!(data_type.equals("normal")&&rpt_data_table.equals("rendom_time"))&&!data_type.equals("warning")&&!data_type.equals("exception")){
				SxReportUtil.getDataList(list,w_cols);
				
				getDataListOverZero(list,w_cols);
				
				StdReportUtil.qs(list,w_q_col,w_gross_cols);
				StdReportUtil.hztjs(list,tj_cols,tj);
			}
		}
		
		
		request.setAttribute("list",list);
		request.setAttribute("tj",tj);
		request.setAttribute("sql",sql);
		request.setAttribute("r_data_table", r_data_table);
		
		
		getReportTitle(request);
		
		  
		
		
	}
    
    //汇总报表中的污染源烟气的累积统计
    public static void hzbb_gas(HttpServletRequest request)throws Exception{
    	
    	String date1,date2,station_type,area_id,valley_id,trade_id,hzbb_type;
    	String data_table = "T_MONITOR_REAL_HOUR";
		String g_cols,g_gross_cols,g_q_col;
		String sql = null;
		Timestamp t1,t2;
		Object[]ps;;
		List list = null;
		List hzbb_list = new ArrayList(); 
		Map m = new HashMap();
		String tj_cols = null;
		String data_flag = "";//标志是按行业或地区或流域，还是按企业统计

		date1 = f.p(request,"date1");
		date2 = f.p(request,"date2");
		
		g_cols = f.p(request,"g_cols");
		g_gross_cols = f.p(request,"g_gross_cols");
		g_q_col = f.p(request,"g_q_col");
		tj_cols = tj_cols(g_cols,g_gross_cols);
		
		station_type = request.getParameter("station_type");
		hzbb_type = request.getParameter("hzbb_type");

		area_id = request.getParameter("area_id");
		valley_id = request.getParameter("valley_id");
		trade_id = request.getParameter("trade_id");
		
		java.text.NumberFormat  formater  =  java.text.DecimalFormat.getInstance();  
		formater.setMaximumFractionDigits(3);  
		formater.setMinimumFractionDigits(3);		
		
		if(request.getParameter("sh_flag").equals("1")){
			data_table = data_table+"_v";
		}
		
		date1 = date1+" "+"00:00:00";
		date2 = date2+" "+"23:59:59";
		
		sql = "select b.station_desc as station_name,b.station_id,b.trade_id,b.area_id,b.valley_id,m_time, "+ g_cols;
		sql = sql + " from " + data_table + " a ,";
		sql = sql + "t_cfg_station_info b ";
		sql = sql + " where a.station_id=b.station_id and b.station_type='"+ station_type + "' and b.show_flag !='1' ";//黄宝修改

		sql = sql + " and m_time>='" + date1 + "' and m_time <='"+date2+"'";
        
		if (!StringUtil.isempty(area_id)) {
			sql = sql + " and a.station_id in(";
			sql = sql + "select station_id from t_cfg_station_info where ";
			sql = sql + "area_id like '" + area_id + "%') ";

		}
		if (!StringUtil.isempty(valley_id) && !valley_id.equals("1100000000")) {
			sql = sql + " and a.station_id in(";
			sql = sql + "select station_id from t_cfg_station_info where ";

			sql = sql + "valley_id like '" + valley_id + "%') ";
		}
		if (!StringUtil.isempty(trade_id) && !trade_id.equals("root")) {
			sql = sql + " and a.station_id in(";
			sql = sql + "select station_id from t_cfg_station_info where ";

			sql = sql + "trade_id like '" + trade_id + "%') ";
		}


		list = f.query(sql,null);
		SxReportUtil.getDataList(list,g_cols);
		
		getDataListOverZero(list,g_cols);
		
		StdReportUtil.qs(list,g_q_col,g_gross_cols);
		//StdReportUtil.hztjs(list,tj_cols,tj);
		//request.setAttribute("list",list);
		//request.setAttribute("sql",sql);
		
		List dataList = new ArrayList();
		int num = 0;
		int num_t = list.size();
		String id = "";
		String id_t = "";
		String t = "";
		Map m_t = new HashMap();
		float val06_q=0,val11=0,val05_q=0,val07_q=0;
		float z_val06_q=0,z_val11=0,z_val05_q=0,z_val07_q=0;
		String format = "0.0000";
		
		if(!"".equals(hzbb_type) && hzbb_type.equals("area")){//按地区分类
			sql = "select AREA_NAME as name,AREA_id,AREA_pid from T_CFG_AREA where area_pid ='"+area_id+"' order by area_id asc";
			hzbb_list = f.query(sql, null);
			num = hzbb_list.size();
			if(num >0){//到市一级，到县一级。按市、县统计。
					for(int i=0;i<num;i++){
						m = (Map)hzbb_list.get(i);
						id = m.get("area_id")+"";
						val06_q=0;val11=0;val05_q=0;val07_q=0;
						for(int j=0;j<num_t;j++){
							m_t = (Map)list.get(j);
							id_t = m_t.get("area_id")+"";
							
							if(id_t.indexOf(id)>=0){
								t = m_t.get("val06_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val06_q = val06_q + Float.valueOf(t);
								}
								t = m_t.get("val11")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val11 = val11 + Float.valueOf(t);
								}
								t = m_t.get("val05_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val05_q = val05_q + Float.valueOf(t);
								}
								t = m_t.get("val07_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val07_q = val07_q + Float.valueOf(t);
								}
								
							}
						}
						m.put("val06_q", f.format(val06_q/1000000,format));
						m.put("val11", f.format(val11,format));
						m.put("val05_q", f.format(val05_q/1000000,format));
						m.put("val07_q", f.format(val07_q/1000000,format));
						z_val06_q = z_val06_q + val06_q;
						z_val11 = z_val11 + val11;
						z_val05_q = z_val05_q + val05_q;
						z_val07_q = z_val07_q + val07_q;
						dataList.add(m);
					}
			}else{//到县一级，这时显示的就是企业信息
					sql = "select  station_desc as name ,* from t_cfg_station_info where station_type='"+ station_type + "' and show_flag !='1' and area_id like '"+area_id+"%' order by area_id desc";
					hzbb_list = f.query(sql, null);
					num = hzbb_list.size();
					for(int i=0;i<num;i++){
						m = (Map)hzbb_list.get(i);
						id = m.get("station_id")+"";
						val06_q=0;val11=0;val05_q=0;val07_q=0;
						for(int j=0;j<num_t;j++){
							m_t = (Map)list.get(j);
							id_t = m_t.get("station_id")+"";
							
							if(id_t.indexOf(id)>=0){
								t = m_t.get("val06_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val06_q = val06_q + Float.valueOf(t);
								}
								t = m_t.get("val11")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val11 = val11 + Float.valueOf(t);
								}
								t = m_t.get("val05_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val05_q = val05_q + Float.valueOf(t);
								}
								t = m_t.get("val07_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val07_q = val07_q + Float.valueOf(t);
								}
							}
						}
						m.put("val06_q", f.format(val06_q/1000000,format));
						m.put("val11", f.format(val11,format));
						m.put("val05_q", f.format(val05_q/1000000,format));
						m.put("val07_q", f.format(val07_q/1000000,format));
						z_val06_q = z_val06_q + val06_q;
						z_val11 = z_val11 + val11;
						z_val05_q = z_val05_q + val05_q;
						z_val07_q = z_val07_q + val07_q;
						dataList.add(m);
					}
					
					data_flag = "data_flag_N";
				
			}
			
		}else if(!"".equals(hzbb_type) && hzbb_type.equals("trade")){//按行业
			sql = "select trace_name as name,trade_id,PARENTNODE from T_CFG_TRADE where PARENTNODE ='"+trade_id+"' order by trade_id asc";
			hzbb_list = f.query(sql, null);
			num = hzbb_list.size();
			if(num >0 && trade_id.equals("root")){//按顶层统计
					for(int i=0;i<num;i++){
						m = (Map)hzbb_list.get(i);
						id = m.get("trade_id")+"";
						val06_q=0;val11=0;val05_q=0;val07_q=0;
						for(int j=0;j<num_t;j++){
							m_t = (Map)list.get(j);
							id_t = m_t.get("trade_id")+"";
							
							if(id_t.indexOf(id)>=0){
								t = m_t.get("val06_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val06_q = val06_q + Float.valueOf(t);
								}
								t = m_t.get("val11")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val11 = val11 + Float.valueOf(t);
								}
								t = m_t.get("val05_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val05_q = val05_q + Float.valueOf(t);
								}
								t = m_t.get("val07_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val07_q = val07_q + Float.valueOf(t);
								}
							}
						}
						m.put("val06_q", f.format(val06_q/1000000,format));
						m.put("val11", f.format(val11,format));
						m.put("val05_q", f.format(val05_q/1000000,format));
						m.put("val07_q", f.format(val07_q/1000000,format));
						z_val06_q = z_val06_q + val06_q;
						z_val11 = z_val11 + val11;
						z_val05_q = z_val05_q + val05_q;
						z_val07_q = z_val07_q + val07_q;
						dataList.add(m);
					}
			}else{//按企业分类
				sql = "select station_desc as name ,* from t_cfg_station_info where station_type='"+ station_type + "' and show_flag !='1' and trade_id like '"+trade_id+"%' order by trade_id desc";
				hzbb_list = f.query(sql, null);
				num = hzbb_list.size();
				for(int i=0;i<num;i++){
					m = (Map)hzbb_list.get(i);
					id = m.get("station_id")+"";
					val06_q=0;val11=0;val05_q=0;val07_q=0;
					for(int j=0;j<num_t;j++){
						m_t = (Map)list.get(j);
						id_t = m_t.get("station_id")+"";
						
						if(id_t.indexOf(id)>=0){
							t = m_t.get("val06_q")+"";
							if(t != null && !"".equals(t) && !"null".equals(t)){
							   val06_q = val06_q + Float.valueOf(t);
							}
							t = m_t.get("val11")+"";
							if(t != null && !"".equals(t) && !"null".equals(t)){
							   val11 = val11 + Float.valueOf(t);
							}
							t = m_t.get("val05_q")+"";
							if(t != null && !"".equals(t) && !"null".equals(t)){
							   val05_q = val05_q + Float.valueOf(t);
							}
							t = m_t.get("val07_q")+"";
							if(t != null && !"".equals(t) && !"null".equals(t)){
							   val07_q = val07_q + Float.valueOf(t);
							}
						}
					}
					m.put("val06_q", f.format(val06_q/1000000,format));
					m.put("val11", f.format(val11,format));
					m.put("val05_q", f.format(val05_q/1000000,format));
					m.put("val07_q", f.format(val07_q/1000000,format));
					z_val06_q = z_val06_q + val06_q;
					z_val11 = z_val11 + val11;
					z_val05_q = z_val05_q + val05_q;
					z_val07_q = z_val07_q + val07_q;
					dataList.add(m);
				}
				data_flag = "data_flag_N";
			}
		}else{//按流域
			sql = "select VALLEY_NAME as name,VALLEY_id,PARENT_ID from  t_cfg_valley where  PARENT_ID='"+valley_id+"' order by valley_id desc";
			hzbb_list = f.query(sql, null);
			num = hzbb_list.size();
			if(num >0 && valley_id.equals("1100000000")){//按顶层流域分类
					for(int i=0;i<num;i++){
						m = (Map)hzbb_list.get(i);
						id = (m.get("valley_id")+"").substring(0,4);
						val06_q=0;val11=0;val05_q=0;val07_q=0;
						for(int j=0;j<num_t;j++){
							m_t = (Map)list.get(j);
							id_t = m_t.get("valley_id")+"";
							
							if(id_t.indexOf(id)>=0){
								t = m_t.get("val06_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val06_q = val06_q + Float.valueOf(t);
								}
								t = m_t.get("val11")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val11 = val11 + Float.valueOf(t);
								}
								t = m_t.get("val05_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val05_q = val05_q + Float.valueOf(t);
								}
								t = m_t.get("val07_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val07_q = val07_q + Float.valueOf(t);
								}
							}
						}
						m.put("val06_q", f.format(val06_q/1000000,format));
						m.put("val11", f.format(val11,format));
						m.put("val05_q", f.format(val05_q/1000000,format));
						m.put("val07_q", f.format(val07_q/1000000,format));
						z_val06_q = z_val06_q + val06_q;
						z_val11 = z_val11 + val11;
						z_val05_q = z_val05_q + val05_q;
						z_val07_q = z_val07_q + val07_q;
						dataList.add(m);
				   }
			}else{//按企业分类
				sql = "select station_desc as name ,* from t_cfg_station_info where station_type='"+ station_type + "' and show_flag !='1' and valley_id like '"+valley_id+"%' order by valley_id desc";
				hzbb_list = f.query(sql, null);
				num = hzbb_list.size();
				for(int i=0;i<num;i++){
					m = (Map)hzbb_list.get(i);
					id = m.get("station_id")+"";
					val06_q=0;val11=0;val05_q=0;val07_q=0;
					for(int j=0;j<num_t;j++){
						m_t = (Map)list.get(j);
						id_t = m_t.get("station_id")+"";
						
						if(id_t.equals(id)){
							t = m_t.get("val06_q")+"";
							if(t != null && !"".equals(t) && !"null".equals(t)){
							   val06_q = val06_q + Float.valueOf(t);
							}
							t = m_t.get("val11")+"";
							if(t != null && !"".equals(t) && !"null".equals(t)){
							   val11 = val11 + Float.valueOf(t);
							}
							t = m_t.get("val05_q")+"";
							if(t != null && !"".equals(t) && !"null".equals(t)){
							   val05_q = val05_q + Float.valueOf(t);
							}
							t = m_t.get("val07_q")+"";
							if(t != null && !"".equals(t) && !"null".equals(t)){
							   val07_q = val07_q + Float.valueOf(t);
							}
						}
					}
					m.put("val06_q", f.format(val06_q/1000000,format));
					m.put("val11", f.format(val11,format));
					m.put("val05_q", f.format(val05_q/1000000,format));
					m.put("val07_q", f.format(val07_q/1000000,format));
					z_val06_q = z_val06_q + val06_q;
					z_val11 = z_val11 + val11;
					z_val05_q = z_val05_q + val05_q;
					z_val07_q = z_val07_q + val07_q;
					dataList.add(m);
				}
				data_flag = "data_flag_N";
			}
		} 
		Map zongj = new HashMap();
		zongj.put("z_val06_q", f.format(z_val06_q/1000000,format));
		zongj.put("z_val11", f.format(z_val11,format));
		zongj.put("z_val05_q", f.format(z_val05_q/1000000,format));
		zongj.put("z_val07_q", f.format(z_val07_q/1000000,format));
		zongj.put("name", "总计");
		request.setAttribute("zongji", zongj);
		request.setAttribute("date1", date1);
		request.setAttribute("date2", date2);
		request.setAttribute("datalist",dataList);
		//getReportTitle(request);

	}
    
    
  //汇总报表中的污染源污水的累积统计
    public static void hzbb_water(HttpServletRequest request)throws Exception{
    	
    	String date1,date2,station_type,area_id,valley_id,trade_id,hzbb_type;
    	String data_table = "T_MONITOR_REAL_HOUR";
		String w_cols,w_gross_cols,w_q_col;
		String sql = null;
		Timestamp t1,t2;
		Object[]ps;;
		List list = null;
		List hzbb_list = new ArrayList(); 
		Map m = new HashMap();
		String tj_cols = null;
		String data_flag = "";//标志是按行业或地区或流域，还是按企业统计

		date1 = f.p(request,"date1");
		date2 = f.p(request,"date2");
		
		w_cols = f.p(request,"w_cols");
		w_gross_cols = f.p(request,"w_gross_cols");
		w_q_col = f.p(request,"w_q_col");
		tj_cols = tj_cols(w_cols,w_gross_cols);
		
		station_type = request.getParameter("station_type");
		hzbb_type = request.getParameter("hzbb_type");

		area_id = request.getParameter("area_id");
		valley_id = request.getParameter("valley_id");
		trade_id = request.getParameter("trade_id");
		
		java.text.NumberFormat  formater  =  java.text.DecimalFormat.getInstance();  
		formater.setMaximumFractionDigits(3);  
		formater.setMinimumFractionDigits(3);		
		
		if(request.getParameter("sh_flag").equals("1")){
			data_table = data_table+"_v";
		}
		
		date1 = date1+" "+"00:00:00";
		date2 = date2+" "+"23:59:59";
		
		sql = "select b.station_desc as station_name,b.station_id,b.trade_id,b.area_id,b.valley_id,m_time, "+ w_cols;
		sql = sql + " from " + data_table + " a ,";
		sql = sql + "t_cfg_station_info b ";
		sql = sql + " where a.station_id=b.station_id and b.station_type='"
				+ station_type + "' and b.show_flag !='1' ";//黄宝修改

		sql = sql + " and m_time>='" + date1 + "' and m_time <='"+date2+"'";
        
		if (!StringUtil.isempty(area_id)) {
			//sql = sql + " and a.station_id in(";
			//sql = sql + "select station_id from t_cfg_station_info where ";
			sql = sql + " and b.area_id like '" + area_id + "%' ";

		}
		if (!StringUtil.isempty(valley_id) && !valley_id.equals("1100000000")) {
			//sql = sql + " and a.station_id in(";
			//sql = sql + "select station_id from t_cfg_station_info where ";

			sql = sql + " and b.valley_id like '" + valley_id + "%' ";
		}
		if (!StringUtil.isempty(trade_id) && !trade_id.equals("root")) {
			//sql = sql + " and a.station_id in(";
			//sql = sql + "select station_id from t_cfg_station_info where ";

			sql = sql + " and b.trade_id like '" + trade_id + "%' ";
		}


		list = f.query(sql,null);
		SxReportUtil.getDataList(list,w_cols);
		
		//getDataListOverZero(list,w_cols);
		
		StdReportUtil.qs(list,w_q_col,w_gross_cols);
		//StdReportUtil.hztjs(list,tj_cols,tj);
		//request.setAttribute("list",list);
		//request.setAttribute("sql",sql);
		
		List dataList = new ArrayList();
		int num = 0;
		int num_t = list.size();
		String id = "";
		String id_t = "";
		String t = "";
		Map m_t = new HashMap();
		float val02_q=0,val04=0,val05_q=0,val17_q=0,val16_q=0;
		float z_val02_q=0,z_val04=0,z_val05_q=0,z_val17_q=0,z_val16_q=0;
		String format = "0.0000";
		
		if(!"".equals(hzbb_type) && hzbb_type.equals("area")){//按地区分类
			//sql = "select AREA_NAME as name,AREA_id,AREA_pid from T_CFG_AREA where area_id='"+area_id+"' or area_pid ='"+area_id+"' order by area_id asc";
			sql = "select AREA_NAME as name,AREA_id,AREA_pid from T_CFG_AREA where area_pid ='"+area_id+"' order by area_id asc";
			hzbb_list = f.query(sql, null);
			num = hzbb_list.size();
			if(num >0){//到市一级，到县一级。按市、县统计。
					for(int i=0;i<num;i++){
						m = (Map)hzbb_list.get(i);
						id = m.get("area_id")+"";
						val02_q=0;val04=0;val05_q=0;val17_q=0;val16_q=0;
						for(int j=0;j<num_t;j++){
							m_t = (Map)list.get(j);
							id_t = m_t.get("area_id")+"";
							
							if(id_t.indexOf(id)>=0){
								t = m_t.get("val02_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val02_q = val02_q + Float.valueOf(t);
								}
								t = m_t.get("val04")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val04 = val04 + Float.valueOf(t);
								}
								t = m_t.get("val05_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val05_q = val05_q + Float.valueOf(t);
								}
								t = m_t.get("val17_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val17_q = val17_q + Float.valueOf(t);
								}
								t = m_t.get("val16_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val16_q = val16_q + Float.valueOf(t);
								}
							}
						}
						m.put("val02_q", f.format(val02_q/1000,format));
						m.put("val04", f.format(val04,format));
						m.put("val05_q", f.format(val05_q/1000,format));
						m.put("val17_q", f.format(val17_q/1000,format));
						m.put("val16_q", f.format(val16_q/1000,format));
						z_val02_q = z_val02_q + val02_q;
						z_val04 = z_val04 + val04;
						z_val05_q = z_val05_q + val05_q;
						z_val17_q = z_val17_q + val17_q;
						z_val16_q = z_val16_q + val16_q;
						dataList.add(m);
					}
			}else{//到县一级，这时显示的就是企业信息
					sql = "select  station_desc as name ,* from t_cfg_station_info where station_type='"+ station_type + "' and show_flag !='1' and area_id like '"+area_id+"%' order by area_id desc";
					hzbb_list = f.query(sql, null);
					num = hzbb_list.size();
					for(int i=0;i<num;i++){
						m = (Map)hzbb_list.get(i);
						id = m.get("station_id")+"";
						val02_q=0;val04=0;val05_q=0;val17_q=0;val16_q=0;
						for(int j=0;j<num_t;j++){
							m_t = (Map)list.get(j);
							id_t = m_t.get("station_id")+"";
							
							if(id_t.indexOf(id)>=0){
								t = m_t.get("val02_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val02_q = val02_q + Float.valueOf(t);
								}
								t = m_t.get("val04")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val04 = val04 + Float.valueOf(t);
								}
								t = m_t.get("val05_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val05_q = val05_q + Float.valueOf(t);
								}
								t = m_t.get("val17_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val17_q = val17_q + Float.valueOf(t);
								}
								t = m_t.get("val16_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val16_q = val16_q + Float.valueOf(t);
								}
							}
						}
						m.put("val02_q", f.format(val02_q/1000,format));
						m.put("val04", f.format(val04,format));
						m.put("val05_q", f.format(val05_q/1000,format));
						m.put("val17_q", f.format(val17_q/1000,format));
						m.put("val16_q", f.format(val16_q/1000,format));
						z_val02_q = z_val02_q + val02_q;
						z_val04 = z_val04 + val04;
						z_val05_q = z_val05_q + val05_q;
						z_val17_q = z_val17_q + val17_q;
						z_val16_q = z_val16_q + val16_q;
						dataList.add(m);
					}
					
					data_flag = "data_flag_N";
				
			}
			
		}else if(!"".equals(hzbb_type) && hzbb_type.equals("trade")){//按行业
			sql = "select trace_name as name,trade_id,PARENTNODE from T_CFG_TRADE where PARENTNODE ='"+trade_id+"' order by trade_id asc";
			hzbb_list = f.query(sql, null);
			num = hzbb_list.size();
			if(num >0 && trade_id.equals("root")){//按顶层统计
					for(int i=0;i<num;i++){
						m = (Map)hzbb_list.get(i);
						id = m.get("trade_id")+"";
						val02_q=0;val04=0;val05_q=0;val17_q=0;val16_q=0;
						for(int j=0;j<num_t;j++){
							m_t = (Map)list.get(j);
							id_t = m_t.get("trade_id")+"";
							
							if(id_t.indexOf(id)>=0){
								t = m_t.get("val02_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val02_q = val02_q + Float.valueOf(t);
								}
								t = m_t.get("val04")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val04 = val04 + Float.valueOf(t);
								}
								t = m_t.get("val05_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val05_q = val05_q + Float.valueOf(t);
								}
								t = m_t.get("val17_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val17_q = val17_q + Float.valueOf(t);
								}
								t = m_t.get("val16_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val16_q = val16_q + Float.valueOf(t);
								}
							}
						}
						m.put("val02_q", f.format(val02_q/1000,format));
						m.put("val04", f.format(val04,format));
						m.put("val05_q", f.format(val05_q/1000,format));
						m.put("val17_q", f.format(val17_q/1000,format));
						m.put("val16_q", f.format(val16_q/1000,format));
						z_val02_q = z_val02_q + val02_q;
						z_val04 = z_val04 + val04;
						z_val05_q = z_val05_q + val05_q;
						z_val17_q = z_val17_q + val17_q;
						z_val16_q = z_val16_q + val16_q;
						dataList.add(m);
					}
			}else{//按企业分类
				sql = "select station_desc as name ,* from t_cfg_station_info where station_type='"+ station_type + "' and show_flag !='1' and trade_id like '"+trade_id+"%' order by trade_id desc";
				hzbb_list = f.query(sql, null);
				num = hzbb_list.size();
				for(int i=0;i<num;i++){
					m = (Map)hzbb_list.get(i);
					id = m.get("station_id")+"";
					val02_q=0;val04=0;val05_q=0;val17_q=0;val16_q=0;
					for(int j=0;j<num_t;j++){
						m_t = (Map)list.get(j);
						id_t = m_t.get("station_id")+"";
						
						if(id_t.indexOf(id)>=0){
							t = m_t.get("val02_q")+"";
							if(t != null && !"".equals(t) && !"null".equals(t)){
							   val02_q = val02_q + Float.valueOf(t);
							}
							t = m_t.get("val04")+"";
							if(t != null && !"".equals(t) && !"null".equals(t)){
							   val04 = val04 + Float.valueOf(t);
							}
							t = m_t.get("val05_q")+"";
							if(t != null && !"".equals(t) && !"null".equals(t)){
							   val05_q = val05_q + Float.valueOf(t);
							}
							t = m_t.get("val17_q")+"";
							if(t != null && !"".equals(t) && !"null".equals(t)){
							   val17_q = val17_q + Float.valueOf(t);
							}
							t = m_t.get("val16_q")+"";
							if(t != null && !"".equals(t) && !"null".equals(t)){
							   val16_q = val16_q + Float.valueOf(t);
							}
						}
					}
					m.put("val02_q", f.format(val02_q/1000,format));
					m.put("val04", f.format(val04,format));
					m.put("val05_q", f.format(val05_q/1000,format));
					m.put("val17_q", f.format(val17_q/1000,format));
					m.put("val16_q", f.format(val16_q/1000,format));
					z_val02_q = z_val02_q + val02_q;
					z_val04 = z_val04 + val04;
					z_val05_q = z_val05_q + val05_q;
					z_val17_q = z_val17_q + val17_q;
					z_val16_q = z_val16_q + val16_q;
					dataList.add(m);
				}
				data_flag = "data_flag_N";
			}
		}else{//按流域
			sql = "select VALLEY_NAME as name,VALLEY_id,PARENT_ID from  t_cfg_valley where  PARENT_ID='"+valley_id+"' order by valley_id desc";
			hzbb_list = f.query(sql, null);
			num = hzbb_list.size();
			if(num >0 && valley_id.equals("1100000000")){//按顶层流域分类
					for(int i=0;i<num;i++){
						m = (Map)hzbb_list.get(i);
						id = (m.get("valley_id")+"").substring(0,4);
						val02_q=0;val04=0;val05_q=0;val17_q=0;val16_q=0;
						for(int j=0;j<num_t;j++){
							m_t = (Map)list.get(j);
							id_t = m_t.get("valley_id")+"";
							
							if(id_t.indexOf(id)>=0){
								t = m_t.get("val02_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val02_q = val02_q + Float.valueOf(t);
								}
								t = m_t.get("val04")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val04 = val04 + Float.valueOf(t);
								}
								t = m_t.get("val05_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val05_q = val05_q + Float.valueOf(t);
								}
								t = m_t.get("val17_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val17_q = val17_q + Float.valueOf(t);
								}
								t = m_t.get("val16_q")+"";
								if(t != null && !"".equals(t) && !"null".equals(t)){
								   val16_q = val16_q + Float.valueOf(t);
								}
							}
						}
						m.put("val02_q", f.format(val02_q/1000,format));
						m.put("val04", f.format(val04,format));
						m.put("val05_q", f.format(val05_q/1000,format));
						m.put("val17_q", f.format(val17_q/1000,format));
						m.put("val16_q", f.format(val16_q/1000,format));
						z_val02_q = z_val02_q + val02_q;
						z_val04 = z_val04 + val04;
						z_val05_q = z_val05_q + val05_q;
						z_val17_q = z_val17_q + val17_q;
						z_val16_q = z_val16_q + val16_q;
						dataList.add(m);
				   }
			}else{//按企业分类
				sql = "select station_desc as name ,* from t_cfg_station_info where station_type='"+ station_type + "' and show_flag !='1' and valley_id like '"+valley_id+"%' order by valley_id desc";
				hzbb_list = f.query(sql, null);
				num = hzbb_list.size();
				for(int i=0;i<num;i++){
					m = (Map)hzbb_list.get(i);
					id = m.get("station_id")+"";
					val02_q=0;val04=0;val05_q=0;val17_q=0;val16_q=0;
					for(int j=0;j<num_t;j++){
						m_t = (Map)list.get(j);
						id_t = m_t.get("station_id")+"";
						
						if(id_t.equals(id)){
							t = m_t.get("val02_q")+"";
							if(t != null && !"".equals(t) && !"null".equals(t)){
							   val02_q = val02_q + Float.valueOf(t);
							}
							t = m_t.get("val04")+"";
							if(t != null && !"".equals(t) && !"null".equals(t)){
							   val04 = val04 + Float.valueOf(t);
							}
							t = m_t.get("val05_q")+"";
							if(t != null && !"".equals(t) && !"null".equals(t)){
							   val05_q = val05_q + Float.valueOf(t);
							}
							t = m_t.get("val17_q")+"";
							if(t != null && !"".equals(t) && !"null".equals(t)){
							   val17_q = val17_q + Float.valueOf(t);
							}
							t = m_t.get("val16_q")+"";
							if(t != null && !"".equals(t) && !"null".equals(t)){
							   val16_q = val16_q + Float.valueOf(t);
							}
						}
					}
					m.put("val02_q", f.format(val02_q/1000,format));
					m.put("val04", f.format(val04,format));
					m.put("val05_q", f.format(val05_q/1000,format));
					m.put("val17_q", f.format(val17_q/1000,format));
					m.put("val16_q", f.format(val16_q/1000,format));
					z_val02_q = z_val02_q + val02_q;
					z_val04 = z_val04 + val04;
					z_val05_q = z_val05_q + val05_q;
					z_val17_q = z_val17_q + val17_q;
					z_val16_q = z_val16_q + val16_q;
					dataList.add(m);
				}
				data_flag = "data_flag_N";
			}
		} 
		Map zongj = new HashMap();
		zongj.put("z_val02_q", f.format(z_val02_q/1000,format));
		zongj.put("z_val04", f.format(z_val04,format));
		zongj.put("z_val05_q", f.format(z_val05_q/1000,format));
		zongj.put("z_val17_q", f.format(z_val17_q/1000,format));
		zongj.put("z_val16_q", f.format(z_val16_q/1000,format));
		zongj.put("name", "总计");
		request.setAttribute("zongji", zongj);
		request.setAttribute("datalist",dataList);
		request.setAttribute("date1",date1);
		request.setAttribute("date2",date2);
		//getReportTitle(request);
		
		  
		
		
	}
    
    public static List getWarnExcpList(String w_cols,Object[] ps,String type) throws Exception{
    	String sql = "select station_id,m_time,"+w_cols+" from t_monitor_warning ";
		sql=sql+" where station_id=? ";
		sql=sql+" and  m_time>=? and m_time<=? ";
		sql=sql+" order by m_time asc ";
		List list = f.query(sql,ps);
		String cols[] = w_cols.split(",");
		Map map = new HashMap();
		List list1 = new ArrayList();
		int num =list.size();
		for(int i=0;i<num;i++){
			map = (Map)list.get(i);
			Map map2 = new HashMap();
			for(int n=0;n<cols.length;n++){
				if(map.get(cols[n])!=null&&!map.get(cols[n]).toString().equals("")){
					String s[] = map.get(cols[n]).toString().split(",");
					if(s[3].equals(type)){
						map2.put(cols[n], (s[0]));
					}
				}
			}
			if(map2.size()>0){
				map2.put("m_time", map.get("m_time").toString());
				list1.add(map2);
			}
			
		}
		return list1;
    }
    public static void gas(HttpServletRequest request)throws Exception{
		
    	get_report_info(request);
    	
    	
    	String rpt_data_table,r_data_table,station_id,date1,date2;
		String g_cols,g_gross_cols,g_q_col;
		String sql = null;
		Timestamp t1,t2;
		Object[]ps;;
		List list = null;
		Map tj = new HashMap();
		String tj_cols = null;
		
		
		
		rpt_data_table = f.p(request,"rpt_data_table");
		r_data_table = rpt_data_table;
		
		String data_type = f.p(request,"data_type");
		station_id = f.p(request,"station_id");
		date1 = f.p(request,"date1");
		date2 = f.p(request,"date2");
		
		g_cols = f.p(request,"g_cols");
		g_gross_cols = f.p(request,"g_gross_cols");
		g_q_col = f.p(request,"g_q_col");
		tj_cols = tj_cols(g_cols,g_gross_cols);
		
		java.text.NumberFormat  formater  =  java.text.DecimalFormat.getInstance();  
		formater.setMaximumFractionDigits(3);  
		formater.setMinimumFractionDigits(3);
		
		if(f.empty(station_id)){ErrorMsg.station_id_empty();}
		
		
		sql = "select station_id,m_time,"+g_cols+" from "+rpt_data_table;
		sql=sql+" where station_id=? ";
		sql=sql+" and  m_time>=? and m_time<=? ";
		sql=sql+" order by m_time asc ";
		
		if(request.getParameter("sh_flag").equals("1")){
			rpt_data_table = rpt_data_table+"_v";
			sql = "select station_id,m_time,v_flag,"+g_cols+" from "+rpt_data_table;//新增v_flag字段，就是把无效的数据抽取出来，黄宝 
			sql=sql+" where station_id=? ";
			sql=sql+" and  m_time>=? and m_time<=? ";
			sql=sql+" order by m_time asc ";
		}
		
		
		t1 = f.time(date1);
		t2 = f.time(date2+" 23:59:59");
		ps = new Object[]{station_id,t1,t2};
		if(data_type == null){
			list = f.query(sql,ps);
			SxReportUtil.getDataList(list,g_cols);
			
			getDataListOverZero(list,g_cols);
			
			StdReportUtil.qs(list,g_q_col,g_gross_cols);
			StdReportUtil.hztjs(list,tj_cols,tj);
		}else{
		if(data_type.equals("normal")&&rpt_data_table.equals("rendom_time")){
			sql = "select station_id,m_time,"+g_cols+" from t_monitor_real_day";
			sql=sql+" where station_id=? ";
			sql=sql+" and  m_time>=? and m_time<=? ";
			sql=sql+" order by m_time asc ";
			list = f.query(sql,ps);
			
			SxReportUtil.getDataList(list,g_cols);
			
			getDataListOverZero(list,g_cols);
			
			StdReportUtil.qs(list,g_q_col,g_gross_cols);
			StdReportUtil.hztjs(list,tj_cols,tj);
			
			g_cols = g_cols+",val01_q,val02_q,val03_q,val04_q,val05_q,val06_q,val07_q,val08_q,val16_q,val17_q";
			String cols[] = g_cols.split(",");
			Map map = new HashMap();
			Map map2 = new HashMap();
			double value = 0.0;
			int num =list.size();
			for(int i=0;i<num;i++){
				map = (Map)list.get(i);
				for(int n=0;n<cols.length;n++){
					if(map.get(cols[n])!=null&&!map.get(cols[n]).toString().equals("")){
						if(map2.get(cols[n])!=null&&!map2.get(cols[n]).toString().equals("")){
							value = StringUtil.getDouble(map2.get(cols[n]).toString(),0)+StringUtil.getDouble(map.get(cols[n]).toString(),0);
							if(i==num-1){
								String s = String.valueOf(value/num);
								map2.put(cols[n], s);
							}else{
								map2.put(cols[n], String.valueOf(value));
							}
						}else{
							map2.put(cols[n], (map.get(cols[n])));
						}
					}
				}
			}
			map2.put("m_time", "从"+date1+"到"+date2);
			list.clear();
			list.add(map2);
			
		}else if(data_type.equals("normal")){
			list = f.query(sql,ps);
		}else if(data_type.equals("warning")){
			list = getWarnExcpList(g_cols,ps,"0");
		}else if(data_type.equals("exception")){
			list = getWarnExcpList(g_cols,ps,"1");
		}
		if(!(data_type.equals("normal")&&rpt_data_table.equals("rendom_time"))&&!data_type.equals("warning")&&!data_type.equals("exception")){
			SxReportUtil.getDataList(list,g_cols);
			
			getDataListOverZero(list,g_cols);
			
			StdReportUtil.qs(list,g_q_col,g_gross_cols);
			StdReportUtil.hztjs(list,tj_cols,tj);
		}
		}
		
		request.setAttribute("list",list);
		request.setAttribute("tj",tj);
		request.setAttribute("sql",sql);
		request.setAttribute("r_data_table", r_data_table);
		
		getReportTitle(request);
		
		  
		
	}
    
    public static void get_report_info(HttpServletRequest request)throws Exception{
    	String data_table = f.p(request,"rpt_data_table");
    	int len = 19;
    	if(f.eq(data_table,"t_monitor_real_day")){len=10;}
    	if(f.eq(data_table,"t_monitor_real_month")){len=7;}
    	request.setAttribute("len",new Integer(len));
    	
    }
    
    
	/*
    public static String get_water_sql(HttpServletRequest request)throws Exception{
    	String sql = null;
    	String station_id = null;
    	
    	
    	return sql;
    	
    }
    
    public static String get_gas_sql(HttpServletRequest request)throws Exception{
    	String sql = null;
    	
    	
    	
    	return sql;
    	
    }
    */
	
}