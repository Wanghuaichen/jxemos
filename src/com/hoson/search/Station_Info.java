package com.hoson.search;

import java.sql.Connection;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.hoson.JspUtil;
import com.hoson.XBean;
import com.hoson.f;
import com.hoson.util.JspPageUtil;

public class Station_Info {

	
	/*!
	  * 根据request值获得站位属性信息
	  */
	public static void view(HttpServletRequest req)throws Exception{
		 String station_id = null;
		    String sql = null;
		    Map m = null;
		    Map m2 = null;
		    String tradeOption,areaOption,valleyOption,showOption,ctlTypeOption,qyStateOption = null;
		    XBean b = null;
		    String s = null;
		    
		    station_id = f.p(req,"station_id");
           if(f.empty(station_id)){f.error("station_id为空");}
           sql = "select * from t_cfg_station_info where station_id=?";
           m = f.queryOne(sql,new Object[]{station_id});
           if(m==null){f.error("记录不存在");}
           b = new XBean(m);
           //s = b.get("trade_id");黄宝修改
           //tradeOption = getTradeOption(s);
           
           s = b.get("area_id");
           areaOption = f.getAreaOption(s);
           s = b.get("valley_id");
           valleyOption = getValleyOption(s);
           s = b.get("show_flag");
           showOption = getShowOption(s);
           s = b.get("qy_state");
           qyStateOption = getqyStateOption(s);
           s = b.get("ctl_type");
           ctlTypeOption = getCtlTypeOption(s);
           
           s = b.get("trade_id");
           sql = "select * from t_cfg_industry_type where IndustryTypeCode=?";
           m2 = f.queryOne(sql, new Object[]{s});
           
           req.setAttribute("tradeInfo", m2);
           req.setAttribute("data",m);
           //req.setAttribute("tradeOption",tradeOption);
           req.setAttribute("areaOption",areaOption);
           req.setAttribute("valleyOption",valleyOption);
           req.setAttribute("showOption",showOption);
           req.setAttribute("ctlTypeOption",ctlTypeOption);
           req.setAttribute("qyStateOption",qyStateOption);
           
	}
	/*!
	  * 根据request值获得监测点因子信息
	  */
	public static void infectantList(HttpServletRequest req)throws Exception{
		
	}
	 /*!
	  * 获得重点源属性的下拉菜单值，type为选中值
	  */
	public static String getCtlTypeOption(String type)throws Exception{
		String vs = "0,1,2,3";
		String ts = "其他,市控,省控,国控";
		String s = JspUtil.getOption(vs,ts,type);
		//s = "<option value=''>\n"+s;
		return s;
	}
	 /*!
	  * 获得是否显示的下拉菜单值，flag为选中值
	  */
	public static String getShowOption(String flag)throws Exception{
		String vs = "1,0";
		String ts = "显示,不显示";
		String s = JspUtil.getOption(vs,ts,flag);
		return s;
	}
	/*!
	  * 获得企业状态的下拉菜单值，flag为选中值
	  */
	public static String getqyStateOption(String flag)throws Exception{
		String vs = "0,1,2";
		String ts = "正常,停产,暂时停产";
		String s = JspUtil.getOption(vs,ts,flag);
		return s;
	}
	/*!
	  * 获得审核状态的下拉菜单值，flag为选中值
	  */
	public static String getShState(String flag)throws Exception{
		String vs = "0,1";
		String ts = "原始数据,审核数据";
		String s = JspUtil.getOption(vs,ts,flag);
		return s;
	}
	/*!
	  * 获得行业的下拉菜单值，trade_id为选中值
	  */
	public static String getTradeOption(String trade_id)throws Exception{
		String sql = "select TRADE_ID,TRACE_NAME from t_cfg_trade where parentnode = 'root' order by TRADE_ID";
		String s = null;
		s = f.getOption(sql,trade_id);
		return s ;
	}
	/*!
	  * 获得流域的下拉菜单值，valley_id为选中值
	  */
	public static String getValleyOption(String valley_id)throws Exception{
		Connection cn = null;
		try{
			cn = f.getConn();
			return JspPageUtil.getValleyOption(cn,valley_id);
		}catch(Exception e){throw e;}
		finally{f.close(cn);}
		
	}
}
