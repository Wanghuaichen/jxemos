package com.hoson.app;

import com.hoson.*;
import java.util.*;
import java.sql.*;
import com.hoson.util.*;


public class AreaInfoDataCache extends Cache{
	
	public Object getObject(Map map)
	throws Exception{
		
	
	return JspPageUtil.getRealDataInfoMap();
		
		
	}
	}