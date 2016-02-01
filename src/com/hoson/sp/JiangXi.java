package com.hoson.sp;

import java.util.*;

import com.hoson.f;
import javax.servlet.http.*;

import com.hoson.ErrorMsg;
import com.hoson.XBean;
import com.hoson.zdxupdate.zdxUpdate;

public class JiangXi {

	/*
	 * ! 根据request值获得所有检测点列表
	 */
	public static void list(HttpServletRequest req) throws Exception {
		Map model = f.model(req);
		List list = null;
		String station_type, area_id, p_station_name;
		String stationTypeOption, areaOption;
		List stationList = null;
		XBean b = new XBean(model);

		station_type = b.get("station_type");
		area_id = b.get("area_id");
		// area_id = req.getSession().getAttribute("area_id")+"";

		p_station_name = b.get("p_station_name");

		if (f.empty(station_type)) {
			station_type = f.getDefaultStationType();
		}
		if (f.empty(area_id)) {
			area_id = f.getDefaultAreaId();
		}
		model.put("station_type", station_type);
		model.put("area_id", area_id);
		model.put("cols", "*");
		model.put("order_cols", "s.station_no,s.area_id,s.station_desc");
		model.put("sp", "yes");
		if (!f.empty(p_station_name)) {
			model.put("station_desc", p_station_name);
		}

		list = zdxUpdate.getStationList(b);
		stationTypeOption = f.getStationTypeOption(station_type);
		areaOption = f.getAreaOption(area_id);
		list = getSpList(list);

		req.setAttribute("station_type", station_type);
		req.setAttribute("area_id", area_id);
		req.setAttribute("stationTypeOption", stationTypeOption);
		req.setAttribute("areaOption", areaOption);
		req.setAttribute("p_station_name", p_station_name);
		req.setAttribute("list", list);

	}

	/*
	 * ! 根据request值获得一个监测点视频信息
	 */
	public static void one(HttpServletRequest req) throws Exception {
		String station_id = req.getParameter("station_id");
		List list;
		list = getSpList(station_id);
		req.setAttribute("list", list);

	}

	public static List getSpList(String station_id) throws Exception {
		if (f.empty(station_id)) {
			ErrorMsg.station_id_empty();
		}
		List list;
		String sql = "select * from t_cfg_station_info where station_id=?";
		Map m = null;
		m = f.queryOne(sql, new Object[] { station_id });
		if (m == null) {
			ErrorMsg.no_data();
		}

		list = getSpList(m);

		int num = 0;
		num = list.size();
		if (num < 1) {
			f.error("请配置视频IP和通道");
		}

		return list;
	}

	/*
	 * ! 根据request值获得监测点因子信息
	 */
	public static List getSpList(Map map) throws Exception {
		// if(f.empty(station_id)){ErrorMsg.station_id_empty();}
		List list = new ArrayList();
		if (map == null) {
			return list;
		}
		String puid, td;
		XBean b = new XBean(map);
		// station_ip,sp_type,sb_id,sp_port,sp_user,sp_pwd,sp_channel
		puid = b.get("sb_id");
		td = b.get("sp_channel");

		if (f.empty(puid)) {
			return list;
		}
		// if(f.empty(td)){return list;}

		String[] arr = td.split(",");
		int i, num = 0;
		String td_str;
		Map m = null;

		num = arr.length;
		for (i = 0; i < num; i++) {
			td_str = arr[i];
			if (f.empty(td_str)) {
				continue;
			}
			String[] a = puid.split(",");
			for (int x = 0; x < a.length; x++) {
				if (f.empty(a[x])) {
					continue;
				}
				m = new HashMap();
				m.put("puid", a[x]);
				m.put("td", td_str);
				m.put("station_id", b.get("station_id"));
				m.put("station_name", b.get("station_desc"));
				list.add(m);
			}
		}
		return list;
	}

	/*
	 * ! 根据request值获得监测点因子信息
	 */
	public static List getSpList(List list) throws Exception {
		List list2 = new ArrayList();
		int i, num = 0;
		Map m = null;
		List list3 = null;

		num = list.size();
		for (i = 0; i < num; i++) {
			m = (Map) list.get(i);
			list3 = getSpList(m);
			list2.addAll(list3);
		}
		return list2;
	}
}