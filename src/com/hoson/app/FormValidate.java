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
			return "创建者不能为空";
		}
		if(StringUtil.isempty(prop.getProperty("create_user_info"))){
			return "创建者联系方式不能为空";
		}
		
		if(StringUtil.isempty(prop.getProperty("feedback_title"))){
			return "标题不能为空";
		}
		if(StringUtil.isempty(prop.getProperty("feedback_content"))){
			return "内容不能为空";
		}
		
		
		return s;
	}
	
	
}