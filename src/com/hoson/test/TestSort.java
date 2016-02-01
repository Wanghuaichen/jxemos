package com.hoson.test;


import com.hoson.*;
import java.util.*;

public class TestSort{
	
	
	public static void main(String args[])throws Exception{
		Map m = null;
		List list = null;
		int i,num=0;
		Random r = null;
		List list2 = null;
		RowCompare c = null;
		
		
		r = new Random();
		
		list = new ArrayList();
		m = new HashMap();
		m.put("col1",new Double(1));
		m.put("col2",new Double(2));
		list.add(m);
		
		m = new HashMap();
		m.put("col1",new Double(9));
		m.put("col2",new Double(6));
		list.add(m);
		
		

		m = new HashMap();
		m.put("col1",null);
		m.put("col2",new Double(7));
		list.add(m);
		
		m = new HashMap();
		m.put("col1",null);
		m.put("col2",new Double(3));
		list.add(m);
		
		m = new HashMap();
		m.put("col1",new Double(5));
		m.put("col2",null);
		list.add(m);
		
		
		m = new HashMap();
		m.put("col1",new Double(5));
		m.put("col2",new Double(5));
		list.add(m);
		
		p(list);
		
		
		c = new RowCompare();
		c.setCompareCol("col1");
		Collections.sort(list,c);
		p(list);
		
		c = new RowCompare();
		c.setCompareCol("col2");
		Collections.sort(list,c);
		p(list);
		
		Collections.reverse(list);
		p(list);
		
		
		
	}
	public static void p(List list)throws Exception{
		int i,num=0;
		num = list.size();
	    for(i=0;i<num;i++){
	    	System.out.println(list.get(i));
	    }
	    System.out.println("\n\n");
	}
}
