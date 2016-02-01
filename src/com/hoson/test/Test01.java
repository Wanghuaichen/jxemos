package com.hoson.test;

import java.sql.Connection;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hoson.DBUtil;
import com.hoson.JspUtil;
import com.hoson.f;
import com.hoson.util.DataAclUtil;
import com.hoson.util.JspPageUtil;

public class Test01{
	
	HttpServletRequest request = null;
	HttpServletResponse response = null;
	HttpSession session = null;
	Map model = null;
	String method = null;
	Connection conn = null;
	
	public String init(HttpServletRequest request,
			HttpServletResponse response,String method)throws Exception{
		try{
		this.response = response;
		this.request = request;
		session=request.getSession();
		this.method=method;
		model = JspUtil.getRequestModel(request);
		//execute();
		return null;
		}catch(Exception e){
			throw e;
		}finally{
			close();
			}
	}
	public void getConn()throws Exception{
		if(conn==null){conn=DBUtil.getConn();}
	}
	
	public void close()throws Exception{
		DBUtil.close(conn);
	}
	
	public void seta(String name,Object obj){
		request.setAttribute(name,obj);
	
	}
	
	public String p(String name)throws Exception{
		return JspUtil.getParameter(request,name);
	}
	public String p(String name,String def)throws Exception{
		String s = JspUtil.getParameter(request,name);
		if(f.empty(s)){s=def;}
		return s;
	}
	
	
	public String rpt01()throws Exception{
		String area_id=p("area_id");
		String date1 = p("date1");
		String date2 = p("date1");
		String station_type=p("station_type");
		String station_id=p("station_id");
		String sql = null;
		int i,num=0;
		Map m = null;
		String id,m_time = null;
		Map data = new HashMap();
		List dataList  = new ArrayList();
		List list = null;
		List stationList = null;
		List timeList = getTimeList(date1,date2);
		sql = getSql(station_type,station_id,area_id,date1,date2,request);
		try{
		getConn();
		list = f.query(conn,sql,null);
		stationList = getStationList(conn,station_type,station_id,area_id);
		}catch(Exception e){
			throw e;
		}finally{close();}
		
		Timestamp t = null;
		Map stationMap = null;
		Map row = null;
		
		int j,snum = 0;
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			id = (String)m.get("station_id");
			m_time = (String)m.get("m_time");
			m_time = f.sub(m_time,0,13);
			data.put(id+"_"+m_time,"1");
			
		}
		
		num = timeList.size();
		snum = stationList.size();
		for(i=0;i<num;i++){
			t = (Timestamp)timeList.get(i);
			  for(j=0;j<snum;j++){
				  stationMap = (Map)stationList.get(j);
				  row = getDataRow01(stationMap,t,data);
				  dataList.add(row);
			  }
			
		}
		
		
		seta("data",dataList);
		
		return null;
	}
	
	public String rpt02()throws Exception{
		String area_id=p("area_id");
		String date1 = p("date1");
		String ph_col = p("ph_col");
		String cod_col = p("cod_col");
		String q_col = p("q_col");
		String station_type=p("station_type");
		String sql = null;
		List list = null;
		Map data = new HashMap();
		List stationList = null;
		int i,num=0;
		Map m = null;
		String station_id = null;
		List dataList = new ArrayList();
		Map datarow = null;
		Map infectantMap = null;
		
		
		sql = "select station_id,"+ph_col+","+cod_col+","+q_col ;
		sql=sql+" from t_monitor_real_hour where m_time>='"+date1+"' ";
		sql=sql+" and m_time<='"+date1+" 23:59:59' ";
		sql=sql+DataAclUtil.getStationIdInString(request,station_type,"station_id");
		getConn();
		list = f.query(conn,sql,null);
		stationList = JspPageUtil.getStationList(conn,station_type,area_id,null,request);	
		infectantMap = getInfectantInfoMap(conn,station_type,area_id,ph_col,cod_col,q_col);
		
		close();
		data = f.getListMap(list,"station_id");
		num = stationList.size();
		for(i=0;i<num;i++){
			m=(Map)stationList.get(i);
			station_id = (String)m.get("station_id");
			list = (List)data.get(station_id);
			datarow = getDataRow(station_id,list,ph_col,cod_col,q_col,infectantMap);
			datarow.put("station_id",station_id);
			datarow.put("station_desc",m.get("station_desc"));
			dataList.add(datarow);
		}
		
		
		seta("data",dataList);
		
		
		
		return null;
	}
	
	static Map getInfectantInfoMap(Connection cn,String station_type,String area_id,
			String ph_col,String cod_col,String q_col)throws Exception{
		Map m = new HashMap();
		String sql = null;
		List list = null;
		int i,num=0;
		
	
		Map m2,m3 = null;
		String station_id,infectant_column = null;
		double dv = 0;
		String v = null;
		String key = null;
		sql = "select station_id,infectant_column,lolo,hihi from t_cfg_monitor_param ";
		sql=sql+" where station_id in(";
		sql=sql+"select station_id from t_cfg_station_info ";
		sql=sql+" where station_type='"+station_type+"' ";
		sql=sql+" and area_id like '"+area_id+"%' ";
		sql=sql+") ";
		list = f.query(cn,sql,null);
		num = list.size();
		for(i=0;i<num;i++){
			m2=(Map)list.get(i);
			station_id = (String)m2.get("station_id");
			infectant_column =  (String)m2.get("infectant_column");
			if(f.empty(station_id)||f.empty(infectant_column)){continue;}
			infectant_column = infectant_column.toLowerCase();
			if(f.eq(infectant_column,ph_col)
					||f.eq(infectant_column,cod_col)
					||f.eq(infectant_column,q_col)){
				
				m3=new HashMap();
				
				v = (String)m2.get("lolo");
				dv = f.getDouble(v,0);
				if(dv>0){m3.put("lolo",new Double(dv));}
				
				
				
				v = (String)m2.get("hihi");
				dv = f.getDouble(v,0);
				if(dv>0){m3.put("hihi",new Double(dv));}
				
				key = station_id+"_"+infectant_column;
				m.put(key,m3);
				
			}
			
			
		}
		
		return m;
	}
	
	static Map getDataRow(String station_id,List list,
			String ph_col,String cod_col,String q_col,
			Map infectantMap)throws Exception{
		if(list==null){list=new ArrayList();}
		Map row = new HashMap();
		String v = null;
		//System.out.println("getDatarow,station_id="+station_id);
		
		
		v = getUp(station_id,list,infectantMap,ph_col);
		row.put("ph_up",v);
		//System.out.println("getup,ph "+station_id);
		
		v = getUp(station_id,list,infectantMap,cod_col);
		row.put("cod_up",v);
		//System.out.println("getup,cod "+station_id);
		
		
		v = getCodAvg(station_id,list,infectantMap,cod_col);
		row.put("cod_avg",v);
		
		//System.out.println("getcodavg"+station_id);
		
		v = getQSum(station_id,list,infectantMap,q_col);
		row.put("q",v);
		
		//System.out.println("qsum"+station_id);
		
		v = getDataGetRate(list);
		row.put("r",v);
		
		//System.out.println("datar"+station_id);
		
		v = getDataGetRate(station_id,list,cod_col,infectantMap);
		row.put("r_cod",v);
		
		
		makeDataRow(row);
		
		return row;
		
	}
	
	static void makeDataRow(Map row){
		String r_cod = (String)row.get("r_cod");
		String r = (String)row.get("r");
		String q = (String)row.get("q");
		String cod_avg = (String)row.get("cod_avg");
		String q2 = null;
		String cod1,cod2 = null;
		Double cod_avg_obj = null;
		Double q_obj = null;
		double dv_r = f.getDouble(r,0);
		double dv = 0;
		double dv_r_cod = f.getDouble(r_cod,0);
		cod1="";
		cod2="";
		q2 = "";
		
		cod_avg_obj = f.getDoubleObj(cod_avg,null);
		q_obj = f.getDoubleObj(q,null);
		if(cod_avg_obj==null){
			cod1=cod_avg;
			cod2=cod_avg;
		}else{
			if(q_obj!=null){
				dv = cod_avg_obj.doubleValue()*q_obj.doubleValue()/1000;
				cod1=dv+"";
				if(dv_r_cod>0){
					dv=dv*100/dv_r_cod;
					cod2=dv+"";
				}
				
			}
			
		}
		
		
		
		//---
		if(q_obj==null){
			q2=q;
			}else{
				dv = q_obj.doubleValue();
				if(dv_r_cod>0){
					dv=dv*100/dv_r_cod;
					q2=dv+"";
				}
			}
		
		
		row.put("cod1",cod1);
		row.put("cod2",cod2);
		row.put("q2",q2);
		
	}
	
	
	static String getUp(String station_id,List list,Map infectantMap,String col){
		    if(list==null){list=new ArrayList();}
		    String s = null;
		    Map info = null;
		    info = (Map)infectantMap.get(station_id+"_"+col);
		    
		    //System.out.println(info);
		    
		    if(info==null){return "n";}
		    Map m = null;
		    int i,dnum = 0;
		    String v = null;
		    double dv = 0;
		    Double dvobj = null;
		    Double hihi,lolo = null;
		    
		    int num = 0;
		    int numup = 0;
		    
		    dnum = list.size();
		    if(dnum<1){return "-";}
		    for(i=0;i<dnum;i++){
		    	m = (Map)list.get(i);
		    	
		    	//System.out.println(m);
		    	
		    	v = (String)m.get(col);
		    	
		    	//System.out.println(v);
		    	
		    	if(f.empty(v)){continue;}
		    	v = f.v(v);
		    	dvobj = f.getDoubleObj(v,null);
		    	if(dvobj==null){continue;}
		    	num++;
		    	dv=dvobj.doubleValue();
		    	
		    	//System.out.println(dv);
		    	
		    	if(isup(dv,info)){numup++;}
		    	
		    	
		    	
		    }
		    if(num<1){return "-";}
		    dv = numup*(100.0)/num;
		    //dv=dv*100;
		    s=dv+"";
		    
		    return s;
	}
	   public static boolean isup(double v,Map info){
		   if(v<=0){return false;}
		   boolean b =false;
		   Double lolo = null;
		   Double hihi = null;
		   
		   //System.out.println("isup "+info);
		   //System.out.println(info.get("lolo").getClass());
		   //System.out.println(info.get("hihi").getClass());
		   lolo = (Double)info.get("lolo");
		   hihi = (Double)info.get("hihi");
		   
		   double dv = 0;
		   
		   //System.out.println(lolo+","+hihi);
		   
		   if(lolo!=null){
			   dv=lolo.doubleValue();
			   if(dv>0&&v<dv){return true;}
		   }
		   if(hihi!=null){
			   dv=hihi.doubleValue();
			   if(dv>0&&v>dv){return true;}
		   }
		   
		   return b;
	   }
	   
	   static String getDataGetRate(List list){
		        
		        if(list==null){return "0";}
		        int num =list.size();
		        double v = num*100.0/24;
		        //v=v*100;
		        return v+"";
	   }
	   static String getDataGetRate(String station_id,List list,String col,Map infectantMap){
		    
		  
		   
		   Map info = (Map)infectantMap.get(station_id+"_"+col);
		    if(info==null){return "n";}
	        if(list==null){return "0";}
	        int num =list.size();
	        int i=0;
	        Map m = null;
	        String v = null;
	        double dv = 0;
	        int dnum = 0;
	        for(i=0;i<num;i++){
	        	m = (Map)list.get(i);
	        	v = (String)m.get(col);
	        	
	        	
	        	if(!f.empty(v)){dnum++;}
	        	
	        }
	        
	       
	        dv = dnum*(100.0)/24;
	        //dv=dv*100;
	        
	       
	        
	        return dv+"";
        }
	
	   static String getCodAvg(String station_id,List list,Map infectantMap,String cod_col){
		    if(list==null){list=new ArrayList();}
		    String s = null;
		    Map info = null;
		    info = (Map)infectantMap.get(station_id+"_"+cod_col);
		    if(info==null){return "n";}
		    Map m = null;
		    int i,dnum = 0;
		    String v = null;
		    double dv = 0;
		    Double dvobj = null;
		    Double hihi,lolo = null;
		    Double sumdvobj = null;
		    
		    int num = 0;
		    int numup = 0;
		    int datanum = 0;
		    dnum = list.size();
		    
		    
		    if(dnum<1){return "-";}
		    for(i=0;i<dnum;i++){
		    	m = (Map)list.get(i);
		    	v = (String)m.get(cod_col);
		    	if(f.empty(v)){continue;}
		    	v = f.v(v);
		    	
		    	
		    	
		    	dvobj = f.getDoubleObj(v,null);
		    	if(dvobj==null){continue;}
		    	datanum++;
		    	if(sumdvobj==null){
		    		sumdvobj=dvobj;
		    		}else{
		    			dv = dvobj.doubleValue();
		    			dv = dv+sumdvobj.doubleValue();
		    			sumdvobj = new Double(dv);
		    		}
		    	
		    	
		    }
		    if(sumdvobj==null){return "-";}
		    dv = sumdvobj.doubleValue()/datanum;
		   
		    s=dv+"";
		    
		    return s;
	}
	   
	   static String getQSum(String station_id,List list,Map infectantMap,String q_col){
		    if(list==null){list=new ArrayList();}
		    String s = null;
		    Map info = null;
		    info = (Map)infectantMap.get(station_id+"_"+q_col);
		    if(info==null){return "n";}
		    Map m = null;
		    int i,dnum = 0;
		    String v = null;
		    double dv = 0;
		    Double dvobj = null;
		    Double hihi,lolo = null;
		    Double sumdvobj = null;
		    
		    int num = 0;
		    int numup = 0;
		    int datanum = 0;
		    dnum = list.size();
		    if(dnum<1){return "-";}
		    for(i=0;i<dnum;i++){
		    	m = (Map)list.get(i);
		    	v = (String)m.get(q_col);
		    	if(f.empty(v)){continue;}
		    	v = f.v(v);
		    	dvobj = f.getDoubleObj(v,null);
		    	if(dvobj==null){continue;}
		    	datanum++;
		    	if(sumdvobj==null){
		    		sumdvobj=dvobj;
		    		}else{
		    			dv = dvobj.doubleValue();
		    			dv = dv+sumdvobj.doubleValue();
		    		}
		    	
		    	
		    }
		    if(sumdvobj==null){return "-";}
		    //dv = sumdvobj.doubleValue()/datanum;
		    
		    //s=dv+"";
		    s=sumdvobj+"";
		    return s;
	}
	   
	   public static String getSql(String station_type,String station_id,
			   String area_id,String date1,String date2,HttpServletRequest req)
	   throws Exception{
		   String sql = null;
		   if(!f.empty(station_id)){
			   sql = "select station_id,m_time from  t_monitor_real_hour where station_id='"+station_id+"' ";
		       sql=sql+" and m_time>='"+date1+"' and m_time<='"+date2+" 23:59:59'";
		       return sql;
		   }
		   
		   sql = "select station_id,m_time from  t_monitor_real_hour ";
		   sql=sql+" where m_time>='"+date1+"' and m_time<='"+date2+" 23:59:59' ";
		   sql=sql+" and station_id in(";
		   sql=sql+"select station_id from t_cfg_station_info where ";
		   sql=sql+" station_type='"+station_type+"' and area_id like '"+area_id+"%'";
		   sql=sql+") ";
		   sql=sql+DataAclUtil.getStationIdInString(req,station_type,"station_id");
		   
		   
		   
		   
		   return sql;
	   }
	   
	   public static List getStationList(Connection cn,
			   String station_type,String station_id,String area_id)
	   throws Exception{
		   Map m = null;
		   String sql = null;
		   List list = null;
		   sql = "select a.station_id,a.station_desc,b.area_name from t_cfg_station_info a,t_cfg_area b";
		   sql=sql+" where a.area_id=b.area_id ";
		   if(!f.empty(station_id)){
	
			   sql=sql+" and a.station_id='"+station_id+"'";
			   list = f.query(cn,sql,null);
			   //m = f.getMap(list,"station_id");
		       //return m;
			   return list;
		   }
		   
		   sql=sql+" and a.station_id in (";
		   sql=sql+"select station_id from t_cfg_station_info where station_type='"+station_type+"' ";
		   sql=sql+" and area_id like '"+area_id+"%'";
		   sql=sql+")";
		   sql=sql+" order by a.area_id,a.station_desc";
		   list = f.query(cn,sql,null);
		   return list;
		   //m = f.getMap(list,"station_id");
		   
		   //return m;
		   
	   }
	   
	   static List  getTimeList(String date1,String date2)throws Exception{
		   List list = new ArrayList();
		   Timestamp t1 = f.time(date1);
		   Timestamp t2 = f.time(date2);
		   Timestamp t = null;
		   
		   long ms1,ms2 = 0;
		   long ms = 0;
		   
		   ms1 = t1.getTime();
		   ms2=t2.getTime();
		   if(ms1>ms2){return list;}
		   if(ms1==ms2){
			   list.add(t1);
			   return list;
		   }
		   list.add(t1);
		   int i=1;
		   
		   while(true){
			   t = f.dateAdd(t1,"day",i);
			   ms = t.getTime();
			   if(ms>ms2){break;}
			   list.add(t);
			   i++;
			   
		   }
		   
		   
		   
		   
		   return list;
	   }
	   
	  static Map getDataRow01(Map stationMap,Timestamp t,Map data){
		  Map row = new HashMap();
		  String m_time = t+"";
		  m_time = f.sub(m_time,0,10);
		  int i,num=0;
		  Object obj = null;
		  String flag = null;
		  num=24;
		  String key = null;
		  String station_id = (String)stationMap.get("sttaion_id");
		  int offnum = 0;
		  for(i=0;i<num;i++){
			  if(i<10){
				  key="0"+i;
				  }else{key=i+"";}
			  m_time=m_time+" "+key;
			  key = station_id+"_"+m_time;
			  obj = data.get(key);
			  if(obj==null){
				  flag="T";
				  offnum++;
				  }else{flag="L";}
			  
			  row.put(i+"",flag);
		  }
		  row.put("m_time",m_time);
		  row.put("station_id",station_id);
		  row.put("station_desc",stationMap.get("station_desc"));
		  row.put("area_name",stationMap.get("area_name"));
		  row.put("off",offnum+"");
		  return row;
		  
	  }
	   
	
	
}