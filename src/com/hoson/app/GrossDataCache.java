package com.hoson.app;

import com.hoson.*;
import java.util.*;
import java.sql.*;
import com.hoson.util.*;
import javax.servlet.http.*;

public class GrossDataCache extends Cache{
	
	public Object getObject(Map map)
	throws Exception{
		List list = null;
		
		
		list = ZjGrossUtil.getGrossData();
	
		return list;
		
	}
	
	

	
}