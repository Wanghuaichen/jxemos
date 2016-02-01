<%@ page contentType="text/html; charset=GBK"%>
<%@page import="com.crystaldecisions.reports.sdk.*" %>
<%@page import="com.crystaldecisions.sdk.occa.report.lib.*" %>
<%@page import="com.crystaldecisions.report.web.viewer.*"%>
<%@ taglib uri="/crystal-tags-reportviewer.tld" prefix="crviewer"%>
 <%
       final String reportName="reports/test.rpt";
       ReportClientDocument crDoc = new ReportClientDocument();
       crDoc.open(reportName,0);
       //crDoc.getDatabaseController().logon("sa","root");
       //session.setAttribute("reportSource",crDoc.getReportSource());
       CrystalReportViewer viewer = new CrystalReportViewer();
       viewer.setOwnPage(true);
       viewer.setOwnForm(true);
       viewer.setPrintMode(CrPrintMode.ACTIVEX);
       //Object reportSource = session.getAttribute("reportSource");
       //viewer.setReportSource(reportSource);
       viewer.setReportSource(crDoc.getReportSource());
       viewer.processHttpRequest(request, response,this. getServletConfig().getServletContext(), null); 
 %>
