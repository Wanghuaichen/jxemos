package com.hoson.util;

import java.util.*;
import com.hoson.f;
import javax.servlet.http.*;

//20090313



public class UserRes{
	
	
	public static String getCheckedFlag(String res_ids,String res_id)throws Exception{
		 if(f.empty(res_ids)){return "";}
		 if(f.empty(res_id)){return "";}
		 if(res_ids.indexOf(","+res_id+",")>=0){return " checked";}
		 return "";
	}
	
	
	public static void view(HttpServletRequest req)throws Exception{
		String user_id = req.getParameter("objectid");
		String sql="select user_name from t_sys_user where  user_id='"+user_id+"'";
	    String msg = null;
	    String user_name;
	    List list = null;
	    String res_ids = null;
	    Map map=null;
	    
	    
	    if(f.empty(user_id)){
	     f.error("��ѡ���û�");
	    }
	   map=f.queryOne(sql,null);
	   if(map==null){
	    //out.println("ָ���ļ�¼������ objectid="+user_id);
	    msg = "ָ���ļ�¼������ objectid="+user_id;
	    f.error(msg);
	    }
	     
	     user_name=(String)map.get("user_name");
	     if(f.eq(user_name,"admin")){

	     msg = "�û�adminӵ������Ȩ��,����Ҫ�����κ�����";
	     f.error(msg);
	     }
	     
	     sql = "select * from t_sys_resource where res_id>1  order by res_id";
	     list = f.query(sql,null);
	     
	     sql = "select * from t_sys_user_res";
	     map = f.queryOne(sql,null);
	     if(map!=null){res_ids = (String)map.get("res_ids");}
	     if(res_ids==null){res_ids="";}
	     
	     res_ids = ","+res_ids+",";
	     
	     
	     req.setAttribute("user_id",user_id);
	     req.setAttribute("res_ids",res_ids);
	     req.setAttribute("list",list);
	    
	     
	     
	     
	}
	
}