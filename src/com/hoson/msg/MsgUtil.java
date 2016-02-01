package com.hoson.msg;
import java.sql.*;
import java.util.*;

import com.hoson.*;
import com.hoson.util.*;

public class MsgUtil{
	static String error_msg = null;
	private static String msg="";
	private static String msg2="";
	
	public static String getMsg(){
		return msg;
	}
	
	public static void set_error_msg(Object msg){
		error_msg=msg+"";
	}
	public static String get_error_msg(){
		return error_msg;
	}
	
	public static Map getStationMap(Connection cn)throws Exception{
		Map m = null;
		String sql = null;
		List list = null;
		
		sql = "select station_id,station_desc,area_id from t_cfg_station_info ";
		list = f.query(cn,sql,null);
		m = f.getMap(list,"station_id");
		return m;
		
	}
	
	public static Map getAreaPhoneListMap(Connection cn)throws Exception{
		Map m = null;
		String sql = null;
		List list = null;
		
		sql = "select area_id,phone_no from t_sys_msg_area_phone ";
		try{
			list = f.query(cn,sql,null);
		}catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(cn);
		}
		m = f.getListMap(list,"area_id");
		return m;
		
	}
	
	public static List getAreaPhoneList(Connection cn)throws Exception{
		Map m = null;
		String sql = null;
		List list = null;
		
		sql = "select area_id,phone_no from t_sys_msg_area_phone ";
		list = f.query(cn,sql,null);
		//m = f.getListMap(list,"area_id");
		return list;
		
	}
	
	
	public static List getPhoneList(List list,String area_id)throws Exception{
		Map m = null;
		HashSet set = new HashSet();
		int i,num=0;
		String id,phone_no = null;
		List list2 = new ArrayList();
		
		if(f.empty(area_id)){return list2;}
		num=list.size();
		
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			id = (String)m.get("area_id");
			phone_no = (String)m.get("phone_no");
			if(f.empty(id)){continue;}
			if(f.empty(phone_no)){continue;}
			//if(area_id.indexOf(id)>=0){set.add(phone_no);}
			if(area_id.startsWith(id)){set.add(phone_no);}
			
		}
		
		
		list2.addAll(set);
		
		return list2;
		
	}
	
	
	public static String  msg_sql(String col)throws Exception{
		String types = f.cfg("msg_station_types","");
		if(f.empty(types)){return "";}
		String[]arr=types.split(",");
		int i,num=0;
		String s="";
		String type=null;
		
		num=arr.length;
		for(i=0;i<num;i++){
			type=arr[i];
			
			if(i>0){s=s+",";}
			s=s+"'"+type+"'";
			
		}
		String sql = " and "+col+" in (select station_id from t_cfg_station_info where station_type in ("+s+") )";
		return sql;
	}
	
	public static List getHourData(Connection cn)throws Exception{
		List list = null;
		String sql = null;
		String now = StringUtil.getNowDate()+"";
		
		sql="select a.* from t_monitor_real_hour a,";
		
	    sql=sql+"(select station_id,max(m_time) as max_m_time from t_monitor_real_hour where m_time>='"+now+"' and m_time<='"+now+" 23:59:59' group by station_id)";
		sql=sql+" b ";
		sql=sql+" where a.m_time=b.max_m_time and a.station_id=b.station_id ";
		sql=sql+" and a.m_time>='"+now+"' and a.m_time<='"+now+" 23:59:59'";
		//f.debug(sql);
		sql=sql+msg_sql("a.station_id");
		//f.sop(sql);
		//list = f.query(cn,sql,null);
		msg2 = "";
		msg2 = msg2+","+f.time()+"";
		list = f.query(cn,sql,null);
		msg2 = msg2+","+f.time()+"";
		
		msg2 = msg2+",hour data size="+list.size();
		msg2 = msg2+","+sql;
		msg=msg2;
		
		return list;
		
	}
	
	public static List getWarnDataList(Connection cn)throws Exception{
		List list = null;
		List list2 = new ArrayList();
		
		List infectantList = null;
		Map infectantListMap = null;
		List stationInfectantList = null;
		Map m = null;
		Map row = null;
		String station_id = null;
		
		list = getHourData(cn);
		infectantList = WarnUtil.getInfectantList(cn);
		infectantListMap = f.getListMap(infectantList,"station_id");
		int i,num=0;
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			station_id =(String)m.get("station_id");
			stationInfectantList = (List)infectantListMap.get(station_id);
			if(stationInfectantList==null){continue;}
			row = WarnUtil.getWarnDataRow(m,stationInfectantList);
			if(row==null){continue;}
			list2.add(row);
			
		}
		
		
		
		return list2;
		
	}
	
	public static List getWarnDataList(List list,Map infectantListMap)throws Exception{
		
		List list2 = new ArrayList();
		
	
		//Map infectantListMap = null;
		List stationInfectantList = null;
		Map m = null;
		Map row = null;
		String station_id = null;
		
		
		//infectantListMap = f.getListMap(infectantList,"station_id");
		int i,num=0;
		num = list.size();
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			station_id =(String)m.get("station_id");
			stationInfectantList = (List)infectantListMap.get(station_id);
			if(stationInfectantList==null){continue;}
			row = WarnUtil.getWarnDataRow(m,stationInfectantList);
			if(row==null){continue;}
			list2.add(row);
			
		}
		
		
		
		return list2;
		
	}
	
	
	
	
	public static Map getMsgMap(Connection cn)throws Exception{
		Map m = new HashMap();
		List list = null;
		int i,num=0;
		Map row = null;
		String sql = null;
		String now = StringUtil.getNowDate()+"";
		String key = null;
		
		sql = "select station_id,m_time,phone_no from t_sys_msg_his where ";
		sql=sql+" m_time>='"+now+"' and m_time<='"+now+" 23:59:59' ";
		list = f.query(cn,sql,null);
		num = list.size();
		for(i=0;i<num;i++){
			row=(Map)list.get(i);
			key=row.get("station_id")+"_"+row.get("m_time")+"_"+row.get("phone_no");
			m.put(key,"1");
			
		}
		
		
		
		return m;
		
	}
	
	public static Map getMsgNumMap(Connection cn)throws Exception{
		Map m = new HashMap();
		List list = null;
		int i,num=0;
		Map row = null;
		String sql = null;
		String now = StringUtil.getNowDate()+"";
		String key = null;
		String v = null;
		int msgnum = 0;
		sql="select station_id,phone_no,count(1) as msg_num from  t_sys_msg_his where ";
		sql=sql+" m_time>='"+now+"' ";		
		sql=sql+" and m_time<='"+now+" 23:59:59' ";		
		sql=sql+"group by station_id,phone_no ";
		
		list = f.query(cn,sql,null);
		num = list.size();
		for(i=0;i<num;i++){
			row = (Map)list.get(i);
			v = (String)row.get("msg_num");
			msgnum = f.getInt(v,0);
			if(msgnum<1){continue;}
			key = row.get("station_id")+"_"+row.get("phone_no");
			m.put(key,new Integer(msgnum));
			
		}
		
		
		return m;
		
	}
	
	
	public static boolean hasSend(Map data,Map msgMap,String phone_no){
		boolean b = false;
		String key = null;
		String flag = null;
		key=data.get("station_id")+"_"+data.get("m_time")+"_"+phone_no;
		flag = (String)msgMap.get(key);
		if(f.eq(flag,"1")){b=true;}
		
		return b;
	}
	public static boolean isOverMaxNum(Map data,Map msgNumMap,String phone_no,int max_num){
		boolean b = false;
		String key = null;
		String flag = null;
		Integer num = null;
		String station_id = (String)data.get("station_id");
		key=data.get("station_id")+"_"+phone_no;
		num = (Integer)msgNumMap.get(key);
		/*
		if(f.eq(station_id,"3301015003")){
			 f.debug("station msg num "+num);
			 }
			 */
		if(num==null){return false;}
		if(num.intValue()>=max_num){return true;}
		return b;
	}
	
	public static String getMsg(Map data,List stationInfectList,Map stationMap,
			Map configMap){
		String msg = null;
		String station_id = (String)data.get("station_id");
		String station_name = null;
		String m_time = (String)data.get("m_time");
		//station_name = (String)stationMap.get(station_id);
		station_name = get(stationMap,station_id,"station_desc");
		String col,v = null;
		int i,num=0;
		Map m = null;
		
		num = stationInfectList.size();
		/*
		 if(f.eq(station_id,"3301015003")){
			 f.debug("station infectant list size "+num);
			 }
		*/
		msg="";
		for(i=0;i<num;i++){
			m = (Map)stationInfectList.get(i);
			col = (String)m.get("col");
			v = (String)data.get(col);
			if(f.empty(v)){continue;}
			msg=msg+" "+m.get("infectant_name")+" "+v;
			
		}
		
		msg=station_name+" "+m_time+msg;
		/*
		if(f.eq(station_id,"3301015003")){
			 f.debug("msg "+msg);
			 }
		
		*/
		
		msg=msg+" "+getMsgFrom(configMap);
		return msg;
	}
	
	 public static void save_msg(Connection cn,String mobile,String content)throws Exception{
		 
		   String sql = "insert into sms_send(id,mobile,content)values(sms_seq.nextval,?,?)";
		  
		  // String id = DBUtil.getMaxId(cn,"sms_send","id")+"";
		   String id = DBUtil.getNextId(cn,"sms_send","id")+"";
		   //sql = "insert into sms_send(id,mobile,content,save_time)values("+id+",?,?,?)";
		   sql = "insert into sms_send(id,mobile,content,submit_time)values("+id+",?,?,?)";
		   
		   f.update(cn,sql,new Object[]{mobile,content,f.time()});
		   
		   
	   }
	 
	 public static void save_msg_his(Connection cn,String station_id,String phone_no,String m_time,String msg)throws Exception{
		 String t = "t_sys_msg_his";
		 String col = "station_id,m_time,phone_no,msg_content";
		 Object[]p=new Object[]{station_id,f.time(),phone_no,msg};
		Map model = new HashMap();
		m_time = f.sub(m_time,0,19);
		model.put("station_id",station_id);
		model.put("m_time",m_time);
		model.put("phone_no",phone_no);
		model.put("msg_content",msg);
		
		f.insert(cn,t,col,0,model);
		
		  
	   }
	 
	 
	   
	 public static int send_msg(Connection cn,Map data,
			 Map msgMap,Map msgNumMap,Map stationMap,Map configMap,
			 List stationInfectList,
			 String phone_no,int max_num)throws Exception{
		 boolean b = false;
		 String station_id = (String)data.get("station_id");
		 //f.debug(data+","+phone_no+","+msgMap+","+msgNumMap);
		 
		 b = hasSend(data,msgMap,phone_no);
		 /*
		 if(f.eq(station_id,"3301015003")){
		 f.debug("has send "+b);
		 }
		 */
		 if(b){return 0;}
		 
		 b = isOverMaxNum(data,msgNumMap,phone_no,max_num);
		 /*
		 if(f.eq(station_id,"3301015003")){
			 f.debug("is over max num "+b);
			 }
			 */
		 
		 if(b){return 0 ;}
		 
		 String msg = getMsg(data,stationInfectList,stationMap,configMap);
		 
		 
		 
		 //f.debug(msg);
		 
		 save_msg(cn,phone_no,msg);
		 String m_time = (String)data.get("m_time");
		 save_msg_his(cn,station_id,phone_no,m_time,msg);
		 
		 return 1;
	 }
	 
	
	 
	 public static int send_msg(Connection cn,Map data,
			 Map msgMap,Map msgNumMap,Map stationMap,Map configMap,
			 Map infectantListMap,
			 List areaPhoneList,int max_num)throws Exception{
		String phone_no = null;
		int i,num=0;
		List phone_list = null;
		String station_id = (String)data.get("station_id");
		Map stationInfo = (Map)stationMap.get(station_id);
		Map phoneMap = null;
		int flag = 0;
		int msgnum=0;
		
		//f.debug(station_id+","+stationInfo);
		
		/*
		if(f.eq(station_id,"3301015003")){
			f.debug(data);
		}
		*/
		if(stationInfo==null){return 0;}
		String area_id = (String)stationInfo.get("area_id");
		
		//f.log_debug("area_id="+area_id+","+stationInfo);
		
		//phone_list = (List)phoneListMap.get(area_id);
		phone_list = getPhoneList(areaPhoneList,area_id);
		
		f.log_debug(f.list2str(phone_list));
		
		//f.debug(station_id+","+area_id+",phone_list "+phone_list);
		/*
		if(f.eq(station_id,"3301015003")){
			f.debug(phone_list);
		}
		*/

		if(phone_list==null){return 0;}
		num = phone_list.size();
		if(num<1){return 0;}
		
		//f.debug(station_id+","+area_id+","+phone_list.size());
		
		List stationInfectList=null;
		
		stationInfectList = (List)infectantListMap.get(station_id);
		//f.debug(station_id+",stationInfectList "+stationInfectList);
		if(stationInfectList==null){return 0;}
		
		//f.debug(station_id+",stationInfectList size "+stationInfectList.size());
		
		
	
	
		
		for(i=0;i<num;i++){
			//phoneMap = (Map)phone_list.get(i);
			//phone_no = (String)phone_list.get(i);
			//phone_no = (String)phoneMap.get("phone_no");
			//f.log_debug("----phone_no="+phone_list.get(i));
			//f.log_debug("----phone_no class="+phone_list.get(i).getClass());
			phone_no = (String)phone_list.get(i);
			//f.log_debug("-----phone_no2="+phone_no);
			flag = send_msg(cn,data,msgMap,msgNumMap,stationMap,configMap,stationInfectList,phone_no,max_num);
			if(flag>0){msgnum=msgnum+flag;}
		}
		
		 return msgnum;
	 }
	
	 public static int send_msg(Connection cn,List dataList,
			 Map msgMap,Map msgNumMap,Map stationMap,Map configMap,
			 Map infectantListMap,
			 List areaPhoneList,int max_num)throws Exception{
		 
		 Map data = null;
		 int i,num=0;
		 int flag = 0;
		 int msgnum=0;
		 
		 num =dataList.size();
		 for(i=0;i<num;i++){
			 data = (Map)dataList.get(i);
			 //f.debug(data);
			 //f.log_debug(data);
			 flag = send_msg(cn,data,msgMap,msgNumMap,stationMap,configMap,infectantListMap,
					 areaPhoneList,max_num);
			 if(flag>0){msgnum=msgnum+flag;}
		 }
		 return msgnum;
	 }
	 
	
	
	 
	public static void run(){
		 Connection cn = null;
	      List list = null;
	      List infectantList = null;
	      Map infectantListMap = null;
	      List warnDataList = null;
	      Map msgNumMap = null;
	      Map msgMap = null;
	      Map stationMap = null;
	      List areaPhoneList = null;
	      
	      int max_num=5;
	      Timestamp t1,t2 = null;
	      String log_msg = null;
	      t1 = f.time();
	      Map configMap = null;
	      String sql = null;
	      int msgnum=0;
	      
	      try{
	      cn = f.getConn();
	       sql = "select msg_key,msg_value from t_sys_msg_config";
	       configMap = f.getMap(cn,sql);
	       f.log_debug(configMap);
	       max_num = getMaxMsgNum(configMap);
	      
	        list = MsgUtil.getHourData(cn);
	        // f.debug("data list size "+list.size()+"");
	        infectantList = WarnUtil.getInfectantList(cn);
	       // f.debug("infectant list size "+infectantList.size()+"");
	        
	         msgNumMap = MsgUtil.getMsgNumMap(cn);
	         //f.debug(msgNumMap);
	         msgMap = MsgUtil.getMsgMap(cn);
	         //f.debug(msgMap);
	         
	         areaPhoneList = getAreaPhoneList(cn);
	     // f.debug(areaPhoneListMap);
	       //  f.log_debug(areaPhoneListMap);
	        infectantListMap = f.getListMap(infectantList,"station_id");
	        warnDataList = MsgUtil.getWarnDataList(list,infectantListMap);
	       
	        f.log_debug("warn data size="+warnDataList.size());
	        
	      //  f.debug("wanr data list size "+warnDataList.size()+"");
	        stationMap = getStationMap(cn);
	        msgnum = send_msg( cn,warnDataList,msgMap,msgNumMap,stationMap,configMap,
	        		infectantListMap,
	        		areaPhoneList,max_num);
	                t2 = f.time();
	                
	                log_msg = "短信报警启动,开始"+t1+",结束"+t2+",发送短信条数="+msgnum;
	      }catch(Exception e){
	    	  
	        //throw e;
	    	  log_msg=e+"";
	        
	      }finally{f.close(cn);}
	      
		log(log_msg);
	} 
	 
	 public static String get(Map m,String key1,String key2){
		 String s = null;
		 Map m2 = null;
		 m2 = (Map)m.get(key1);
		 if(m2==null){return "";}
		 s = (String)m2.get(key2);
		 if(s==null){s="";}
		 return s;
		 
	 }
	 
	 public static void log(Object msg){
		 try{
		 String t = "t_sys_msg_log";
		 String cols = "log_id,log_time,log_content";
		 Map m = new HashMap();
		 String time = f.time()+"";
		 time = f.sub(time,0,19);
		 m.put("log_time",time);
		 m.put("log_content",msg+"");
		 f.insert(t,cols,1,m);
		 }catch(Exception e){
			 
		 }
		 
	 }
	 
	 public static String getMsgFrom(Map m){
		 String key="msg_from";
		 String s = (String)m.get(key);
		 if(f.empty(s)){s="环境保护局";}
		 return s;
	 }
	 
	 public static int getMaxMsgNum(Map m){
		 String key="station_max_msg_num";
		 String s = (String)m.get(key);
		 //if(f.empty(s)){s="环境保护局";}
		 int num = f.getInt(s,5);
		 if(num<1){num=1;}
		 
		 return num;
	 }
	public static int get_sleep_time(){
		String s = f.cfg("msg_sleep_time","600");
		int i = f.getInt(s,600);
		i = i*1000;
		return i;
	}
}