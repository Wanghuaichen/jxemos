package com.hoson.zdxupdate;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.sql.Connection;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.hoson.DBUtil;
import com.hoson.JspUtil;
import com.hoson.StringUtil;
import com.hoson.XBean;
import com.hoson.f;
public class zdxUpdate
{
	public static String get_css(String time,String value,String bz,String col,HttpServletRequest req,String v_flag) throws Exception
	{
		String mark = "";
		if(value==null||f.empty(value)) return "";
		else if(StringUtil.isempty(time)&&StringUtil.isempty(bz))
		{
			mark = "drop";
		}
		else
		{
			HttpSession session = req.getSession();
			Map standard = (Map)session.getAttribute("standard");
			if(standard!=null)
			{
				Map st = (Map)standard.get(col);
				if(st!=null)
				{
					Object objhi = st.get("hi");
					Object objlo = st.get("lo");
					Object objhihi = st.get("hihi");
					Object objlolo = st.get("lolo");
					if(objhihi!=null&&!f.empty(objhihi.toString())&&StringUtil.isNum(value)&&!objhihi.equals("0.0000"))
					{
						double hihi = Double.parseDouble(objhihi.toString());
						double v = Double.parseDouble(value);
						if(v>=hihi)
						{
							mark = "yc";
						}
					}
					if(objlolo!=null&&!f.empty(objlolo.toString())&&StringUtil.isNum(value)&&!objlolo.equals("0.0000"))
					{
						double lolo = Double.parseDouble(objlolo.toString());
						double v = Double.parseDouble(value);
						if(v<=lolo) mark="yc";
					}
					if(!mark.equals("yc")&&objhi!=null&&!f.empty(objhi.toString())&&StringUtil.isNum(value)&&!objhi.equals("0.0000"))
					{
						double hi = Double.parseDouble(objhi.toString());
						double v = Double.parseDouble(value);
						if(v>=hi) mark="up";
					}
					if(!mark.equals("yc")&&objlo!=null&&!f.empty(objlo.toString())&&StringUtil.isNum(value)&&!objlo.equals("0.0000"))
					{
						double lo = Double.parseDouble(objlo.toString());
						double v = Double.parseDouble(value);
						if(v<=lo) mark="up";
					}
				}
			}
		}
		if(v_flag.equals("5")){
			mark = "drop";
		}
		return mark;
	}
	public static String get_css(String time,String value,String bz,String col,HttpServletRequest req) throws Exception
	{
		String mark = "";
		if(value==null||f.empty(value)) return "";
		else if(StringUtil.isempty(time)&&StringUtil.isempty(bz))
		{
			mark = "drop";
		}
		else
		{
			HttpSession session = req.getSession();
			Map standard = (Map)session.getAttribute("standard");
			
			if(standard!=null)
			{
				Map st = (Map)standard.get(col);
				if(st!=null)
				{
					Object objhi = st.get("hi");
					Object objlo = st.get("lo");
					Object objhihi = st.get("hihi");
					Object objlolo = st.get("lolo");
					if(objhihi!=null&&!f.empty(objhihi.toString())&&StringUtil.isNum(value)&&!objhihi.equals("0.0000"))
					{
						double hihi = Double.parseDouble(objhihi.toString());
						double v = Double.parseDouble(value);
						if(v>=hihi)
						{
							mark = "bj";
						}
					}
					if(objlolo!=null&&!f.empty(objlolo.toString())&&StringUtil.isNum(value)&&!objlolo.equals("0.0000"))
					{
						double lolo = Double.parseDouble(objlolo.toString());
						double v = Double.parseDouble(value);
						if(v<=lolo) mark="bj";
					}
					if(!mark.equals("bj")&&objhi!=null&&!f.empty(objhi.toString())&&StringUtil.isNum(value)&&!objhi.equals("0.0000"))
					{
						double hi = Double.parseDouble(objhi.toString());
						double v = Double.parseDouble(value);
						if(v>=hi) mark="yj";
					}
					if(!mark.equals("bj")&&objlo!=null&&!f.empty(objlo.toString())&&StringUtil.isNum(value)&&!objlo.equals("0.0000"))
					{
						double lo = Double.parseDouble(objlo.toString());
						double v = Double.parseDouble(value);
						if(v<=lo) mark="yj";
					}
				}
			}
		}
		return mark;
	}
	
	public static void advice_add(HttpServletRequest request) throws Exception
	{
		Properties prop = JspUtil.getReqProp(request);
		Timestamp ts = f.time();
		prop.setProperty("advice_time",ts+"");
		prop.setProperty("advice_state","0");
		Connection con = DBUtil.getConn();
		String sql = "select max(advice_id) as m_id from t_cfg_advice";
		Map mp = f.queryOne(sql,null);
		Object obj = mp.get("m_id");
		String advice_id = "";
		if(obj!=null&&!obj.toString().trim().equals(""))
		{
			advice_id = obj.toString();
			int id = Integer.parseInt(advice_id)+1;
			advice_id = id+"";
		}
		else
		{
			advice_id="1";
		}
		prop.setProperty("advice_id",advice_id);
		DBUtil.insert(con,"t_cfg_advice","advice_id,advice_time,advice_user,advice_state,advice_jg,advice_content,advice_lx",prop);
		con.close();
	}
	
	//添加现场核查信息
	public static void xchc_add(HttpServletRequest request) throws Exception
	{
		Connection con  = null;
		try{
			Properties prop = JspUtil.getReqProp(request);
			String id = java.util.UUID.randomUUID().toString();
			prop.setProperty("id",id);
			Timestamp ts = f.time();
			prop.setProperty("sjsj",ts+"");
			con = DBUtil.getConn();
			String user_name = (String)request.getSession().getAttribute("user_name");
			prop.setProperty("user_name", user_name);
			String sql = "id,username,hcdw,hcrq,qyid,sjsj,qymc,zzjgdm,address,youbian,frdb,hbfzr,phone,wr_pwkmc,wr_pwkbm,wr_sbxh,wr_sccj,wr_ysqk,zd_sbyw,zd_sbws,zd_xjyw,zd_xyyw,zd_xjws,zd_xyws,zd_ghyw,zd_ghws,zd_clyw,zd_clws,sb_mjyw,sb_ylyw,sb_xsyw,sb_scyw,sb_cjsb,sb_cjxc,sb_kqsb,sb_kqxc,sb_xzsb,sb_xzxc,sb_sdsb,sb_sdxc,sb_ycbjyw,sb_ycclyw,sb_sbyzl,sb_sjcsl,sb_bbnd,sb_bbll,sb_bbzl,sb_bbrb,sb_bbyb,sb_bbjb,hcjl,beizhu,hcry,hcry_rq,qyry,qyry_rq";
			DBUtil.insert(con,"t_xchc",sql,prop);
			con.close();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			con.close();
		}
	}
	
	//修改现场核查信息
	public static void xchc_update(HttpServletRequest request) throws Exception
	{
		Properties prop = JspUtil.getReqProp(request);

		Timestamp ts = f.time();
		prop.setProperty("sjsj",ts+"");
		Connection con = DBUtil.getConn();
		String user_name = (String)request.getSession().getAttribute("user_name");
		prop.setProperty("user_name", user_name);
		
		String sql = "id,username,hcdw,hcrq,qyid,sjsj,qymc,zzjgdm,address,youbian,frdb,hbfzr,phone,wr_pwkmc,wr_pwkbm,wr_sbxh,wr_sccj,wr_ysqk,zd_sbyw,zd_sbws,zd_xjyw,zd_xyyw,zd_xjws,zd_xyws,zd_ghyw,zd_ghws,zd_clyw,zd_clws,sb_mjyw,sb_ylyw,sb_xsyw,sb_scyw,sb_cjsb,sb_cjxc,sb_kqsb,sb_kqxc,sb_xzsb,sb_xzxc,sb_sdsb,sb_sdxc,sb_ycbjyw,sb_ycclyw,sb_sbyzl,sb_sjcsl,sb_bbnd,sb_bbll,sb_bbzl,sb_bbrb,sb_bbyb,sb_bbjb,hcjl,beizhu,hcry,hcry_rq,qyry,qyry_rq";

		DBUtil.updateRow(con, "t_xchc", sql, prop);
		
		con.close();
	}
	
	//删除现场核查信息
	public static void xchc_delete(HttpServletRequest request) throws Exception
	{
		String[] xchc_ids = request.getParameterValues("xchc_ids");
		String ids = "";
		String sql = "";
		Connection con = DBUtil.getConn();
		if(xchc_ids !=null && xchc_ids.length >0){
           for(int i=0;i<xchc_ids.length;i++){
        	   if(!"".equals(ids)){
            	   ids = ids+",'"+xchc_ids[i]+"'";  
        	   }else{
            	   ids = "'"+xchc_ids[i]+"'";  
        	   }      	   
           }
           
           sql = "delete from t_xchc where id in("+ids+")";
           
           DBUtil.update(con, sql, null);
           
		}

		con.close();
	}
	
	
	//添加考核结论信息
	public static void khjl_add(HttpServletRequest request) throws Exception
	{
		//request.setCharacterEncoding("GBK");
		Properties prop = JspUtil.getReqProp(request);
		String id = java.util.UUID.randomUUID().toString();
		prop.setProperty("id",id);
		Timestamp ts = f.time();
		prop.setProperty("tjsj",ts+"");
		String station_desc = request.getParameter("");
		Connection con = DBUtil.getConn();
		String user_name = (String)request.getSession().getAttribute("user_name");
		prop.setProperty("user_name", user_name);		
		
		String sql = "id,jd_zhi,jd_hao,qy_id,tjsj,qy_mc,jd_name,jd_jl,jd_jg,jd_rq,jbr,spr";
		DBUtil.insert(con,"t_khjl",sql,prop);
		con.close();
	}
	
	
	//删除考核结论信息
	public static void khjl_delete(HttpServletRequest request) throws Exception
	{
		String[] khjl_ids = request.getParameterValues("khjl_ids");
		String ids = "";
		String sql = "";
		Connection con = DBUtil.getConn();
		if(khjl_ids !=null && khjl_ids.length >0){
           for(int i=0;i<khjl_ids.length;i++){
        	   if(!"".equals(ids)){
            	   ids = ids+",'"+khjl_ids[i]+"'";  
        	   }else{
            	   ids = "'"+khjl_ids[i]+"'";  
        	   }      	   
           }
           
           sql = "delete from t_khjl where id in("+ids+")";
           
           DBUtil.update(con, sql, null);
           
		}

		con.close();
	}
	
	//更新考核结论信息
	public static void khjl_update(HttpServletRequest request) throws Exception
	{
		//request.setCharacterEncoding("GBK");
		Properties prop = JspUtil.getReqProp(request);
		Timestamp ts = f.time();
		prop.setProperty("sjsj",ts+"");
		String qy_mc = request.getParameter("qy_mc");
	    if(!"".equals(qy_mc) && qy_mc != null){
	    	qy_mc = new String(qy_mc.getBytes("ISO-8859-1"), "gbk"); 
		}
	    prop.setProperty("qy_mc", qy_mc);
		Connection con = DBUtil.getConn();
		String user_name = (String)request.getSession().getAttribute("user_name");
		prop.setProperty("user_name", user_name);
		String sql = "id,jd_zhi,jd_hao,qy_id,tjsj,qy_mc,jd_name,jd_jl,jd_jg,jd_rq,jbr,spr";
		DBUtil.updateRow(con,"t_khjl",sql,prop);
		con.close();
	}
	
	//添加比对监测信息
	public static void bdjc_add(HttpServletRequest request) throws Exception
	{
		request.setCharacterEncoding("GBK");
		Properties prop = JspUtil.getReqProp(request);
		String bdjc_id = java.util.UUID.randomUUID().toString();
		prop.setProperty("id",bdjc_id);
		Timestamp ts = f.time();
		prop.setProperty("sjsj",ts+"");
    
		Connection con = DBUtil.getConn();
		String user_name = (String)request.getSession().getAttribute("user_name");
		prop.setProperty("user_name", user_name);
		
		//先存t_bdjc表中的信息		
		String sql = "id,username,bddw,bdrq,sjsj,bdjg,qymc,qyid,zwmc,sbmc,zzdw,xhbh,bdjcjl,jbr,spr";
		DBUtil.insert(con,"t_bdjc",sql,prop);
		
		//然后存t_jcxm表中的信息
		sql = "id,bdjc_id,jcxm_name,jcxm_bdff,jcxm_jcff";
		String jcxm_id = "";
		prop.setProperty("bdjc_id",bdjc_id);
		String id = "";
		String jcxm_name = "";
		String jcxm_jcff = "";
		String jcxm_bdff = "";
		for(int i=0;i<=6;i++){
		   jcxm_name = request.getParameter("jcxm_name_"+i);
		   jcxm_bdff = request.getParameter("jcxm_bdff_"+i);
		   jcxm_jcff = request.getParameter("jcxm_jcff_"+i);
		   
		   if(!"".equals(jcxm_name) && !"".equals(jcxm_jcff) && !"".equals(jcxm_bdff)){
			   jcxm_id = java.util.UUID.randomUUID().toString();
			   prop.setProperty("id",jcxm_id);
			   jcxm_name = new String(jcxm_name.getBytes("ISO-8859-1"), "gbk"); 
			   prop.setProperty("jcxm_name",jcxm_name);
			   jcxm_bdff = new String(jcxm_bdff.getBytes("ISO-8859-1"), "gbk"); 
			   prop.setProperty("jcxm_bdff",jcxm_bdff);
			   jcxm_jcff = new String(jcxm_jcff.getBytes("ISO-8859-1"), "gbk"); 
			   prop.setProperty("jcxm_jcff",jcxm_jcff);
			   DBUtil.insert(con,"t_jcxm",sql,prop);
		   }
		   
		}
		
		
		//再存t_xm表中的信息
		sql = "id,bdjc_id,xm_name,xm_bdsj,xm_zdsj,xm_bzxz,xm_bdjg,xm_dbqk";
		String xm_id = "";
		prop.setProperty("bdjc_id",bdjc_id);

		String xm_name = "";
		String xm_bdsj = "";
		String xm_zdsj = "";
		String xm_bzxz = "";
		String xm_bdjg = "";
		String xm_dbqk = "";
		for(int i=0;i<=6;i++){
			xm_name = request.getParameter("xm_name_"+i);
			xm_bdsj = request.getParameter("xm_bdsj_"+i);
			xm_zdsj = request.getParameter("xm_zdsj_"+i);
			xm_bzxz = request.getParameter("xm_bzxz_"+i);
			xm_bdjg = request.getParameter("xm_bdjg_"+i);
			xm_dbqk = request.getParameter("xm_dbqk_"+i);
		   
		   if(!"".equals(xm_name) && !"".equals(xm_bdsj) && !"".equals(xm_zdsj) && !"".equals(xm_bzxz) && !"".equals(xm_bdjg) && !"".equals(xm_dbqk)){
			   xm_id = java.util.UUID.randomUUID().toString();
			   prop.setProperty("id",xm_id);
			   xm_name = new String(xm_name.getBytes("ISO-8859-1"), "gbk");
			   prop.setProperty("xm_name",xm_name);
			   xm_bdsj = new String(xm_bdsj.getBytes("ISO-8859-1"), "gbk");
			   prop.setProperty("xm_bdsj",xm_bdsj);
			   xm_zdsj = new String(xm_zdsj.getBytes("ISO-8859-1"), "gbk");
			   prop.setProperty("xm_zdsj",xm_zdsj);
			   xm_bzxz = new String(xm_bzxz.getBytes("ISO-8859-1"), "gbk");
			   prop.setProperty("xm_bzxz",xm_bzxz);
			   xm_bdjg = new String(xm_bdjg.getBytes("ISO-8859-1"), "gbk");
			   prop.setProperty("xm_bdjg",xm_bdjg);
			   xm_dbqk = new String(xm_dbqk.getBytes("ISO-8859-1"), "gbk");
			   prop.setProperty("xm_dbqk",xm_dbqk);
	
			   
			   DBUtil.insert(con,"t_xm",sql,prop);
		   }
		   
		}
		
		
		
		con.close();
	}
	
	
	
	//修改比对监测信息
	public static void bdjc_update(HttpServletRequest request) throws Exception
	{
		request.setCharacterEncoding("GBK");
		Properties prop = JspUtil.getReqProp(request);

		Timestamp ts = f.time();
		prop.setProperty("sjsj",ts+"");
        String id = request.getParameter("id");
		Connection con = DBUtil.getConn();
		String user_name = (String)request.getSession().getAttribute("user_name");
		prop.setProperty("user_name", user_name);
		
		//先存t_bdjc表中的信息		
		String sql = "id,username,bddw,bdrq,sjsj,bdjg,qymc,qyid,zwmc,sbmc,zzdw,xhbh,bdjcjl,jbr,spr";
		DBUtil.updateRow(con,"t_bdjc",sql,prop);
		
		//然后存t_jcxm表中的信息
		sql = "id,bdjc_id,jcxm_name,jcxm_bdff,jcxm_jcff";
		String jcxm_id = "";
		prop.setProperty("bdjc_id",id);

		String jcxm_name = "";
		String jcxm_jcff = "";
		String jcxm_bdff = "";
		for(int i=0;i<=6;i++){
		   jcxm_name = request.getParameter("jcxm_name_"+i);
		   jcxm_bdff = request.getParameter("jcxm_bdff_"+i);
		   jcxm_jcff = request.getParameter("jcxm_jcff_"+i);
		   jcxm_id = request.getParameter("jcxm_id_"+i);
		   if(!"".equals(jcxm_name) && !"".equals(jcxm_jcff) && !"".equals(jcxm_bdff) && "".equals(jcxm_id)){
			   jcxm_id = java.util.UUID.randomUUID().toString();
			   prop.setProperty("id",jcxm_id);
			   jcxm_name = new String(jcxm_name.getBytes("ISO-8859-1"), "gbk"); 
			   prop.setProperty("jcxm_name",jcxm_name);
			   jcxm_bdff = new String(jcxm_bdff.getBytes("ISO-8859-1"), "gbk"); 
			   prop.setProperty("jcxm_bdff",jcxm_bdff);
			   jcxm_jcff = new String(jcxm_jcff.getBytes("ISO-8859-1"), "gbk"); 
			   prop.setProperty("jcxm_jcff",jcxm_jcff);
			   DBUtil.insert(con,"t_jcxm",sql,prop);
		   }else if(!"".equals(jcxm_name) && !"".equals(jcxm_jcff) && !"".equals(jcxm_bdff) && !"".equals(jcxm_id)){
			   prop.setProperty("id",jcxm_id);
			   jcxm_name = new String(jcxm_name.getBytes("ISO-8859-1"), "gbk"); 
			   prop.setProperty("jcxm_name",jcxm_name);
			   jcxm_bdff = new String(jcxm_bdff.getBytes("ISO-8859-1"), "gbk"); 
			   prop.setProperty("jcxm_bdff",jcxm_bdff);
			   jcxm_jcff = new String(jcxm_jcff.getBytes("ISO-8859-1"), "gbk"); 
			   prop.setProperty("jcxm_jcff",jcxm_jcff);
			   DBUtil.updateRow(con,"t_jcxm",sql,prop);
		   }
		   
		}
		
		
		//再存t_xm表中的信息
		sql = "id,bdjc_id,xm_name,xm_bdsj,xm_zdsj,xm_bzxz,xm_bdjg,xm_dbqk";
		String xm_id = "";
		prop.setProperty("bdjc_id",id);

		String xm_name = "";
		String xm_bdsj = "";
		String xm_zdsj = "";
		String xm_bzxz = "";
		String xm_bdjg = "";
		String xm_dbqk = "";
		for(int i=0;i<=6;i++){
			xm_name = request.getParameter("xm_name_"+i);
			xm_bdsj = request.getParameter("xm_bdsj_"+i);
			xm_zdsj = request.getParameter("xm_zdsj_"+i);
			xm_bzxz = request.getParameter("xm_bzxz_"+i);
			xm_bdjg = request.getParameter("xm_bdjg_"+i);
			xm_dbqk = request.getParameter("xm_dbqk_"+i);
		    xm_id = request.getParameter("xm_id_"+i);
		   if(!"".equals(xm_name) && !"".equals(xm_bdsj) && !"".equals(xm_zdsj) && !"".equals(xm_bzxz) && !"".equals(xm_bdjg) && !"".equals(xm_dbqk) && "".equals(xm_id)){
			   xm_id = java.util.UUID.randomUUID().toString();
			   prop.setProperty("id",xm_id);
			   xm_name = new String(xm_name.getBytes("ISO-8859-1"), "gbk");
			   prop.setProperty("xm_name",xm_name);
			   xm_bdsj = new String(xm_bdsj.getBytes("ISO-8859-1"), "gbk");
			   prop.setProperty("xm_bdsj",xm_bdsj);
			   xm_zdsj = new String(xm_zdsj.getBytes("ISO-8859-1"), "gbk");
			   prop.setProperty("xm_zdsj",xm_zdsj);
			   xm_bzxz = new String(xm_bzxz.getBytes("ISO-8859-1"), "gbk");
			   prop.setProperty("xm_bzxz",xm_bzxz);
			   xm_bdjg = new String(xm_bdjg.getBytes("ISO-8859-1"), "gbk");
			   prop.setProperty("xm_bdjg",xm_bdjg);
			   xm_dbqk = new String(xm_dbqk.getBytes("ISO-8859-1"), "gbk");
			   prop.setProperty("xm_dbqk",xm_dbqk);
	
			   
			   DBUtil.insert(con,"t_xm",sql,prop);
		   }else if(!"".equals(xm_name) && !"".equals(xm_bdsj) && !"".equals(xm_zdsj) && !"".equals(xm_bzxz) && !"".equals(xm_bdjg) && !"".equals(xm_dbqk) && !"".equals(xm_id)){
			   prop.setProperty("id",xm_id);
			   xm_name = new String(xm_name.getBytes("ISO-8859-1"), "gbk");
			   prop.setProperty("xm_name",xm_name);
			   xm_bdsj = new String(xm_bdsj.getBytes("ISO-8859-1"), "gbk");
			   prop.setProperty("xm_bdsj",xm_bdsj);
			   xm_zdsj = new String(xm_zdsj.getBytes("ISO-8859-1"), "gbk");
			   prop.setProperty("xm_zdsj",xm_zdsj);
			   xm_bzxz = new String(xm_bzxz.getBytes("ISO-8859-1"), "gbk");
			   prop.setProperty("xm_bzxz",xm_bzxz);
			   xm_bdjg = new String(xm_bdjg.getBytes("ISO-8859-1"), "gbk");
			   prop.setProperty("xm_bdjg",xm_bdjg);
			   xm_dbqk = new String(xm_dbqk.getBytes("ISO-8859-1"), "gbk");
			   prop.setProperty("xm_dbqk",xm_dbqk);
	
			   
			   DBUtil.updateRow(con,"t_xm",sql,prop);
		   }
		}
		
		
		
		con.close();
	}
	
	
	//删除比对监测信息
	public static void bdjc_delete(HttpServletRequest request) throws Exception
	{
		
		String[] bdjc_ids = request.getParameterValues("bdjc_ids");
		String ids = "";
		String sql = "";
		
		if(bdjc_ids !=null && bdjc_ids.length >0){
           for(int i=0;i<bdjc_ids.length;i++){
        	   if(!"".equals(ids)){
            	   ids = ids+",'"+bdjc_ids[i]+"'";  
        	   }else{
            	   ids = "'"+bdjc_ids[i]+"'";  
        	   }      	   
           }
           Connection con = DBUtil.getConn();
           
           con.setAutoCommit(false);
           //首先删除t_bdjc表中的数据
           sql = "delete from t_bdjc where id in("+ids+")";
           DBUtil.update(con, sql, null);
           //删除t_jcxm表中的数据
           sql = "delete from t_jcxm where bdjc_id in("+ids+")";
           DBUtil.update(con, sql, null);
           //删除t_xm表中的数据
           sql = "delete from t_xm where bdjc_id in("+ids+")";
           DBUtil.update(con, sql, null);
           
           con.commit();
           
           con.close();
		}

		
	}
	
	
	//添加合格标志
	public static void bdjc_hgbz(HttpServletRequest request) throws Exception
	{

		Properties prop = JspUtil.getReqProp(request);
		String hgbz_id = java.util.UUID.randomUUID().toString();
		prop.setProperty("id",hgbz_id);
		Timestamp ts = f.time();
		prop.setProperty("tjsj",ts+"");
    
		Connection con = DBUtil.getConn();
		String qyid = request.getParameter("station_id");
		String user_name = (String)request.getSession().getAttribute("user_name");
		prop.setProperty("user_name", user_name);
		prop.setProperty("qyid", qyid);
		//先存t_bdjc表中的信息		
		String sql = "id,bsdw,bsrq,bsr,dh,qymc,qyid,khdw,jcxm,pwkmc,pwkbh,sbsccj,sbxh,sbbh,bzbh,sbjdkhrq,bzhfrq,bzyxqz,username,tjsj";
		DBUtil.insert(con,"t_hgbz",sql,prop);
		con.close();
	}
	
	//修改合格标志
	public static void hgbz_update(HttpServletRequest request) throws Exception
	{

		Properties prop = JspUtil.getReqProp(request);
		//String hgbz_id = java.util.UUID.randomUUID().toString();
		//prop.setProperty("id",hgbz_id);
		Timestamp ts = f.time();
		prop.setProperty("tjsj",ts+"");
    
		Connection con = DBUtil.getConn();
		String qyid = request.getParameter("station_id");
		String user_name = (String)request.getSession().getAttribute("user_name");
		prop.setProperty("user_name", user_name);
		prop.setProperty("qyid", qyid);
		//先存t_bdjc表中的信息		
		String sql = "id,bsdw,bsrq,bsr,dh,qyid,qymc,khdw,jcxm,pwkmc,pwkbh,sbsccj,sbxh,sbbh,bzbh,sbjdkhrq,bzhfrq,bzyxqz,username,tjsj";
		DBUtil.updateRow(con,"t_hgbz",sql,prop);
		con.close();
	}
	
	
	public static void query_admin(HttpServletRequest request) throws Exception
	{
		String sql = "select * from t_cfg_advice where advice_id !=-1";
		String advice_state = request.getParameter("advice_state");
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date2");
		String d1 = "1900-01-01 00:00:00";
		String d2 = "2200-12-31 23:59:59";
		if(advice_state!=null&&!advice_state.equals("s"))
		{
			sql = sql + " and advice_state='"+advice_state+"'";
		}
		if(date1!=null&&!StringUtil.isempty(date1))
		{
			String[] dates = date1.split("-");
			String m = dates[1];
			if(m.length()==1)
			{
				m = "0"+m;
				dates[1]=m;
			}
			d1 = dates[0]+"-"+dates[1]+"-"+dates[2];
			d1 = d1 + " 00:00:00";
		}
		if(date2!=null&&!StringUtil.isempty(date2))
		{
			String[] dates = date2.split("-");
			String m = dates[1];
			if(m.length()==1)
			{
				m = "0"+m;
				dates[1]=m;
			}
			d2 = dates[0]+"-"+dates[1]+"-"+dates[2];
			d2 = d2 + " 23:59:59";
		}
		sql = sql + " and advice_time between '"+d1+"' and '"+d2+"' order by advice_time desc";//这里需要加排序功能。
		List list1 = new ArrayList();
		Map map1 = new HashMap();
		map1.put("value_key","1");
		map1.put("title_key","已处理");
		Map map2 = new HashMap();
		map2.put("value_key","0");
		map2.put("title_key","未查阅");
		Map map3 = new HashMap();
		map3.put("value_key","2");
		map3.put("title_key","处理中");
		Map map4 = new HashMap();
		map4.put("value_key","s");
		map4.put("title_key","全部");
		list1.add(map4);
		list1.add(map2);
		list1.add(map3);
		list1.add(map1);
		String stateOpts = f.getOption(list1,"value_key","title_key",advice_state);
		List list = f.query(sql,null);
		request.setAttribute("adviceCol",list);
		request.setAttribute("stateOpts",stateOpts);
		
		if(date1==null)
		{
			date1 = "";
		}
		if(date2==null)
		{
			date2 = "";
		}
		
		request.setAttribute("d1",date1);
		request.setAttribute("d2",date2);
	}
	
	public static void query_detail(HttpServletRequest request) throws Exception
	{
		String sql = "select * from t_cfg_advice where advice_id='"+request.getParameter("advice_id")+"'";
		Map map = f.queryOne(sql,null);
		String advice_time = map.get("advice_time").toString();
		advice_time = advice_time.substring(0,16);
		map.put("advice_time",advice_time);
		request.setAttribute("advice",map);
	}
	
	public static void advice_update(HttpServletRequest request) throws Exception
	{
		Properties prop = JspUtil.getReqProp(request);
		Connection con = DBUtil.getConn();
		DBUtil.updateRow(con,"t_cfg_advice","advice_id,advice_user,advice_time,advice_content,advice_state,advice_jg,deal_advice,advice_lx",prop);
	}
	
	public static void advice_delete(HttpServletRequest request) throws Exception
	{
		String advice_id = request.getParameter("advice_id");
		String sql = "delete from t_cfg_advice where advice_id='"+advice_id+"'";
		DBUtil.update(DBUtil.getConn(),sql,null);
	}
	
	
	public static void query_advice(HttpServletRequest request) throws Exception
	{
		HttpSession session = request.getSession();
		String advice_user = (String)session.getAttribute("user_name");
		String sql = "select * from t_cfg_advice where advice_id!=-1 and advice_user='"+advice_user+"'";
		String advice_state = request.getParameter("advice_state");
		String date1 = request.getParameter("date1");
		String date2 = request.getParameter("date2");
		String d1 = "1900-01-01 00:00:00";
		String d2 = "2200-12-31 23:59:59";
		if(advice_state!=null && !"".equals(advice_state) && !advice_state.equals("s"))
		{
			sql = sql + " and advice_state='"+advice_state+"'";
		}
		if(date1!=null&&!StringUtil.isempty(date1))
		{
			String[] dates = date1.split("-");
			String m = dates[1];
			if(m.length()==1)
			{
				m = "0"+m;
				dates[1]=m;
			}
			d1 = dates[0]+"-"+dates[1]+"-"+dates[2];
			d1 = d1 + " 00:00:00";
		}
		if(date2!=null&&!StringUtil.isempty(date2))
		{
			String[] dates = date2.split("-");
			String m = dates[1];
			if(m.length()==1)
			{
				m = "0"+m;
				dates[1]=m;
			}
			d2 = dates[0]+"-"+dates[1]+"-"+dates[2];
			d2 = d2 + " 23:59:59";
		}
		sql = sql + " and advice_time between '"+d1+"' and '"+d2+"'  order by advice_time desc";//这里需要加排序功能。
		List list1 = new ArrayList();
		Map map1 = new HashMap();
		map1.put("value_key","1");
		map1.put("title_key","已处理");
		Map map2 = new HashMap();
		map2.put("value_key","0");
		map2.put("title_key","未查阅");
		Map map3 = new HashMap();
		map3.put("value_key","2");
		map3.put("title_key","处理中");
		Map map4 = new HashMap();
		map4.put("value_key","s");
		map4.put("title_key","全部");
		list1.add(map4);
		list1.add(map2);
		list1.add(map3);
		list1.add(map1);
		String stateOpts = f.getOption(list1,"value_key","title_key",advice_state);
		List list = f.query(sql,null);
		request.setAttribute("adviceCol",list);
		request.setAttribute("stateOpts",stateOpts);
		
		if(date1==null)
		{
			date1 = "";
		}
		if(date2==null)
		{
			date2 = "";
		}
		request.setAttribute("d1",date1);
		request.setAttribute("d2",date2);
	}
	
	public static void getRight(HttpServletRequest req) throws Exception
	{
//		HttpSession session = req.getSession();
//		String user_name = session.getAttribute("user_name").toString();
	}
	
	public static void add_user(HttpServletRequest req) throws Exception
	{
		String user_name = (String)req.getSession().getAttribute("user_name");
		Connection con = DBUtil.getConn();
		String user_id = DBUtil.getNextId(con,"t_sys_user","user_id")+"";
		Properties prop = new Properties();
		prop.setProperty("user_id",user_id);
		prop.setProperty("user_name",user_name);
		prop.setProperty("dept_id","5");
		String cols="user_id,user_name,user_pwd,user_cn_name,dept_id,user_desc";
		DBUtil.insert(con,"t_sys_user",cols,prop);
		con.close();
	}
	
	
	public static String getStandardByStation(String m_time,String bz,String station_id,HttpServletRequest req) throws Exception
	{
		HttpSession session = req.getSession();
		String mark = "zc";
		Map mp = new HashMap();
		String sql = "select * from t_cfg_monitor_param where station_id='"+station_id+"'";
		List list = f.query(sql,null);
		for(int i=0;i<list.size();i++)
		{
			Map map = (Map)list.get(i);
			Map m1 = new HashMap();
			XBean b = new XBean(map);
			String hi = b.get("hi");
			String lo = b.get("lo");
			String hihi = b.get("hihi");
			String lolo = b.get("lolo");
			m1.put("lo",lo);
			m1.put("hi",hi);
			m1.put("lolo",lolo);
			m1.put("hihi",hihi);
			mp.put(b.get("infectant_column").toLowerCase(),m1);
		}
		if(StringUtil.isempty(m_time) && StringUtil.isempty(bz))
		{
			mark = "drop";
		}
		session.setAttribute("standard",mp);
		return mark;
	}
	
	public static List getStationList(XBean b) throws Exception
	{
		String station_type = b.get("station_type");
		String area_id = b.get("area_id");
		String station_name = b.get("p_station_name");
		String sql = "select * from t_cfg_station_info where sb_id is not null and sb_id!='' and sb_id!='0'";
		if(f.empty(station_type))
		{
			station_type = f.getDefaultStationType();
		}
		if(f.empty(area_id))
		{
			area_id = f.getDefaultAreaId();
		}
		sql = sql + " and station_type='"+station_type+"'";
		sql = sql + " and area_id like '%"+area_id+"%'";
		if(!f.empty(station_name))
		{
			sql = sql + " and station_desc like '%"+station_name+"%'";
		}
		return f.query(sql,null);
	}
	
	public static Map getRight(String user_name,String session_id) throws Exception
	{
		/*int wh=360;
		String ip = f.getUums_ip();
		String port = f.getUums_port();
		String url = "http://"+ip+":"+port+"/uums/uums_get_right?session_id="+session_id+"&username="+user_name+"&sysid=50";
		URL u = new URL(url);
		String temp;
		StringBuffer sb = new StringBuffer();
		BufferedReader in = new BufferedReader(new InputStreamReader(u.openStream(), "utf-8"));// 读取网页全部内容
        while ((temp = in.readLine())!= null)
        {
            sb.append(temp);
        }
        Map map = new HashMap();
        for(int i=10132;i<=13148;i++)
        {
        	String id = i+"";
        	map.put(id,"none");
        }
        String rt = sb.toString();
        if(rt.indexOf("10140")>=0)
        {
        	wh= wh+90;
        }
        if(rt.indexOf("10141")>=0)
        {
        	wh= wh+90;
        }
        String[] rts = rt.split("=");
        String rh = "";
        if(rts.length==2)
        {
        	rh = rts[1];
        	String[] str = rh.split(",");
        	for(int i=0;i<str.length;i++)
        	{
        		String r_id = str[i];
        		map.put(r_id,"yes");
        	}
        }
        map.put("wh",wh+"");*/
		Map map = new HashMap();
        return map;
	}
	
	public static Map getUserInfo(String user_name,String session_id) throws Exception
	{
		int wh=360;
		String ip = f.getUums_ip();
		String port = f.getUums_port();
		String url = "http://"+ip+":"+port+"/uums/uums_get_user?session_id="+session_id+"&username="+user_name;
		URL u = new URL(url);
		String temp;
		StringBuffer sb = new StringBuffer();
		BufferedReader in = new BufferedReader(new InputStreamReader(u.openStream(), "utf-8"));// 读取网页全部内容
        while ((temp = in.readLine())!= null)
        {
            sb.append(temp);
        }
        Map map = new HashMap();
        

        String rt = sb.toString();

        String[] rts = rt.split("");
        String rh = "";
        
        
        return map;
	}
	
	public static String getAearID(String user_name,String session_id) throws Exception
	{
/*		int wh=360;
		String ip = f.getUums_ip();
		String port = f.getUums_port();
		String url = "http://"+ip+":"+port+"/uums/uums_get_user?session_id="+session_id+"&username="+user_name;
		URL u = new URL(url);
		String temp;
		StringBuffer sb = new StringBuffer();
		BufferedReader in = new BufferedReader(new InputStreamReader(u.openStream(), "utf-8"));// 读取网页全部内容
        while ((temp = in.readLine())!= null)
        {
            sb.append(temp);
        }
        Map map = new HashMap();
        

        String rt = sb.toString();

        String[] rts = rt.split("");
        String rh = "";
        if(rts.length>=17){
        	rh = rts[12];
        }else{
        	rh = "3601";
        }*/
		String rh = "3601";
        return rh;
	}
	
	public static String getSessionID(String user_name,String password) throws Exception
	{
		int wh=360;
		String ip = f.getUums_ip();
		String port = f.getUums_port();
		String url = "http://"+ip+":"+port+"/uums/uums_login?account="+user_name+"&password="+password;
		URL u = new URL(url);
		String temp;
		StringBuffer sb = new StringBuffer();
		BufferedReader in = new BufferedReader(new InputStreamReader(u.openStream(), "utf-8"));// 读取网页全部内容
        while ((temp = in.readLine())!= null)
        {
            sb.append(temp);
        }
       
        String rt = sb.toString();

       
        
        return rt;
	}
	
	
	public static boolean isReal(String user_name,String session_id) throws Exception
	{
		/*String ip = f.getUums_ip();
		String port = f.getUums_port();
		String url = "http://"+ip+":"+port+"/uums/uums_get_right?session_id="+session_id+"&username="+user_name+"&sysid=50";
		URL u = new URL(url);
		String temp;
		StringBuffer sb = new StringBuffer();
		BufferedReader in = new BufferedReader(new InputStreamReader(u.openStream(), "utf-8"));// 读取网页全部内容
        while ((temp = in.readLine())!= null)
        {
            sb.append(temp);
        }
        String rt = sb.toString();
        if(rt.indexOf("10132")>=0)
        {
        	return true;
        }
        else
        {
        	return false;
        }*/
		return true;
	}
}