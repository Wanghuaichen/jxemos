package com.hoson;

import java.util.*;
import java.sql.*;

import com.hoson.util.*;
import com.hoson.app.*;
import com.hoson.hello.*;
import javax.servlet.http.*;


public class Test{
	static HttpServletRequest request = null;
	static HttpServletResponse res = null;
	 public static void test()throws Exception{
		 
		  String station_id = null;
	      String station_name = null;
	      Map m = null;
	      Connection cn = null;
	      String sql = null;
	      String now = null;
	      List list = null;
	      int i,num=0;
	      String id,name,col = null;
	      String option = "";
	      
	      
	      try{
	             now = StringUtil.getNowDate()+"";
	      		station_id = request.getParameter("station_id");
	      		if(StringUtil.isempty(station_id)){
	      		  throw new Exception("station_id为空");
	      		}
	            sql = "select station_desc from t_cfg_station_info where station_id='"+station_id+"'";
	            cn = DBUtil.getConn();
	            
	            m = DBUtil.queryOne(cn,sql,null);
	            if(m==null){throw new Exception("站位不存在");}
	            station_name=(String)m.get("station_desc");
	            
	            sql = "select a.infectant_id,a.infectant_name,a.infectant_column ";
	            sql=sql+" from t_cfg_infectant_base a,t_cfg_monitor_param b ";
	            sql=sql+" where a.infectant_id=b.infectant_id and b.station_id='"+station_id+"'";
	            list = DBUtil.query(cn,sql,null);
	            num=list.size();
	            if(num<1){throw new Exception("请配置监测指标");}
	            for(i=0;i<num;i++){
	            	m = (Map)list.get(i);
	            	id=(String)m.get("infectant_id");
	            	name=(String)m.get("infectant_name");
	            	col=(String)m.get("infectant_column");
	            	
	            	option=option+"<option value='"+id+","+col+"'>"+name+"\n";
	            	
	            	
	            }
	            
	            
	            
	      
	      
	      }catch(Exception e){
	      //JspUtil.go2error(request,response,e);
	    	  System.out.println(e);
	      return;
	      }finally{DBUtil.close(cn);}
	      
	 }
	
	  public static String list(Connection cn,String station_type,String area_id)throws Exception{
	        
	       String sql = null;
	           String sb_id = null;
	             String[]arr=null;
	             Map map = null;
	    
	             String sp_s = "";
	             int i,num=0;
	             int j,sb_num=0;
	              List stationList = null;
	             Map sbMap = null;
	             String station_id,station_name = null;
	             Map row = null;
	            String sss = "";
	             
	         

	               
	      sql = "select station_id,station_desc,sb_id from t_cfg_station_info where station_type='"+station_type+"' and area_id like '"+area_id+"%' ";
	             
	      
	     // sql=sql+ DataAclUtil.getStationIdInString(request,station_type,"station_id");
	      
	      sql=sql+" order by area_id,station_desc";
	             stationList = DBUtil.query(cn,sql,null);
	            
	            
	            
	             
	             //out.println(sbMap);
	             num = stationList.size();
	             for(i=0;i<num;i++){
	             row = (Map)stationList.get(i);
	             station_id = (String)row.get("station_id");             
	             station_name = (String)row.get("station_desc");
	             sb_id = (String)row.get("sb_id");
	           
	             if(f.empty(sb_id)){continue;}
	             arr=sb_id.split(",");
	             sb_num=arr.length;
	             
	             
	             for(j=0;j<sb_num;j++){
	             sb_id = arr[j];
	             if(f.empty(sb_id)){continue;}
	             //spOption =spOption+"<option value='"+sb_id+facode+"'>"+station_name+"_通道"+(j+1)+"</option>\n";
	             
	             sss=sss+station_name+"_通道"+(j+1)+"<br>";
	             }
	             
	             }
	             return sss;
	             }
	             
	
	
	public static void x(){
		
	String s = "1";
	s.toLowerCase();
	}
	
	
	public static String getDataTable(Connection cn,
			String sql,Object[]params)throws Exception{
		if(cn==null){
			throw new Exception("connection is null");
			}
		//StringBuffer sb = new StringBuffer();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try{
		ps = cn.prepareStatement(sql);
		DBUtil.setParam(ps,params);
		rs = ps.executeQuery();
		
		
		return DBUtil.rs2table(rs,0,10000000);
		}catch(Exception e){
			
			throw e;
		}finally{
			
			DBUtil.close(rs,ps,null);
		}
	
		
	}
	
	public static String getDataTable(String sql,Object[]params)throws Exception{
		Connection cn = null;
		try{
		cn = DBUtil.getConn();
		return getDataTable(cn,sql,params);
		}catch(Exception e){
			throw e;
		}finally{
			DBUtil.close(cn);
		}
		
	}
	
	public static String dataCheck()throws Exception{
		
		String s = "";
		String sql = "select * from t_monitor_real_minute order by m_time desc";
		int max_rows = 50;
		
		List list = null;
		Map map = null;
		
		CheckEmos c = new CheckEmos();
		String m_value = null;
		String vd = null;
		int flag =0;
		
		Connection cn = null;
		
		try{
		cn = DBUtil.getConn();
		list = DBUtil.query(cn,sql,(Object[])null,max_rows);
		
		}catch(Exception e){
			throw e;
			
		}finally{DBUtil.close(cn);}
		
		
		int i,num=0;
		num = list.size();
		for(i=0;i<num;i++){
			map = (Map)list.get(i);
			m_value = (String)map.get("m_value");
			//System.out.println(m_value);
			if(StringUtil.isempty(m_value)){continue;}
			m_value = StringUtil.format(m_value,"0.0000");
			//System.out.println(m_value+",//");
			
			vd = (String)map.get("vd");
			if(vd==null){vd="";}
			
			
			flag = c.check(m_value,vd);
			
			s=s+"<tr>\n";
			s=s+"<td>"+m_value+"</td>";
			s=s+"<td>"+vd+"</td>";
			s=s+"<td>"+flag+"</td>";
			s=s+"</tr>\n";
			
			
			
			
		}
		
		return s;
		
	}
    public static String dataCheck(String station_id)throws Exception{
		
		String s = "";
		String sql = "select * from t_monitor_real_minute where 2>1 ";
		
		if(!StringUtil.isempty(station_id)){
			sql =sql+" and station_id='"+station_id+"' ";
		}
		sql = sql+"  order by m_time desc";
		
		int max_rows = 50;
		
		List list = null;
		Map map = null;
		
		CheckEmos c = new CheckEmos();
		String m_value = null;
		String vd = null;
		int flag =0;
		
		Connection cn = null;
		
		try{
		cn = DBUtil.getConn();
		list = DBUtil.query(cn,sql,(Object[])null,max_rows);
		
		}catch(Exception e){
			throw e;
			
		}finally{DBUtil.close(cn);}
		
		
		int i,num=0;
		num = list.size();
		for(i=0;i<num;i++){
			map = (Map)list.get(i);
			m_value = (String)map.get("m_value");
			//System.out.println(m_value);
			if(StringUtil.isempty(m_value)){continue;}
			m_value = StringUtil.format(m_value,"0.0000");
			//System.out.println(m_value+",//");
			
			vd = (String)map.get("vd");
			if(vd==null){vd="";}
			
			
			flag = c.check(m_value,vd);
			
			s=s+"<tr>\n";
			s=s+"<td>"+map.get("station_id")+"</td>";
			s=s+"<td>"+map.get("infectant_id")+"</td>";
			s=s+"<td>"+map.get("m_time")+"</td>";
			s=s+"<td>"+m_value+"</td>";
			s=s+"<td>"+vd+"</td>";
			s=s+"<td>"+flag+"</td>";
			s=s+"</tr>\n";
			
			
			
			
		}
		
		return s;
		
	}
	
	
    public static List getstationList(Connection cn,String user_id)
	throws Exception{
		List list = new ArrayList();
		String sql = "";
		List userStationList = null;
		List idList = new ArrayList();
		String[]arr = null;
		String station_ids = null;
		int i,num=0;
		Map map = null;
		String ids = "";
		String id = null;
		Map stationMap = new HashMap();
		List stationList = null;
		Map stationSbMap = null;
		
		
		sql = "select * from t_sys_user_station where user_id='"+user_id+"' ";
		userStationList = DBUtil.query(cn,sql,null);
		num = userStationList.size();
		for(i=0;i<num;i++){
			map = (Map)userStationList.get(i);
			station_ids = (String)map.get("station_ids");
			if(StringUtil.isempty(station_ids)){continue;}
			ids=ids+","+station_ids;
			
		}
		//System.out.println(sql+","+ids);
		
		arr = ids.split(",");
		num=arr.length;
		
		for(i=0;i<num;i++){
			id=arr[i];
			if(StringUtil.isempty(id)){continue;}
			idList.add(id);
		}
		//System.out.println(idList.size());
		
		sql = "select station_id,station_type,station_desc,area_id from t_cfg_station_info ";
		stationList = DBUtil.query(cn,sql,null);
		
		num = stationList.size();
		//System.out.println(num);
		
		for(i=0;i<num;i++){
			map = (Map)stationList.get(i);
			stationMap.put(map.get("station_id"),map); 
		}
		
		sql = "select station_id,sb_id from t_sp_sb_station";
		stationSbMap  = DBUtil.getMap(cn,sql);
		//System.out.println(stationSbMap);
		num = idList.size();
		String sb_id = null;
		
		for(i=0;i<num;i++){
			id = (String)idList.get(i);
			map = (Map)stationMap.get(id);
			if(map==null){continue;}
			sb_id = (String)stationSbMap.get(id);
			//System.out.println(map+","+sb_id+","+id);
			if(StringUtil.isempty(sb_id)){continue;}
			map.put("sb_id",sb_id);
			list.add(map);
			
			
		}
		
		
		
		
		
		return list;
	}
    public static List getstationList(String user_id)
	throws Exception{
    	Connection cn = null;
    	try{
    	cn = DBUtil.getConn();
    	return getstationList( cn,user_id);
    	}catch(Exception e){
    		throw e;
    		}finally{DBUtil.close(cn);}
    	
    }
    
    public static List getstationList(Connection cn,String user_id,String station_id)
	throws Exception{
    	List list = new ArrayList();
    	String sql = null;
    	List list2 = null;
    	Map map = null;
    	int i,num =0;
    	String ids = "";
    	String station_ids = null;
    	
    	sql = "select station_ids from t_sys_user_station where user_id='"+user_id+"' ";
    	list2 = DBUtil.query(cn,sql,null);
    	num = list2.size();
    	for(i=0;i<num;i++){
    		map=(Map)list2.get(i);
    		
    		station_ids = (String)map.get("station_ids");
    		if(StringUtil.isempty(station_ids)){continue;}
    		ids=ids+","+station_ids;
    		
    	}
    	if(StringUtil.isempty(ids)){return list;}
    	ids=","+ids+",";
    	if(ids.indexOf(","+station_id+",")<0){return list;}
    	sql = "select station_id,station_type,station_desc,area_id from t_cfg_station_info where station_id='"+station_id+"'";
    	map = DBUtil.queryOne(cn,sql,null);
    	if(map==null){return list;}
    	sql = "select sb_id from t_sp_sb_station where station_id='"+station_id+"'";
    	Map map2 = DBUtil.queryOne(cn,sql,null);
    	if(map2==null){return list;}
    	String sb_id = (String)map2.get("sb_id");
    	if(StringUtil.isempty(sb_id)){return list;}
    	map.put("sb_id",sb_id);
    	list.add(map);
    	return list;
    }
    
    //20071205
    
    public static List getInfectantInfo(Connection cn,String station_id)throws Exception{
        
    	String sql = null;
    	List list = null;
    	int num=0;
    	
    	sql = "select * from t_cfg_infectant_base where infectant_id in (";
    	sql=sql+"select infectant_id from t_cfg_monitor_param where station_id='"+station_id+"'";
    	sql=sql+") order by infectant_order";
    	
    	list = DBUtil.query(cn,sql,null);
    	num=list.size();
    	if(num<1){throw new Exception("请配置监测指标");}
    	
    	
    	return list;
    }
    
    public static Map getColumnInfo(List list)throws Exception{
    	int i,num=0;
    	String s= "";
    	String col = null;
    	String key = "infectant_column";
    	Map m = null;
    	Map map = new HashMap();
    	String shi,slow = null;
    	
    	num=list.size();
    	
    	String[]arr = new String[num];
    	
    	for(i=0;i<num;i++){
    		m = (Map)list.get(i);
    		col=(String)m.get(key);
    		if(StringUtil.isempty(col)){
    			throw new Exception("infectant_column is empty");
    		}
    		col=col.toLowerCase();
    		s=s+","+col;
    		arr[i]=col;
    		
    		
    	}
    	map.put("sql",s);
    	map.put("cols",arr);
    	return map;
    }

    public static Map q()throws Exception{
    	Map m = null;
    	Connection cn = null;
    	String sql = null;
    	String station_id,date1,date2 = null;
    	List list = null;
    	int i,num=0;
    	Map map = null;
    	try{
    		
    		cn = DBUtil.getConn();
    		station_id = request.getParameter("station_id");
    		date1 = request.getParameter("date1");
    		date2 = request.getParameter("date2");
    		list = getInfectantInfo(cn,station_id);
    		map = getColumnInfo(list);
    		
    		sql = "select m_time"+(String)map.get("sql")+" from t_montior_real_hour ";
    		sql=sql+" where station_id='"+station_id+"' and m_time>='"+date1+"' ";
    		sql=sql+" and m_time<='"+date2+" 23:59:59' order by m_time ";
    	    m = PagedQuery.query(cn,sql,null,request);
    	    m.put("cols",map.get("cols"));
    	    m.put("info",list);
    		
    		return m;
    	}catch(Exception e){
    		System.out.println(e);
    		return null;
    		
    	}finally{DBUtil.close(cn);}
    	
    	
    	
    }
    
    
    public static Timestamp getRealStartTime()throws Exception{
		 
		 String real_hour_s = f.cfg("real_hour","6");
		 int real_hour = f.getInt(real_hour_s,6);
		 String real_start_time_s = f.cfg("real_start_time","");
		 Timestamp real_start_time = null;
		 real_start_time = f.time(real_start_time_s,null);
		 
		 if(real_start_time!=null){return real_start_time;}
		 real_hour = 0-real_hour;
		 real_start_time = f.dateAdd(f.time(),"hour",real_hour);
		 return real_start_time;

		 
		 
	 }
    
}