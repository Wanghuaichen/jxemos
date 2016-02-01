package com.hoson.bizreport;

import java.text.SimpleDateFormat;
import java.util.*;

import com.hoson.*;
import javax.servlet.http.*;
import java.sql.*;

public class OnlineReport{
	
	public static int getOnlineNum(List stationList,Map data){
		int num =0;
		int stationNum = 0;
		int i=0;
		Map m = null;
		String station_id = null;
		List list = null;
		
		stationNum = stationList.size();
		
		for(i=0;i<stationNum;i++){
			m = (Map)stationList.get(i);
			station_id = (String)m.get("station_id");
			list = (List)data.get(station_id);
			if(list!=null){num++;}
			
		}
		
		
		return num;
		
	} 
	public static int getOfflineNum(List stationList,Map data){
		int num =0;
		int stationNum = 0;
		int i=0;
		Map m = null;
		String station_id = null;
		List list = null;
		
		stationNum = stationList.size();
		
		for(i=0;i<stationNum;i++){
			m = (Map)stationList.get(i);
			station_id = (String)m.get("station_id");
			list = (List)data.get(station_id);
			if(list==null){num++;}
			
		}
		
		
		return num;
		
	} 
	
	public static int getOnlineNumNation(List stationList,Map data){
		int num =0;
		int stationNum = 0;
		int i=0;
		Map m = null;
		String station_id = null;
		List list = null;
		String ep_type = null;
		
		stationNum = stationList.size();
		
		for(i=0;i<stationNum;i++){
			m = (Map)stationList.get(i);
			station_id = (String)m.get("station_id");
			ep_type = (String)m.get("ep_type");
			list = (List)data.get(station_id);
			if(list!=null && f.eq(ep_type,"1")){num++;}
			
		}
		
		
		return num;
		
	} 
	public static int getOfflineNumNation(List stationList,Map data){
		int num =0;
		int stationNum = 0;
		int i=0;
		Map m = null;
		String station_id = null;
		List list = null;
		String ep_type = null;
		
		stationNum = stationList.size();
		
		for(i=0;i<stationNum;i++){
			m = (Map)stationList.get(i);
			station_id = (String)m.get("station_id");
			ep_type = (String)m.get("ep_type");
			list = (List)data.get(station_id);
			if(list==null&&f.eq(ep_type,"1")){num++;}
			
		}
		
		
		return num;
		
	} 
	
	public static int getZeroNum(List stationList,Map data,String col){
		int num =0;
		int i,stationNum = 0;
		String station_id = null;
		List list = null;
		String ep_type = null;
		Map m = null;
		stationNum = stationList.size();
		for(i=0;i<stationNum;i++){
			m = (Map)stationList.get(i);
			station_id = (String)m.get("station_id");
			ep_type = (String)m.get("ep_type");
			list = (List)data.get(station_id);
			if(isZero(list,col)){num++;}
			
		}
		
		
		return num;
		
	}
	
	
	public static int getZeroNumNation(List stationList,Map data,String col){
		int num =0;
		int i,stationNum = 0;
		String station_id = null;
		List list = null;
		String ep_type = null;
		Map m = null;
		stationNum = stationList.size();
		for(i=0;i<stationNum;i++){
			m = (Map)stationList.get(i);
			station_id = (String)m.get("station_id");
			ep_type = (String)m.get("ep_type");
			
			list = (List)data.get(station_id);
			if(isZero(list,col)&&f.eq(ep_type,"1")){num++;}
			
		}
		
		
		return num;
	}
	
	public static boolean isZero(List list,String col){
		if(list==null){return false;}
		boolean b = false;
		int i,num=0;
		String v = null;
		Map m = null;
		double dv = 0;
		
		
		
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			v = (String)m.get(col);
			//if(f.empty(v)){return true;}
			if(f.empty(v)){continue;}
			//System.out.println(v);
		    v = f.v(v);
			dv = f.getDouble(v,0);
			//if(dv==0){return true;}
			if(dv>0){return false;}
			b = true;
			
		}
		
		return b;
	}
	
	
	public static List getZeroList(List stationList,Map data,String col){
		int num =0;
		int i,stationNum = 0;
		String station_id = null;
		List list = null;
		String ep_type = null;
		Map m = null;
		List list2 = new ArrayList();
		stationNum = stationList.size();
		for(i=0;i<stationNum;i++){
			m = (Map)stationList.get(i);
			station_id = (String)m.get("station_id");
			//ep_type = (String)m.get("ep_type");
			
			list = (List)data.get(station_id);
			//if(isZero(list,col)&&f.eq(ep_type,"1")){num++;}
			if(isZero(list,col)){
             list2.add(m);
			}
		}
		
		
		return list2;
	}
	
	
	
	public static List getOfflineList(List stationList,Map data){
		List list = new ArrayList();
		
		int i,stationNum = 0;
		String station_id = null;
		List tmp = null;
		Map m = null;
		stationNum = stationList.size();
		for(i=0;i<stationNum;i++){
			m = (Map)stationList.get(i);
			station_id = (String)m.get("station_id");
			
			tmp = (List)data.get(station_id);
			if(tmp==null){
				list.add(m);
			}
			
		}

		return list;
		
	}
	
	
	public static List getOfflineList2(List stationList,Map data){
		List list = new ArrayList();
		
		int i,stationNum = 0;
		String station_id = null;
		List tmp = null;
		Map m = null;
		stationNum = stationList.size();
		for(i=0;i<stationNum;i++){
			m = (Map)stationList.get(i);
			station_id = (String)m.get("station_id");
			
			tmp = (List)data.get(station_id);
			if(tmp !=null){
				list.add(m);
			}
			
		}

		return list;
		
	}
	
	public static List getOfflineListNation(List stationList,Map data){
		List list = new ArrayList();
		
		int i,stationNum = 0;
		String station_id = null;
		List tmp = null;
		Map m = null;
		String ep_type = null;
		stationNum = stationList.size();
		for(i=0;i<stationNum;i++){
			m = (Map)stationList.get(i);
			station_id = (String)m.get("station_id");
			ep_type = (String)m.get("ep_type");
			tmp = (List)data.get(station_id);
			if(tmp==null && f.eq(ep_type,"1")){list.add(m);}
			
		}
		
		
		return list;
		
	}
	
	
	
	
	public static List getZeroListNation(List stationList,Map data,String col){
		List list = new ArrayList();
		
		int i,stationNum = 0;
		String station_id = null;
		List tmp = null;
		Map m = null;
		
		String ep_type = null;
		stationNum = stationList.size();
		for(i=0;i<stationNum;i++){
			m = (Map)stationList.get(i);
			station_id = (String)m.get("station_id");
			ep_type = (String)m.get("ep_type");
			
			tmp = (List)data.get(station_id);
			if(isZero(tmp,col)&&f.eq(ep_type,"1")){list.add(m);}
			
		}
		
		
		return list;
		
	}
	
	//
	
	public static void run(HttpServletRequest req)throws Exception{
		
		  String gas_station_type = "2";
		    String water_station_type = "1";
		    String so2_col = "val01";
		    String cod_col = "val02";
		    
		    Connection cn = null;
		    String sql = null;
		    List list = null;
		    Map data = null;
		    List waterStationList = null;
		    List gasStationList = null;
		    //String date = req.getParameter("date");
		    //String now = StringUtil.getNowDate()+"";
		    String now = req.getParameter("date")+"";//黄宝修改
		    String date1,date2 = null;
		    Map areaMap = null;
		    Map bean = new HashMap();
		    date1 = now+"";
		    date2 = now+" 23:59:59";
		    int i,num=0;
		    Map m = null;
		    String area_id = null;
		    try{
		    
		    	area_id = req.getParameter("area_id");
		    	if(area_id==null){area_id="";}
		    	
		    	//date1 = req.getParameter("date1");
		    	//date1 = req.getParameter("date1");
		    	
		    	
		    sql = "select station_id,"+so2_col+","+cod_col+" from "+req.getParameter("tableName");
		    sql=sql+" where m_time>='"+date1+"' and m_time<='"+date2+"'";
		    sql=sql+" and station_id in (";
		    sql=sql+"select station_id from t_cfg_station_info where station_type in ('1','2') and area_id like '"+area_id+"%')";
		    
		    //System.out.println(sql);
		    
		    
		    cn =f.getConn();
		    
		    //System.out.println(sql);
		    
		    list = f.query(cn,sql,null);
		    data = f.getListMap(list,"station_id");
		    
		    sql = "select station_id,station_desc,ep_type,area_id,station_bz from t_cfg_station_info where station_type='1' and area_id like '"+area_id+"%' order by area_id,station_desc";
		    waterStationList = f.query(cn,sql,null);
		    
		    //System.out.println(sql);
		    
		    sql = "select station_id,station_desc,ep_type,area_id from t_cfg_station_info where station_type='2' and area_id like '"+area_id+"%' order by area_id,station_desc";
		    gasStationList = f.query(cn,sql,null);
		    
		    //System.out.println(sql);
		    
		    sql = "select area_id,area_name from t_cfg_area";
		    areaMap = f.getMap(cn,sql);
		    
		    //System.out.println(sql);
		    num = waterStationList.size();
		    for(i=0;i<num;i++){
		    	m = (Map)waterStationList.get(i);
		    	area_id = (String)m.get("area_id");
		    	m.put("area_name",areaMap.get(area_id));
		    	
		    }
		    
		    num = gasStationList.size();
		    for(i=0;i<num;i++){
		    	m = (Map)gasStationList.get(i);
		    	area_id = (String)m.get("area_id");
		    	m.put("area_name",areaMap.get(area_id));
		    	
		    }
		    
		    //System.out.println("before close,cn="+cn);
		    f.close(cn);
		    //System.out.println("after close,cn="+cn);
		    
		      int waterOnlineNum,gasOnlineNum,onlineNum=0;
			    int waterOfflineNum,gasOfflineNum,offlineNum=0;
			    int waterOfflineNumNation,gasOfflineNumNation,offlineNumNation=0;
			    int waterZeroNum,gasZeroNum,zeroNum=0;
			    int waterZeroNumNation,gasZeroNumNation,zeroNumNation=0;
			    
			    
			    waterOnlineNum = OnlineReport.getOnlineNum(waterStationList,data);
			    gasOnlineNum = OnlineReport.getOnlineNum(gasStationList,data);
			    onlineNum = waterOnlineNum+gasOnlineNum;
			    
			    //System.out.println(onlineNum);
			    
			     waterOfflineNum = OnlineReport.getOfflineNum(waterStationList,data);
			    gasOfflineNum = OnlineReport.getOfflineNum(gasStationList,data);
			    offlineNum = waterOfflineNum+gasOfflineNum;
			    
			    //System.out.println("zeroNumNation "+zeroNumNation);
			    
			    
			      waterOfflineNumNation = OnlineReport.getOfflineNumNation(waterStationList,data);
			    gasOfflineNumNation = OnlineReport.getOfflineNumNation(gasStationList,data);
			    offlineNumNation = waterOfflineNumNation+gasOfflineNumNation;
			    
			    //System.out.println("offlineNumNation "+offlineNumNation);
			    
			    
			    waterZeroNum = OnlineReport.getZeroNum(waterStationList,data,cod_col);
			    gasZeroNum = OnlineReport.getZeroNum(gasStationList,data,so2_col);
			    zeroNum = waterZeroNum+gasZeroNum;
			    
			    //System.out.println(zeroNum);
			    
			    waterZeroNumNation = OnlineReport.getZeroNumNation(waterStationList,data,cod_col);
			    gasZeroNumNation = OnlineReport.getZeroNumNation(gasStationList,data,so2_col);
			    zeroNumNation = waterZeroNumNation+gasZeroNumNation;
			    
			    
			    //System.out.println(zeroNumNation);
			    
			    bean.put("waterOnlineNum",waterOnlineNum+"");
			    bean.put("gasOnlineNum",gasOnlineNum+"");
			    bean.put("onlineNum",onlineNum+"");
			    
			    
			    
			    bean.put("waterOfflineNum",waterOfflineNum+"");
			    bean.put("gasOfflineNum",gasOfflineNum+"");
			    bean.put("offlineNum",offlineNum+"");
			    
			    bean.put("waterOfflineNumNation",waterOfflineNumNation+"");
			    bean.put("gasOfflineNumNation",gasOfflineNumNation+"");
			    bean.put("offlineNumNation",offlineNumNation+"");
			    
			    
			    bean.put("waterZeroNum",waterZeroNum+"");
			    bean.put("gasZeroNum",gasZeroNum+"");
			    bean.put("zeroNum",zeroNum+"");
			    
			    bean.put("waterZeroNumNation",waterZeroNumNation+"");
			    bean.put("gasZeroNumNation",gasZeroNumNation+"");
			    bean.put("zeroNumNation",zeroNumNation+"");
			    
			    
			    req.setAttribute("bean",bean);
			    
			    
			    
		   
		       list = getOfflineList(waterStationList,data);
		       req.setAttribute("waterOfflineList",list);
		       
		       list = getOfflineList(gasStationList,data);
		       req.setAttribute("gasOfflineList",list);
		    
		       list = getOfflineListNation(waterStationList,data);
		       req.setAttribute("waterOfflineListNation",list);
		       
		       list = getOfflineListNation(gasStationList,data);
		       req.setAttribute("gasOfflineListNation",list);
		    
		       list = getZeroListNation(waterStationList,data,cod_col); 
		       req.setAttribute("waterZeroListNation",list);
		       
		       list = getZeroListNation(gasStationList,data,so2_col); 
		       req.setAttribute("gasZeroListNation",list);
		       
		          
		    
		    
		    }catch(Exception e){
		      throw e;
		    }finally{f.close(cn);}
		     
		
		    
		    
		    
	}
	
	
	//一周内的污染源在线脱机联机报表
	public static void run7(HttpServletRequest req)throws Exception{
		
		  String gas_station_type = "2";
		    String water_station_type = "1";
		    String so2_col = "val01";
		    String cod_col = "val02";
		    
		    Connection cn = null;
		    String sql = null;
		    List list = new ArrayList();//存储这周内的数据
		    List list2 = new ArrayList();//存储今天的数据
		    List list3 = new ArrayList();//存储脱机的数据
		    List l_temp = null;
		    List td_temp = null;//存储今天的数据
		    String kv = null;
		    String kv_2 = null;
		    Map tmp = null;
		    Map tmp_2 = null;
		    
		    Map tmp2 = new HashMap();
		    Map tmp3 = new HashMap();
		    Map data = null; //存这周内有数据的站位
		    Map data2 = null ;//存储今天的数据
		    Map data3 = null;//存储这周脱机的站位
		    List waterStationList = null;
		    List gasStationList = null;
		    //String date = req.getParameter("date");
		    String now = StringUtil.getNowDate()+"";
		    // String now = req.getParameter("date")+"";//黄宝修改
		    String date1,date2 = null;
		    //从现在开始，退后7天。
		    Calendar cal = Calendar.getInstance();
		    Calendar cal2 = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			cal.setTime(cal.getTime());
			
			cal.add(Calendar.DAY_OF_MONTH,-7);//退后7天
		    
			String now_7 = sdf.format(cal.getTime());
			
            cal2.setTime(cal2.getTime());
			
			cal2.add(Calendar.DAY_OF_MONTH,-1);//退后1天
			
			String now_1 = sdf.format(cal2.getTime())+ " 23:59:59";;
			date1 = sdf.format(cal2.getTime())+ " 23:59:59";
			date2 = now_7+"";
		    
		    Map areaMap = null;
		    Map bean = new HashMap();
		    
		    int i,num=0;
		    Map m = null;
		    String area_id = null;
		    try{
		    
		    	area_id = req.getParameter("area_id");
		    	if(area_id==null){area_id="";}
		    	
		    	//date1 = req.getParameter("date1");
		    	//date1 = req.getParameter("date1");
		    	
		    	
		    sql = "select station_id,m_time,"+so2_col+","+cod_col+" from "+req.getParameter("tableName");
		    sql=sql+" where m_time>='"+date2+"' and m_time<='"+date1+"'";
		    sql=sql+" and station_id in (";
		    sql=sql+"select station_id from t_cfg_station_info where station_type in ('1','2') and area_id like '"+area_id+"%') order by m_time desc";
		    
		    //System.out.println(sql);
		    
		    
		    cn =f.getConn();
		    
		    //System.out.println(sql);
		    
		    l_temp = f.query(cn,sql,null);//最近一周的数据
		    num = l_temp.size();
		    for(i=0;i<num;i++){
	    		tmp = (Map)l_temp.get(i);
	    		kv = (String)tmp.get("station_id");
	    		
                String station_id_t = (String)tmp2.get(kv);
                if("".equals(station_id_t) || station_id_t == null){
                	list.add(tmp);//最近一周都有的数据
                	tmp2.put(kv, kv);
                }
	    	
	    	}

		    //data = f.getListMap(list,"station_id");//最近一周都有的数据
		    
		    //查询今天有数据的站位
		    String now_time = StringUtil.getNowDate()+"";
		    date1 = now_time+"";
		    date2 = now_time+" 23:59:59";
		    
		    sql = "select station_id,m_time,"+so2_col+","+cod_col+" from "+req.getParameter("tableName");
		    sql=sql+" where m_time>='"+date1+"' and m_time<='"+date2+"'";
		    sql=sql+" and station_id in (";
		    sql=sql+"select station_id from t_cfg_station_info where station_type in ('1','2') and area_id like '"+area_id+"%') order by m_time desc";
		    
		    td_temp = f.query(cn,sql,null);//今天的数据
		    tmp2 = null;
		    
		    num = td_temp.size();
		    for(i=0;i<num;i++){
	    		tmp = (Map)td_temp.get(i);
	    		kv = (String)tmp.get("station_id");
	    		
                String station_id_t = (String)tmp3.get(kv);
                if("".equals(station_id_t) || station_id_t == null){
                	list2.add(tmp);//今天有数据的站位。
                	tmp3.put(kv, kv);
                }
	    	
	    	}
		    
		    //循环这一周内有数据的站位列表list，如果list中的站位不能在今天的站位信息列表中list2中找到的话，则表明是脱机
		    num = list.size();
		    int j = 0;
		    int num2 = list2.size();
		    String station_id_1 = "";
		    String station_id_2 = "";
		    int l = 0;
		    for(i=0;i<num;i++){
		    	tmp = (Map)list.get(i);
		    	station_id_1 = (String)tmp.get("station_id");
		    	l = 0;
		    	for(j=0;j<num2;j++){
		    		tmp_2 = (Map)list2.get(j);
		    		station_id_2 = (String)tmp_2.get("station_id");
		    		if(station_id_1.equals(station_id_2)){
		    			l++;   			
		    		}
		    	}
		    	if(l==0){
		    		list3.add(tmp);
		    	}
		    }
		    
		    data = f.getListMap(list3,"station_id");//这周脱机的站位信息列表
		    
		    l_temp = null;
		    tmp = null;
		    list2 = null;
		    list3 = null;
		    tmp_2 = null;
		    tmp3 = null;
		    
		    
		    sql = "select station_id,station_desc,ep_type,area_id,station_bz from t_cfg_station_info where station_type='1' and area_id like '"+area_id+"%' order by area_id,station_desc";
		    waterStationList = f.query(cn,sql,null);
		    
		    //System.out.println(sql);
		    
		    sql = "select station_id,station_desc,ep_type,area_id from t_cfg_station_info where station_type='2' and area_id like '"+area_id+"%' order by area_id,station_desc";
		    gasStationList = f.query(cn,sql,null);
		    
		    //System.out.println(sql);
		    
		    sql = "select area_id,area_name from t_cfg_area";
		    areaMap = f.getMap(cn,sql);
		    
		    //System.out.println(sql);
		    num = waterStationList.size();
		    for(i=0;i<num;i++){
		    	m = (Map)waterStationList.get(i);
		    	area_id = (String)m.get("area_id");
		    	m.put("area_name",areaMap.get(area_id));
		    	
		    }
		    
		    num = gasStationList.size();
		    for(i=0;i<num;i++){
		    	m = (Map)gasStationList.get(i);
		    	area_id = (String)m.get("area_id");
		    	m.put("area_name",areaMap.get(area_id));
		    	
		    }
		    
		    //System.out.println("before close,cn="+cn);
		    f.close(cn);
		    //System.out.println("after close,cn="+cn);
		    
		      int waterOnlineNum,gasOnlineNum,onlineNum=0;
			    int waterOfflineNum,gasOfflineNum,offlineNum=0;
			    int waterOfflineNumNation,gasOfflineNumNation,offlineNumNation=0;
			    int waterZeroNum,gasZeroNum,zeroNum=0;
			    int waterZeroNumNation,gasZeroNumNation,zeroNumNation=0;
			    
			    
			    waterOnlineNum = OnlineReport.getOnlineNum(waterStationList,data);
			    gasOnlineNum = OnlineReport.getOnlineNum(gasStationList,data);
			    onlineNum = waterOnlineNum+gasOnlineNum;
			    
			    //System.out.println(onlineNum);
			    
			     waterOfflineNum = OnlineReport.getOfflineNum(waterStationList,data);
			    gasOfflineNum = OnlineReport.getOfflineNum(gasStationList,data);
			    offlineNum = waterOfflineNum+gasOfflineNum;
			    
			    //System.out.println("zeroNumNation "+zeroNumNation);
			    
			    
			      waterOfflineNumNation = OnlineReport.getOfflineNumNation(waterStationList,data);
			    gasOfflineNumNation = OnlineReport.getOfflineNumNation(gasStationList,data);
			    offlineNumNation = waterOfflineNumNation+gasOfflineNumNation;
			    
			    //System.out.println("offlineNumNation "+offlineNumNation);
			    
			    
			    waterZeroNum = OnlineReport.getZeroNum(waterStationList,data,cod_col);
			    gasZeroNum = OnlineReport.getZeroNum(gasStationList,data,so2_col);
			    zeroNum = waterZeroNum+gasZeroNum;
			    
			    //System.out.println(zeroNum);
			    
			    waterZeroNumNation = OnlineReport.getZeroNumNation(waterStationList,data,cod_col);
			    gasZeroNumNation = OnlineReport.getZeroNumNation(gasStationList,data,so2_col);
			    zeroNumNation = waterZeroNumNation+gasZeroNumNation;
			    
			    
			    //System.out.println(zeroNumNation);
			    
			    bean.put("waterOnlineNum",waterOnlineNum+"");
			    bean.put("gasOnlineNum",gasOnlineNum+"");
			    bean.put("onlineNum",onlineNum+"");
			    
			    
			    
			    bean.put("waterOfflineNum",waterOfflineNum+"");
			    bean.put("gasOfflineNum",gasOfflineNum+"");
			    bean.put("offlineNum",offlineNum+"");
			    
			    bean.put("waterOfflineNumNation",waterOfflineNumNation+"");
			    bean.put("gasOfflineNumNation",gasOfflineNumNation+"");
			    bean.put("offlineNumNation",offlineNumNation+"");
			    
			    
			    bean.put("waterZeroNum",waterZeroNum+"");
			    bean.put("gasZeroNum",gasZeroNum+"");
			    bean.put("zeroNum",zeroNum+"");
			    
			    bean.put("waterZeroNumNation",waterZeroNumNation+"");
			    bean.put("gasZeroNumNation",gasZeroNumNation+"");
			    bean.put("zeroNumNation",zeroNumNation+"");
			    
			    date1 = now_7;
			    date2 = StringUtil.getNowDate()+"";
			    
			    bean.put("date1", date2);
			    bean.put("date2", date1);
			    
			    
			    req.setAttribute("bean",bean);
			    
			    
			   
		   
		       list = getOfflineList2(waterStationList,data);
		       req.setAttribute("waterOfflineList",list);
		       
		       list = getOfflineList2(gasStationList,data);
		       req.setAttribute("gasOfflineList",list);
		    
		       list = getOfflineListNation(waterStationList,data);
		       req.setAttribute("waterOfflineListNation",list);
		       
		       list = getOfflineListNation(gasStationList,data);
		       req.setAttribute("gasOfflineListNation",list);
		    
		       list = getZeroListNation(waterStationList,data,cod_col); 
		       req.setAttribute("waterZeroListNation",list);
		       
		       list = getZeroListNation(gasStationList,data,so2_col); 
		       req.setAttribute("gasZeroListNation",list);
		       
		          
		    
		    
		    }catch(Exception e){
		      throw e;
		    }finally{f.close(cn);}
		     
		
		    
		    
		    
	}
	
	
}