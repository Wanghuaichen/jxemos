package com.hoson.util;
import java.util.*;
import java.sql.*;
import com.hoson.*;

public class BOData{
	
	
	public static List getStationIdList(){
		List list = new ArrayList();
		/*
		//water
		//hz
		list.add("3301821111");
		list.add("3301001001");
		list.add("3301041001");
		list.add("3301041003");
		list.add("3301041005");
		list.add("33010401");
		//nb
		list.add("3302011004");
		list.add("3302011001");
		list.add("3302031001");
		list.add("3302031003");
		
		//wz
		list.add("3303010020");
		list.add("3303010023");
		list.add("3303010016");
		list.add("3303010022");
		
		//gas
		//hz
		list.add("3301012001");
		list.add("3301022001");
		list.add("3301052001");
		list.add("3301052004");
		//nb
		list.add("3302012005");
		list.add("3302012002");
		list.add("3302012003");
		list.add("3302042003");
		//wz
		list.add("3303010033");
		list.add("3303010041");
		list.add("3303010037");
		list.add("3303010036");
		
		*/
		list.add("3303010036");
		
		
		return list;
		
	}
	
	public static String getInSql(){
		List list = getStationIdList();
		int i,num=0;
		num=list.size();
		String s = "";
		
		for(i=0;i<num;i++){
			s=s+"'"+list.get(i)+"',";
		}
		
		s = " and station_id in("+s+"'0')";
		return s;
		
	}
	
	
	public static String sql1(){
		int i,num=0;
		num=30;
		String s = "";
		for(i=1;i<=num;i++){
			 s=s+"val";
			 if(i<10){s=s+"0";}
			s=s+i;
			s=s+" float,\n";
			 //s=s+" double";
			 //if(i<30){s=s+",\n";}
			
		}
		return s;
	}
	
	public static String sql(String t){
		String s = "";
		s = "create table "+t+"(\n";
		s=s+"station_id varchar(30),\n";
		s=s+"m_time date,\n";
		s=s+sql1();
		s=s+"primary key(station_id,m_time)";
		s=s+"\n)\n";
		return s;
	}
	
	public static String sqli(String t){
		String s = "";
		int i,num=0;
		String s1,s2 = null;
		String col = null;
		
		num=30;
		s1="";
		s2="";
		
		for(i=1;i<=num;i++){
			col="val";
			if(i<10){col=col+"0";}
			col=col+i;
			s1=s1+","+col;
			s2=s2+",?";
		}
		
		s = "insert into "+t+"(station_id,m_time"+s1+") values(?,?"+s2+")";
		
		
		return s;
	}
	
	
	
	public static String grosssql(){
		String sql = null;
		sql = "create table t_bo_report_gross(\n";
		sql=sql+"station_id varchar(30),\n";
		sql=sql+"m_time date,\n";
		
		sql=sql+"v_cod float,\n";
		sql=sql+"v_so2 float,\n";
		sql=sql+"primary key(station_id,m_time)";
		sql=sql+"\n)\n";
		
		
		return sql;
	}
	
	public static void create_table(Connection cn,String sql){
		  try{
		f.update(cn,sql,null);
		
		  }catch(Exception e){
			  System.out.println(e);
		  }
	}
	
	public static void create_table()throws Exception{
		 String sql = null;
		 String t = "t_bo_report_hour";
		 Connection cn = null;
		 
		 
		 try{
		 cn = f.getConn();
		 sql = sql(t);
		 create_table(cn,sql);
		 t = "t_bo_report_day";
		 sql = sql(t);
		 create_table(cn,sql);
		 
		 sql = grosssql();
		 create_table(cn,sql);
		 
		 }catch(Exception e){
			 throw e;
		 }finally{f.close(cn);}
		 
	}
	

	
	
	public static List getData(Connection cn,String sql)throws Exception{
		List list = null;
		int i,num=0;
		List list2 = new ArrayList();
		Map m1,m2 = null;
		int j,colnum=0;
		String id,time,s = null;
		Timestamp m_time = null;
		int colvnum=0;
		colnum=30;
		String colkey = null;
		Double dblobj = null;
		
		
		
		list = f.query(cn,sql,null);
		
		System.out.println("get data,sql="+sql);
		
		
		num=list.size();
		
		System.out.println("get data,num="+num);
		
		for(i=0;i<num;i++){
			m1 = (Map)list.get(i);
			id = (String)m1.get("station_id");
			time = (String)m1.get("m_time");
			if(f.empty(id)){continue;}
			m_time = f.time(time,null);
			if(m_time==null){continue;}
			
			colvnum=0;
			m2 = new HashMap();
			
			for(j=1;j<=colnum;j++){
				colkey = "val";
				if(j<10){colkey=colkey+"0";}
				colkey=colkey+j;
				s = (String)m1.get(colkey);
				if(f.empty(s)){continue;}
				s = f.v(s);
				dblobj = f.getDoubleObj(s,null);
				if(dblobj==null){continue;}
				colvnum++;
				m2.put(colkey,dblobj);
				
			}
			if(colvnum<1){continue;}
			m2.put("station_id",id);
			m2.put("m_time",m_time);
			
			list2.add(m2);
			
		}
		
		
		
		return list2;
		
	}
	
	public static void insert(Connection cn,String sqli,Map data)throws Exception{
		Object[]p = null;
		p = new Object[32];
		int i,num=0;
		String col = null;
		num=30;
		p[0] = data.get("station_id");
		p[1]=data.get("m_time");
		for(i=1;i<=num;i++){
			col="val";
			if(i<10){col=col+"0";}
			col=col+i;
			p[i+1]=data.get(col);
		}
		f.update(cn,sqli,p);
		
	}
	
	public static int dayData(Connection cn)throws Exception{
		int rnum=0;
		String sqlq,sqli = null;
		sqlq = "select * from t_monitor_real_day where m_time>='2008-1-1' and m_time<='2008-12-31 23:59:59'";
		sqlq = sqlq+" "+getInSql();
		List list = null;
		int i,num=0;
		Map row = null;
		int inum=0;
		String msg = null;
		
		sqli = sqli("t_bo_report_day");
		list = getData(cn,sqlq);
		num=list.size();
		System.out.println("get day data,size="+num);
		
		for(i=0;i<num;i++){
			row = (Map)list.get(i);
			try{
			insert(cn,sqli,row);
			inum++;
			}catch(Exception e){
				msg=e+"";
			}
		}
		
		System.out.println("day data insert,num="+inum);
		
		System.out.println("day data insert error msg="+msg);
		
		
		return rnum;
		
	}
	
	public static int dayData()throws Exception{
		Connection cn = null;
		try{
		cn = f.getConn();
		return dayData(cn);
		}catch(Exception e){
			throw e;
		}finally{f.close(cn);}
		
	}
	
	public static int hourData(Connection cn)throws Exception{
		int rnum=0;
		String sqlq,sqli = null;
		sqlq = "select * from t_monitor_real_hour where m_time>='2008-1-1' and m_time<='2008-12-31 23:59:59'";
		sqlq = sqlq+" "+getInSql();
		List list = null;
		int i,num=0;
		Map row = null;
		int inum=0;
		String msg = null;
		
		sqli = sqli("t_bo_report_hour");
		list = getData(cn,sqlq);
		num=list.size();
		System.out.println("get hour data,size="+num);
		
		for(i=0;i<num;i++){
			row = (Map)list.get(i);
			try{
			insert(cn,sqli,row);
			inum++;
			}catch(Exception e){
				msg=e+"";
			}
		}
		
		System.out.println("hour data insert,num="+inum);
		
		System.out.println("hour data insert error msg="+msg);
		
		
		return rnum;
		
	}
	public static int hourData()throws Exception{
		Connection cn = null;
		try{
		cn = f.getConn();
		return hourData(cn);
		}catch(Exception e){
			throw e;
		}finally{f.close(cn);}
		
	}
}