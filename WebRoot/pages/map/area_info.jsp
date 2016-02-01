<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp" %>
<%
        try{
    
      JspAction.area_info(request);
      
      }catch(Exception e){
      JspUtil.go2error(request,response,e);
      return;
      }
 
  
%>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="0">
<style>
body{
font-size:13px;
margin-top: 5px;
 margin-left: 5px;
 background-color:#F7F7F7;
 line-height:20px;
 text-align:left;
}

</style>


<form name=form1>
<input type=hidden name=area_id value="<%=w.get("area_id")%>">

<b><%=w.get("area_name")%></b>
<!--<a href='all_area_info.jsp' target='new'>全部</a>-->
<br>

<input type=radio name=system_type value=1 <%=w.get("flag1")%> onclick=form1.submit()>
环境质量 


<input type=radio name=system_type value=2  <%=w.get("flag2")%>  onclick=form1.submit()>
污染源 

</form>

<b><%=w.get("name1")%></b><br><br>

<!--
监测点(位)数 54 <br>
脱机数 53 <br>
连机数 1 <br>
报警记录数 0 <br>
实时记录数 3 <br>
时均值记录数 0 <br>
-->
<%=w.get("0")%>

<br><b><%=w.get("name2")%></b><br><br>

<!--
监测点(位)数 54 <br>
脱机数 53 <br>
连机数 1 <br>
报警记录数 0 <br>
实时记录数 3 <br>
时均值记录数 0 <br>
-->
<%=w.get("1")%>
<!--
<br><b>噪声</b><br><br>


监测点(位)数 54 <br>
脱机数 53 <br>
连机数 1 <br>
报警记录数 0 <br>
实时记录数 3 <br>
时均值记录数 0 <br>

<%=w.get("2")%>
-->

