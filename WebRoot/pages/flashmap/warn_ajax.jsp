<%@page import="java.io.PrintWriter"%>
<%@page import="com.hoson.map.WarningAnyChart"%>
<%@page import="com.hoson.map.AnyChartUtil"%>
<%@page import="com.hoson.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
String monthTime=request.getParameter("monthTime");

	if(monthTime==null || monthTime==""){
		monthTime=(StringUtil.getNowDate()+"").substring(0, 7);
	}
	WarningAnyChart warn = new WarningAnyChart();
	warn.saveAsXml(request,monthTime);
	PrintWriter pw=response.getWriter();
	pw.write(monthTime);
	pw.flush();
	pw.close();
%>
