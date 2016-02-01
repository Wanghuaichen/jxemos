package com.hoson.action;

import java.sql.*;
import java.util.*;
import com.hoson.*;
import com.hoson.util.*;

public class MsgAction extends BaseAction{
	
	
	public String execute()throws Exception{
	
		String table = "sms_send";
		String cols = "id,mobile,content";
		String msg = null;
	
		String mobile = (String)model.get("mobile");
		String content = (String)model.get("content");
		try{
		
		checkContent(content);
		checkMobile(mobile);
		DBUtil.insert(table,cols,1,model);
		msg = "短信已成功发送";
		}catch(Exception e){
			
			msg=e+"";
			msg = msg.replaceAll("java.lang.Exception:","");
		
		}
		
		msg = StringUtil.encodeHtml(msg);
		model.put("msg",msg);
		return null;
	}
	
	
	public  String getHide()throws Exception{
		
		String cols = "station_id,infectant_id,starth,endh,date1,date2";
		return JspUtil.getHiddenHtml(cols,request);
	}
	
	void checkMobile(String s)throws Exception{
		
        String msg = null;
        msg = "无效的手机号码";
		if(s==null){s="";}
		if(s.length()<10){
			
			throw new Exception(msg);
		}
		
		if(isNumber(s)<1){
			
			throw new Exception(msg);
		}
	

		
	}
	
	
	int  isNumber(String s){
		
		if(StringUtil.isempty(s)){return 0;}
		
		char ch = '0';
		
		int i =0;
		int num =0;
		
		num = s.length();
		for(i=0;i<num;i++){
			
			ch = s.charAt(i);
			if(!(ch>='0'&&ch<='9')){
				
				return 0;
			}
			
		}
		
		return 1;
	}
	
	
    void checkContent(String s)throws Exception{
    	
    	String msg = null;
		

		if(StringUtil.isempty(s)){
			msg = "短信内容不能为空";
			throw new Exception(msg);
		}
		
    	
	}
	
}