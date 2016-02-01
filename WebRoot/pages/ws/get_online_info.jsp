<%@ page contentType="text/html;charset=GBK" %>
<%@page import="com.hoson.ws.*"%>
<%
      String s = null;
     
      
      try{
           s = WsUtil.get_online_info(request);
           
      }catch(Exception e){
           s=WsUtil.getErrorStr(e);
      }
%>
<%=s%>