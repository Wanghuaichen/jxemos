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
     <td width="10%" class="tdtitle">污染源名称</td>
     <td width="20%"><%=psBaseInfoList.get("psname")%></td>
     <td width="10%" class="tdtitle">法定代表人</td>
     <td width="20%"><%=psBaseInfoList.get("corporationname")%></td>
     <td width="10%" class="tdtitle">法人代码</td>
     <td width="20%" ><%=psBaseInfoList.get("corporationcode")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">污染源地址</td>
     <td colspan="5"><%=psBaseInfoList.get("psaddress")%></td>
   </tr>
   </table>
   <br/>
   <table border=0 cellspacing=1 >
   <tr> 
     <td width="10%" class="tdtitle">行政区划</td>
     <td width="20%"><%=psBaseInfoList.get("area_name")%></td>
     <td width="10%" class="tdtitle">录属关系</td>
     <td width="20%"><%=psBaseInfoList.get("subjection_relation")%></td>
     <td width="10%" class="tdtitle">行业类别</td>
     <td width="20%"><%=psBaseInfoList.get("trace_name")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">注册类型</td>
     <td width="20%"><%=psBaseInfoList.get("enterprise_type")%></td>
     <td width="10%" class="tdtitle">单位类别</td>
     <td width="20%"><%=psBaseInfoList.get("company_type")%></td>
     <td width="10%" class="tdtitle">污染源规模</td>
     <td width="20%"><%=psBaseInfoList.get("station_size")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">总占地面积(㎡)</td>
     <td width="20%"><%=psBaseInfoList.get("totalarea")%></td>
     <td width="10%" class="tdtitle">污染源类别</td>
     <td width="20%"><%=psBaseInfoList.get("resource_type")%></td>
     <td width="10%" class="tdtitle">是否30万千瓦电力企业</td>
     <td width="20%">
     <%if(psBaseInfoList.get("ifthirtytenthousandkilowat").equals("1")){%>
     	是
     <%}else{ %>
     	否
     <%} %>
     </td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">投产日期</td>
     <td width="20%"><%=psBaseInfoList.get("rundate")%></td>
     <td width="10%" class="tdtitle">关注程度</td>
     <td width="20%"><%=psBaseInfoList.get("attention_level")%></td>
     <td width="10%" class="tdtitle">地区代码</td>
     <td width="20%"><%=psBaseInfoList.get("area_name")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">流域</td>
     <td width="20%"><%=psBaseInfoList.get("valley_name")%></td>
     <td width="10%" class="tdtitle">建设状态</td>
     <td  colspan="3"><%=psBaseInfoList.get("status")%></td>
   </tr>
   </table>
   <br/>
   <table border=0 cellspacing=1 >
    <tr> 
     <td width="10%" class="tdtitle">通讯地址</td>
     <td  colspan="5"><%=psBaseInfoList.get("communicateaddr")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">邮政编码</td>
     <td width="20%"><%=psBaseInfoList.get("postalcode")%></td>
     <td width="10%" class="tdtitle">联系人</td>
     <td width="20%"><%=psBaseInfoList.get("linkman")%></td>
     <td width="10%" class="tdtitle">电子邮箱</td>
     <td width="20%"><%=psBaseInfoList.get("email")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">办公电话</td>
     <td width="20%"><%=psBaseInfoList.get("officephone")%></td>
     <td width="10%" class="tdtitle">移动电话</td>
     <td width="20%"><%=psBaseInfoList.get("mobilephone")%></td>
     <td width="10%" class="tdtitle">传真</td>
     <td width="20%"><%=psBaseInfoList.get("fax")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">污染源网址</td>
     <td width="20%"><%=psBaseInfoList.get("pswebsite")%></td>
     <td width="10%" class="tdtitle">中心经度</td>
     <td width="20%"><%=psBaseInfoList.get("longitude")%></td>
     <td width="10%" class="tdtitle">中心纬度</td>
     <td width="20%"><%=psBaseInfoList.get("latitude")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">开户银行</td>
     <td width="20%"><%=psBaseInfoList.get("openaccountbank")%></td>
     <td width="10%" class="tdtitle">银行帐号</td>
     <td  colspan="3"><%=psBaseInfoList.get("bankaccount")%></td>
   </tr>
</table>
<br/>
<table border=0 cellspacing=1>
  <tr> 
     <td width="10%" class="tdtitle">污染源环保部门</td>
     <td width="20%"><%=psBaseInfoList.get("psenvironmentdept")%></td>
     <td width="10%" class="tdtitle">环保负责人</td>
     <td width="20%"><%=psBaseInfoList.get("environmentprincipal")%></td>
     <td width="10%" class="tdtitle">专职环保人员数</td>
     <td width="20%"><%=psBaseInfoList.get("environmentmans")%></td>
   </tr>
    <tr> 
     <td width="10%" class="tdtitle">备注</td>
     <td  colspan="5"><%=psBaseInfoList.get("pscomment")%></td>
   </tr>
</table>
</td>
</tr>
</table>
 <%}%>