package com.hoson.search;

public interface CodSearchI {

	public double GetEntMonthCodFlux(String EnterpriseCode,int Year,int Month);
	
	public double GetEntSeasonCodFlux(String EnterpriseCode,int Year,int Season);
	
	public double GetEntHalfYearCodFlux(String EnterpriseCode,int Year,int HalfYear);
	
	public double GetEntYearCodFlux(String EnterpriseCode,int Year);
	
	public double GetEntMonthCodConcentration(String EnterpriseCode,int Year,int Month,int Tp);
	
	public double GetEnSeasonCodConcentration(String EnterpriseCode,int Year,int Season,int Tp);
	
	public double GetEntHalfYearCodConcentration(String EnterpriseCode,int Year,int HalfYear,int Tp);
	
	public double GetEntYearCodConcentration(String EnterpriseCode,int Year,int Tp);
}
