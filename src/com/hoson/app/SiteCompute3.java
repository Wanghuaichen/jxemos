package com.hoson.app;

import java.sql.*;
import java.io.*;
import java.util.*;
import java.text.*;
import com.hoson.*;

import javax.servlet.http.*;
import com.hoson.util.*;


public class SiteCompute3{
	
	private void SiteCompute3(){		
	}
	
	//-----------
	public static Map getStationMap(Connection cn,String station_type)
	throws Exception{
		
		String sql = null;
		sql="select station_id,station_desc from ";
		sql=sql+"t_cfg_station_info where station_type='"+station_type+"' ";
		try{
		Map map = DBUtil.getMap(cn,sql);
		return map;
		}catch(Exception e){
			throw e;
			}
	}
	//-------------
	
	public static Map getInfectantMap(Connection cn,String station_type)
	throws Exception{
		
		String sql = null;
		sql="select infectant_id,infectant_name from ";
		sql=sql+"t_cfg_infectant_base where station_type='"+station_type+"' ";
		try{
		Map map = DBUtil.getMap(cn,sql);
		return map;
		}catch(Exception e){
			throw e;
			}
	}
	//-------------
	//-----------alert report-----------
	public static String getStationAlertReport(String station_id,
			Map stationMap,Map infectantMap,List alertList){
		
		String s ="";
		String station_name = null;
		String infectant_id = null;
		String infectant_name = null;
		int totalAlertNum = 0;
		int alertNum = 0;
		String sAlertNum = null;
		List list = null;
		Map map = null;
		int i =0;
		int num = 0;
		
		list=new ArrayList();
		
		station_name=(String)stationMap.get(station_id);
		if(station_name==null){station_name="";}
		
		//System.out.println(station_name);
		String id = null;
		num = alertList.size();
		
		for(i=0;i<num;i++){
			map=(Map)alertList.get(i);
			id = (String)map.get("station_id");
			//System.out.println(id);
			if(StringUtil.equals(id,station_id)){
				list.add(map);
			}
			
		}//end for
		
		num = list.size();
		//System.out.println(num);
		
	int flag=num-1;
		
		
		for(i=0;i<num;i++){
			map = (Map)list.get(i);
			id = (String)map.get("station_id");
			
			//System.out.println(id);
			
			infectant_id = (String)map.get("infectant_id");
			//System.out.println(infectant_id);
			
			infectant_name =(String)infectantMap.get(infectant_id);
			//System.out.println(infectant_name);
			if(infectant_name==null){infectant_name="";}
			sAlertNum = (String)map.get("alert_num");
			alertNum = StringUtil.getInt(sAlertNum,0);
			if(i<flag){
			s=s+" "+infectant_name+" "+alertNum+" 次"+",";
			}else{
				s=s+" "+infectant_name+" "+alertNum+" 次";
			}
			totalAlertNum=totalAlertNum+alertNum;
			//System.out.println(infectant_name);
		}
		//s=station_name+" "+totalAlertNum+"次 "+s+"<br>\n";

		String s2 = "";
		s2 = s2 + "<td>"+station_name+"</td>\n";
		s2 = s2 + "<td>"+totalAlertNum+"</td>\n";
		s2=s2+"<td>"+s+"</td>\n";
		
		return s2;
	}
	//----------
	public static int getTotalAlertNum(List alertList){
		int totalAlertNum =0;
		String sAlertNum = null;
		int alertNum = 0;
		Map map = null;
		int i =0;
		int num = 0;
		num = alertList.size();
		
		
		for(i=0;i<num;i++){
			map=(Map)alertList.get(i);
			sAlertNum = (String)map.get("alert_num");
			alertNum=StringUtil.getInt(sAlertNum,0);
			totalAlertNum=totalAlertNum+alertNum;
		}
		
		
		return totalAlertNum;
		
	}
	//---------
	
	public static String getAlertReport(Connection cn,String station_type,
			String date1,String date2,
			String area_id,String valley_id,
			HttpServletRequest req)throws Exception{
		String s = "";
		String sql = "";
		List list = null;
		List list2 = new ArrayList();
		Map map = null;
		String date3 = null;
        
        date3 = StringUtil.getNextDay(java.sql.Date.valueOf(date2))+"";
        
		
		sql=sql+"select ";
		sql=sql+"a.station_id,";
		sql=sql+"a.infectant_id,";
		sql=sql+"count(1) as alert_num from ";
		sql=sql+"t_monitor_warning_real a,";
		sql=sql+"t_cfg_station_info b ";
		sql=sql+"where a.station_id=b.station_id ";
		sql=sql+"and b.station_type='"+station_type+"' ";
		
		sql=sql+"and a.start_time>='"+date1+"' ";
		//sql=sql+"and a.start_time<='"+date2+"' ";
		sql=sql+"and a.start_time<'"+date3+"' ";
		if(!StringUtil.isempty(area_id)){
		sql=sql+"and b.area_id like '"+area_id+"%' ";
		}
		
		if(!StringUtil.isempty(valley_id)){
		sql=sql+"and b.valley_id like '"+valley_id+"%' ";
		}
		
		sql = sql+DataAclUtil.getStationIdInString(req,station_type,"a.station_id");
		
		sql=sql+"group by a.station_id,a.infectant_id";
		
		
		Map stationMap=getStationMap(cn,station_type);
		Map infectantMap=getInfectantMap(cn,station_type);
		
		list = DBUtil.query(cn,sql,null);
		//System.out.println(sql);
		//System.out.println(list.size());
		
		int i =0;
		int num = 0;
		num = list.size();
		//if(num<1){return list2;}
		
		String station_id0 = null;
		String station_id = null;
		String infectant_id = null;
		int alert_num = 0;
		String sAlertNum = null;
		
		
		List stationIdList = new ArrayList();
		//List stationList = new ArrayList();
		
		Map xxx = new HashMap();
		String ss = null;
		
		for(i=0;i<num;i++){
			
			
			//20071212 stationIdList 站位编号重复 
			
			
			map=(Map)list.get(i);
			station_id=(String)map.get("station_id");
			ss = (String)xxx.get(station_id);
			if(StringUtil.isempty(ss)){
				stationIdList.add(station_id);
				xxx.put(station_id,"1");
				
			}
			/*
			if(!StringUtil.equals(station_id0,station_id)){
				stationIdList.add(station_id);
				station_id0=station_id;
			}
			*/
			
			
			
		}//end for
		
		
		num =  stationIdList.size();
		
		//System.out.println(num);
		
		
		for(i=0;i<num;i++){
			
		station_id = (String)stationIdList.get(i);
		/*
		s=s+getStationAlertReport(station_id,
				stationMap,infectantMap,list)+"<br>\n";
				*/
		s=s+"<tr><td>"+(i+1)+"</td>\n";
		s=s+getStationAlertReport(station_id,
				stationMap,infectantMap,list);
		s=s+"</tr>";
			
		}
		
		
		
		
		String s2 = "";
		String sTotal = "";
		String sTitle = "";
		
		sTitle = sTitle+"<tr class=title>\n";
		sTitle = sTitle+"<td>序号</td>\n";
		sTitle = sTitle+"<td>站位名称</td>\n";
		sTitle = sTitle+"<td>报警次数</td>\n";
		sTitle = sTitle+"<td>报警指标</td>\n";
		sTitle = sTitle+"<tr>\n";
		
		
		
		sTotal = "<tr><td class=left colspan=100>";
		sTotal = sTotal+"共有 "+num+" 个站位发生 "+getTotalAlertNum(list)+" 次报警<br>\n";
		sTotal = sTotal +"</td></tr>\n";
		
		//s="共有 "+num+" 个站位发生 "+getTotalAlertNum(list)+" 次报警<br>\n"+s;
		
		s2 = sTotal+sTitle+s;
		return s2;
		
	}
	
	
	//------------------------
	//20070926
	public static Map getAlertReport(Connection cn,String station_type,
			String date1,String date2,
			String area_id,String valley_id,int hh)throws Exception{
		
		String sql = null;
		List list = null;
		int i,num=0;
		int total_alert_num,alert_num = 0;
		double d = 0;
		Map m = null;
		
		String s = "";
		String v = null;
	
		int h = 0;
		sql = "select a.station_id,b.station_desc,a.warning_cnt as alert_num,a.out_info from t_station_sum_info a,t_cfg_station_info b ";
		sql=sql+" where a.station_id=b.station_id and sum_time>='"+date1+"' and sum_time<='"+date2+" 23:59:59'";
		
		
		if(!StringUtil.isempty(area_id)){
			
			sql=sql+" and b.area_id like '"+area_id+"%'";
		}
		if(!StringUtil.isempty(area_id)){
			
			sql=sql+" and b.valley_id like '"+valley_id+"%'";
		}
		sql=sql+" order by b.area_id,b.station_desc ";
		
		list = DBUtil.query(cn,sql,null);
		
		total_alert_num = getTotalAlertNum(list);
		
		
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			
			v = (String)m.get("alert_num");
			d = StringUtil.getDouble(v,0);
			d = hh*d/total_alert_num;
			h = new Double(d).intValue();
			
			s=s+"<tr>\n";
			s=s+"<td>"+(i+1)+"</td>\n";
			s=s+"<td>"+m.get("station_desc")+"</td>\n";
			s=s+"<td>"+m.get("alert_num")+"</td>\n";
			s=s+"<td><img src=x.gif width="+h+"px height=30px></td>\n";
			s=s+"<td>"+m.get("out_info")+"</td>\n";
			s=s+"</tr>\n";
			
			
		}
		
		m = new HashMap();
		m.put("data",s);
		m.put("station_num",num+"");
		m.put("alert_num",total_alert_num+"");
		//s = "共有 "+num+" 个站位发生 "+total_alert_num+" 次报警"; 

		
		
		return m;
	}
	
	
	//------------------------
	
	
	//--------------out report-------------
	
	public static String getOutReport(Connection cn,String station_type,
			String date1,String date2,
			String area_id,String valley_id)throws Exception{
		String s = "";
		String sql = "";
		List list = null;
		int i =0;
		int num =0;
		
		Map map = null;
		
	
		sql=sql+"select ";
		sql=sql+"a.station_id as station_id,";

		sql=sql+"sum(a.total_out_cnt) as out_num from ";
		sql=sql+"t_station_sum_info a,";
		sql=sql+"t_cfg_station_info b ";
		sql=sql+"where a.station_id=b.station_id ";
		sql=sql+"and a.total_out_cnt>0 ";
		sql=sql+"and b.station_type='"+station_type+"' ";
		
		sql=sql+"and a.sum_time>='"+date1+"' ";
		sql=sql+"and a.sum_time<='"+date2+"' ";
		
		if(!StringUtil.isempty(area_id)){
		sql=sql+"and b.area_id like '"+area_id+"%' ";
		}
		
		if(!StringUtil.isempty(valley_id)){
		sql=sql+"and b.valley_id like '"+valley_id+"%' ";
		}
		sql=sql+"group by a.station_id";
		
		
		int totalOutNum = 0;
		String sOutNum = null;
		int outNum = 0;
		String station_name = null;
		String station_id = null;
		
		Map stationMap = getStationMap(cn,station_type);
		list = DBUtil.query(cn,sql,null);
		num=list.size();
		int flag = num-1;
		
		for(i=0;i<num;i++){
			map=(Map)list.get(i);
			sOutNum=(String)map.get("out_num");
			outNum=StringUtil.getInt(sOutNum,0);
			station_id=(String)map.get("station_id");
			//System.out.println(station_id);
			if(station_id==null){station_id="";}
			station_name=(String)stationMap.get(station_id);
			if(station_name==null){station_name="";}
			totalOutNum = totalOutNum+outNum;
			
				s=s+station_name+" "+outNum+" 次"+"<br>\n";
			
		}
		
		s="共 "+list.size()+" 个站位发生超标 "+totalOutNum+" 次<br><br>\n"+s;
		return s;
		
	}
	
	
	//------------------------
	//-----------------comm state report-------
	
	public static String getStateReport(Connection cn,String station_type,
			String date1,String date2,
			String area_id,String valley_id,
			HttpServletRequest req)throws Exception{
		String s = "";
		String sql = "";
		List list = null;
		int i =0;
		int num =0;
		
		Map map = null;
		String date3 = null;
        
        date3 = StringUtil.getNextDay(java.sql.Date.valueOf(date2))+"";
        
	
		sql=sql+"select ";
		sql=sql+"a.station_id as station_id,";

		sql=sql+"count(1) as off_num from ";
		sql=sql+"t_station_sum_info a,";
		sql=sql+"t_cfg_station_info b ";
		sql=sql+"where a.station_id=b.station_id ";
		sql=sql+"and a.comm_state='0' ";
		sql=sql+"and b.station_type='"+station_type+"' ";
		
		sql=sql+"and a.sum_time>='"+date1+"' ";
		//sql=sql+"and a.sum_time<='"+date2+"' ";
		sql=sql+"and a.sum_time<'"+date3+"' ";
		if(!StringUtil.isempty(area_id)){
		sql=sql+"and b.area_id like '"+area_id+"%' ";
		}
		
		if(!StringUtil.isempty(valley_id)){
		sql=sql+"and b.valley_id like '"+valley_id+"%' ";
		}
		sql = sql+DataAclUtil.getStationIdInString(req,station_type,"a.station_id");
		sql=sql+" group by a.station_id";
		
	
		int totalOffNum = 0;
		String sOffNum = null;
		int offNum = 0;
		String station_name = null;
		String station_id = null;
		
		Map stationMap = getStationMap(cn,station_type);
		list = DBUtil.query(cn,sql,null);
		num=list.size();
		int flag = num-1;
		String pre = "，仪器未开启 0 次，仪器故障 0 次";
		
		
		
		
		
		
		
		s = s+"<tr class=title>";
		s = s+"<td>序号</td>";
		s = s+"<td>站位名称</td>";
		s = s+"<td>脱机次数</td>";
		s = s+"<td>未开启次数</td>";
		s = s+"<td>故障次数</td>";
		s=s+"</tr>";
		
		String sData = "";
		
		for(i=0;i<num;i++){
			map=(Map)list.get(i);
			sOffNum=(String)map.get("off_num");
			offNum=StringUtil.getInt(sOffNum,0);
			station_id=(String)map.get("station_id");
			//System.out.println(station_id);
			if(station_id==null){station_id="";}
			station_name=(String)stationMap.get(station_id);
			if(station_name==null){station_name="";}
			totalOffNum = totalOffNum+offNum;
			
				//s=s+station_name+" 脱机 "+offNum+" 次"+pre+"<br>\n";
			
			sData=sData+"<tr class=tr"+i%2+">\n";
			sData=sData+"<td>"+(i+1)+"</td>\n";
			sData=sData+"<td>"+station_name+"</td>\n";
			sData=sData+"<td>"+offNum+"</td>\n";
			sData=sData+"<td>"+0+"</td>\n";
			sData=sData+"<td>"+0+"</td>\n";
			sData=sData+"</tr>\n";
		}
		
		String sTotal = "共 "+list.size()+" 个站位发生仪器异常 "+totalOffNum+" 次<br><br>\n";
		
		s = "<tr><td colspan=100 class=left>"+sTotal+"</td></tr>" +s;
		s=s+sData;
		
		//s="共 "+list.size()+" 个站位发生仪器异常 "+totalOffNum+" 次<br><br>\n"+s;
		return s;
		
	}
	
	public static List getAlertChartList(Connection cn,String station_type,
			String date1,String date2,
			String area_id,String valley_id)throws Exception{
		String sql = null;
		String id,name = null;
		
		sql="select ";
		//sql=sql+"a.station_id,";
		sql=sql+"a.infectant_id,";
		sql=sql+"count(1) as alert_num from ";
		sql=sql+"t_monitor_warning_real a,";
		sql=sql+"t_cfg_station_info b ";
		sql=sql+"where a.station_id=b.station_id ";
		sql=sql+"and b.station_type='"+station_type+"' ";
		
		sql=sql+"and a.start_time>='"+date1+"' ";
		//sql=sql+"and a.start_time<='"+date2+"' ";
		sql=sql+"and a.start_time<'"+date2+" 23:59:59' ";
		if(!StringUtil.isempty(area_id)){
		sql=sql+"and b.area_id like '"+area_id+"%' ";
		}
		
		if(!StringUtil.isempty(valley_id)){
		sql=sql+"and b.valley_id like '"+valley_id+"%' ";
		}
		sql=sql+"group by a.infectant_id";
		
		
		
		List list = DBUtil.query(cn,sql,null);
		Map m,m2 = null;
		List list2 = new ArrayList();
		//sql = "select infectant_id,infectant_name from t_cfg_infectant_base where station_type='"+station_type+"'";
		m2 = getInfectantMap(cn,station_type);
		int i,num=0;
		num =list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			id = (String)m.get("infectant_id");
			name=(String)m2.get(id);
			if(StringUtil.isempty(name)){continue;}
			m.put("infectant_name",name);
			list2.add(m);
		}
		
		
		
		return list2;
		
		
	}
	
	public static int get(int alert_num,int alert_num_all,int w){
		double d = 0;
		
		d = alert_num*w/alert_num_all;
		
		return new Double(d).intValue();
		
		
	}
	
	//----------
}//end class