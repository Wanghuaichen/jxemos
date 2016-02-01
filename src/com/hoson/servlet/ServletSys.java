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
					name = "江西省南昌市";
				}else if(area_id.equals("3602")){
					name = "江西省景德镇市";
				}else if(area_id.equals("3603")){
					name = "江西省萍乡市";
				}else if(area_id.equals("3604")){
					name = "江西省九江市";
				}else if(area_id.equals("3605")){
					name = "江西省新余市";
				}else if(area_id.equals("3606")){
					name = "江西省鹰潭市";
				}else if(area_id.equals("3607")){
					name = "江西省赣州市";
				}else if(area_id.equals("3608")){
					name = "江西省吉安市";
				}else if(area_id.equals("3609")){
					name = "江西省宜春市";
				}else if(area_id.equals("36010")){
					name = "江西省抚州市";
				}else if(area_id.equals("36011")){
					name = "江西省上饶市";
				}
				if(area_id.equals("36")){
					String sql = "select area_id,area_name from t_cfg_area where area_id ='"+area_id+"' or area_pid='"+area_id+"' order by area_id";
					s = f.getOption(sql,area_id);
				}else{
					String sql = "select area_id,area_name from t_cfg_area where area_id='"+area_id+"' or area_pid='"+area_id+"' order by area_id";
					s = f.getOption(sql,area_id);
					s = s+"<option value='36' >返回上一级</option>";
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
