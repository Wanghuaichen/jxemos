<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.ps.*" %>
<%@page import="com.hoson.*" %>
<style>
td{
text-align:left;
}
</style>
<%

   // RowSet psWaterOutputSet;
    Map m = null;
    XBean b = null;
    String id,m_time,m_value;
    try{
    
      lshUpdate.getPsWaterOutput(request);
      m = (Map)request.getAttribute("psWaterOutput");
      b = new XBean(m);
    //  psWaterOutputSet = w.rs("psWaterOutputSet");
    }catch(Exception e){
     w.error(e);
     return;
    }
   
%>

  <table border=0 cellspacing=1 >
   <tr> 
     <td width="10%" class="tdtitle">�ŷſ�����</td>
     <td width="20%"><%=b.get("outputname")%></td>
     <td width="10%" class="tdtitle">�ŷſ�λ��</td>
     <td width="20%"><%=b.get("outputposition")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">����</td>
     <td width="20%"><%=b.get("longitude")%></td>
     <td width="10%" class="tdtitle">γ��</td>
     <td width="20%"><%=b.get("latitude")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">�ŷ�ȥ��</td>
     <td width="20%"><%=b.get("let_place")%></td>
     <td width="10%" class="tdtitle">�ŷŹ���</td>
     <td width="20%"><%=b.get("let_rule")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">ˮ���������</td>
     <td width="20%"><%=b.get("function_area_type")%></td>
     <td width="10%" class="tdtitle">��־�ư�װ��ʽ</td>
     <td width="20%"><%=b.get("flag_install")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">����</td>
     <td width="20%"><%=b.get("valley_name")%></td>
     <td width="10%" class="tdtitle">״̬</td>
     <td width="20%">
		<%if(b.get("status").equals("1")){%>
     		����
     	<%}else{ %>
     		ͣ��
     	<%} %>
	</td>
   </tr>
   </table>
   <%-- 
<br/>
<table border=0 cellspacing=1 >
   <tr class="title"> 
     <td>��Ⱦ������</td>
     <td>�쳣ֵ����</td>
     <td>�쳣ֵ����</td>
     <td>Ũ�ȱ�������</td>
     <td>Ũ�ȱ�������</td>
     <td>״̬</td>
   </tr>
   <%while(psWaterOutputSet.next()){%>
	   <tr> 
	     <td><%=psWaterOutputSet.get("pollutantcode") %></td>
	     <td><%=psWaterOutputSet.get("exceptionminvalue") %></td>
	     <td><%=psWaterOutputSet.get("exceptionmaxvalue") %></td>
	     <td><%=psWaterOutputSet.get("concenalarmlowerlimit") %></td>
	     <td><%=psWaterOutputSet.get("concenalarmupperlimit") %></td>
	     <td><%=psWaterOutputSet.get("status") %></td>
	   </tr>
    <%}%>
   </table>
--%>

