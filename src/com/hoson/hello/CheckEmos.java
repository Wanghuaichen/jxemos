package com.hoson.hello;
import com.hoson.f;
public class CheckEmos  
{
	
	static int load_flag = 0;
	
	/*
	synchronized  void load(){
		
		 if(load_flag<1){
		 System.loadLibrary("vdaj"); 
		 load_flag = 1;
		 }
		
	}
	*/
	
	synchronized  void load(){
		
		 if(load_flag<1){
		 System.loadLibrary("vdaj"); 
		 load_flag = 1;
		 }
		
	}
	
	
	public CheckEmos(){
		//load();
	}
	

 static{
 	//System.out.println(System.getProperty("java.library.path"));
  //System.loadLibrary("vdaj");    // (1)
	 System.loadLibrary(f.cfg("dll","vdaj"));
 }

	
  
 
  public native static int check(String str,String dest);  // (2)
  public native static String decode(String str);
}
