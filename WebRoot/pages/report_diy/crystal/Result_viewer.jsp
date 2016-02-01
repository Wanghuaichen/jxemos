<%@ page contentType="text/html; charset=GBK"%>
<%@page import="com.hoson.map.CrystalDataSource" %>
<%@page import="com.crystaldecisions.report.web.viewer.*" %>
<%@ page import="com.crystaldecisions.reports.sdk.*" %>
<%    
	CrystalDataSource jrcd=new CrystalDataSource("reports/test123.rpt");
	String query = "select area_id,area_pid,area_name from t_cfg_area where area_id>36";
	jrcd.isReportSourceInSession("reportSource",session,query);
	
     CrystalReportViewer crViewer=new CrystalReportViewer();
     crViewer.setOwnPage(true);
     crViewer.setOwnForm(true);
     crViewer.setPrintMode(CrPrintMode.ACTIVEX);
    
     Object reportSource=session.getAttribute("reportSource");
     crViewer.setReportSource(reportSource);
    
     crViewer.processHttpRequest(request,response,this.getServletConfig().getServletContext(),null);
%>