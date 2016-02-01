<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="com.hoson.f"%>
<%@ page import="com.hoson.util.*"%>
<%@ page import="java.util.*"%>
<%
   Map m = null;
   String s = "";
   String zh_url = null;
   
   try{
   
   //s = request.getRequestURL()+","+request.getRequestURI()+","+request.getRemoteAddr()+","+request.getHeader("Referer");
   //System.out.println(s);
   
   zh_url = request.getHeader("Referer");
   String zh_url_cfg=f.cfg("zh_url","");
   
   //System.out.println(zh_url);
   //System.out.println("cfg="+zh_url_cfg);
   
   /*
   if(!f.eq(zh_url,zh_url_cfg)){
   throw new Exception("非法路径");
   //f.sop("非法路径");
   }
  */
   
   m = ZhLogin.login(request);
   String url = "user_name="+m.get("user_name");
   //url = url+"&user_pwd="+m.get("user_pwd");
   //url="../../userLogin.do?reqCode=check&"+url;
   //url="../../userLogin.do?reqCode=check";
   url = "../home/login_action.jsp";
   //response.sendRedirect(url);
   request.getRequestDispatcher(url).forward(request,response);
   //
   //System.out.println(Util.time()+"//////////////////\n\n");
  
   }catch(Exception e){
     out.println(e.getMessage());
   }
%>