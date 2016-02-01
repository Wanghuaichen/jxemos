<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp" %>
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

<style>
body{text-align:left;}
</style>
<body scroll=no onload=form1.submit()>

<form name="form1" method=post action="./water_rpt.jsp" target="q">


<input type=hidden name='tableName' value='<%=request.getParameter("tableName")%>'>
<!--
站位<select name="station_id">
<%=option%>
</select>

从 <input name="date1" type="text" value="2006-08-16" class=date onclick="new Calendar().show(this);">

到 <input name="date2" type="text" value="2006-08-16" class=date onclick="new Calendar().show(this);">
-->
<select name=area_id onchange=form1.submit()><%=option%></select>
<input type=input name=date1 value="<%=date1%>" class=date onclick="new Calendar().show(this);">



<input type="submit" value="查询" class="btn" class=btn>

</form>


<iframe name="q"  width=100% height=100%  scrolling="auto" frameborder="0"  style="border:0px" allowtransparency="true">
</iframe>




