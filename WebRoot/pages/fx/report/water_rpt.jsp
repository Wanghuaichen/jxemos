<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp" %>

<%
String area_id = null;
String m_time = null;
String s = null;
   area_id = request.getParameter("area_id");
   m_time = request.getParameter("date1");
   



try{
     s = Report.getWaterReport(m_time,area_id,request);    

}catch(Exception e){
//out.println(e);
        JspUtil.go2error(request,response,e);
return;
}

%>


<div id='div_excel_content'>
<table border=0 cellspacing=1>

<!--
<tr class="title">
<td>监测点位</td>
<td>pH值</td>
<td>溶解氧(mg/L)</td>
<td>电导率(μs/cm)</td>
<td>浊度(NTU)</td>
<td>高锰酸盐指数(mg/L)</td>

<td>氨氮(mg/L)</td>
<td>总有机碳(mg/L)</td>
<td>水质类别</td>
</tr>
-->
<tr class="title">
<td>监测点位</td>
<td>pH值</td>
<td>溶解氧</td>
<td>电导率</td>
<td>浊度</td>
<td>高锰酸盐指数</td>

<td>氨氮</td>
<td>总有机碳</td>
<td>水质类别</td>
</tr>

<%=s%>
</table>
</div>
