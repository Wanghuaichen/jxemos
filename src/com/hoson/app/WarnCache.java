package com.hoson.app;


import com.hoson.*;
import java.util.*;
import java.sql.*;
import com.hoson.util.*;


public class WarnCache extends Cache{
	
	public Object getObject(Map map)
	throws Exception{
		return WarnUtil.getWarnNumData();
		//return null;
	}
	
}