package com.hoson.util;

import java.util.*;
import com.hoson.f;
import javax.servlet.http.*;
import com.hoson.XBean;




public class Demo{
	
	public static void create_table(HttpServletRequest req)throws Exception{
		String sql = "create table t_demo_user(user_id int primary key,user_name varchar(50),birth_day date,ww number(5,2),hh number(5,2))";
	    //ִ�и�����䣬��2������Ϊsql��������
		req.setAttribute("sql",sql);
		f.update(sql,null);
	    
	}
	//����ҳ
	public static void list(HttpServletRequest req)throws Exception{
		String sql = "select * from t_demo_user order by user_id desc";
	    //ִ�в�ѯ��䣬��2������Ϊsql��������
		//f.update(sql,null);
	    List list = f.query(sql,null);
	    
	    req.setAttribute("list",list);
		
		
		
	}
    //	��ҳ��ѯ
	public static void query(HttpServletRequest req)throws Exception{
		String sql = "select * from t_demo_user order by user_id desc";
	    Map m = null;
	    //��ҳ��ѯ��ע����˸�request����
	    //
	    m = f.query(sql,null,req);
	    List list = (List)m.get("data");
	    //barΪ��ҳ������
	    String bar = (String)m.get("bar");
	    
	    req.setAttribute("list",list);
	    req.setAttribute("bar",bar);
		
		
	}
	
	
	 //	�鿴�û���Ϣ
	public static void view(HttpServletRequest req)throws Exception{
		String user_id = req.getParameter("user_id");
		if(f.empty(user_id)){f.error("�û�IDΪ��");}
		
		String sql = "select * from t_demo_user where user_id =?";
	    Map m = null;
        Object[]params = new Object[1];
        Integer id = null;
        id = f.getIntObj(user_id,null);
        if(id==null){f.error("�û�ID����Ϊ����");}
        params[0] = id;
        
	    
	    m = f.queryOne(sql,params);
	    if(m==null){f.error("��¼������");}
		req.setAttribute("user",m);
		
	}
	//�����û���Ϣ
	public static void update(HttpServletRequest req)throws Exception{
		
		Map model = f.model(req);
		XBean b = new XBean(model);
		String user_id = b.get("user_id");
		String user_name = b.get("user_name");
		
		if(f.empty(user_id)){f.error("user_id is empty");}
		if(f.empty(user_name)){f.error("user_name is empty");}
		
		String table = "t_demo_user";
		String cols = "user_id,user_name,birth_day,ww,hh";
		//�Զ�����update���
		//Ҫ���µ��ֶΣ������ֶ�������ǰ��
		//��3������Ϊ�����и���
		f.save(table,cols,1,model);
		
		
		
		
		
		
	}
	
    //	����û�
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
        //		�Զ�����insert���
		//Ҫ���µ��ֶΣ������ֶ�������ǰ��
		//��3������Ϊ�����Ƿ��Զ�����
		
		
		
		
		
		
		
		
	}
	
	public static void del(HttpServletRequest req)throws Exception{
		String user_id = req.getParameter("user_id");
		if(f.empty(user_id)){f.error("�û�IDΪ��");}
		
		String sql = "delete from t_demo_user where user_id =?";
        Object[]params = new Object[1];
        Integer id = null;
        id = f.getIntObj(user_id,null);
        if(id==null){f.error("�û�ID����Ϊ����");}
        params[0] = id;
        
	    
	    f.update(sql,params);
	
	}
	
}