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

   // RowSet psGasOutputSet;
    Map m = null;
    XBean b = null;
    String id,m_time,m_value;
    try{
    
      lshUpdate.getPsGasOutput(request);
      m = (Map)request.getAttribute("psGasOutput");
      b = new XBean(m);
    //  psGasOutputSet = w.rs("psGasOutputSet");
    }catch(Exception e){
     w.error(e);
     return;
    }
   
%>

  <table border=0 cellspacing=1 >
   <tr> 
     <td width="10%" class="tdtitle">�ŷſ�����</td>
     <td width="20%"><%=b.get("outputname")%></td>
     <td width="10%" class="tdtitle">�Ƿ�������</td>
     <td width="20%">
     <%if(b.get("iftwoarea").equals("1")){%>
     	��
     <%}else{ %>
     	��
     <%} %>
     </td>
     <td width="10%" class="tdtitle">����</td>
     <td width="20%"><%=b.get("longitude")%></td>
   </tr>
   <tr> 
   <td width="10%" class="tdtitle">�ŷſ�λ��</td>
     <td width="20%"><%=b.get("outputposition")%></td>
     <td width="10%" class="tdtitle">ȼ�Ϸ���</td>
     <td width="20%"><%=b.get("fuel_type")%></td>
     <td width="10%" class="tdtitle">γ��</td>
     <td width="20%"><%=b.get("latitude")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">������������</td>
     <td width="20%"><%=b.get("gas_function")%></td>
     <td width="10%" class="tdtitle">��־�ư�װ��ʽ</td>
     <td width="20%"><%=b.get("flag_install")%></td>
      <td width="10%" class="tdtitle">ȼ�շ�ʽ</td>
     <td width="20%"><%=b.get("burning_mode")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">�ŷſڸ߶�(��)</td>
     <td width="20%"><%=b.get("outputhigh")%></td>
     <td width="10%" class="tdtitle">�����ŷſ�����</td>
     <td width="20%"><%=b.get("gasoutput_type")%></td>
     <td width="10%" class="tdtitle">����������</td>
     <td width="20%"><%=b.get("twoarea_type")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">�����ھ�</td>
     <td width="20%"><%=b.get("outputdiameter")%></td>
     <td width="10%" class="tdtitle">�豸����</td>
     <td width="20%"><%=b.get("equipmentname")%></td>
     <td width="10%" class="tdtitle">ȼ���豸��;</td>
     <td width="20%"><%=b.get("burntequipment_user")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">�ŷŹ���</td>
     <td width="20%"><%=b.get("let_rule")%></td>
     <td width="10%" class="tdtitle">״̬</td>
     <td width="20%">
		<%if(b.get("status").equals("1")){%>
     		����
     	<%}else{ %>
     		ͣ��
     	<%} %>
	</td>
     <td width="10%" class="tdtitle">���乤������</td>
     <td width="20%"><%=b.get("workshopname")%></td>
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
   <%while(psGasOutputSet.next()){%>
	   <tr> 
	     <td><%=psGasOutputSet.get("pollutantcode") %></td>
	     <td><%=psGasOutputSet.get("exceptionminvalue") %></td>
	     <td><%=psGasOutputSet.get("exceptionmaxvalue") %></td>
	     <td><%=psGasOutputSet.get("concenalarmlowerlimit") %></td>
	     <td><%=psGasOutputSet.get("concenalarmupperlimit") %></td>
	     <td><%=psGasOutputSet.get("status") %></td>
	   </tr>
    <%}%>
   </table>
--%>

