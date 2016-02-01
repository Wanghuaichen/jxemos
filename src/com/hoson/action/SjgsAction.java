package com.hoson.action;
import com.hoson.util.*;

import java.util.*;

import com.hoson.*;
import java.sql.*;

import javax.servlet.http.HttpServletRequest;


public class SjgsAction extends BaseAction{
	
	
	public String q()throws Exception{
		String sql = "select * from t_cfg_sjgs";
		Map m = null;
		
		m = f.query(sql,null,request);
		
		
		
		return null;
		
		
	}
	
}