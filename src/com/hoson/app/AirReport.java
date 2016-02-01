package com.hoson.app;

import java.sql.*;
import java.util.*;
import com.hoson.*;
import com.hoson.app.*;

public class AirReport
{

	public static String getDate(String s)
	{
		if(s == null)
		{
			return "";
		}
		int ipos = 0;
		ipos = s.indexOf(" ");
		if(ipos > 0)
		{
			s = s.substring(0, ipos);
		}
		return s;

	}

	// ---------------
	public static int get_so2_api(double so2) throws Exception
	{
		double api = 0;
		double d = 0;
		if(so2 <= 0)
		{
			api = 0;
		}
		if(so2 > 0 && so2 <= 0.05)
		{
			api = 1000 * so2;
		}

		if(so2 > 0.05 && so2 <= 0.15)
		{
			api = 500 * (so2 - 0.05) + 50;
		}

		if(so2 > 0.15 && so2 <= 0.475)
		{
			api = (150 - 100) / (0.475 - 0.15) * (so2 - 0.15) + 100;
		}

		if(so2 > 0.475 && so2 <= 0.800)
		{
			api = (200 - 150) / (0.800 - 0.475) * (so2 - 0.475) + 150;
		}
		if(so2 > 0.8 && so2 <= 1.2)
		{
			api = (250 - 200) / (1.2 - 0.8) * (so2 - 0.8) + 200;
		}
		if(so2 > 1.2 && so2 <= 1.6)
		{
			api = (300 - 250) / (1.6 - 1.2) * (so2 - 1.2) + 250;
		}
		if(so2 > 1.6 && so2 <= 2.1)
		{
			api = (400 - 300) / (2.1 - 1.6) * (so2 - 1.6) + 300;
		}
		if(so2 > 2.1 && so2 < 2.62)
		{
			api = (500 - 400) / (2.62 - 2.1) * (so2 - 2.1) + 400;
		}

		if(so2 >= 2.62)
		{
			api = 500;
		}
		return double2int(api);
	}

	// ----------------
	public static int get_no2_api(double no2) throws Exception
	{
		double api = 0;
		double d = 0;
		if(no2 <= 0)
		{
			api = 0;
		}
		if(no2 > 0 && no2 <= 0.080)
		{
			api = 625 * no2;
		}
		if(no2 > 0.080 && no2 <= 0.12)
		{
			api = (100 - 50) / 0.04 * (no2 - 0.08) + 50;
		}
		if(no2 > 0.12 && no2 <= 0.2)
		{
			api = (150 - 100) / (0.2 - 0.12) * (no2 - 0.12) + 100;
		}
		if(no2 > 0.2 && no2 <= 0.28)
		{
			api = (200 - 150) / (0.28 - 0.2) * (no2 - 0.2) + 150;
		}
		if(no2 > 0.28 && no2 <= 0.4225)
		{
			api = (250 - 200) / (0.4225 - 0.28) * (no2 - 0.28) + 200;
		}
		if(no2 > 0.4225 && no2 <= 0.565)
		{
			api = (300 - 250) / (0.565 - 0.4225) * (no2 - 0.4225) + 250;
		}
		if(no2 > 0.565 && no2 <= 0.750)
		{
			api = (400 - 300) / (0.75 - 0.565) * (no2 - 0.565) + 300;
		}
		if(no2 > 0.75 && no2 < 0.940)
		{
			api = (500 - 400) / (0.94 - 0.75) * (no2 - 0.75) + 400;
		}
		if(no2 >= 0.940)
		{
			api = 500;
		}
		return double2int(api);
	}

	// -------------------
	public static int get_pm_api(double pm) throws Exception
	{
		double api = 0;
		double d = 0;
		if(pm <= 0)
		{
			api = 0;
		}
		if(pm > 0 && pm <= 0.05)
		{
			api = 1000 * pm;
		}
		if(pm > 0.05 && pm <= 0.15)
		{
			api = 500 * (pm - 0.05) + 50;
		}
		if(pm > 0.15 && pm <= 0.25)
		{
			api = (150 - 100) / (0.25 - 0.15) * (pm - 0.15) + 100;
		}
		if(pm > 0.25 && pm <= 0.35)
		{
			api = (200 - 150) / (0.35 - 0.25) * (pm - 0.25) + 150;
		}
		if(pm > 0.35 && pm <= 0.385)
		{
			api = (250 - 200) / (0.385 - 0.35) * (pm - 0.35) + 200;
		}
		if(pm > 0.385 && pm <= 0.42)
		{
			api = (300 - 250) / (0.42 - 0.385) * (pm - 0.385) + 250;
		}
		if(pm > 0.42 && pm <= 0.50)
		{
			api = (400 - 300) / (0.50 - 0.42) * (pm - 0.42) + 300;
		}
		if(pm > 0.50 && pm < 0.6)
		{
			api = (500 - 400) / (0.6 - 0.5) * (pm - 0.5) + 400;
		}
		if(pm >= 0.6)
		{
			api = 500;
		}
		return double2int(api);
	}

	// -------------------------------------
	public static int double2int(double d) throws Exception
	{
		int intValue = 0;
		String s = d + "";
		int i = 0;
		i = s.indexOf(".");
		if(i >= 0)
		{
			s = s.substring(0, i);
		}
		intValue = Integer.parseInt(s);
		if(d > intValue)
		{
			intValue = intValue + 1;
		}
		return intValue;
	}

	// ---------
	public static double getDouble(String s) throws Exception
	{
		double d = 0;
		try
		{
			d = Double.parseDouble(s);
		}
		catch(Exception e)
		{
			d = 0;
		}
		return d;
	}

	// -----------
	public static int getMaxInt(int v1, int v2, int v3) throws Exception
	{
		int max = 0;
		if(v1 >= v2)
		{
			max = v1;
		}
		else
		{
			max = v2;
		}
		if(max < v3)
		{
			max = v3;
		}
		return max;
	}

	// --------
	public static String getPolution(int api_so2, int api_no2, int api_pm)
			throws Exception
	{
		int api_max = getMaxInt(api_so2, api_no2, api_pm);
		if(api_max<=50){return "";}
		String s = null;
		if(api_max == api_so2)
		{
			s = "二氧化硫";
		}
		if(api_max == api_no2)
		{
			s = "二氧化氮";
		}
		if(api_max == api_pm)
		{
			s = "可吸入颗粒物";
		}
		return s;
	}

	// ---------

	public static String getPolution(int api_so2, int api_no2, int api_pm,
			int api_max) throws Exception
	{
		// int api_max = getMaxInt(api_so2,api_no2,api_pm);
		if(api_max<=50){return "";}

		String s = null;
		if(api_max == 0)
		{
			return "";
		}
		if(api_max == api_so2)
		{
			s = "二氧化硫";
		}
		if(api_max == api_no2)
		{
			s = "二氧化氮";
		}
		if(api_max == api_pm)
		{
			s = "可吸入颗粒物";
		}
		return s;
	}

	// -----------------

	public static String[] getLevelAndDesc(int api_max) throws Exception
	{
		String level = null;
		String description = null;
		String[] arr = new String[2];
		if(api_max >= 0 && api_max <= 50)
		{
			level = "Ⅰ";
			description = "优";
		}
		if(api_max > 50 && api_max <= 100)
		{
			level = "Ⅱ";
			description = "良";
		}
		if(api_max > 100 && api_max <= 150)
		{
			level = "Ⅲ1";
			description = "轻微污染";
		}
		if(api_max > 150 && api_max <= 200)
		{
			level = "Ⅲ2";
			description = "轻度污染";
		}
		if(api_max > 200 && api_max <= 250)
		{
			level = "Ⅳ1";
			description = "中度污染";
		}
		if(api_max > 250 && api_max <= 300)
		{
			level = "Ⅳ2";
			description = "中重度污染";
		}
		if(api_max > 300)
		{
			level = "Ⅴ";
			description = "重度污染";
		}
		arr[0] = level;
		arr[1] = description;
		return arr;
	}

	// ------------------

	public static String getAirReport(String station_id, String date1,
			String date2) throws Exception
	{
		String s = "";
		// StringBuffer sb = new StringBuffer();

		String sql = null;
		List list = null;
		List dataList = new ArrayList();
		Map map = null;
		Map dataMap = null;
		Connection cn = null;
		int i = 0;
		int num = 0;
		double so2 = 0;
		double no2 = 0;
		double pm = 0;
		int so2_api = 0;
		int no2_api = 0;
		int pm_api = 0;
		String lvl = null;
		String polution = null;
		String state = null;
		int max_api = 0;
		String[] arr = null;

		String m_time = null;

		sql = "select val01,val02,val03,m_time from t_monitor_real_day ";
		sql = sql + "where 2>1 ";
		sql = sql + "and station_id='" + station_id + "' ";
		sql = sql + "and m_time>='" + date1 + "' ";
		sql = sql + "and m_time<='" + date2 + "' ";
		sql = sql + "order by m_time asc ";

		try
		{
			cn = DBUtil.getConn();
			list = DBUtil.query(cn, sql, null);

			num = list.size();
			// System.out.println(StringUtil.getNowTime());

			for(i = 0; i < num; i++)
			{
				map = (Map) list.get(i);
				m_time = (String) map.get("m_time");
				m_time = getDate(m_time);

				so2 = StringUtil.getDouble(App.getValueStr((String) map
						.get("val01")), 0);
				no2 = StringUtil.getDouble(App.getValueStr((String) map
						.get("val02")), 0);
				pm = StringUtil.getDouble(App.getValueStr((String) map
						.get("val03")), 0);
				so2_api = get_so2_api(so2);
				no2_api = get_no2_api(no2);
				pm_api = get_pm_api(pm);
				max_api = getMaxInt(so2_api, no2_api, pm_api);
				polution = getPolution(so2_api, no2_api, pm_api, max_api);
				if(max_api < 1)
				{
					lvl = "";
					state = "";

				}
				else
				{

					arr = getLevelAndDesc(max_api);
					lvl = arr[0];
					state = arr[1];
				}

				s = s + "<tr class=tr" + i % 2 + ">\n";
				s = s + "<td>" + m_time + "</td>\n";
				s = s + "<td>" + max_api + "</td>\n";
				s = s + "<td>" + polution + "</td>\n";
				s = s + "<td>" + lvl + "</td>\n";
				s = s + "<td>" + state + "</td>\n";
				s = s + "</tr>\n";

			}

			return s;
		}
		catch(Exception e)
		{
			throw e;

		}
		finally
		{
			DBUtil.close(cn);
		}
	}

	// ------------------

}