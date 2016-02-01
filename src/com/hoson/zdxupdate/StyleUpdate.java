package com.hoson.zdxupdate;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.hoson.f;


public class StyleUpdate
{
	public static void getPercentOfStyle(HttpServletRequest req) throws Exception
	{
		String ctl_type = req.getParameter("ctl_type");
		String date1 = req.getParameter("date1");
		String date2 = req.getParameter("date2");
		List hourList = new ArrayList();
		for(int i=0;i<24;i++)
		{
			Map mp = new HashMap();
			mp.put("v_k",i+"");
			mp.put("t_k",i+"");
			hourList.add(mp);
		}
		int hour = f.time().getHours()+1;
		String hourOption1 = f.getOption(hourList,"v_k","t_k",null);
		String hourOption2 = f.getOption(hourList,"v_k","t_k",hour+"");
		req.setAttribute("hour1",hourOption1);
		req.setAttribute("hour2",hourOption2);
		if(f.empty(date1))
		{
			date1 = f.today();
		}
		if(f.empty(date2))
		{
			date2 = f.today();
		}
		req.setAttribute("date1",date1);
		req.setAttribute("date2",date2);
		String ctlOption = StyleUtil.getCtlOption(ctl_type);
		req.setAttribute("ctlOption",ctlOption);
		if(ctl_type==null)
		{
			return;
		}
		List areaList = StyleUtil.getAreaList();
		List typeList = StyleUtil.getTypeList();
		req.setAttribute("areaList",areaList);
		req.setAttribute("typeList",typeList);
		Map stationMap = StyleUtil.getArea_StationMap(ctl_type);
		stationMap = StyleUtil.getAreaAndTypePercent(areaList,typeList,stationMap,date1,date2);
		req.setAttribute("stationMap",stationMap);
		req.setAttribute("mark","1");
	}
}