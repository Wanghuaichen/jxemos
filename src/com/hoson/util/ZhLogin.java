package com.hoson.util;
import java.util.*;
import javax.servlet.http.*;
import com.hoson.f;


public class ZhLogin{
	
	public static int getNextId(String table,String id)throws Exception{
		String sql = "select max("+id+") as max_id from "+table;
		Map m = null;
		m = f.queryOne(sql,null);
		if(m==null){return 1;}
		String max_id = null;
		max_id = (String)m.get("max_id");
		
		int i = Integer.parseInt(max_id);
		
		i=i+1;
		return i;
		
		
	}
	
	public static Map add(String user_name)throws Exception{
		String sql = "insert into t_sys_user(user_id,dept_id,user_name,user_pwd,is_view_all_station) values(?,?,?,?,?)";
	    Object[]ps = new Object[5];
	    int id = 0;
	    
	    ps[1]="1";
	    ps[2]=user_name;
	    ps[3]="123456";
	    ps[4]="1";
	    
	    id = getNextId("t_sys_user","user_id");
	    
	    ps[0] = new Integer(id);
	    
	    f.update(sql,ps);
	    
	    //1 0 综合管理 
	     //2 0 综合查询 
	    //4  测点浏朗
	    //8 1 实时数据 
	    //10 1 数据分析 
	    //14 2 历史数据 
	    /*
	    String mids = "1,2,4,8,10,14";
	    String[]arr=mids.split(",");
	    int i,num=0;
	    num=arr.length;
	    Object[]ps2 = new Object[2];
	    ps2[0] = new Integer(id);
	    sql = "insert into t_sys_user_module(user_id,module_id) values(?,?)";
	    for(i=0;i<num;i++){
	    	ps2[1] = arr[i];
	    	f.update(sql,ps2);
	    }
	    */
        Map m = new HashMap();
        m.put("user_id",id+"");
        m.put("user_name",user_name);
        m.put("user_pwd","123456");
        
	    return m;
	    
	    
	}
	
	
    public static Map login(HttpServletRequest req)throws Exception{
		//String user_name = req.getParameter("Acount");
    	String user_name = f.p(req,"Account","");
		if(f.empty(user_name)){
			//Util.error("帐号为空");
			throw new Exception("帐号为空");
		}
		Map m = null;
		String sql = null;
		
		sql = "select * from t_sys_user where user_name=?";
		m = f.queryOne(sql,new Object[]{user_name});
		//System.out.println("m="+m);
		if(m==null){
			m = add(user_name);
			//m = Util.detail(sql,new Object[]{user_name});
		}
		
		//set_session(req.getSession(),m);
		req.setAttribute("zh_user_name",user_name);
		req.setAttribute("zh_user_pwd",m.get("user_pwd"));
		
		return m;
		
		
	}
	
  
    
	
}