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
	  * ����requestֵ���վλ������Ϣ
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
           if(f.empty(station_id)){f.error("station_idΪ��");}
           sql = "select * from t_cfg_station_info where station_id=?";
           m = f.queryOne(sql,new Object[]{station_id});
           if(m==null){f.error("��¼������");}
           b = new XBean(m);
           //s = b.get("trade_id");�Ʊ��޸�
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
	  * ����requestֵ��ü���������Ϣ
	  */
	public static void infectantList(HttpServletRequest req)throws Exception{
		
	}
	 /*!
	  * ����ص�Դ���Ե������˵�ֵ��typeΪѡ��ֵ
	  */
	public static String getCtlTypeOption(String type)throws Exception{
		String vs = "0,1,2,3";
		String ts = "����,�п�,ʡ��,����";
		String s = JspUtil.getOption(vs,ts,type);
		//s = "<option value=''>\n"+s;
		return s;
	}
	 /*!
	  * ����Ƿ���ʾ�������˵�ֵ��flagΪѡ��ֵ
	  */
	public static String getShowOption(String flag)throws Exception{
		String vs = "1,0";
		String ts = "��ʾ,����ʾ";
		String s = JspUtil.getOption(vs,ts,flag);
		return s;
	}
	/*!
	  * �����ҵ״̬�������˵�ֵ��flagΪѡ��ֵ
	  */
	public static String getqyStateOption(String flag)throws Exception{
		String vs = "0,1,2";
		String ts = "����,ͣ��,��ʱͣ��";
		String s = JspUtil.getOption(vs,ts,flag);
		return s;
	}
	/*!
	  * ������״̬�������˵�ֵ��flagΪѡ��ֵ
	  */
	public static String getShState(String flag)throws Exception{
		String vs = "0,1";
		String ts = "ԭʼ����,�������";
		String s = JspUtil.getOption(vs,ts,flag);
		return s;
	}
	/*!
	  * �����ҵ�������˵�ֵ��trade_idΪѡ��ֵ
	  */
	public static String getTradeOption(String trade_id)throws Exception{
		String sql = "select TRADE_ID,TRACE_NAME from t_cfg_trade where parentnode = 'root' order by TRADE_ID";
		String s = null;
		s = f.getOption(sql,trade_id);
		return s ;
	}
	/*!
	  * �������������˵�ֵ��valley_idΪѡ��ֵ
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
