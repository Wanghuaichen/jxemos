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
<td>����λ</td>
<td>pHֵ</td>
<td>�ܽ���(mg/L)</td>
<td>�絼��(��s/cm)</td>
<td>�Ƕ�(NTU)</td>
<td>��������ָ��(mg/L)</td>

<td>����(mg/L)</td>
<td>���л�̼(mg/L)</td>
<td>ˮ�����</td>
</tr>
-->
<tr class="title">
<td>����λ</td>
<td>pHֵ</td>
<td>�ܽ���</td>
<td>�絼��</td>
<td>�Ƕ�</td>
<td>��������ָ��</td>

<td>����</td>
<td>���л�̼</td>
<td>ˮ�����</td>
</tr>

<%=s%>
</table>
</div>
