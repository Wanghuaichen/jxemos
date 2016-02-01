package com.hoson.app;

import java.sql.*;
import java.util.*;
import com.hoson.*;
import com.hoson.app.*;

public class WaterReport
{

	public static int getMaxInt(int v1, int v2, int v3) 
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
	
	
//	-----------------water----

	public static int getWaterLevelByPH(double ph){
	         if(ph<=0){return 0;}
	         if(ph<=9&&ph>=6){return 1;}
	          return 6;

	}
//	-------------------------
	public static int getWaterLevelByDO(double ddo){

	         if(ddo<=0){return 0;}
	         if(ddo>=7.5){return 1;}
	         if(ddo<7.5&&ddo>=6){return 2;}
	         if(ddo<6&&ddo>=5){return 3;}
	         if(ddo<5&&ddo>=3){return 4;}
	          if(ddo<3&&ddo>=2){return 5;}
	        

	          return 6;

	}
//	-------------------------
	public static int getWaterLevelByNH3N(double nh3n){
	         if(nh3n<=0){return 0;}
	         if(nh3n<=0.15&&nh3n>0){return 1;}
	         if(nh3n<=0.5&&nh3n>0.15){return 2;}
	         if(nh3n<=1&&nh3n>0.5){return 3;}
	         if(nh3n<=1.5&&nh3n>1){return 4;}
	         if(nh3n<=2&&nh3n>1.5){return 5;}
	  
	           return 6;

	}
//	-------------------------

	public static int getWaterLevelByIMN(double imn){
	         if(imn<=0){return 0;}
	         if(imn<=2&&imn>0){return 1;}
	         if(imn<=4&&imn>2){return 2;}
	         if(imn<=6&&imn>4){return 3;}
	         if(imn<=10&&imn>6){return 4;}
	         if(imn<=15&&imn>10){return 5;}
	         if(imn>15){return 6;}
	           return 6;

	}
//	-------------------------
	public static int getWaterLevel(int a,int b,int c,int d){

	         int max1 = getMaxInt(a,b,c);
	         if(max1>=d){return max1;}else{return d;}
	          

	}
//	-------------------------
	public static String  getWaterLevelDesc(int lvl){

	         if(lvl==1){return "¢Ò";}
	         if(lvl==2){return "¢Ú";}
	         if(lvl==3){return "¢Û";}

	         if(lvl==4){return "¢Ù";}
	         if(lvl==5){return "¢ı";}
	         if(lvl==6){return "¡”¢ı";}
	            return "";

	}
//	-------------------------
	
	public static int get_ph_lvl(String s){
		
		s = App.getValueStr(s);
		double v = StringUtil.getDouble(s,0);
		return getWaterLevelByPH(v);
	}

	// ------------------
public static int get_do_lvl(String s){
		
		s = App.getValueStr(s);
		double v = StringUtil.getDouble(s,0);
		return getWaterLevelByDO(v);
	}

	// ------------------
public static int get_nh3n_lvl(String s){
	
	s = App.getValueStr(s);
	double v = StringUtil.getDouble(s,0);
	return getWaterLevelByNH3N(v);
}

// ------------------
public static int get_imn_lvl(String s){
	
	s = App.getValueStr(s);
	double v = StringUtil.getDouble(s,0);
	return getWaterLevelByIMN(v);
}

// ------------------
public static String getDesc(int lvl){
	
	return getWaterLevelDesc(lvl);
}

}