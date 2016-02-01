package com.hoson;
import java.util.*;

public class RowCompare implements Comparator{
	
	String col = null;
	
	
	
	public void setCompareCol(String col){
		this.col = col;
	}
	
	public int compare(Object o1,Object o2){
		if(f.empty(col)){return 0;}
		Map r1,r2 = null;
		Double v1,v2 = null;
		r1 = (Map)o1;
		r2=(Map)o2;
		v1 = (Double)r1.get(col);
		v2 =  (Double)r2.get(col);
		
		if(v1==null && v2==null){return 0;}
		//if(v1!=null && v2==null){return 1;}
		//if(v1==null && v2!=null){return -1;}
		
		if(v1!=null && v2==null){return -1;}
		if(v1==null && v2!=null){return 1;}
		
		return (0-v1.compareTo(v2));
		
		//return 0;
	}
	
}
