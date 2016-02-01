<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.zdxupdate.Export"%>

<%

    try{

        Export.export_Info(request,response);
    }catch(Exception e){
       w.error(e);
       return;
    }


%>




