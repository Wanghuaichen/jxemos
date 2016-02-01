package com.hoson;

import java.util.*;

public class XBean {

	Map map = null;

	public XBean(Map m) {
		if (m == null) {
			map = new HashMap();
		} else {
			map = m;
		}
	}

	public String get(String key) {

		Object obj = map.get(key);
		if (obj == null) {
			return "";
		}
		return obj + "";
	}

	
	
	
	public Object getObject(String key) {
		return map.get(key);
		
	}

	
	
	
	
	public String get(String key,double r,String format) {

		Object obj = get(key);
		
		if (obj == null) {
			return "";
		}
		String s = obj+"";
		Double vobj = f.getDoubleObj(s,null);
		//System.out.println(key+"="+s+","+vobj);
    	if(vobj==null){return "";}
    	double v = vobj.doubleValue();
    	v = v/r;
    	s = f.format(v+"",format);
    	//System.out.println("*****v="+v+","+s+","+format);
		
		return s;
	}
	

}