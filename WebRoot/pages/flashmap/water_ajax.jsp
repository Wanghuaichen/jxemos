<%@page import="java.io.PrintWriter"%>
<%@page import="com.hoson.map.WarningAnyChart"%>
<%@page import="com.hoson.map.AnyChartUtil"%>
<%@page import="com.hoson.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
String dateTime=request.getParameter("dateTime");


if(dateTime==null || dateTime=="")
dateTime=StringUtil.getNowDate()+"";

	AnyChartUtil acu = new AnyChartUtil();
	acu.saveAsXml(request, "water",dateTime);
	PrintWriter pw=response.getWriter();
		pw.write(dateTime);
		pw.flush();
		pw.close();
%>
