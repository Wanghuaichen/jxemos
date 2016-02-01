// Decompiled by Jad v1.5.8f. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   PowerCheckFilter.java

package com.hoson.app;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import com.hoson.*;
// Referenced classes of package com.hoson:
//            JspUtil, AirApp, DBUtil

public class AppPowerCheckFilter
    implements Filter
{

	private static Map aclUrlMap = null;
	private static String no_login_page="/pages/commons/nologin.jsp";
	private static String no_access_page="/pages/commons/noaccess.jsp";
	static{
		try{
		aclUrlMap = getAclUrlMap();
		}catch(Exception e){}
		
		
	}
	
	
	//-----------
	
	public synchronized  static Map getAclUrlMap()
	throws Exception{
		
		if(aclUrlMap!=null){
			return aclUrlMap;
		}
		
		Map m_aclUrlMap = new HashMap();
		Map map = null;
		Statement stmt = null;
		ResultSet rs = null;
		Connection cn = null;
		String sql = null;
		String res_id = null;
		String res_url = null;
		String res_name = null;
		
		
		sql = "select res_id,res_name,res_url from t_sys_resource ";
		sql=sql+"where is_url='1' and is_acl='1'";
		try{
		cn = DBUtil.getConn();
		stmt=cn.createStatement();
		rs = stmt.executeQuery(sql);
		while(rs.next()){
			res_id=rs.getString(1);
			res_name=rs.getString(2);
			res_url=rs.getString(3);
			map=new HashMap();
			map.put("res_id",res_id);
			map.put("res_name",res_name);
			m_aclUrlMap.put(res_url,map);
			//System.out.println(res_url);
		}			
		
		
		aclUrlMap = m_aclUrlMap;
		return m_aclUrlMap;
		}catch(Exception e){
			
			throw e;
		}finally{
		
			DBUtil.close(rs,stmt,cn);
		}
		
	}
	
 

//-----------------------------------
    public AppPowerCheckFilter()
    {
    }
//----------------
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws ServletException, IOException
    {
        HttpServletRequest req = null;                    
        HttpServletResponse res=null;
        String url = null;
        req = (HttpServletRequest)request;
        res = (HttpServletResponse)response;
             
        try{
        url = powerCheck(req);
        if(url!=null){
        	JspUtil.forward(req,response,url);
        	return;
        }
                
        chain.doFilter(request, response);
        return;
        }catch(Exception e){
        	try{
        		JspUtil.go2error(req, res,e);
        	return;
        	}catch(Exception ee){}
        	}

    }
//----------------------------------------
    public void init(FilterConfig filterconfig)
        throws ServletException
    {
    }
//--------------------------------
    public void destroy()
    {
    }

//---------------------------------
    public static String powerCheck(HttpServletRequest req)
        throws Exception
    {
    	
    	String res_url = null;
    	
        res_url = req.getServletPath();
        
        if(res_url.indexOf("/pages/commons/file/")>=0){
        	return null;
        }
        
        
    	
    	if(aclUrlMap==null){
    		
    		//aclUrlMap=getAclUrlMap();
    		getAclUrlMap();
    	}
    	
        boolean b = false;
        String user_id = null;
        String res_ids = null;
        
        String res_name = null;
        String res_id = null;
        Map map = null;
        String user_name = null;
        
        HttpSession session =null;  
        session=req.getSession();
        
        user_name = (String)session.getAttribute("user_name");
        
      
        
        if(StringUtil.equals("admin",user_name)){
        	return null;
        }
        
        res_url = req.getServletPath();
        map = (Map)aclUrlMap.get(res_url);
        
        if(map==null){
        	return null;
        	}
       
        res_id = (String)map.get("res_id");
        res_name=(String)map.get("res_name");
        if(StringUtil.isempty(res_id)){
        	return null;
        }
        
        user_id=(String)session.getAttribute("user_id");
        
        if(StringUtil.isempty(user_id)){
        
        	return no_login_page;
        }
        
        res_ids = (String)session.getAttribute("res_ids");
        
        if(StringUtil.isempty(res_ids)){
        	
        	req.setAttribute("res_name",res_name);
       
        	return no_access_page;
        }
        
        //String[]arr=res_ids.split(",");
  
        //b=StringUtil.hasValue(arr,res_id);
        
        b=hasValue(res_ids,res_id);
        
        if(!b){
        	
        	req.setAttribute("res_name",res_name);
     
        	return no_access_page;
        }
        
        
        return null;
        
    }
//---------------------------------
    
    public static boolean hasValue(String res_ids,String res_id){
    	
    	boolean b = false;
    	
    	String []arr = null;
    	try{
    	arr = res_ids.split(",");
    	b = StringUtil.hasValue(arr,res_id);
    	}catch(Exception e){
    		b = false;
    	}
    	
    	return b;
    	
    }
    
    
    //--------------
    public static void clearAclMap(){
    	
    	aclUrlMap = null;
    }
    
    

}
