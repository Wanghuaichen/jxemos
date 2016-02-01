package com.hoson;

import org.apache.log4j.*;





public class LogUtil{
	
	 private static Logger log = null;
	 static  String default_log_name = "ajf";
	 static int user_log_flag = -1;
	
	 
	 static int getFlag(){
		  if(user_log_flag>=0){
			  return user_log_flag;
		  }
		  //int flag = StringUtil.getInt(Config.get("log","0"),0);
		  int flag=1;
		  user_log_flag = flag;
		  return flag;
		 
	 }
	 
	static   Logger  getLog(){
		/*
		if(log!=null){return log;}
		log = Logger.getLogger("ajf");
		return log;
		*/
		return Logger.getLogger(default_log_name);
		
	}
	
	
   static   Logger  getLog(String name){
		/*
		if(log!=null){return log;}
		log = Logger.getLogger(name);
		return log;
		*/
	   if(StringUtil.isempty(name)){
		   return getLog();
	   }
	   return Logger.getLogger(name);
		
	}
	
	
	
	public static void info(Object msg){
		if(getFlag()<1){return;}
		getLog().info(msg);
	
	}
	public static void debug(Object msg){
		if(getFlag()<1){return;}
		getLog().debug(msg);
	
	}
	
	public static void warn(Object msg){
		if(getFlag()<1){return;}
		getLog().warn(msg);
		
	}
	
	public static void error(Object msg){
		if(getFlag()<1){return;}
		getLog().error(msg);
		
	}
	
    public static void fatal(Object msg){
    	if(getFlag()<1){return;}
		getLog().fatal(msg);
		
	}
    
    
    

	
	public static void info(String name,Object msg){
		if(getFlag()<1){return;}
		if(StringUtil.isempty(name)){
			getLog().info(msg);
		}
		getLog(name).info(msg);
	
	}
	public static void debug(String name,Object msg){
		if(getFlag()<1){return;}
		if(StringUtil.isempty(name)){
			getLog().debug(msg);
		}
		getLog(name).debug(msg);
	
	}
	
	public static void warn(String name,Object msg){
		if(getFlag()<1){return;}
		if(StringUtil.isempty(name)){
			getLog().warn(msg);
		}
		getLog(name).warn(msg);
		
	}
	
	public static void error(String name,Object msg){
		if(getFlag()<1){return;}
		if(StringUtil.isempty(name)){
			getLog().error(msg);
		}
		getLog(name).error(msg);
		
	}
	
    public static void fatal(String name,Object msg){
    	if(getFlag()<1){return;}
		if(StringUtil.isempty(name)){
			getLog().fatal(msg);
		}
		getLog(name).fatal(msg);
		
	}

    
    
    
    
    
    
    
    
    
    
    
    
    

}