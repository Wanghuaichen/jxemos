package com.hoson.util;

import java.util.*;
import java.sql.*;
import com.hoson.*;

public class DataUtil{


  public static List getRealData(List list)
  throws Exception{
    
    int i,num=0;
    num = list.size();
    Map map,m = null;
    String infectant_id,m_time,m_value,m_time0 = null;
    List dataList = new ArrayList();
    
    
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
			}
    return dataList;
  }

	
}