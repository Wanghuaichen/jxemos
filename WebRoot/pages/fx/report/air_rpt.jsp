<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp" %>
<%
String area_id = null;
String m_time = null;
String s = null;
   area_id = request.getParameter("area_id");
   m_time = request.getParameter("date1");
   



try{
     s = Report.getAirReport(m_time,area_id,request);    

}catch(Exception e){
//out.println(e);
        JspUtil.go2error(request,response,e);
return;
}

%>


<div id='div_excel_content'>
<table border=0 cellspacing=1>
<tr class=title>
<td>站位名称</td>
<td>污染指数</td>
<td>首要污染物</td>
<td>空气质量级别</td>
<td>空气质量状况</td>
</tr>  

<%=s%>
</table>
</div>
