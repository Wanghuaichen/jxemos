package com.hoson.search;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hoson.DBUtil;

public class CodSearch implements CodSearchI {

	//COD月度流量汇总
	public double GetEntMonthCodFlux(String EnterpriseCode,int Year,int Month){
		String beginTime = String.valueOf(Year)+"-"+String.valueOf(Month)+"-01";
		String endTime = String.valueOf(Year)+"-"+String.valueOf(Month+1)+"-01";
		return this.getFluxValue(EnterpriseCode, beginTime, endTime);
	}
	
	//COD季度流量汇总
	public double GetEntSeasonCodFlux(String EnterpriseCode,int Year,int Season){
		int beginMonth = this.getMonthBySeason(Season);
		String beginTime = String.valueOf(Year)+"-"+String.valueOf(beginMonth)+"-01";
		String endTime = String.valueOf(Year)+"-"+String.valueOf(beginMonth+3)+"-01";
		return this.getFluxValue(EnterpriseCode, beginTime, endTime);
	}
	
	//COD半年流量汇总
	public double GetEntHalfYearCodFlux(String EnterpriseCode,int Year,int HalfYear){
		int beginMonth = this.getMonthByHalfYear(HalfYear);
		String beginTime = String.valueOf(Year)+"-"+String.valueOf(beginMonth)+"-01";
		String endTime = String.valueOf(Year)+"-"+String.valueOf(beginMonth+6)+"-01";
		return this.getFluxValue(EnterpriseCode, beginTime, endTime);
	}
	
	//COD年度流量汇总
	public double GetEntYearCodFlux(String EnterpriseCode,int Year){
		String beginTime = String.valueOf(Year)+"-01-01";
		String endTime = String.valueOf(Year+1)+"-01-01";
		return this.getFluxValue(EnterpriseCode, beginTime, endTime);
	}
	
	//COD月平均浓度,Tp默认为1
	public double GetEntMonthCodConcentration(String EnterpriseCode,int Year,int Month,int Tp){
		String beginTime = String.valueOf(Year)+"-"+String.valueOf(Month)+"-01";
		String endTime = String.valueOf(Year)+"-"+String.valueOf(Month+1)+"-01";
		if(Tp==1){
			return this.getConcentrationValue(EnterpriseCode, beginTime, endTime);
		}else{
			return 0;
		}
	}
	
	//COD季度平均浓度,Tp默认为1
	public double GetEnSeasonCodConcentration(String EnterpriseCode,int Year,int Season,int Tp){
		int beginMonth = this.getMonthBySeason(Season);
		String beginTime = String.valueOf(Year)+"-"+String.valueOf(beginMonth)+"-01";
		String endTime = String.valueOf(Year)+"-"+String.valueOf(beginMonth+3)+"-01";
		if(Tp==1){
			return this.getConcentrationValue(EnterpriseCode, beginTime, endTime);
		}else{
			return 0;
		}
	}
	
	//COD半年平均浓度,Tp默认为1
	public double GetEntHalfYearCodConcentration(String EnterpriseCode,int Year,int HalfYear,int Tp){
		int beginMonth = this.getMonthByHalfYear(HalfYear);
		String beginTime = String.valueOf(Year)+"-"+String.valueOf(beginMonth)+"-01";
		String endTime = String.valueOf(Year)+"-"+String.valueOf(beginMonth+6)+"-01";
		if(Tp==1){
			return this.getConcentrationValue(EnterpriseCode, beginTime, endTime);
		}else{
			return 0;
		}
	}
	
	//COD年度平均浓度,Tp默认为1
	public double GetEntYearCodConcentration(String EnterpriseCode,int Year,int Tp){
		String beginTime = String.valueOf(Year)+"-01-01";
		String endTime = String.valueOf(Year+1)+"-01-01";
		if(Tp==1){
			return this.getConcentrationValue(EnterpriseCode, beginTime, endTime);
		}else{
			return 0;
		}
	}
	
	//根据企业编号和开始结束时间获得汇总数据,返回KG
	private double getFluxValue(String EnterpriseCode,String beginTime,String endTime){
		Connection cn = null;
		PreparedStatement stm = null;
		ResultSet rs = null;
		double value = 0.0;
		String val01 = "";
		String val02 = "";
		try {
			cn = DBUtil.getConn();
			String sql = "select station_id"+this.getCodLlStationType(EnterpriseCode)+" from t_monitor_real_hour m where m.station_id=? and m.m_time>=? and m.m_time<?";
			stm = cn.prepareStatement(sql);
			stm.setString(1, EnterpriseCode);
			stm.setString(2, beginTime);
			stm.setString(3, endTime);
			rs = stm.executeQuery();
			while(rs.next()){
				val01 = rs.getString(2);
				val02 = rs.getString(3);
				if(val01!=null&&!val01.equals("0.00,0.00,0.00")&&!val01.equals("")&&val02!=null&&!val02.equals("0.00,0.00,0.00")&&!val02.equals("")){
					double tempvalue = Double.parseDouble(val01.split(",")[0])*Double.parseDouble(val02.split(",")[0]);
					value = value + tempvalue;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs, stm, cn);
		}
		return value/1000;
	}
	
//	根据企业编号和开始结束时间获得汇总数据
	private double getConcentrationValue(String EnterpriseCode,String beginTime,String endTime){
		Connection cn = null;
		PreparedStatement stm = null;
		ResultSet rs = null;
		double value = 0.0;
		String val01 = "";
		int num = 0;
		try {
			cn = DBUtil.getConn();
			String sql = "select station_id,"+this.getCodStationType(EnterpriseCode)+" from t_monitor_real_hour m where m.station_id=? and m.m_time>=? and m.m_time<?";
			stm = cn.prepareStatement(sql);
			stm.setString(1, EnterpriseCode);
			stm.setString(2, beginTime);
			stm.setString(3, endTime);
			rs = stm.executeQuery();
			while(rs.next()){
				val01 = rs.getString(2);
				if(val01!=null&&!val01.equals("0.00,0.00,0.00")&&!val01.equals("")){
					value = value + Double.parseDouble(val01.split(",")[0]);
					num++;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs, stm, cn);
		}
		double pvalue=value/num;
		return pvalue;
	}
	
	//根据季度获得初始月份
	public int getMonthBySeason(int Season){
		if(Season==1){
			return 1;
		}else if(Season==2){
			return 4;
		}else if(Season==3){
			return 7;
		}else{
			return 10;
		}
	}
	
	//根据上半年或下半年标记获得初始月份
	public int getMonthByHalfYear(int HalfYear){
		if(HalfYear==0){
			return 1;
		}else{
			return 7;
		}
	}
	
	//获得COD和流量对应的val值
	public String getCodLlStationType(String station_id) throws Exception{
		Connection cn = null;
		PreparedStatement stm = null;
		ResultSet rs = null;
		String s = "";
		try {
			cn = DBUtil.getConn();
			String sql = "select t.infectant_column from t_cfg_infectant_base t where t.station_type=(select t.station_type from t_cfg_station_info t " +
						"where t.station_id=?) and t.infectant_name in ('COD','流量')";
			stm = cn.prepareStatement(sql);
			stm.setString(1, station_id);
			rs = stm.executeQuery();
			while(rs.next()){
				s += "," + rs.getString(1);
			}
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs, stm, cn);
		}
		return s;
	}
	
	//获得COD和流量对应的val值
	public String getCodStationType(String station_id) throws Exception{
		Connection cn = null;
		PreparedStatement stm = null;
		ResultSet rs = null;
		String s = "";
		try {
			cn = DBUtil.getConn();
			String sql = "select t.infectant_column from t_cfg_infectant_base t where t.station_type=(select t.station_type from t_cfg_station_info t " +
						"where t.station_id=?) and t.infectant_name='COD'";
			stm = cn.prepareStatement(sql);
			stm.setString(1, station_id);
			rs = stm.executeQuery();
			while(rs.next()){
				s = rs.getString(1);
			}
		} catch (Exception e) {
			throw e;
		} finally {
			DBUtil.close(rs, stm, cn);
		}
		return s;
	}
	
	public static void main(String args[]){
		CodSearchI cod = new CodSearch();
		cod.GetEntSeasonCodFlux("3605011001", 2009, 1);
	}
}
