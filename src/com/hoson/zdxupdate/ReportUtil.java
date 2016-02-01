package com.hoson.zdxupdate;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.hoson.StringUtil;
import com.hoson.XBean;
import com.hoson.f;

public class ReportUtil 
{
	
	/*!
	 * 很据站点类型获取监测因子列表
	 */
	public static List getParamList(String station_type) throws Exception
	{
		List paramList = new ArrayList();
		String sql = "select infectant_column,infectant_name,infectant_unit from t_cfg_infectant_base where station_type='"+station_type+"' and (infectant_type='1' or infectant_type='2') and infectant_name!='流量2' order by infectant_order";
		paramList = f.query(sql,null);
		return paramList;
	}
	
	
	/*!
	 * stationList 站位列表
	 * 根据获取站位列表里的站位的date1至date2时间内的日均值
	 */
	public static List getDataList(List stationList,String date1,String date2,List paramList) throws Exception
	{
		String params = "";
		List list = new ArrayList();
		for(int i=0;i<paramList.size();i++)
		{
			Map m = (Map)paramList.get(i);
			if(i==0)
			{
				params = m.get("infectant_column").toString();
			}
			params = params + "," +m.get("infectant_column").toString();
		}
		for(int i=0;i<stationList.size();i++)
		{
			Map mp = (Map)stationList.get(i);
			Map dataMap = new HashMap();
			String station_id = mp.get("station_id").toString();
			dataMap.put("station_id",station_id);
			dataMap.put("station_desc",mp.get("station_desc"));
			String sql = "select m_time,"+params+" from t_monitor_real_day where station_id='"+station_id+"' and m_time >'"+date1+"' and m_time< '"+date2+"' order by m_time";
			List data = f.query(sql,null);
			for(int x=0;x<paramList.size();x++)
			{
				Map m = (Map)paramList.get(x);
				String col = m.get("infectant_column").toString();
				dataMap.put("i_"+col,data.size()+"");
				dataMap.put("t_"+col,"0");
			}
			for(int j=0;j<data.size();j++)
			{
				Map m = (Map)data.get(j);
				XBean b = new XBean(m);
				for(int k=0;k<paramList.size();k++)
				{
					String col = ((Map)paramList.get(k)).get("infectant_column").toString();
					String str = b.get(col.toLowerCase());
					if(isNum(f.v(str)))
					{
						String i_col = dataMap.get("i_"+col).toString();
						int t = Integer.parseInt(i_col);
						t = t-1;
						dataMap.put("i_"+col,t+"");
					}
					else
					{
						String value = str;
						value = f.v(value);
						double d = Double.parseDouble(value);
						String t_col = dataMap.get("t_"+col).toString();
						double t_d = 0d;
						if(f.empty(t_col))
						{
							t_d = 0d;
						}
						t_d = Double.parseDouble(t_col);
						t_d = t_d + d;
						dataMap.put("t_"+col,t_d+"");
					}
					dataMap.put("m_time",b.getObject("m_time"));
				}
			}
			list.add(dataMap);
		}
		return list;
	}
	
	
	/*!
	 * 计算某段时间内的日均值
	 */
	public static List getAvgData(List dataList,List paramList) throws Exception
	{
		List list = new ArrayList();
		for(int i=0;i<dataList.size();i++)
		{
			Map mp = (Map)dataList.get(i);
			XBean b = new XBean(mp);
			for(int j=0;j<paramList.size();j++)
			{
				Map m = (Map)paramList.get(j);
				String col = m.get("infectant_column").toString();
				String t_col = b.get("t_"+col);
				if(!f.eq("0",t_col))
				{
					String i_col = b.get("i_"+col);
					int index = Integer.parseInt(i_col);
					double tcol = Double.parseDouble(t_col);
					double v_col = tcol/index;
					tcol = getDouble(tcol);
					v_col = getDouble(v_col);
					mp.put(col,v_col+"");
					mp.put("t_"+col,tcol+"");
				}
			}
			list.add(mp);
		}
		return list;
	}
	
	
	/*!
	 * 判断str是否为数字，是数字返回false，不是数字返回true
	 */
	public static boolean isNum(String str) throws Exception
	{
		boolean b = false;
		if(f.empty(str)) return true;
		if(f.eq(str,".")) return true;
		if(str.indexOf(".",str.indexOf(".")+1)>=0) return true;
		str = str.replace(".","0");
		String sta = "0123456789";
		int k = str.length();
		int j = 0;
		for(int i=0;i<str.length();i++)
		{
			char c = str.charAt(i);
			if(f.eq(c+"","0"))
			{
				j++;
			}
			if(sta.indexOf(c)<0)
			{
				b = true;
				break;
			}
		}
		if(k==j)
		{
			b=true;
		}
		return b;
	}
	
	
	/*!
	 * 将d精确到小数点后2位
	 */
	public static double getDouble(double d) throws Exception
	{
		DecimalFormat df = new DecimalFormat("##.00");
		return Double.parseDouble(df.format(d));
	}
	
	
	/*!
	 * list 是站点列表
	 * 获取date1至date2时间段内的list站位的实时数据列表
	 */
	public static List getRealHour(List list,HttpServletRequest req,String date1,String date2) throws Exception
	{
		String[] params = req.getParameterValues("col");
		Map model = f.model(req);
		XBean b = new XBean(model);
		String param="";
		for(int k=0;k<params.length;k++)
		{
			if(k==0)
			{
				param = params[0];
			}
			else
			{
				param = param + "," + params[k];
			}
		}
		List datalist = new ArrayList();
		for(int i=0;i<list.size();i++)
		{
			Map mp = (Map)list.get(i);
			String station_id = mp.get("station_id").toString();
			String sql = "select "+param+",m_time from t_monitor_real_hour where station_id='"+station_id+"' and m_time between '"+date1+"' and '"+date2+"'";
			List list1 = f.query(sql,null);
			for(int k=0;k<list1.size();k++)
			{
				Map lmp = (Map)list1.get(k);
				lmp.put("station_id",mp.get("station_id"));
				lmp.put("station_desc",mp.get("station_desc"));
				datalist.add(lmp);
			}
		}
		return datalist;
	}
	
	
	/*!
	 * 对datalist内的数据进行条件筛选
	 */
	public static List getNewDataList(List datalist,HttpServletRequest req) throws Exception
	{
		String[] params = req.getParameterValues("col");
		Map model = f.model(req);
		XBean b = new XBean(model);
		List list = new ArrayList();
		int num = datalist.size();
		int[] indexs = new int[num];
		for(int i=0;i<num;i++)
		{
			Map map = (Map)datalist.get(i);
			XBean b1 = new XBean(map);
			indexs[i] = -1;
			for(int k=0;k<params.length;k++)
			{
				String col = params[k].toLowerCase();
				String v = f.v(b1.get(col));
				String v_lo = b.get("v_"+col+"_lo");
				String v_hi = b.get("v_"+col+"_hi");
				if((!f.empty(v)&&!StringUtil.isNum(v))||(f.empty(v)&&(!f.empty(v_lo)||!f.empty(v_hi))))
				{
					indexs[i] = 0;
				}
				if(!f.empty(v)&&!f.empty(v_lo)&&StringUtil.isNum(v))
				{
					double v_d = Double.parseDouble(v);
					double v_lo_d = Double.parseDouble(v_lo);
					if(v_d<v_lo_d)
					{
						indexs[i] = 0;
					}
				}
				if(!f.empty(v)&&!f.empty(v_hi)&&StringUtil.isNum(v))
				{
					double v_d = Double.parseDouble(v);
					double v_hi_d = Double.parseDouble(v_hi);
					if(v_d>v_hi_d)
					{
						indexs[i] = 0;
					}
				}
			}
		}
		for(int i=0;i<num;i++)
		{
			if(indexs[i]==-1)
			{
				list.add(datalist.get(i));
			}
		}
		return list;
	}
	
	
	/*!
	 * 获取页面上传过来的监测因子，并返回监测因子的详细信息列表
	 */
	public static List getParamListByArray(HttpServletRequest req,String station_type) throws Exception
	{
		String[] params = req.getParameterValues("col");
		List list = new ArrayList();
		for(int i=0;i<params.length;i++)
		{
			String col = params[i];
			String sql = "select infectant_name,infectant_unit,infectant_column from t_cfg_infectant_base where infectant_column='"+col.toUpperCase()+"'and station_type='"+station_type+"'";
			Map map = f.queryOne(sql,null);
			list.add(map);
		}
		return list;
	}
	
	
	/*!
	 * 返回符合条件的站点
	 */
	public static List getStationList(HttpServletRequest req) throws Exception
	{
		List stationList = new ArrayList();
		String area_id,station_type,ctl_type,valley_id,trade_id,station_name;
		
		Map model = f.model(req);
		XBean b = new XBean(model);
		
		area_id = b.get("area_id");
		station_type = b.get("station_type");
		ctl_type = b.get("ctl_type");
		valley_id = b.get("valley_id");
		trade_id = b.get("trade_id");
		station_name = b.get("station_name");
		
		if(f.empty(area_id))
		{
			area_id = f.getDefaultAreaId();
		}
		if(f.empty(station_type))
		{
			station_type = req.getParameter("station_type");
			if(f.empty(station_type))
			{
				station_type = f.getDefaultStationType();
			}
		}
		Object user = req.getSession().getAttribute("user_id");
		String user_id="-1";
		Object om = req.getSession().getAttribute("view_all_station");
		String mark="0";
		if(user!=null)
		{
			user_id = user.toString();
			mark = om.toString();
		}
		String sql = "select station_id from t_sys_user_station where user_id='"+user_id+"' and station_id is not null";
//		List testlist = f.query(sql,null);
//		if(testlist.size()>0&&mark.equals("0"))
//		{
//			sql = "select station_id,station_desc from user_station_view where 2>1 ";
//			//"user_id='"+user_id+"' and station_type='"+station_type+"'";
//		}
//		else
//		{
			sql = "select station_id,station_desc from t_cfg_station_info where area_id like'"+area_id+"%' and station_type='"+station_type+"'";
//		}
		if(!ctl_type.equals("null")&&!f.empty(ctl_type))
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
		if(!valley_id.equals("null")&&!f.empty(valley_id))
		{
			sql = sql + " and valley_id='"+valley_id+"'";
		}
		if(!trade_id.equals("null")&&!f.empty(trade_id))
		{
			sql = sql + " and trade_id like '"+trade_id+"%'";
		}
		if(!f.empty(station_name))
		{
			sql = sql + " and station_desc like '%"+station_name+"%'";
		}
		sql = sql + " order by station_no,area_id,station_desc";
		stationList = f.query(sql,null);
		return stationList;
	}
	
	/*!
	 * stations是一个由站位编号用“,”隔开的字符串
	 * 返回根据stations里的站位编号的站点列表
	 */
	public static List getStationListById(String stations) throws Exception
	{
		String[] station_ids = stations.split(",");
		List list = new ArrayList();
		if(station_ids.length==0)
		{
			String station_id = stations;
			String sql ="select station_id,station_desc from t_cfg_station_info where station_id='"+station_id+"'";
			Map mp = f.queryOne(sql,null);
			list.add(mp);
		}
		else
		{
			for(int i=0;i<station_ids.length;i++)
			{
				String station_id = station_ids[i];
				String sql ="select station_id,station_desc from t_cfg_station_info where station_id='"+station_id+"'";
				Map mp = f.queryOne(sql,null);
				list.add(mp);
			}
		}
		return list;
	}
	
	
	/*!
	 * table代表报表类型 t_cfg_real_month代表月均值报表，t_cfg_real_day代表日均值报表
	 * 返回其中一种类型报表的数据
	 */
	public static List getRealMD(List list,HttpServletRequest req,String date1,String date2,String table) throws Exception
	{
		String[] params = req.getParameterValues("col");
		Map model = f.model(req);
		XBean b = new XBean(model);
		String param="";
		for(int k=0;k<params.length;k++)
		{
			if(k==0)
			{
				param = params[0];
			}
			else
			{
				param = param + "," + params[k];
			}
		}
		List datalist = new ArrayList();
		for(int i=0;i<list.size();i++)
		{
			Map mp = (Map)list.get(i);
			String station_id = mp.get("station_id").toString();
			String sql = "select "+param+",m_time from "+table+" where station_id='"+station_id+"' and m_time between '"+date1+"' and '"+date2+"'";
			List list1 = f.query(sql,null);
			for(int k=0;k<list1.size();k++)
			{
				Map lmp = (Map)list1.get(k);
				lmp.put("station_id",mp.get("station_id"));
				lmp.put("station_desc",mp.get("station_desc"));
				datalist.add(lmp);
			}
		}
		return datalist;
	}
	
	
	/*!
	 * table 代表报表类型  tj_up代表预警报表  tj_yc代表报警报表
	 * 返回其中一种状态的数据列表
	 */
	public static List getRealState(List stationList,HttpServletRequest req,String date1,String date2,String table) throws Exception
	{
		List dataList = new ArrayList();
		String[] params = req.getParameterValues("col");
		String param="";
		for(int k=0;k<params.length;k++)
		{
			if(k==0)
			{
				param = params[0];
			}
			else
			{
				param = param + "," + params[k];
			}
		}
		for(int i=0;i<stationList.size();i++)
		{
			Map mp = (Map)stationList.get(i);
			String station_id = mp.get("station_id").toString();
			Object[] obj = new Object[]{station_id,date1,date2};
			Map m = getWarnExcpList(param,obj,table);
			if(m!=null&&m.get("m_time")!=null&&!f.empty(m.get("m_time").toString()))
			{
				m.put("station_id",station_id);
				m.put("station_desc",mp.get("station_desc"));
				dataList.add(m);
			}
		}
		return dataList;
	}
	
	/*!
	 * 获取预警或者报警的数据列表
	 */
	public static Map getWarnExcpList(String w_cols,Object[] ps,String type) throws Exception{
    	String sql = "select station_id,m_time,"+w_cols+" from t_monitor_warning ";
		sql=sql+" where station_id=? ";
		sql=sql+" and  m_time>=? and m_time<=? ";
		sql=sql+" order by m_time asc ";
		List list = f.query(sql,ps);
		String cols[] = w_cols.split(",");
		Map map = new HashMap();
		int num =list.size();
		for(int i=0;i<num;i++){
			map = (Map)list.get(i);
			for(int n=0;n<cols.length;n++){
				if(map.get(cols[n])!=null&&!map.get(cols[n]).toString().equals("")){
					String s[] = map.get(cols[n]).toString().split(",");
					if(s[3].equals(type)&&type.equals("0")){
						map.put("v_"+cols[n],"0");
					}
					if(s[3].equals(type)&&type.equals("1")){
						map.put("v_"+cols[n],"1");
					}
					map.put(cols[n],s[0]);
				}
			}
		}
		return map;
    }
	
	/*!
	 * 将获取到的预警数据通过值区间进行筛选
	 */
	public static List getNewUpDataList(List datalist,HttpServletRequest req) throws Exception
	{
		String[] cols = req.getParameterValues("bs_col");
		String station_type = req.getParameter("station_type");
		Map colmap  = getColsByArray(cols,station_type);
		String colname = colmap.get("colname").toString();
		if(colname.indexOf("PH")>-1)
		{
			datalist = movePHlist(datalist,req,colmap.get("phcol").toString());
		}
		String[] newcols = movePHcol(cols,station_type);
		datalist = getBSlist(datalist,newcols,req);
		return datalist;
	}
	/*!
	 * cols数组里为监测因子编号
	 * 根据cols里的监测因子编号返回监测因子详细信息列表
	 */
	public static Map getColsByArray(String[] cols,String station_type) throws Exception
	{
		String colname = "";
		String col = "";
		Map map = new HashMap();
		for(int i=0;i<cols.length;i++)
		{
			String c = cols[i];
			String sql = "select infectant_name from t_cfg_infectant_base where infectant_column='"+c.toUpperCase()+"' and station_type='"+station_type+"'";
			Map ColMap = f.queryOne(sql,null);
			String infectant_name = ColMap.get("infectant_name").toString();
			if(infectant_name.equals("PH"))
			{
				map.put("phcol",c.toLowerCase());
			}
			if(i==0)
			{
				colname = infectant_name;
				col = c;
			}
			else
			{
				colname = colname + "," +infectant_name;
				col = col + "," + c;
			}
		}
		map.put("colname",colname);
		map.put("col",col);
		return map;
	}
	
	/*!
	 * 筛选除去ph以外的监测因子值区间之内的数据
	 */
	public static List movePHlist(List datalist,HttpServletRequest req,String col) throws Exception
	{
		Map model = f.model(req);
		XBean xb = new XBean(model);
		String lo_v = xb.get("bs_"+col.toLowerCase()+"_lo");
		String hi_v = xb.get("bs_"+col.toLowerCase()+"_hi");
		if(!f.empty(lo_v)||!f.empty(hi_v))
		{
			for(int i=0;i<datalist.size();i++)
			{
				Map dataMap = (Map)datalist.get(i);
				XBean b = new XBean(dataMap);
				String data = b.get(col);
				if(!StringUtil.isNum(data)&&!f.empty(data))
				{
					datalist.remove(i);
				}
				if(!f.empty(data)&&!f.empty(lo_v)&&StringUtil.isNum(data))
				{
					double d_v = Double.parseDouble(data);
					double d_lo_v = Double.parseDouble(lo_v);
					if(d_v<d_lo_v)
					{
						datalist.remove(i);
					}
				}
				if(!f.empty(data)&&!f.empty(hi_v)&&StringUtil.isNum(data))
				{
					double d_v = Double.parseDouble(data);
					double d_hi_v = Double.parseDouble(hi_v);
					if(d_v>d_hi_v)
					{
						datalist.remove(i);
					}
				}
			}
		}
		return datalist;
	}
	
	
	/*!
	 * 返回不带PH指标的监测因子列表
	 */
	public static String[] movePHcol(String[] cols,String station_type) throws Exception
	{
		Map m = getColsByArray(cols,station_type);
		String colname = m.get("colname").toString();
		String[] newcols;
		if(colname.indexOf("PH")>-1)
		{
			newcols = new String[cols.length-1];
			int k=0;
			for(int i=0;i<cols.length;i++)
			{
				String c = cols[i];
				String sql = "select infectant_name from t_cfg_infectant_base where infectant_column='"+c.toUpperCase()+"' and station_type='"+station_type+"'";
				Map ColMap = f.queryOne(sql,null);
				String infectant_name = ColMap.get("infectant_name").toString();
				if(!infectant_name.equals("PH"))
				{
					newcols[k] = c;
					k++;
				}
			}
		}
		else
		{
			newcols = cols;
		}
		return newcols;
	}
	
	
	/*!
	 * 根据超标倍数筛选数据
	 */
	public static List getBSlist(List datalist,String[] cols,HttpServletRequest req) throws Exception
	{
		Map model = f.model(req);
		XBean xbe = new XBean(model);
		for(int i=0;i<datalist.size();i++)
		{
			Map data = (Map)datalist.get(i);
			XBean xb = new XBean(data);
			String station_id = data.get("station_id").toString();
			for(int k=0;k<cols.length;k++)
			{
				String col = cols[k];
				String bs = xbe.get("bs_"+(col.toLowerCase()));
				String sql = "select standard_value from t_cfg_monitor_param where station_id='"+station_id+"' and infectant_column='"+col.toUpperCase()+"'";
				Map stMap = f.queryOne(sql,null);
				if(stMap!=null)
				{
					XBean b = new XBean(stMap);
					String st = b.get("standard_value");
					if(!f.empty(st)&&!f.empty(bs))
					{
						double st_d = Double.parseDouble(st);
						double bs_d = Double.parseDouble(bs);
						double bz = st_d*bs_d;
						String v = xb.get(col.toLowerCase());
						if(!f.empty(v)&&StringUtil.isNum(v))
						{
							double d_v = Double.parseDouble(v);
							if(d_v<bz)
							{
								datalist.remove(i);
							}
						}
					}
				}
			}
		}
		return datalist;
	}
	
	public static List getTotalParamList(String station_type) throws Exception
	{
		String sql = "select infectant_column,infectant_name,infectant_unit from t_cfg_infectant_base where station_type=? and (infectant_unit ='mg/L' or infectant_unit='mg/M<sup>3</sup>') and (infectant_type='1' or infectant_type='2') and infectant_name not like '%折算%' and infectant_name not like '%CO浓度%'";
		Object[] obj = new Object[]{station_type};
		List list = f.query(sql,obj);
		return list;
	}
	
	/*!
	 * 获取报表类型的下拉框列表
	 */
	public static String getTypeOption(String type) throws Exception
	{
		List list = new ArrayList();
		Map map1 = new HashMap();
		map1.put("v_k","real_hour");
		map1.put("t_k","时均值基础报表");
		Map map2 = new HashMap();
		map2.put("v_k","real_day");
		map2.put("t_k","日均值基础报表");
		Map map3 = new HashMap();
		map3.put("v_k","real_month");
		map3.put("t_k","月均值基础报表");
		Map map4 = new HashMap();
		map4.put("v_k","tj_up");
		map4.put("t_k","预警统计报表");
		Map map5 = new HashMap();
		map5.put("v_k","tj_yc");
		map5.put("t_k","报警统计报表");
		Map map6 = new HashMap();
		map6.put("v_k","tj_zh");
		map6.put("t_k","综合查询统计报表");
		Map map7 = new HashMap();
		map7.put("v_k","tj_zl");
		map7.put("t_k","总量统计报表");
		list.add(map1);
		list.add(map2);
		list.add(map3);
		list.add(map4);
		list.add(map5);
		list.add(map6);
		list.add(map7);
		return f.getOption(list,"v_k","t_k",type);
	}
	
	
	/*!
	 * 获取总量统计中的站点类型下拉框列表
	 */
	public static String getStationTypeOption(String station_type) throws Exception
	{
		List list = new ArrayList();
		Map map1 = new HashMap();
		map1.put("v_k","1");
		map1.put("t_k","污染源污水");
		Map map2 = new HashMap();
		map2.put("v_k","2");
		map2.put("t_k","污染源烟气");
		list.add(map1);
		list.add(map2);
		if(f.empty(station_type))
		{
			station_type="1";
		}
		return f.getOption(list,"v_k","t_k",station_type);
	}
	
	
	/*!
	 * 获取污染源污水的总量信息
	 */
	public static List getTotalDataWS(List stationList,List paramList,String date1,String date2)throws Exception
	{
		String sql = "select infectant_column from t_cfg_infectant_base where infectant_name='流量' and station_type='1'";
		String flow = f.queryOne(sql,null).get("infectant_column").toString();
		sql = "select infectant_column from t_cfg_infectant_base where infectant_name='流量2' and station_type='1'";
		String flow2 = f.queryOne(sql,null).get("infectant_column").toString();
		String cols = flow+","+flow2;
		List list = new ArrayList();
		for(int i=0;i<paramList.size();i++)
		{
			Map mp = (Map)paramList.get(i);
			cols = cols + ","+mp.get("infectant_column").toString();
		}
		for(int i=0;i<stationList.size();i++)
		{
			Map stationMap = (Map)stationList.get(i);
			String station_id = stationMap.get("station_id").toString();
			sql = "select "+cols+" from t_monitor_real_hour where station_id=? and (m_time between ? and ?)";
			Object[] obj = new Object[]{station_id,date1,date2};
			List dataList = f.query(sql,obj);
			for(int k=0;k<dataList.size();k++)
			{
				Map dataMap = (Map)dataList.get(k);
				if(dataMap!=null)
				{
					XBean b = new XBean(dataMap);
					String ff = "";
					String f1 = b.get(flow.toLowerCase());
					String f2 = b.get(flow2.toLowerCase());
					if((f.empty(f1)&&f.empty(f2))||(!f.empty(f1)&&!StringUtil.isNum(f.v(f1)))||(!f.empty(f2)&&!StringUtil.isNum(f.v(f2))))
					{
						continue;
					}
					else
					{
						if(!f.empty(f1))
						{
							ff = f.v(f1);
						}
						else if(!f.empty(f2))
						{
							ff=f.v(f2);
						}
						double d_f = Double.parseDouble(ff);
						for(int x=0;x<paramList.size();x++)
						{
							Map colMap = (Map)paramList.get(x);
							String col = colMap.get("infectant_column").toString().toLowerCase();
							String value = b.get(col);
							if(f.empty(value)||(!f.empty(value)&&!StringUtil.isNum(f.v(value))))
							{
								continue;
							}
							else
							{
								double d_v = Double.parseDouble(f.v(value));
								double d_col = (d_v*d_f)/1000;
								if(stationMap.get(col.toLowerCase())!=null)
								{
									String total = stationMap.get(col.toLowerCase()).toString();
									double tt = Double.parseDouble(total);
									tt = tt+d_col;
									stationMap.put(col.toLowerCase(),tt+"");
								}
								else
								{
									stationMap.put(col.toLowerCase(),d_col+"");
								}
							}
						}
					}
				}
			}
			list.add(stationMap);
		}
		return list;
	}
	
	
	/*!
	 * 获取污染源烟气的总量信息
	 */
	public static List getTotalDataYQ(List stationList,List paramList,String date1,String date2)throws Exception
	{
		String sql = "select infectant_column from t_cfg_infectant_base where infectant_name like '标况流量' and station_type='2' and (infectant_type='1' or infectant_type='2')";
		String flow = f.queryOne(sql,null).get("infectant_column").toString();
		String cols = flow;
		for(int i=0;i<paramList.size();i++)
		{
			Map mp = (Map)paramList.get(i);
			cols = cols + ","+mp.get("infectant_column").toString();
		}
		for(int i=0;i<stationList.size();i++)
		{
			Map stationMap = (Map)stationList.get(i);
			String station_id = stationMap.get("station_id").toString();
			sql = "select "+cols+" from t_monitor_real_hour where station_id=? and (m_time between ? and ?)";
			Object[] obj = new Object[]{station_id,date1,date2};
			List dataList = f.query(sql,obj);
			for(int k=0;k<dataList.size();k++)
			{
				Map dataMap = (Map)dataList.get(k);
				if(dataMap!=null)
				{
					XBean b = new XBean(dataMap);
					String ff = "";
					String f1 = b.get(flow.toLowerCase());
					if((f.empty(f1)||(!f.empty(f1)&&!StringUtil.isNum(f.v(f1)))))
					{
						continue;
					}
					else
					{
						if(!f.empty(f1))
						{
							ff = f.v(f1);
						}
						double d_f = Double.parseDouble(ff);
						for(int x=0;x<paramList.size();x++)
						{
							Map colMap = (Map)paramList.get(x);
							String col = colMap.get("infectant_column").toString().toLowerCase();
							String value = b.get(col);
							if(f.empty(value)||(!f.empty(value)&&!StringUtil.isNum(f.v(value))))
							{
								continue;
							}
							else
							{
								double d_v = Double.parseDouble(f.v(value));
								double d_col = (d_v*d_f)/1000000;
								if(stationMap.get(col.toLowerCase())!=null)
								{
									String total = stationMap.get(col.toLowerCase()).toString();
									double tt = Double.parseDouble(total);
									tt = tt+d_col;
									stationMap.put(col.toLowerCase(),tt+"");
								}
								else
								{
									stationMap.put(col.toLowerCase(),d_col+"");
								}
							}
						}
					}
				}
			}
			stationList.remove(i);
			stationList.add(stationMap);
		}
		return stationList;
	}
	
	/*!
	 * 获取页面样式信息
	 */
	public static String getZQ_BScss(String type,String style) throws Exception
	{
		String css = "";
		if(type.equals("tj_up"))
		{
			if(style.equals("bs"))
			{
				css = "block";
			}
			else if(style.equals("zq"))
			{
				css = "none";
			}
		}
		else if(!type.equals("tj_up")&&style.equals("bs"))
		{
			css="none";
		}
		return css;
	}
}
