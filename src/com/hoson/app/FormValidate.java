package com.hoson.app;

import java.sql.*;
import java.util.*;
import com.hoson.*;
import javax.servlet.http.HttpServletRequest;


public class FormValidate{
	
	public static String feedback_form(
			HttpServletRequest req,Properties prop	
	)	
	throws Exception{
		String s = "";
		if(StringUtil.isempty(prop.getProperty("create_user"))){
			return "�����߲���Ϊ��";
		}
		if(StringUtil.isempty(prop.getProperty("create_user_info"))){
			return "��������ϵ��ʽ����Ϊ��";
		}
		
		if(StringUtil.isempty(prop.getProperty("feedback_title"))){
			return "���ⲻ��Ϊ��";
		}
		if(StringUtil.isempty(prop.getProperty("feedback_content"))){
			return "���ݲ���Ϊ��";
		}
		
		
		return s;
	}
	
	
}