package com.hoson.util;

public class DataDecode  
{
	
	static int load_flag = 0;
	
	synchronized  void load(){
		
		 if(load_flag<1){
		 System.loadLibrary("vdaj"); 
		 load_flag = 1;
		 }
		
	}
	
	private DataDecode(){
		//load();
	}
	
	
 static{
 	//System.out.println(System.getProperty("java.library.path"));
    System.loadLibrary("vdaj");    // (1)
 }

	
 
 
  public native static String decode(String str);  // (2)
}
