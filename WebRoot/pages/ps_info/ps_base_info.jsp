<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.ps.*" %>
<style>
td{
text-align:left;
}
</style>
<%

    RowSet psBaseInfoList;
    String id,m_time,m_value;
    try{
    
      lshUpdate.getPsBaseInfo(request);
    
    }catch(Exception e){
     w.error(e);
     return;
    }
    psBaseInfoList = w.rs("psBaseInfoList");
%>
<%while(psBaseInfoList.next()){%>
<table border=0 cellspacing=0 style="width:100%;height:100%">
<tr>
<td class="top" style="height:50%">
<table border=0 cellspacing=1 >
   <tr> 
     <td width="10%" class="tdtitle">��ȾԴ����</td>
     <td width="20%"><%=psBaseInfoList.get("psname")%></td>
     <td width="10%" class="tdtitle">����������</td>
     <td width="20%"><%=psBaseInfoList.get("corporationname")%></td>
     <td width="10%" class="tdtitle">���˴���</td>
     <td width="20%" ><%=psBaseInfoList.get("corporationcode")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">��ȾԴ��ַ</td>
     <td colspan="5"><%=psBaseInfoList.get("psaddress")%></td>
   </tr>
   </table>
   <br/>
   <table border=0 cellspacing=1 >
   <tr> 
     <td width="10%" class="tdtitle">��������</td>
     <td width="20%"><%=psBaseInfoList.get("area_name")%></td>
     <td width="10%" class="tdtitle">¼����ϵ</td>
     <td width="20%"><%=psBaseInfoList.get("subjection_relation")%></td>
     <td width="10%" class="tdtitle">��ҵ���</td>
     <td width="20%"><%=psBaseInfoList.get("trace_name")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">ע������</td>
     <td width="20%"><%=psBaseInfoList.get("enterprise_type")%></td>
     <td width="10%" class="tdtitle">��λ���</td>
     <td width="20%"><%=psBaseInfoList.get("company_type")%></td>
     <td width="10%" class="tdtitle">��ȾԴ��ģ</td>
     <td width="20%"><%=psBaseInfoList.get("station_size")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">��ռ�����(�O)</td>
     <td width="20%"><%=psBaseInfoList.get("totalarea")%></td>
     <td width="10%" class="tdtitle">��ȾԴ���</td>
     <td width="20%"><%=psBaseInfoList.get("resource_type")%></td>
     <td width="10%" class="tdtitle">�Ƿ�30��ǧ�ߵ�����ҵ</td>
     <td width="20%">
     <%if(psBaseInfoList.get("ifthirtytenthousandkilowat").equals("1")){%>
     	��
     <%}else{ %>
     	��
     <%} %>
     </td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">Ͷ������</td>
     <td width="20%"><%=psBaseInfoList.get("rundate")%></td>
     <td width="10%" class="tdtitle">��ע�̶�</td>
     <td width="20%"><%=psBaseInfoList.get("attention_level")%></td>
     <td width="10%" class="tdtitle">��������</td>
     <td width="20%"><%=psBaseInfoList.get("area_name")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">����</td>
     <td width="20%"><%=psBaseInfoList.get("valley_name")%></td>
     <td width="10%" class="tdtitle">����״̬</td>
     <td  colspan="3"><%=psBaseInfoList.get("status")%></td>
   </tr>
   </table>
   <br/>
   <table border=0 cellspacing=1 >
    <tr> 
     <td width="10%" class="tdtitle">ͨѶ��ַ</td>
     <td  colspan="5"><%=psBaseInfoList.get("communicateaddr")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">��������</td>
     <td width="20%"><%=psBaseInfoList.get("postalcode")%></td>
     <td width="10%" class="tdtitle">��ϵ��</td>
     <td width="20%"><%=psBaseInfoList.get("linkman")%></td>
     <td width="10%" class="tdtitle">��������</td>
     <td width="20%"><%=psBaseInfoList.get("email")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">�칫�绰</td>
     <td width="20%"><%=psBaseInfoList.get("officephone")%></td>
     <td width="10%" class="tdtitle">�ƶ��绰</td>
     <td width="20%"><%=psBaseInfoList.get("mobilephone")%></td>
     <td width="10%" class="tdtitle">����</td>
     <td width="20%"><%=psBaseInfoList.get("fax")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">��ȾԴ��ַ</td>
     <td width="20%"><%=psBaseInfoList.get("pswebsite")%></td>
     <td width="10%" class="tdtitle">���ľ���</td>
     <td width="20%"><%=psBaseInfoList.get("longitude")%></td>
     <td width="10%" class="tdtitle">����γ��</td>
     <td width="20%"><%=psBaseInfoList.get("latitude")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">��������</td>
     <td width="20%"><%=psBaseInfoList.get("openaccountbank")%></td>
     <td width="10%" class="tdtitle">�����ʺ�</td>
     <td  colspan="3"><%=psBaseInfoList.get("bankaccount")%></td>
   </tr>
</table>
<br/>
<table border=0 cellspacing=1>
  <tr> 
     <td width="10%" class="tdtitle">��ȾԴ��������</td>
     <td width="20%"><%=psBaseInfoList.get("psenvironmentdept")%></td>
     <td width="10%" class="tdtitle">����������</td>
     <td width="20%"><%=psBaseInfoList.get("environmentprincipal")%></td>
     <td width="10%" class="tdtitle">רְ������Ա��</td>
     <td width="20%"><%=psBaseInfoList.get("environmentmans")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">��ע</td>
     <td  colspan="5"><%=psBaseInfoList.get("pscomment")%></td>
   </tr>
</table>
</td>
</tr>
</table>
 <%}%>