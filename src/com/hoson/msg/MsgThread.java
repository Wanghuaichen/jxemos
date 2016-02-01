package com.hoson.msg;

import java.sql.Timestamp;

import com.hoson.f;
import java.sql.*;

public class MsgThread extends Thread{
	
	public void run(){
         System.out.println("¿ªÊ¼Ö´ÐÐ...");
		 while(2>1){
		     System.out.println(f.time());
			 del_old_msg(30);
		    	MsgUtil.run();
		    	try{
		    	Thread.sleep(MsgUtil.get_sleep_time());
		    	}catch(Exception e){}
		    	
		    }
		
    }

	static void del_old_msg(int mins){
		add_col();
		String sql = "delete from  sms_send where save_time is null";
	    update(sql,null);
	    
	    sql = "delete from sms_send where save_time<?";
	    update(sql,new Object[]{time(mins)});
	    
	}
   static void add_col(){
    	String sql_oracle = "alter table sms_send add (save_time date)";
		String sql_mssql = "alter table sms_send add save_time datetime";
	    update(sql_oracle,null);
	    update(sql_mssql,null);
   }
    
    static void update(String sql,Object[]ps){
    	   try{
    		   f.update(sql,ps);
    	   }catch(Exception e){
    		   
    		   //System.out.println(e+"\n\n");
    	   }
    }
	
	static Timestamp time(int mins){
		long now = f.ms();
		now = now-mins*60*1000;
		return new Timestamp(now);
	}
	
}