package com.hoson.util;
import java.sql.*;
import java.io.*;
import java.util.*;

import com.hoson.*;
import com.hoson.app.*;
import com.hoson.util.*;

import javax.servlet.http.*;
public class x{
	
	public static String getRealDataByDay(HttpServletRequest req)
	throws Exception{
		String s = null;
		String station_id = (String)req.getParameter("station_id");
		//String m_time = (String)req.getParameter("m_time");
		String m_time = (String)req.getParameter("date1");
		
		String sql = null;
		Map map = null;
		Map m = null;
		List list = null;
		List dataList = new ArrayList();
		Map timeMap = new HashMap();
		int i,j,num =0;
		Connection cn = null;
		
		String infectant_id = null;
		String m_time0 = null;
		String station_type = null;
		StringBuffer sb = new StringBuffer();
		String m_value = null;
		
		sql = "select m_time,infectant_id,m_value from t_monitor_real_minute where station_id='"+station_id+"' and m_time>='"+m_time+"' and m_time<'"+m_time+" 23:59:59' order by m_time desc";
		//System.out.println(sql);
		try{
		cn = DBUtil.getConn();
		list = DBUtil.query(cn,sql);
		
		num = list.size();
		
		for(i=0;i<num;i++){
			
			map = (Map)list.get(i);
			m_time = (String)map.get("m_time");
			infectant_id = (String)map.get("infectant_id");
			
			if(!StringUtil.equals(m_time,m_time0)){
				m_time0 = m_time;
				m = new HashMap();
				dataList.add(m);
				m.put("m_time",m_time);
				m.put(infectant_id,map.get("m_value"));
			}else{
				m.put(infectant_id,map.get("m_value"));
			}
			
			//System.out.println(m);
			
		
			
		}
		sql = "select station_type from t_cfg_station_info where station_id='"+station_id+"' ";
		map = DBUtil.queryOne(cn,sql,null);
		if(map==null){
			//throw new Exception("station_type不能为空");
			throw new Exception("记录不存在 station_id="+station_id);
		}
		station_type = (String)map.get("station_type");
		
		
		map = AppPage.getInfectantIdAndTitle(cn,station_id,"0");
		
		List idList = (List)map.get("id");
		List titleList = (List)map.get("title");
		
		int idNum = 0;
		idNum = idList.size();
		//System.out.println(idNum);
		num = dataList.size();
		for(i=0;i<num;i++){
			map = (Map)dataList.get(i);
			sb.append("<tr>\n");
			
			sb.append("<td>").append(i+1).append("</td>");
			m_time = (String)map.get("m_time");
				//m_time = getRealTime(m_time);
				
			sb.append("<td>").append(m_time).append("</td>\n");
			
			
			for(j=0;j<idNum;j++){
				infectant_id=(String)idList.get(j);
				m_value = (String)map.get(infectant_id);
				/*
				if(StringUtil.isempty(m_value)){
					sb.append("<td></td>\n");
				}else{
					if(m_value.startsWith(".")){m_value="0"+m_value;}
					sb.append("<td>").append(m_value).append("</td>\n");
				}
				*/
				if(StringUtil.isempty(m_value)){
					m_value = "";
				}
				if(m_value.startsWith(".")){m_value="0"+m_value;}
				sb.append("<td>").append(m_value).append("</td>\n");
				
			}
			sb.append("</tr>\n");
		}
		s = sb+"";
		String s2 = "";
		for(i=0;i<idNum;i++){
			s2 = s2+"<td class=center>"+titleList.get(i)+"</td>\n";
			
		}
		s = s2+"</tr>\n"+s;
		
		return s;
		}catch(Exception e){throw e;}finally{DBUtil.close(cn);}
		
	}
	
	
	
}