package com.hoson.map;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.sql.Connection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.hoson.DBUtil;

public class MapUtil_bak {

	public static String getAllStation(HttpServletRequest req,
			String station_type) throws Exception {
		Connection cn = DBUtil.getConn(req);
		/*String sql = "select a.station_desc,a.x_d,a.x_m,a.x_s,a.y_d,a.y_m,a.y_s, b.parameter_name from t_cfg_station_info a, t_cfg_parameter b where b.parameter_type_id='monitor_type' and a.station_type=b.parameter_value and a.station_type="
				+ station_type;*/
		//只取丰城站点
		String sql = "select a.station_desc,a.x_d,a.x_m,a.x_s,a.y_d,a.y_m,a.y_s, b.parameter_name from t_cfg_station_info a, t_cfg_parameter b where b.parameter_type_id='monitor_type' and a.station_type=b.parameter_value and (charge_area=3609 or charge_area=360981) and a.station_type="
			+ station_type;
		List list = DBUtil.query(cn, sql);
		Map hm = new HashMap();
		String typech = "";
		if(list!=null||list.size()>0){
			try{
				typech = (String)((HashMap)list.get(0)).get("parameter_name");
			}catch(Exception e){
				typech = "";
			}
		}
		String xmlString = "<?xml version='1.0' encoding='UTF-8'?>"
				+ "<anychart>"
				+ "<charts>"
				+ "<chart plot_type='Map'>"
				+ "<chart_settings>"
				+ "<title>"
				+ "<font family='宋体' color='Black' size='15' bold='True' italic='False' underline='False' render_as_html='False' />"
				+ "<text>丰城市"
				+typech
				+"站点</text>"
				+ "</title>"
				+ "<controls>"
				+ "<navigation_panel width='50' height='50' enabled='true' position='right' align='near' inside_dataplot='true'>"
				+ "<background enabled='false' />"
				+ "</navigation_panel>"
				+ "<zoom_panel width='50' enabled='true' position='right' align='near' inside_dataplot='true'>"
				+ "<background enabled='false' />"
				+ "</zoom_panel>"
				+ "</controls>"
				+ "<chart_background enabled='false'/> "
				+ "</chart_settings>"
				+ "<data_plot_settings>"
				+ "<map_series source='fengcheng.amap' labels_display_mode='Always' id_column='EN_NAME'>"
				+ "<projection type='mercator' />"
				+ "<defined_map_region palette='default'>"
				+ "<label_settings enabled='True' >"
				+ "<format><![CDATA[{%ch_name}]]></format>"
				+ "<font color='#000000' size='14' />"
				+ "<background enabled='false'/>"
				+ "</label_settings>"
				+ "</defined_map_region>"
				+ "</map_series>"
				+ "<marker_series>"
				+ "<label_settings enabled='false'>"
				+ "<font family='宋体' color='Black' size='12' bold='True' italic='False' underline='False' render_as_html='False' />"
				+ "<format>{%Name}</format>"
				+ "</label_settings>"
				+ "<tooltip_settings enabled='true'>"
				+ "<font family='宋体' color='Black' size='12' bold='True' italic='False' underline='False' render_as_html='False' />"
				+ "<format>{%Name}</format>" + "</tooltip_settings>"
				+ "</marker_series>" + "</data_plot_settings>" + "<data>"
				+ "        <series type='MapRegions'>"
				+ "          <point name='xingan' color='Violet'>"
				+ "            <attributes>"
				+ "              <attribute name='ch_name'>新干县</attribute>"
				+ "            </attributes>" + "          </point>"
				+ "          <point name='zhangshu' color='Thistle'>"
				+ "            <attributes>"
				+ "              <attribute name='ch_name'>樟树市</attribute>"
				+ "            </attributes>" + "          </point>"
				+ "          <point name='gaoan' color='wheat'>" + "            <attributes>"
				+ "              <attribute name='ch_name'>高安市</attribute>"
				+ "            </attributes>" + "          </point>"
				+ "          <point name='linchuan'  color='Thistle'>"
				+ "            <attributes>"
				+ "              <attribute name='ch_name'>临川区</attribute>"
				+ "            </attributes>" + "          </point>"
				+ "          <point name='fengcheng' color='Yellow'>"
				+ "            <attributes>"
				+ "              <attribute name='ch_name'>丰城市</attribute>"
				+ "            </attributes>" + "          </point>"
				+ "          <point name='lean' color='Pink'>" + "            <attributes>"
				+ "              <attribute name='ch_name'>乐安县</attribute>"
				+ "            </attributes>" + "          </point>"
				+ "          <point name='chongren' color='Orange'>"
				+ "            <attributes>"
				+ "              <attribute name='ch_name'>崇仁县</attribute>"
				+ "            </attributes>" + "          </point>"
				+ "          <point name='jinxian' color='Violet'>"
				+ "            <attributes>"
				+ "              <attribute name='ch_name'>进贤县</attribute>"
				+ "            </attributes>" + "          </point>"
				+ "          <point name='nanchang' color='Pink'>"
				+ "            <attributes>"
				+ "              <attribute name='ch_name'>南昌县</attribute>"
				+ "            </attributes>" + "          </point>"
				+ "          <point name='xinjian' color='Orange'>"
				+ "            <attributes>"
				+ "              <attribute name='ch_name'>新建县</attribute>"
				+ "            </attributes>" + "          </point>"
				+ "        </series>";
		String x_d, x_m, x_s, y_d, y_m, y_s;
		Double fx,fy;
		for (int i = 0; i < list.size(); i++) {
			hm = (HashMap) list.get(i);
			x_d = (String) hm.get("x_d");
			y_d = (String) hm.get("y_d");
			if (x_d != null && x_d.length() > 0 && y_d != null && y_d.length() > 0) {
				fx = Double.parseDouble(x_d);
				fy = Double.parseDouble(y_d);
				x_m = (String) hm.get("x_m");
				if (x_m != null && x_m.length() > 0) {
					fx = fx+Double.parseDouble(x_m)/60;
					x_s = (String) hm.get("x_s");
					if (x_s != null && x_s.length() > 0) {
						fx = fx +Double.parseDouble(x_s)/3600;
					}
				}
				y_m = (String) hm.get("y_m");
				if (y_m != null && y_m.length() > 0) {
					fy = fy+Double.parseDouble(y_m)/60;
					y_s = (String) hm.get("y_s");
					if (y_s != null && y_s.length() > 0) {
						fy = fy +Double.parseDouble(y_s)/3600;
					}
				}
				
				xmlString = xmlString
						+ "<series type='Marker' style='Cities'>"
						+ "<point name='"
						+ (String) hm.get("station_desc")
						+ "' y='"
						+ fy
						+ "' x='"
						+ fx
						+ "' >"
						+ "<attributes>"
						+ "<attribute name='type'>"
						+ (String) hm.get("parameter_name")
						+ "</attribute>"
						+ "</attributes>"
						+ "<actions>"
						+ "<action type='navigateToURL' url='../real_data/index.jsp' target='frm_home_main'/>"
						+ "</actions>" + "</point>" + "</series>";
			}
		}
		xmlString = xmlString + "</data>" + "<styles>"
				+ "<marker_style name='Cities' color='Red'>"
				+ "<marker size='6' type='Circle' />"
				+ "<border color='Black' thickness='1' />" + "</marker_style>"
				+ "</styles>" + "</chart>" + "</charts>" + "</anychart>";

		return xmlString;
	}

	public void saveAsXml(HttpServletRequest req, String station_type) {
		try {
			String urlContent = getAllStation(req, station_type);
			// String fileName =this.getClass().getClassLoader().getResource("/").toString().replace("WEB-INF/classes/", "").replace("file:","")+"pages/flashmap/anychart.xml";
			// 童亮修改 原先方法在目录存在空格时，空格会变成 %20 以致文件找不到。
			String fileName = req.getSession().getServletContext().getRealPath("")+ "/pages/flashmap/anychart.xml";
			File file = new File(fileName);
			BufferedWriter output = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), "UTF-8"));
			output.write(urlContent);
			output.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
