<%@ page contentType="text/html;charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.hoson.*"%>
<%@page import="com.hoson.app.*"%>
<%@page import="com.hoson.util.*"%>
<%
String sql = null;

String option = null;
String date1 = null;
String date2 = null;



sql="select station_id,station_desc from t_cfg_station_info where station_type='6'";
try{
//option = JspUtil.getOption(sql,"",request);
option = JspPageUtil.getAreaOption("");
}catch(Exception e){
//out.println(e);
        JspUtil.go2error(request,response,e);
return;
}

date1=date2=StringUtil.getNowDate()+"";



%>

<link rel="StyleSheet" href="/<%=JspUtil.getCtx(request)%>/styles/css1.css" type="text/css" />
<script type="text/javascript" src="/<%=JspUtil.getCtx(request)%>/scripts/01.js"></script>
<script type="text/javascript" src="/<%=JspUtil.getCtx(request)%>/scripts/newdate.js"></script>
<style>
body{text-align:left;}
</style>
<body onload=form1.submit() style="background-color: #f7f7f7">

<form name="form1" method=post action="./hz07.jsp" target="q">

<input type=hidden name='tableName' value='<%=request.getParameter("tableName")%>'>

<select name=area_id onchange=form1.submit()><%=option%></select>

<input type="submit" value="²éÑ¯" class="btn">


</form>

<iframe name="q"  width=100% height=100%   frameborder="0"   >
</iframe>




