package com.hoson.ps;

/*
 * author:lshh
 * desc:database operate
 */
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.hoson.DBUtil;
import com.hoson.f;

public class lshUpdate {

	/*!
	 * desc:获得污染源基本信息
	 */
	public static void getPsBaseInfo(HttpServletRequest req)throws Exception{
    	 String station_id;
		
		 String sql = null;
		 List psBaseInfoList = null;
		 
		 
		 
		 station_id = req.getParameter("station_id");
		 if(f.empty(station_id)){f.error("请选择站位");}
		 
		 sql =getPsBaseInfoSqlStart()+
			"select temp_table2.*,t_cfg_area.area_name from (select temp_table1.*,t_cfg_trade.trace_name from ( "+
			"select t_ps_psbaseinfo.*,t_cfg_valley.valley_name from t_ps_psbaseinfo left OUTER JOIN t_cfg_valley on t_ps_psbaseinfo.valleycode=t_cfg_valley.valley_id" +
			") temp_table1 left OUTER JOIN t_cfg_trade on temp_table1.industrytypecode=t_cfg_trade.trade_id " +
			") temp_table2 left OUTER JOIN t_cfg_area on temp_table2.areacode=t_cfg_area.area_id " +
		    getPsBaseInfoSqlEnd()+
		    "where station_id=?";
		 
		 psBaseInfoList = f.query(sql,new Object[]{station_id});
		 
		 req.setAttribute("psBaseInfoList",psBaseInfoList);
	}
	
	/*!
	 * desc:获得数据采集仪信息
	 */
	public static void getPsDgiInfo(HttpServletRequest req)throws Exception{
   	 	 String station_id;
		
		 String sql = null;
		 List psDgiInfoList = null;
		 
		 
		 
		 station_id = req.getParameter("station_id");
		 if(f.empty(station_id)){f.error("请选择站位");}
		 
		 sql = "select distinct t_ps_dgiinfo.*,dgi_type.parameter_name as dgi_type from t_ps_dgiinfo left OUTER JOIN (select * from t_cfg_parameter where "+
		    "t_cfg_parameter.parameter_type_id='dgi_type') dgi_type on t_ps_dgiinfo.dgitypecode=dgi_type.parameter_value where station_id=? ";
		 
		 psDgiInfoList = f.query(sql,new Object[]{station_id});
		 
		 req.setAttribute("psDgiInfoList",psDgiInfoList);
	}
	
	/*!
	 * desc:获得治理设备信息
	 */
	
	public static void getPsPteInfo(HttpServletRequest req)throws Exception{
  	 	 String station_id;
		
		 String sql = null;
		 List psPteInfoList = null;
		 
		 
		 
		 station_id = req.getParameter("station_id");
		 if(f.empty(station_id)){f.error("请选择站位");}
		 
		 sql = getSqlStart("temp_table","manage_method")+ 
	 		"select t_ps_pteinfo.*,pollutant_type.parameter_name as pollutant_type from t_ps_pteinfo left OUTER JOIN (select * from t_cfg_parameter where "+
	 		"t_cfg_parameter.parameter_type_id='pollutant_type') pollutant_type on t_ps_pteinfo.pollutanttypecode=pollutant_type.parameter_value "+
		    getSqlEnd("temp_table","manage_method","managemethodcode")+
		    " where station_id=? ";
		 
		 psPteInfoList = f.query(sql,new Object[]{station_id});
		 
		 req.setAttribute("psPteInfoList",psPteInfoList);
	}
	
	/*!
	 * desc:获得监控设备信息
	 */
	
	public static void getPsMonitorInfo(HttpServletRequest req)throws Exception{
 	 	 String station_id;
		
		 String sql = null;
		 List psMonitorInfoList = null;
		 
		 
		 
		 station_id = req.getParameter("station_id");
		 if(f.empty(station_id)){f.error("请选择站位");}
		 
		 sql = "select * from t_ps_monitorinfo where station_id=? ";
		 
		 psMonitorInfoList = f.query(sql,new Object[]{station_id});
		 
		 req.setAttribute("psMonitorInfoList",psMonitorInfoList);
	}
	
	/*!
	 * desc:获得污水进水口信息
	 */
	
	public static void getPsWaterInput(HttpServletRequest req)throws Exception{
	   	  	 String station_id;
			
			 String sql = null;
			 
			 station_id = req.getParameter("station_id");
			 if(f.empty(station_id)){f.error("请选择站位");}
			 
			 sql = "select * from t_ps_waterinput where station_id=? ";
			 
			 Map m = f.queryOne(sql,new Object[]{station_id});
			 if(m==null){f.error("记录不存在");}
			 
			 req.setAttribute("psWaterInput",m);
		}
	
	/*!
	 * desc:获得废水排放口信息
	 */
	
	public static void getPsWaterOutput(HttpServletRequest req)throws Exception{
	   	 	 String station_id;
			
			 String sql = null;
			 
			 station_id = req.getParameter("station_id");
			 if(f.empty(station_id)){f.error("请选择站位");}
			 
			 sql =getPsWaterOutputSqlStart()+
				"select t_ps_wateroutput.*,t_cfg_valley.valley_name from t_ps_wateroutput left OUTER JOIN "+
				"t_cfg_valley on t_ps_wateroutput.valleycode=t_cfg_valley.valley_id"+
				getPsWaterOutputSqlEnd()+
			    "where station_id=? ";
			 
			 Map m = f.queryOne(sql,new Object[]{station_id});
			 if(m==null){f.error("记录不存在");}
			 req.setAttribute("psWaterOutput",m);
		}
	
	
	/*!
	 * desc:获得废气排放口信息
	 */
	
	public static void getPsGasOutput(HttpServletRequest req)throws Exception{
  	 	 String station_id;
		
		 String sql = null;
		 
		 station_id = req.getParameter("station_id");
		 if(f.empty(station_id)){f.error("请选择站位");}
		 
		 sql =  getPsGasOutputSqlStart()+
				"select t_ps_gasoutput.*,fuel_type.parameter_name as fuel_type from t_ps_gasoutput left OUTER JOIN (select * from t_cfg_parameter where "+
				"t_cfg_parameter.parameter_type_id='fuel_type') fuel_type on t_ps_gasoutput.fueltypecode=fuel_type.parameter_value "+
				getPsGasOutputSqlEnd()+
				"where station_id=? ";
		 
		 Map m = f.queryOne(sql,new Object[]{station_id});
		 if(m==null){f.error("记录不存在");}
		 req.setAttribute("psGasOutput",m);
	}
	/*!
	 * desc:获得污染源基本信息的查询开始sql
	 */
	public static String getPsBaseInfoSqlStart(){
		return getSqlStart("temp_table8","subjection_relation")+getSqlStart("temp_table7","attention_level")+ 
		 getSqlStart("temp_table6","resource_type")+ getSqlStart("temp_table5","company_type")+
		 getSqlStart("temp_table4","enterprise_type")+getSqlStart("temp_table3","station_size");
	}
	/*!
	 * desc:获得污染源基本信息的查询结束sql
	 */
	public static String getPsBaseInfoSqlEnd(){
		return getSqlEnd("temp_table3","station_size","PSSCALECODE")+getSqlEnd("temp_table4","enterprise_type","REGISTTYPECODE")+
	    getSqlEnd("temp_table5","company_type","UNITTYPECODE")+getSqlEnd("temp_table6","resource_type","PSCLASSCODE")+
	    getSqlEnd("temp_table7","attention_level","ATTENTIONDEGREECODE")+getSqlEnd("temp_table8","subjection_relation","SUBJECTIONRELATIONCODE");
	}
	/*!
	 * desc:获得污水排放口信息的查询开始sql
	 */
	public static String getPsWaterOutputSqlStart(){
		return getSqlStart("temp_table4","flag_install")+ 
		 getSqlStart("temp_table3","function_area_type")+ 
		 getSqlStart("temp_table2","let_rule")+ 
		 getSqlStart("temp_table1","let_place");
	}
	/*!
	 * desc:获得污水排放口信息的查询结束sql
	 */
	public static String getPsWaterOutputSqlEnd(){
		return getSqlEnd("temp_table1","let_place","outputwhithercode")+
		getSqlEnd("temp_table2","let_rule","LETRULECODE")+
		getSqlEnd("temp_table3","function_area_type","FUNCTIONAREACODE")+
		getSqlEnd("temp_table4","flag_install","FLAGINSTALLFORMCODE");
	}
	/*!
	 * desc:获得废气排放口信息的查询开始sql
	 */
	public static String getPsGasOutputSqlStart(){
		return getSqlStart("temp_table7","gasoutput_type")+ getSqlStart("temp_table6","gas_function")+ 
				 getSqlStart("temp_table5","burntequipment_user")+ getSqlStart("temp_table4","twoarea_type")+ 
				 getSqlStart("temp_table3","let_rule")+ getSqlStart("temp_table2","flag_install")+ getSqlStart("temp_table1","burning_mode");
	}
	/*!
	 * desc:获得废气排放口信息的查询结束sql
	 */
	public static String getPsGasOutputSqlEnd(){
		return getSqlEnd("temp_table1","burning_mode","BURNINGMODECODE")+getSqlEnd("temp_table2","flag_install","FLAGINSTALLFORMCODE")+
		getSqlEnd("temp_table3","let_rule","LETRULECODE")+getSqlEnd("temp_table4","twoarea_type","TWOAREATYPECODE")+
		getSqlEnd("temp_table5","burntequipment_user","TWOAREATYPECODE")+getSqlEnd("temp_table6","gas_function","FUNCTIONAREACODE")+
		getSqlEnd("temp_table7","gasoutput_type","GASOUTPUTTYPECODE");
	}
	/*!
	 * desc:获得开始查询sql
	 */
	public static String getSqlStart(String temp_table,String type){
		StringBuffer str = new StringBuffer("select distinct ");
		str = str.append(temp_table).append(".*,").append(type).append(".parameter_name as ").append(type).append(" from (");
		return str.toString();
	}
	/*!
	 * desc:获得结束查询sql
	 */
	public static String getSqlEnd(String temp_table,String type,String relation){
		StringBuffer str = new StringBuffer(") ");
		str = str.append(temp_table).append(" left OUTER JOIN (select * from t_cfg_parameter where t_cfg_parameter.parameter_type_id='")
		.append(type).append("') ").append(type).append(" on ").append(temp_table).append(".").append(relation).append("=").append(type).append(".parameter_value ");
		return str.toString();
	}
	/*!
	 * 根据站位编号station_id和request获得站位名称
	 */
	public static String getStationName(String station_id,HttpServletRequest req) throws Exception {
		Connection cn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String station_name = "";
		try {
			cn = DBUtil.getConn(req);
			stmt = cn.createStatement();
			String sql ="select station_desc from T_CFG_STATION_INFO where station_id='"+station_id+"'";
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				station_name = rs.getString(1);
			}
		}	
		catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs, stmt, cn);
		}
		return station_name;
	}
	/*!
	 * 将字符串name转换为int型，为空则返回0
	 */
	public static int getInt(String name){
		if(name.equals("")||name==null){
			return 0;
		}else{
			return Integer.parseInt(name);
		}
	}
}
