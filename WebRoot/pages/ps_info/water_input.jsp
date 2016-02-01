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

   // RowSet psWaterInputSet;
    Map m = null;
    XBean b = null;
    String id,m_time,m_value;
    try{
    
      lshUpdate.getPsWaterInput(request);
      m = (Map)request.getAttribute("psWaterInput");
      b = new XBean(m);
    //  psWaterInputSet = w.rs("psWaterInputSet");
    }catch(Exception e){
     w.error(e);
     return;
    }
   
%>

  <table border=0 cellspacing=1 >
   <tr> 
     <td width="10%" class="tdtitle">进水口名称</td>
     <td width="20%"><%=b.get("inputname")%></td>
     <td width="10%" class="tdtitle">进水口位置</td>
     <td width="20%"><%=b.get("inputposition")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">经度</td>
     <td width="20%"><%=b.get("longitude")%></td>
     <td width="10%" class="tdtitle">纬度</td>
     <td width="20%"><%=b.get("latitude")%></td>
   </tr>
   <tr> 
     <td width="10%" class="tdtitle">集纳范围</td>
     <td width="20%"><%=b.get("acceptrange")%></td>
     <td width="10%" class="tdtitle">状态</td>
     <td width="20%">
	<%if(b.get("status").equals("1")){%>
     	在用
     <%}else{ %>
     	停用
     <%} %>
	</td>
   </tr>
   </table>
   <%-- 
<br/>
<table border=0 cellspacing=1 >
   <tr class="title"> 
     <td>污染物名称</td>
     <td>浓度报警下限</td>
     <td>浓度报警上限</td>
     <td>状态</td>
   </tr>
   <%while(psWaterInputSet.next()){%>
	   <tr> 
	     <td><%=psWaterInputSet.get("pollutantcode") %></td>
	     <td><%=psWaterInputSet.get("chromaalarmupperlimit") %></td>
	     <td><%=psWaterInputSet.get("chromaalarmlowerlimit") %></td>
	     <td><%=psWaterInputSet.get("status") %></td>
	   </tr>
    <%}%>
   </table>
--%>

