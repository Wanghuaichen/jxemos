<%@ page contentType="text/html;charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.hoson.*"%>
<%@page import="com.hoson.app.*"%>

<%
String area_id = null;
String m_time = null;
String s = null;
   area_id = request.getParameter("area_id");
   m_time = request.getParameter("m_time");
   



try{
     s = Report.getAirReport(m_time,area_id,request);    

}catch(Exception e){
//out.println(e);
        JspUtil.go2error(request,response,e);
return;
}

%>


<link rel="StyleSheet" href="/<%=JspUtil.getCtx(request)%>/styles/css1.css" type="text/css" />
<script type="text/javascript" src="/<%=JspUtil.getCtx(request)%>/scripts/01.js"></script>
<script type="text/javascript" src="/<%=JspUtil.getCtx(request)%>/scripts/newdate.js"></script>

<table border=0 cellspacing=1>
<tr class=title>
<td>վλ����</td>
<td>��Ⱦָ��</td>
<td>��Ҫ��Ⱦ��</td>
<td>������������</td>
<td>��������״��</td>
</tr>  

<%=s%>
</table>

