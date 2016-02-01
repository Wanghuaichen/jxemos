package com.hoson.action;
import com.hoson.mvc.*;
import com.hoson.*;

import java.util.*;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;

import com.hoson.util.*;
import com.hoson.app.*;
import com.hoson.app.AppPagedUtil;

public class AreaReportAction extends BaseAction{
	
	public String form()throws Exception{
		
		String date1 = p("date1");
		String station_type = p("station_type");
		String report_type = p("report_type");
		String area_id = p("area_id");
		
		String stationTypeOption = null;
		String reportTypeOption = null;
		String areaOption = null;
		
		
		
		if(f.empty(date1)){date1 = f.today();}
		if(f.empty(station_type)){station_type="1";}
		if(f.empty(report_type)){report_type="day";}
		if(f.empty(area_id)){
			area_id = f.cfg("default_area_id","3301");
		}
		getConn();
        areaOption = JspPageUtil.getAreaOption(conn,area_id);
		
		stationTypeOption =AreaReport.getStationTypeOption(station_type);
		reportTypeOption =AreaReport.getReportTypeOption(report_type);
		

		seta("areaOption",areaOption);
		seta("stationTypeOption",stationTypeOption);
		seta("reportTypeOption",reportTypeOption);
		seta("date1",date1);
		

		return null;
	}
	
}