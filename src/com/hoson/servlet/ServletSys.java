package com.hoson.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hoson.f;

public class ServletSys extends HttpServlet {

	
	public ServletSys() {
		super();
	}

	
	public void destroy() {
		super.destroy(); 
		
	}

	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);
	}

	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
        
		String area_id = request.getParameter("area_id");
        String s = "";
        String name = "";
        try{
			if(!"".equals(area_id) && area_id !=null && area_id.length()<=4){
				if(area_id.equals("3601")){
					name = "����ʡ�ϲ���";
				}else if(area_id.equals("3602")){
					name = "����ʡ��������";
				}else if(area_id.equals("3603")){
					name = "����ʡƼ����";
				}else if(area_id.equals("3604")){
					name = "����ʡ�Ž���";
				}else if(area_id.equals("3605")){
					name = "����ʡ������";
				}else if(area_id.equals("3606")){
					name = "����ʡӥ̶��";
				}else if(area_id.equals("3607")){
					name = "����ʡ������";
				}else if(area_id.equals("3608")){
					name = "����ʡ������";
				}else if(area_id.equals("3609")){
					name = "����ʡ�˴���";
				}else if(area_id.equals("36010")){
					name = "����ʡ������";
				}else if(area_id.equals("36011")){
					name = "����ʡ������";
				}
				if(area_id.equals("36")){
					String sql = "select area_id,area_name from t_cfg_area where area_id ='"+area_id+"' or area_pid='"+area_id+"' order by area_id";
					s = f.getOption(sql,area_id);
				}else{
					String sql = "select area_id,area_name from t_cfg_area where area_id='"+area_id+"' or area_pid='"+area_id+"' order by area_id";
					s = f.getOption(sql,area_id);
					s = s+"<option value='36' >������һ��</option>";
				}
			}

            response.setCharacterEncoding("UTF-8");
            PrintWriter  out = response.getWriter();
            out.println(s);
            out.flush();
            out.close();
        }catch(Exception e){
        	e.printStackTrace();
        }
	}

	
	public void init() throws ServletException {
		
	}

}
