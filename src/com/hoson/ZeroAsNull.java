package com.hoson;
import java.util.*;

public class ZeroAsNull{
	
	public static void make(Map m,String[]cols){
		if(m==null){return;}
		if(cols==null){return;}
	
		int num=cols.length;
		if(num<1){return;}
		int i =0;
		String col = null;
		Double objv = null;
		Double nullv = null;
		for(i=0;i<num;i++){
			col=cols[i];
			objv = (Double)m.get(col);
			
			//System.out.println(col+","+objv);
			if(objv==null){continue;}
			if(objv.doubleValue()==0){m.put(col,nullv);}
		}
		
		
	}
	
	public static void make(List list,String cols){
		if(list==null){return;}
		if(f.empty(cols)){return;}
		String[]arr=null;
		int i,num=0;
		String col = null;
		Map m = null;
		Double objv = null;
		
		
		
		arr=cols.split(",");
		num=list.size();
		
		for(i=0;i<num;i++){
			m = (Map)list.get(i);
			make(m,arr);
		}
		
		
		
		
		
		
	}
	
	
}