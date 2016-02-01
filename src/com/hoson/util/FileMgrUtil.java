package com.hoson.util;

import com.hoson.*;
import java.util.*;
import java.sql.*;
import com.hoson.app.*;
import java.io.*;


import javax.servlet.http.*;


//站位数据查看权限控制

public class FileMgrUtil{
	
	public static List getFiles(String dir)
	throws Exception{
		List list = new ArrayList();
		
		File file = new File(dir);
		
		
		if(!file.exists()){
			throw new Exception("file not exist,file="+file);
		}
		
		if(!file.isDirectory()){
			throw new Exception("not dir,file="+file);
		}
		
		File[]fs = file.listFiles();
		int i,num=0;
		Map map = null;
		File f = null;
		
		
		num = fs.length;
		//System.out.println(dir+","+num);
		
		for(i=0;i<num;i++){
			f = fs[i];
			map = new HashMap();
			
			map.put("name",f.getName());
			if(f.isDirectory()){
				map.put("type","d");
			}
			map.put("path",f.getPath());
			map.put("update",new Timestamp(f.lastModified()));
			
			list.add(map);
		}
		
		
		
		
		
		return list;
		
	}
	
	
	
	
	
}