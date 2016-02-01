package com.hoson.map;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hoson.DBUtil;
import com.hoson.app.App;

public class GoogleMap {
	/**
	 * 谷歌地图上站点信息
	 * 
	 * @return
	 */
	public List<TCfgStationInfo> getStations() {
		try {
			Connection cn = DBUtil.getConn();
//			String sql = "select a.station_id,a.station_desc,a.x_d,a.x_m,a.x_s,a.y_d,a.y_m,a.y_s, b.parameter_name from t_cfg_station_info a, t_cfg_parameter b where b.parameter_type_id='monitor_type' and a.station_type=b.parameter_value and (charge_area=3609 or charge_area=360981) ";
			String sql = "select a.station_id,a.station_desc,a.x_d,a.x_m,a.x_s,a.y_d,a.y_m,a.y_s, b.parameter_name from t_cfg_station_info a, t_cfg_parameter b where b.parameter_type_id='monitor_type' and a.station_type=b.parameter_value and area_id like '"+App.get("default_area_id")+"%'";
			List list = DBUtil.query(cn, sql);
			Map hm = new HashMap();
			String x_d, x_m, x_s, y_d, y_m, y_s;
			Double fx, fy;
			List<TCfgStationInfo> stationList = new ArrayList<TCfgStationInfo>();
			for (int i = 0; i < list.size(); i++) {
				TCfgStationInfo stationInfo = new TCfgStationInfo();
				hm = (HashMap) list.get(i);
				x_d = (String) hm.get("x_d");
				stationInfo.setStationId((String) hm.get("station_id"));
				stationInfo.setStationDesc((String) hm.get("station_desc"));
				stationInfo.setParameterName((String) hm.get("parameter_name"));
				y_d = (String) hm.get("y_d");
				if (x_d != null && x_d.length() > 0 && y_d != null
						&& y_d.length() > 0) {
					fx = Double.parseDouble(x_d);
					fy = Double.parseDouble(y_d);
					x_m = (String) hm.get("x_m");
					if (x_m != null && x_m.length() > 0) {
						fx = fx + Double.parseDouble(x_m) / 60;
						x_s = (String) hm.get("x_s");
						if (x_s != null && x_s.length() > 0) {
							fx = fx + Double.parseDouble(x_s) / 3600;
							stationInfo.setLongitude(String.valueOf(fx));
						}
					}
					y_m = (String) hm.get("y_m");
					if (y_m != null && y_m.length() > 0) {
						fy = fy + Double.parseDouble(y_m) / 60;
						y_s = (String) hm.get("y_s");
						if (y_s != null && y_s.length() > 0) {
							fy = fy + Double.parseDouble(y_s) / 3600;
							stationInfo.setLatitude(String.valueOf(fy));
						}
					}
				}
				stationList.add(stationInfo);
			}
			return stationList;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}
