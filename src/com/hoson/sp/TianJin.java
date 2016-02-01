package com.hoson.sp;

import java.util.*;

import com.hoson.f;
import javax.servlet.http.*;
import com.hoson.ErrorMsg;
import com.hoson.XBean;
import com.hoson.util.*;


public class TianJin{
	
	public static void list(HttpServletRequest req)throws Exception{
		Map model = f.model(req);
		List list = null;
		String station_type,area_id,p_station_name;
		String stationTypeOption,areaOption;
		List stationList = null;
		XBean b = new XBean(model);
		
		
		
		station_type = b.get("station_type");
		area_id = b.get("area_id");
		
		p_station_name = b.get("p_station_name");
		

		if(f.empty(station_type)){
			station_type = f.getDefaultStationType();
		}
		if(f.empty(area_id)){
			area_id = f.getDefaultAreaId();
		}
		model.put("station_type",station_type);
		model.put("area_id",area_id);
		model.put("cols","*");
		model.put("order_cols","station_no,area_id,station_desc");
		if(!f.empty(p_station_name)){model.put("station_desc",p_station_name);}
		
		
		
		//list = f.getStationList(model,req);
		
		String sql = "select * from t_cfg_station_info where 2>1 ";
		sql = sql+DataAclUtil.getStationIdInString(req,station_type,"station_id");
        list = f.query(sql,null);
		list = getSpList(list);
		
		
		stationTypeOption = f.getStationTypeOption(station_type);
		areaOption = f.getAreaOption(area_id);
		
		
		//list = getSpList(list);
		
		req.setAttribute("station_type",station_type);
		req.setAttribute("area_id",area_id);
		req.setAttribute("stationTypeOption",stationTypeOption);
		req.setAttribute("areaOption",areaOption);
		req.setAttribute("p_station_name",p_station_name);
		
		req.setAttribute("list",list);
		
	}
	
	
	public static void list_all(HttpServletRequest req)throws Exception{
		//Map model = f.model(req);
		List list = null;
		//String station_type,area_id,p_station_name;
		//String stationTypeOption,areaOption;
		//List stationList = null;
		//XBean b = new XBean(model);
		String sql = null;
		String station_type = req.getParameter("station_type");
		
		/*
		station_type = b.get("station_type");
		area_id = b.get("area_id");
		
		p_station_name = b.get("p_station_name");
		

		if(f.empty(station_type)){
			station_type = f.getDefaultStationType();
		}
		if(f.empty(area_id)){
			area_id = f.getDefaultAreaId();
		}
		model.put("station_type",station_type);
		model.put("area_id",area_id);
		model.put("cols","*");
		model.put("order_cols","station_no,area_id,station_desc");
		if(!f.empty(p_station_name)){model.put("station_desc",p_station_name);}
		
		
		*/
		
		
		//list = f.getStationList(model,req);
		
		sql = "select * from t_cfg_station_info where 2>1 ";
		//sql=sql+DataAclUtil.
		sql = sql+DataAclUtil.getStationIdInString(req,station_type,"station_id");
		
		//stationTypeOption = f.getStationTypeOption(station_type);
		//areaOption = f.getAreaOption(area_id);
		
		
		list = getSpList(list);
		
		//req.setAttribute("station_type",station_type);
		//req.setAttribute("area_id",area_id);
		//req.setAttribute("stationTypeOption",stationTypeOption);
		//req.setAttribute("areaOption",areaOption);
		//req.setAttribute("p_station_name",p_station_name);
		
		req.setAttribute("list",list);
		
	}
	
	
	
    public static void one(HttpServletRequest req)throws Exception{
		String station_id = req.getParameter("station_id");
    	List list;
		list = getSpList(station_id);
		req.setAttribute("list",list);
		
		
		
	}
	
	
    public static List getSpList(String station_id)throws Exception{
		if(f.empty(station_id)){ErrorMsg.station_id_empty();}
    	List list;
		String sql = "select * from t_cfg_station_info where station_id=?";
    	
		Map m = null;
    	m = f.queryOne(sql,new Object[]{station_id});
    	if(m==null){ErrorMsg.no_data();}
    	
    	list = getSpList(m);
    	
    	int num=0;
    	num = list.size();
    	if(num<1){f.error("请配置视频IP和通道");}
    	
		return list;
	}
	
    public static List getSpList(Map map)throws Exception{
		//if(f.empty(station_id)){ErrorMsg.station_id_empty();}
    	List list=new ArrayList();
		if(map==null){return list;}
		String ip,port,user,pwd,td;
    	XBean b = new XBean(map);
    	//station_ip,sp_type,sb_id,sp_port,sp_user,sp_pwd,sp_channel
    	ip = b.get("station_ip");
    	port = b.get("sp_port");
    	user = b.get("sp_user");
    	pwd = b.get("sp_pwd");
    	td = b.get("sb_id");
    	
    	//if(f.empty(ip)){return list;}
    	if(f.empty(td)){return list;}
    	
    	
    	if(f.empty(port)){port=f.cfg("sp_port_hk","8000");}
    	if(f.empty(user)){user=f.cfg("sp_user_hk","admin");}
    	if(f.empty(pwd)){pwd=f.cfg("sp_pwd_hk","123456");}
    	
    	
    	String[]arr=td.split(",");
    	int i,num=0;
    	String td_str;
    	Map m = null;
    	
    	num=arr.length;
    	for(i=0;i<num;i++){
    		td_str = arr[i];
    		if(f.empty(td_str)){continue;}
    		m = new HashMap();
    		m.put("ip",ip);
    		m.put("port",port);
    		m.put("user",user);
    		m.put("pwd",pwd);
    		m.put("td",td_str);
    		m.put("station_id",b.get("station_id"));
    		m.put("station_name",b.get("station_desc"));
    		list.add(m);
    		
    		
    	}
    	
    	
    	
    	
    	
    	
		return list;
	}
    
    
    public static List getSpList(List list)throws Exception{
		List list2 =new ArrayList();
		int i,num=0;
		Map m = null;
		List list3 = null;
		
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			list3 = getSpList(m);
			list2.addAll(list3);
		}
		
		return list2;
	}
    
    
}
