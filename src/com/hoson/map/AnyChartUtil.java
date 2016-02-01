package com.hoson.map;

/**
 * @author Administrator
 */
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
import com.hoson.StringUtil;
import com.hoson.app.App;

public class AnyChartUtil {
	/**
	 * �����ˮ����xml����
	 * 
	 * @param req
	 * @return
	 */
	public static String gatherWater(HttpServletRequest req, String date) {
		String date1 = date + " 00:00:00";// ��������
		String date2 = date + " 23:59:59";
		// String date1 = "2011-6-16 00:00:00";//
		// String date2 = "2011-6-16 23:59:59";// ������������
		List list = null;
		Map<String, String> map = new HashMap<String, String>();
		/*
		 * String sql = "select  a.p_name,a.name, " +
		 * "m.v02,m.v04,m.v05,m.v16,m.v17 from" +
		 * "(select h.STATION_ID s_id,h.VAL02 v02,h.VAL05 v05,h.VAL17 v17,h.VAL16 v16,h.VAL04 v04 "
		 * + "from T_MONITOR_REAL_HOUR h where h.m_time>='" + date1 + "' " +
		 * "and h.m_time <='" + date2 +
		 * "') m,(select a1.AREA_NAME p_name, a3.AREA_ID a_id ,a2.AREA_NAME name"
		 * + " from T_CFG_AREA a1,T_CFG_AREA a2, T_CFG_AREA a3 " +
		 * "where a3.AREA_PID=a2.AREA_ID and a2.AREA_PID=a1.AREA_ID and a1.AREA_ID='36') "
		 * +
		 * "a,T_CFG_STATION_INFO c where m.s_id=c.STATION_ID and  c.AREA_ID=a.a_id and  c.station_type='1'"
		 * + " and c.show_flag !='1'";
		 */
		String sql = "";
		try {
			// sql =
			// "select DISTINCT b.VAL02 as v02, b.VAL04 v04, b.VAL16 v16,b.VAL05 v05, b.VAL17 v17 "
			// +
			// "from T_CFG_AREA a1, T_CFG_AREA a2, T_CFG_AREA a3, T_MONITOR_REAL_HOUR b, T_CFG_STATION_INFO c "
			// +
			// "where ( (c.AREA_ID=a3.AREA_ID and a3.AREA_PID=a2.AREA_ID and a2.AREA_PID=a1.AREA_ID and "
			// + "a1.AREA_ID='"
			// + App.get("default_area_id")
			// +
			// "') or (c.AREA_ID=a3.AREA_ID and a3.AREA_PID=a2.AREA_ID and a2.AREA_ID='"
			// + App.get("default_area_id")
			// + "') or (c.AREA_ID=a3.AREA_ID and a3.AREA_ID='"
			// + App.get("default_area_id")
			// +
			// "') ) and b.STATION_ID=c.STATION_ID and c.station_type='1' and c.show_flag !='1' and b.m_time>='"
			// + date1 + "' and b.m_time <='" + date2 + "' ;";

			sql = "SELECT b.VAL02 AS v02, b.VAL04 v04, b.VAL16 v16, b.VAL05 v05, b.VAL17 v17, b.M_TIME, "
					+ "a.AREA_NAME FROM T_MONITOR_REAL_HOUR b, ( SELECT c.STATION_ID, a.AREA_ID, a.AREA_NAME "
					+ "FROM T_CFG_AREA a, T_CFG_STATION_INFO c WHERE a.AREA_ID = c.AREA_ID AND c.station_type = '1' "
					+ "AND c.show_flag != '1' ) a WHERE a.AREA_ID LIKE '"
					+ App.get("default_area_id")
					+ "%' "
					+ "AND a.STATION_ID = b.STATION_ID  AND b.m_time>='"
					+ date1 + "' and b.m_time <='" + date2 + "' ;";
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		try {
			Connection conn = DBUtil.getConn(req);
			list = DBUtil.query(conn, sql);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/*
		 * //�������� int i = 0; Map<String, Float> data=new HashMap<String,
		 * Float>();
		 * 
		 * while (i < list.size() - 1) {
		 * 
		 * HashMap map1 = (HashMap) list.get(i); HashMap map2 = (HashMap)
		 * list.get(i + 1); float value = commautil(map1.get("v02").toString());
		 * while (map1.get("name").equals(map2.get("name"))) { value +=
		 * commautil(map2.get("v02").toString()); i++; }
		 * data.put(map1.get("name").toString(), value);
		 * 
		 * 
		 * }
		 */
		float v02 = 0;
		float v04 = 0;
		float v05 = 0;
		float v16 = 0;
		float v17 = 0;
		for (Object object : list) {
			v02 += commautil(((HashMap) object).get("v02"))
					* commautil(((HashMap) object).get("v04")) * 3.6 / 1000;
			v04 += commautil(((HashMap) object).get("v04")) * 3.6;
			v05 += commautil(((HashMap) object).get("v05"))
					* commautil(((HashMap) object).get("v04")) * 3.6 / 1000;
			v16 += commautil(((HashMap) object).get("v16"))
					* commautil(((HashMap) object).get("v04")) * 3.6 / 1000;
			v17 += commautil(((HashMap) object).get("v17"))
					* commautil(((HashMap) object).get("v04")) * 3.6 / 1000;

		}
		String xmlString = "<?xml version='1.0' encoding='UTF-8'?>";
		xmlString += "<anychart><settings><animation enabled='True'/></settings>"
				+ "<charts><chart plot_type='CategorizedVertical'>"
				+ "<data_plot_settings default_series_type='Bar' enable_3d_mode='True' z_aspect='2.5'>"
				+ "<bar_series point_padding='2' group_padding='1'>"
				+ "<tooltip_settings enabled='true'><format>{%Name}\nValue: {%YValue}</format></tooltip_settings>"
				+ "</bar_series></data_plot_settings><chart_settings><title enabled='true'>"
				+ "<text>";
//		if (date != null && date.equals(StringUtil.getNowDate().toString())) {
//			xmlString += "����";
//
//		} else {
//			xmlString += date;
//		}

		xmlString += "��ˮ����ͼ</text></title><axes><y_axis><title><text>�ۻ���</text></title></y_axis> <x_axis><labels />"
				+ "<title><text>�ɷ�</text></title></x_axis></axes>"
				+ "<chart_background enabled='false'/> </chart_settings> <data><series name='Series 1' palette='Default'>"
				+ "<point name='COD/Kg' y='"
				+ v02
				+ "'/>"
				+ "<point name='����/Kg'  y='"
				+ v05
				+ "'/>"
				+ "<point name='�ܵ�/Kg'  y='"
				+ v17
				+ "'/>"
				+ "<point name='����/Kg'  y='"
				+ v16
				+ "'/>"
				+ "<point name='�ۻ�����/m3'  y='"
				+ v04
				+ "'/>"
				+ "</series> </data> </chart> </charts> </anychart>";

		return xmlString;
	}

	/**
	 * ������������ת������
	 * 
	 * @param arg
	 * @return
	 */
	public static float commautil(Object obj) {

		String arg = (obj == null ? "" : obj.toString());
		float num = 0;
		if (arg.length() > 0)
			num = Float.parseFloat(arg.split(",")[0]);
		return num;
	}

	/**
	 * �����������xml����
	 * 
	 * @param req
	 * @return
	 */
	public String gatherGas(HttpServletRequest req, String date) {
		String date1 = date + " 00:00:00";// ��������
		String date2 = date + " 23:59:59";
		// String date1 = "2011-6-16 00:00:00";//
		// String date2 = "2011-6-16 23:59:59";// ������������
		/*
		 * String sql =
		 * "select b.VAL06 as VAL06, b.VAL05 as VAL05, b.VAL07 as VAL07, b.VAL11 as VAL11, a1.AREA_NAME as p_name, a2.AREA_NAME as name, 'ȫ����ҵ' as trade"
		 * +
		 * " from T_CFG_AREA a1, T_CFG_AREA a2, T_CFG_AREA a3, T_MONITOR_REAL_HOUR b, T_CFG_STATION_INFO c "
		 * +
		 * "where ( (c.AREA_ID=a3.AREA_ID and a3.AREA_PID=a2.AREA_ID and a2.AREA_PID=a1.AREA_ID and a1.AREA_ID='36') "
		 * +
		 * "or (c.AREA_ID=a3.AREA_ID and a3.AREA_PID=a2.AREA_ID and a2.AREA_ID='36') or (c.AREA_ID=a3.AREA_ID and a3.AREA_ID='36') )"
		 * +
		 * " and b.STATION_ID=c.STATION_ID and c.station_type='2' and c.show_flag !='1' and b.m_time>='"
		 * + date1 + "' and b.m_time <='" + date2 +
		 * "' order by a2.AREA_ID asc;";
		 */
		String sql = "";
		try {
			// sql =
			// "select  b.VAL06, b.VAL05, b.VAL07, b.VAL11 from T_CFG_AREA a1, T_CFG_AREA a2,"
			// +
			// " T_CFG_AREA a3, T_MONITOR_REAL_HOUR b, T_CFG_STATION_INFO c where "
			// +
			// "( (c.AREA_ID=a3.AREA_ID and a3.AREA_PID=a2.AREA_ID and a2.AREA_PID=a1.AREA_ID and a1.AREA_ID='"
			// + App.get("default_area_id")
			// +
			// "') or(c.AREA_ID=a3.AREA_ID and a3.AREA_PID=a2.AREA_ID and a2.AREA_ID='"
			// + App.get("default_area_id")
			// + "') or (c.AREA_ID=a3.AREA_ID and a3.AREA_ID='"
			// + App.get("default_area_id")
			// +
			// "') ) and b.STATION_ID=c.STATION_ID and c.station_type='2' and c.show_flag !='1' and b.m_time>='"
			// + date1 + "' and b.m_time <='" + date2 + "'";

			sql = "SELECT b.VAL06, b.VAL05, b.VAL07, b.VAL11 "
					+ " FROM T_MONITOR_REAL_HOUR b, ( SELECT c.STATION_ID, a.AREA_ID, a.AREA_NAME "
					+ "FROM T_CFG_AREA a, T_CFG_STATION_INFO c WHERE a.AREA_ID = c.AREA_ID AND c.station_type = '2' "
					+ "AND c.show_flag != '1' ) a WHERE a.AREA_ID LIKE '"
					+ App.get("default_area_id") + "%' "
					+ "AND a.STATION_ID = b.STATION_ID  AND b.m_time>='"
					+ date1 + "' and b.m_time <='" + date2 + "' ;";
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		List list = null;
		Map<String, String> map = new HashMap<String, String>();
		try {
			Connection conn = DBUtil.getConn(req);
			list = DBUtil.query(conn, sql);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		float v06 = 0;
		float v05 = 0;
		float v07 = 0;
		float v11 = 0;
		for (Object object : list) {
			v11 += commautil((((HashMap) object).get("val11")));
			v06 += commautil((((HashMap) object).get("val06")))
					* commautil((((HashMap) object).get("val11"))) / 1000000;
			v05 += commautil((((HashMap) object).get("val05")))
					* commautil((((HashMap) object).get("val11"))) / 1000000;
			v07 += commautil(((HashMap) object).get("val07"))
					* commautil(((HashMap) object).get("val11")) / 1000000;
		}
		String xmlString = "<?xml version='1.0' encoding='UTF-8'?>";
		xmlString += "<anychart><settings><animation enabled='True'/></settings>"
				+ "<charts><chart plot_type='CategorizedVertical'>"
				+ "<data_plot_settings default_series_type='Bar' enable_3d_mode='True' z_aspect='2.5'>"
				+ "<bar_series point_padding='0.5' group_padding='1'>"
				+ "<tooltip_settings enabled='true'><format>{%Name}\nValue: {%YValue}</format></tooltip_settings>"
				+ "</bar_series></data_plot_settings><chart_settings><title enabled='true'>"
				+ "<text>";
//		if (date != null && date.equals(StringUtil.getNowDate().toString())) {
//			xmlString += "����";
//
//		} else {
//			xmlString += date;
//		}

		xmlString += "��������ͼ</text></title><axes><y_axis><title><text>�ۻ���</text></title></y_axis> <x_axis><labels />"
				+ "<title><text>�ɷ�</text></title></x_axis></axes>"
				+ "<chart_background enabled='false'/> </chart_settings> <data><series name='Series 1' palette='Default'>"
				+ "<point name='������/Kg' y='"
				+ v06
				+ "'/>"
				+ "<point name='SO2/Kg'  y='"
				+ v05
				+ "'/>"
				+ "<point name='NOX/Kg'  y='"
				+ v07
				+ "'/>"
				+ "<point name='�ۻ�����/m3'  y='"
				+ v11
				+ "'/>"
				+ "</series> </data> </chart> </charts> </anychart>";
		return xmlString;
	}

	/*
	 * public void saveAsXml(HttpServletRequest req) { try {
	 * 
	 * String urlContent = gatherWater(req,date); // String fileName //
	 * =this.getClass
	 * ().getClassLoader().getResource("/").toString().replace("WEB-INF/classes/"
	 * , // "").replace("file:","")+"pages/flashmap/water.xml"; // ͯ���޸�
	 * ԭ�ȷ�����Ŀ¼���ڿո�ʱ���ո���� %20 �����ļ��Ҳ����� String fileName =
	 * req.getSession().getServletContext() .getRealPath("") +
	 * "/pages/flashmap/water.xml"; File file = new File(fileName);
	 * BufferedWriter output = new BufferedWriter(new OutputStreamWriter( new
	 * FileOutputStream(file), "UTF-8")); output.write(urlContent);
	 * output.flush(); output.close(); } catch (Exception e) { // TODO
	 * Auto-generated catch block e.printStackTrace(); }
	 * 
	 * }
	 */

	public void saveAsXml(HttpServletRequest req, String type, String date) {
		BufferedWriter output = null;
		String urlContent = "";
		String fileName = "";
		try {
			if ("water".equals(type)) {
				urlContent = gatherWater(req, date);
				// String fileName
				// =this.getClass().getClassLoader().getResource("/").toString().replace("WEB-INF/classes/",
				// "").replace("file:","")+"pages/flashmap/water.xml";
				// ͯ���޸� ԭ�ȷ�����Ŀ¼���ڿո�ʱ���ո���� %20 �����ļ��Ҳ�����
				fileName = req.getSession().getServletContext().getRealPath("")
						+ "/pages/flashmap/water.xml";

			} else {
				urlContent = gatherGas(req, date);
				fileName = req.getSession().getServletContext().getRealPath("")
						+ "/pages/flashmap/gas.xml";

			}
			File file = new File(fileName);
			output = new BufferedWriter(new OutputStreamWriter(
					new FileOutputStream(file), "UTF-8"));
			output.write(urlContent);
			output.flush();
			output.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
//			output.write("failed");
		}
	}

}
