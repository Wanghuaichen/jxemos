package com.hoson.zdxupdate;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hoson.XBean;
import com.hoson.f;
import com.hoson.StringUtil;



public class StyleUtil 
{
	/*!
	 * 获取每一个站点类型的下的每一个区域内的站点信息
	 */
	public static Map getArea_StationMap(String ctl_type) throws Exception
	{
		List areaList = getAreaList();
		List stationTypeList = getTypeList();
		Map stationMap = getStationList(areaList,stationTypeList,ctl_type);
		return stationMap;
	}
	
	/*!
	 * 获取地区信息列表
	 */
	public static List getAreaList() throws Exception
	{
		String topAreaid = f.getTopAreaId();
		String sql = "select area_id,area_name from t_cfg_area where area_pid='"+topAreaid+"'";
		List areaList = f.query(sql,null);
		return areaList;
	}
	
	
	/*!
	 * 返回站点类型列表
	 */
	public static List getTypeList()
	{
		List list = new ArrayList();
		
		Map map1 = new HashMap();
		map1.put("type_id","1");
		map1.put("type_name","污染源污水");
		Map map2 = new HashMap();
		map2.put("type_id","2");
		map2.put("type_name","污染源烟气");
		Map map3 = new HashMap();
		map3.put("type_id","5");
		map3.put("type_name","环境质量地表水");
		Map map4 = new HashMap();
		map4.put("type_id","6");
		map4.put("type_name","环境质量大气");
		list.add(map1);
		list.add(map2);
		list.add(map3);
		list.add(map4);
		
		return list;
	}
	
	
	/*!
	 * 根据地区信息、站位类型等站点属性将站点详细信息分类
	 */
	public static Map getStationList(List areaList,List typeList,String ctl_type) throws Exception
	{
		Map stationMap = new HashMap();
		for(int i=0;i<typeList.size();i++)
		{
			Map mp = (Map)typeList.get(i);
			String type_id = mp.get("type_id").toString();
			Map m = new HashMap();
			for(int k=0;k<areaList.size();k++)
			{
				Map areaMap = (Map)areaList.get(k);
				String area_id = areaMap.get("area_id").toString();
				String sql = "select station_id,station_desc from t_cfg_station_info where area_id like '"+area_id+"%' and station_type='"+type_id+"'";
				if(!ctl_type.equals("null"))
				{
					if(!ctl_type.equals("0"))
					{
						sql = sql + " and ctl_type>='"+ctl_type+"'";
					}
					else if(ctl_type.equals("0"))
					{
						sql = sql + " and ctl_type!=1 and ctl_type!=2 and ctl_type!=3";
					}
				}
				List stationlist = f.query(sql,null);
				m.put(area_id,stationlist);
			}
			stationMap.put(type_id,m);
		}
		return stationMap;
	}
	
	/*!
	 * 获取站点重点源属性下拉框列表
	 */
	public static String getCtlOption(String ctl_type) throws Exception
	{
		List list = new ArrayList();
		Map map = new HashMap();
		map.put("ctl_type","1");
		map.put("ctl_value","市控");
		list.add(map);
		Map map1 = new HashMap();
		map1.put("ctl_type","2");
		map1.put("ctl_value","省控");
		list.add(map1);
		Map map2 = new HashMap();
		map2.put("ctl_type","3");
		map2.put("ctl_value","国控");
		list.add(map2);
		String ctlOption = f.getOption(list,"ctl_type","ctl_value",ctl_type);
		return ctlOption;
	}
	
	/*!
	 * 获取各个污染源类型各个地区的联网率、以及有效数据获取率
	 */
	public static Map getAreaAndTypePercent(List areaList,List typeList,Map stationMap,String date1,String date2) throws Exception
	{
		Map countMap = new HashMap();
		for(int i=0;i<typeList.size();i++)
		{
			Map typeMap = (Map)typeList.get(i);
			String type_id = typeMap.get("type_id").toString();
			Map typedata = (Map)stationMap.get(type_id);
			Map areaDataMap = new HashMap();
			if(typedata!=null)
			{
				for(int k=0;k<areaList.size();k++)
				{
					Map areaMap = (Map)areaList.get(k);
					String area_id = areaMap.get("area_id").toString();
					List areadata = (List)typedata.get(area_id);
					Map m = new HashMap();
					double y_num = 0;
					double s_num = 0;
					double x_num = 0;
					if(areadata!=null)
					{
						for(int j=0;j<areadata.size();j++)
						{
							Map station = (Map)areadata.get(j);
							String station_id = station.get("station_id").toString();
							Map numMap = getStationCount(station_id,date1,date2);
							String yd_num = numMap.get("yd_num").toString();
							String sd_num = numMap.get("sd_num").toString();
							String yx_num = numMap.get("yx_num").toString();
							y_num = y_num + Double.parseDouble(yd_num);
							s_num = s_num + Double.parseDouble(sd_num);
							x_num = x_num + Double.parseDouble(yx_num);
						}
					}
					double sd =0;
					if(y_num>0)
					{
						sd = s_num*100/y_num;
					}
					double yx = 0;
					if(s_num>0)
					{
						yx = x_num*100/s_num;
					}
					m.put("sd_percent",dformat(sd)+"");
					m.put("yx_percent",dformat(yx)+"");
					areaDataMap.put(area_id,m);
				}
			}
			countMap.put(type_id,areaDataMap);
		}
		return countMap;
	}
	
	
	/*!
	 * 获取每一污染源类型下的每一地区的站点监测数据应得个数和实际得到的个数
	 */
	public static Map getStationCount(String station_id,String date1,String date2) throws Exception
	{
		Map stationMap = new HashMap();
		if(f.empty(date1))
		{
			date1 = f.today()+" 00:00:00";
		}
		if(f.empty(date2))
		{
			date2 = f.today()+" 23:59:59";
		}
		long hour = countDay(date1,date2);
		String yd_count = yd_count(station_id,hour);
		stationMap = getSD_YXcount(station_id,date1,date2);
		stationMap.put("yd_num",yd_count);
		return stationMap;
	}
	
	/*!
	 * 获取某一站点应该得到的监测数据个数
	 */
	public static String yd_count(String station_id,long hour) throws Exception
	{
		String yd_count="0";
		String sql = "select count(infectant_id) as colsnum from param_view where station_id=?";
		Object[] obj = new Object[]{station_id};
		Map mp = f.queryOne(sql,obj);
		if(mp!=null&&mp.get("colsnum")!=null)
		{
			String colsnum = mp.get("colsnum").toString();
			if(!f.empty(colsnum))
			{
				int num = Integer.parseInt(colsnum);
				long count = num*hour;
				yd_count = count+"";
			}
		}
		return yd_count;
	}
	
	/*!
	 * 计算两个时间点之间的小时数
	 */
	public static long countDay(String date1,String date2) throws Exception
	{
		if(f.empty(date1))
		{
			date1 = f.today();
		}
		if(f.empty(date2))
		{
			date2 = f.today();
		}
		Timestamp ts1 = f.time(date1);
		Timestamp ts2 = f.time(date2);
		long d = ts2.getTime()-ts1.getTime();
		return (d/(3600*1000)+1);
	}
	
	/*!
	 * 获取某一站点在一段时间内的有效数据个数和实际得到的数据个数
	 */
	public static Map getSD_YXcount(String station_id,String date1,String date2) throws Exception
	{
		Map countMap = new HashMap();
		int sd_num = 0;
		int yx_num = 0;
		String sql = "select infectant_column,lo_min,hi_max from param_view where station_id='"+station_id+"'";
		List colList = f.query(sql,null);
		sql = "select * from t_monitor_real_hour where station_id='"+station_id+"' and (m_time between '"+date1+"' and '"+date2+"')";
		List dataList = f.query(sql,null);
		for(int i=0;i<dataList.size();i++)
		{
			Map dataMap = (Map)dataList.get(i);
			if(dataMap!=null)
			{
				XBean datab = new XBean(dataMap);
				for(int k=0;k<colList.size();k++)
				{
					Map colMap = (Map)colList.get(k);
					XBean colb = new XBean(colMap);
					String col = colb.get("infectant_column");
					String lo_min = colb.get("lo_min");
					String hi_max = colb.get("hi_max");
					String v = datab.get(col.toLowerCase());
					v = f.v(v);
					if(!f.empty(v))
					{
						sd_num++;
						boolean b = true;
						if(f.empty(lo_min)&&f.empty(hi_max)&&StringUtil.isNum(v))
						{
							yx_num++;
						}
						else
						{
							if(StringUtil.isNum(v)&&!f.empty(lo_min))
							{
								double d_v=Double.parseDouble(v);
								double d_lo_min = Double.parseDouble(lo_min);
								if(d_v<d_lo_min)
								{
									b=false;
								}
							}
							if(StringUtil.isNum(v)&&!f.empty(hi_max))
							{
								double d_v=Double.parseDouble(v);
								double d_hi_max = Double.parseDouble(hi_max);
								if(d_v>d_hi_max)
								{
									b=false;
								}
							}
							if(b==true)
							{
								yx_num++;
							}	
						}
					}
				}
			}
		}
		countMap.put("sd_num",sd_num+"");
		countMap.put("yx_num",yx_num+"");
		return countMap;
	}
	
	
	/*!
	 * 将数据精确到小数点后1位
	 */
	public static double dformat(double d) throws Exception
	{
		DecimalFormat df = new DecimalFormat("0.0");
		return Double.parseDouble(df.format(d));
	}
}
