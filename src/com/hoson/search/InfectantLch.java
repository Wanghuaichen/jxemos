package com.hoson.search;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.hoson.util.AreaInfo;
import com.hoson.f;

public class InfectantLch {
	
	public static void infectan_lch(HttpServletRequest req)throws Exception{
		
		String station_types="1,2,3,4,5,6";
		String arr[]=station_types.split(",");
		String station_type = "";
		List list= null;
		int num=arr.length;
		String sql = "select * from t_cfg_infectant_base where infectant_type!='0' and station_type=?";
		for(int i=0;i<num;i++){
			station_type=arr[i];
			list = f.query(sql,new Object[]{station_type});
			req.setAttribute("list_"+station_type,list);
		}
		Map m = AreaInfo.getStationTypeMap();
		req.setAttribute("map",m);
	}
}
