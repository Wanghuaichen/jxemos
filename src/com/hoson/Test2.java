package com.hoson;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class Test2 {

	/**
	 * @param args
	 * @throws ParseException 
	 */
	/*public static void main(String[] args) {
		Connection cn = null;
		String msg = null;
		String driver = "net.sourceforge.jtds.jdbc.Driver";
		String url = "jdbc:jtds:sqlserver://115.149.129.65:1433/emos2";
		String user = "hoson_emos2";
		String pwd = "cmbjx2!";
		if (StringUtil.isempty(driver)) {
			msg = "jdbc driver is empty";
		}
		if (StringUtil.isempty(url)) {
			msg = "jdbc url is empty";
		}
		try {
			Class.forName(driver);
			cn = DriverManager.getConnection(url, user, pwd);
			System.out.println(cn.toString());
		} catch (Exception e) {
             e.printStackTrace();
		}

	}*/
	
	/*public static void main(String[] args) {
		
		Calendar cal = Calendar.getInstance();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		cal.setTime(cal.getTime());
		
		cal.add(Calendar.DAY_OF_MONTH,-7);
		
		System.out.println(sdf.format(cal.getTime()));
	}*/
	
   /*public static void main(String[] args) {
		
		double hihi = 1500.0;
		
		int hi = 0;
		
		hi = (int)hihi;
		
		System.out.println(hi);
		
	}*/
	
	
    /*public static void main(String[] args) throws ParseException {
		
    	SimpleDateFormat f=new SimpleDateFormat("yyyy-MM-dd");

		
		System.out.println(f.format(getLastDayOfQuarter(2009,1)));
    	
    	int Year=getYear("2010-07-13");
        int month=getMonth("2010-07-13");
        String  result=getThisSeasonTime(month)+" "+Year+getMonthToMonth(month);
        System.out.println(result);
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd"); 
        try { 
            Date dt1 = df.parse("2010-07-01"); 
            Date dt2 = df.parse("2010-07-09"); 
            if (dt1.getTime() > dt2.getTime()) { 
                System.out.println("dt1 在dt2前"); 
            } else if (dt1.getTime() < dt2.getTime()) { 
                System.out.println("dt1在dt2后"); 
            } else { 
            } 
        } catch (Exception exception) { 
            exception.printStackTrace(); 
        } 

        
        
        
        //System.out.println(f.time("2010-07-07")>f.time("2010-07-09"));
		
	}*/
	
	

    public static void main(String[] args) throws ParseException {

    	/*MSWordManager ms = null;
    	ms = new MSWordManager(false);
		ms.openDocument("d:\\bdjc.doc");//打开模版
		ms.putTxtToCell(1,17, 2, "ok");
		ms.closeDocument();
		   ms.close();*/
    	/*SimpleDateFormat  df = new SimpleDateFormat("yyyy-MM-dd"); 
    	
    	System.out.println(getLastDayOfMonthString(2010,01));*/
    	
    	/*float online = 20;
    	float num = 24;
    	
    	float result = 20/24;
    	
    	Format   format = new   DecimalFormat("0.0000"); 

    	System.out.println(format.format(result));*/
    	
    	/*System.out.println(getLastDayOfMonthString(2010,4));*/
    	
    	/*System.out.println("2010-06-01 00:00:00".split("-")[0]);*/
    	
    	SimpleDateFormat  df = new SimpleDateFormat("yyyy-MM-dd");
    	
    	System.out.println(df.format(getLastDayOfQuarter(2010,4)));
    	System.out.println(df.format(getFirstDayOfQuarter(2010,2)));
	}
    
    public static String getLastDayOfMonthString(int year,int month){
       	
    	Calendar now= Calendar.getInstance();
    	now.set(Calendar.YEAR, year);
    	now.set(Calendar.MONTH,month-1);
		now.add(Calendar.MONTH, +1);
		now.set(now.get(Calendar.YEAR), now.get(Calendar.MONTH), 01);
		now.add(Calendar.DAY_OF_MONTH, -1);
		int yue = now.get(Calendar.MONTH);
		String yue_s = "";
        if(yue <10){
        	yue_s = "0"+ String.valueOf(yue);
        }
    	
    	String next_month =String.valueOf(now.get(Calendar.YEAR)+"-"+(month)+"-"+now.get(Calendar.DAY_OF_MONTH));
    	
		return next_month;
	}
	
    
    /**   
     *   获得某年某季度的最后一天的日期   
     *   @param   year   
     *   @param   quarter   
     *   @return   Date   
     */   
   public   static   Date   getLastDayOfQuarter(int   year,int   quarter){   
   int   month=0;   
   if(quarter>4){   
   return   null;   
   }else{   
   month=quarter*3;   
   }   
   return   getLastDayOfMonth(year,month);   
     
   }   
   
  
     
   /**   
     *   获得某年某季度的第一天的日期   
     *   @param   year   
     *   @param   quarter   
     *   @return   Date   
     */   
   public   static   Date   getFirstDayOfQuarter(int   year,int   quarter){   
   int   month=0;   
   if(quarter>4){   
   return   null;   
   }else{   
   month=(quarter-1)*3+1;   
   }   
   return   getFirstDayOfMonth(year,month);   
   }   
   
   /**   
    *   获得某年某月第一天的日期   
    *   @param   year   
    *   @param   month   
    *   @return   Date   
    */   
  public   static   Date   getFirstDayOfMonth(int   year,int   month){   
  Calendar   calendar=Calendar.getInstance();   
  calendar.set(Calendar.YEAR,year);   
  calendar.set(Calendar.MONTH,month-1);   
  calendar.set(Calendar.DATE,1);   
  return   getSqlDate(calendar.getTime());   
  }   
    
  /**   
    *   获得某年某月最后一天的日期   
    *   @param   year   
    *   @param   month   
    *   @return   Date   
    */   
  public   static   Date   getLastDayOfMonth(int   year,int   month){   
  Calendar   calendar=Calendar.getInstance();   
  calendar.set(Calendar.YEAR,year);   
  calendar.set(Calendar.MONTH,month);   
  calendar.set(Calendar.DATE,1);   
  return   getPreviousDate(getSqlDate(calendar.getTime()));   
  }   
  
  /**   
   *   由java.util.Date到java.sql.Date的类型转换   
   *   @param   date   
   *   @return   Date   
   */   
 public   static   Date   getSqlDate(java.util.Date   date){   
 return   new   Date(date.getTime());   
 }   
 
 /**   
  *   获得某一日期的前一天   
  *   @param   date   
  *   @return   Date   
  */   
public   static   Date   getPreviousDate(Date   date){   
Calendar   calendar=Calendar.getInstance();   
calendar.setTime(date);   
int   day=calendar.get(Calendar.DATE);   
calendar.set(Calendar.DATE,day-1);   
return   getSqlDate(calendar.getTime());   
}   


//获取季度
public static String getThisSeasonTime(int month){     
    String quarter="";    
    if(month>=1&&month<=3){     
        quarter="1";     
    }     
    if(month>=4&&month<=6){     
        quarter="2";       
    }     
    if(month>=7&&month<=9){     
        quarter = "3";     
    }     
    if(month>=10&&month<=12){     
        quarter = "4";     
    }
    return quarter;
}

//获取几月到几月
public static String getMonthToMonth(int month){     
    String monthToMonth="";    
    String[] months={"(January-March)","(April-June)","(July-September)","(October-December)"};
    int index=month/4;
    monthToMonth=months[index];
    return monthToMonth;
}

//取得当前时间
public static Date getDateTime(String dateTime){
    Date strDate=java.sql.Date.valueOf(dateTime);
    return strDate;     
}    

public static int getMonth(String dateTime)
{
   Calendar c=Calendar.getInstance();
   c.setTime(getDateTime(dateTime));
   int month=c.get(c.MONTH)+1;
   return month;
}

public static int getYear(String dateTime)
{
   Calendar c=Calendar.getInstance();
   c.setTime(getDateTime(dateTime));
   int year=c.get(c.YEAR);
   return year;
}






}
