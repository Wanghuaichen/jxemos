<%@ page contentType="text/html;charset=GBK" %>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.hoson.*"%>
<%@page import="com.hoson.util.*"%>
<%@page import="com.hoson.zdxupdate.*"%>
 
<%
       int flag=0;

       try{
        flag=ddUtil.wwlogin(request,response);
        if(flag==0){
        	f.fd(request,response,"/pages/home/wwlogin.jsp");
        }else{
        	response.sendRedirect("./wwindex.jsp");
        }
       }catch(Exception e){
       JspUtil.go2error(request,response,e);
       return;
       }
 %>
