package com.hoson;

import java.util.*;

public class RowSet {

	List list = null;

	int row_num = 0;

	int index = -1;

	Map row = null;

	public RowSet(List list) {
		if (list == null) {
			list = new ArrayList();

		}
		this.list = list;
		row_num = list.size();

	}

	public boolean next() {

		index++;
		if (index < row_num) {
			row = (Map) list.get(index);
			return true;
		} else {
			return false;
		}

	}
	
	public int size(){
		return list.size();
	}
	
	public void reset(){
		index=-1;
	}
	public int getIndex(){
		
		return index;
	}
	public Map getRow(){
		return row;
	}
	public int getRowNum(){
		
		return row_num;
	}
	

	public String get(String key, String defaultValue, int start, int len) {
		Object obj = row.get(key);
		if (obj == null) {
			return defaultValue;
		}
		String s = obj + "";
		s = substring(s, start, len);

		return s;
	}

	public String get(String key, String defaultValue) {

		Object obj = row.get(key);
		if (obj == null) {
			return defaultValue;
		}
		return obj + "";
	}
	
	
	

	public String get(String key) {

		Object obj = row.get(key);
		if (obj == null) {
			return "";
		}
		return obj + "";
	}
	
	public String get(String key,double r,String format) {

		Object obj = row.get(key);
		
		if (obj == null) {
			return "";
		}
		String s = obj+"";
		Double vobj = f.getDoubleObj(s,null);
		//System.out.println(s);
    	if(vobj==null){return "";}
    	double v = vobj.doubleValue();
    	v = v/r;
    	s = f.format(v+"",format);
    	//System.out.println("*****v="+v+","+s+","+format);
		
		return s;
	}
	
	
	
	public  String get(String key, int start, int len) {
		
		Object obj = row.get(key);
		if(obj==null){return "";}
		return substring(obj+"",start,len);
	}
	
	
	public int getInt(String key,int defv){
		Object obj = row.get(key);
		if(obj==null){return defv;}
		return StringUtil.getInt(obj+"",defv);
		
	}
	
	
	public double getDouble(String key,double defv){
		Object obj = row.get(key);
		if(obj==null){return defv;}
		return StringUtil.getDouble(obj+"",defv);
	}
	
	
	public String  format(String key,String f){
		if(f==null){return get(key);}
		Object obj = row.get(key);
		return StringUtil.format(obj,f);
	}

	public static String substring(String s, int start, int len) {

		if (s == null) {
			return s;
		}
		if (len < 1) {
			return "";
		}
		int max_index = s.length() - 1;
		if (start > max_index) {
			return "";
		}
		int end = start + len;
		if (end > max_index) {
			return s.substring(start);
		}

		return s.substring(start, end);

	}

}