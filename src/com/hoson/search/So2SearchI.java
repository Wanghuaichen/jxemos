package com.hoson.search;

public interface So2SearchI {

	public double GetEntMonthSo2Flux(String EnterpriseCode,int Year,int Month);
	
	public double GetEntSeasonSo2Flux(String EnterpriseCode,int Year,int Season);
	
	public double GetEntHalfYearSo2Flux(String EnterpriseCode,int Year,int HalfYear);
	
	public double GetEntYearSo2Flux(String EnterpriseCode,int Year);
	
	public double GetEntMonthSo2Concentration(String EnterpriseCode,int Year,int Month,int Tp);
	
	public double GetEnSeasonSo2Concentration(String EnterpriseCode,int Year,int Season,int Tp);
	
	public double GetEntHalfYearSo2Concentration(String EnterpriseCode,int Year,int HalfYear,int Tp);
	
	public double GetEntYearSo2Concentration(String EnterpriseCode,int Year,int Tp);
}
