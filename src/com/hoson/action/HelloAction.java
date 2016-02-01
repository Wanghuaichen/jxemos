package com.hoson.action;
import com.hoson.util.*;

import java.util.*;

import com.hoson.*;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;


public class HelloAction extends BaseAction{
	
	
	public String hello()throws Exception{
		String flag = p("flag");
		if(f.eq(flag,"1")){
			getConn();
			seta("msg","get conn");
		}
		
		seta("time",f.time());
		return null;
	}
	
}