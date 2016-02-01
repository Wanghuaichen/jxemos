package com.hoson.util;

import java.util.*;
import com.hoson.f;
import javax.servlet.http.*;
import com.hoson.XBean;




public class Demo{
	
	public static void create_table(HttpServletRequest req)throws Exception{
		String sql = "create table t_demo_user(user_id int primary key,user_name varchar(50),birth_day date,ww number(5,2),hh number(5,2))";
	    //执行更新语句，第2个参数为sql参数数组
		req.setAttribute("sql",sql);
		f.update(sql,null);
	    
	}
	//不分页
	public static void list(HttpServletRequest req)throws Exception{
		String sql = "select * from t_demo_user order by user_id desc";
	    //执行查询语句，第2个参数为sql参数数组
		//f.update(sql,null);
	    List list = f.query(sql,null);
	    
	    req.setAttribute("list",list);
		
		
		
	}
    //	分页查询
	public static void query(HttpServletRequest req)throws Exception{
		String sql = "select * from t_demo_user order by user_id desc";
	    Map m = null;
	    //分页查询，注意多了个request参数
	    //
	    m = f.query(sql,null,req);
	    List list = (List)m.get("data");
	    //bar为分页工具条
	    String bar = (String)m.get("bar");
	    
	    req.setAttribute("list",list);
	    req.setAttribute("bar",bar);
		
		
	}
	
	
	 //	查看用户信息
	public static void view(HttpServletRequest req)throws Exception{
		String user_id = req.getParameter("user_id");
		if(f.empty(user_id)){f.error("用户ID为空");}
		
		String sql = "select * from t_demo_user where user_id =?";
	    Map m = null;
        Object[]params = new Object[1];
        Integer id = null;
        id = f.getIntObj(user_id,null);
        if(id==null){f.error("用户ID必需为整数");}
        params[0] = id;
        
	    
	    m = f.queryOne(sql,params);
	    if(m==null){f.error("记录不存在");}
		req.setAttribute("user",m);
		
	}
	//更新用户信息
	public static void update(HttpServletRequest req)throws Exception{
		
		Map model = f.model(req);
		XBean b = new XBean(model);
		String user_id = b.get("user_id");
		String user_name = b.get("user_name");
		
		if(f.empty(user_id)){f.error("user_id is empty");}
		if(f.empty(user_name)){f.error("user_name is empty");}
		
		String table = "t_demo_user";
		String cols = "user_id,user_name,birth_day,ww,hh";
		//自动生成update语句
		//要更新的字段，主键字段列在最前面
		//第3个参数为主键列个数
		f.save(table,cols,1,model);
		
		
		
		
		
		
	}
	
    //	添加用户
	public static void insert(HttpServletRequest req)throws Exception{
		
		Map model = f.model(req);
		XBean b = new XBean(model);
		//String user_id = b.get("user_id");
		String user_name = b.get("user_name");
		
		//if(f.empty(user_id)){f.error("user_id is empty");}
		if(f.empty(user_name)){f.error("user_name is empty");}
		
		String table = "t_demo_user";
		String cols = "user_id,user_name,birth_day,ww,hh";
		
		f.insert(table,cols,1,model);
        //		自动生成insert语句
		//要更新的字段，主键字段列在最前面
		//第3个参数为主键是否自动增长
		
		
		
		
		
		
		
		
	}
	
	public static void del(HttpServletRequest req)throws Exception{
		String user_id = req.getParameter("user_id");
		if(f.empty(user_id)){f.error("用户ID为空");}
		
		String sql = "delete from t_demo_user where user_id =?";
        Object[]params = new Object[1];
        Integer id = null;
        id = f.getIntObj(user_id,null);
        if(id==null){f.error("用户ID必需为整数");}
        params[0] = id;
        
	    
	    f.update(sql,params);
	
	}
	
}