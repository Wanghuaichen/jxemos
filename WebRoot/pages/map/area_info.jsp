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
<!--<a href='all_area_info.jsp' target='new'>ȫ��</a>-->
<br>

<input type=radio name=system_type value=1 <%=w.get("flag1")%> onclick=form1.submit()>
�������� 


<input type=radio name=system_type value=2  <%=w.get("flag2")%>  onclick=form1.submit()>
��ȾԴ 

</form>

<b><%=w.get("name1")%></b><br><br>

<!--
����(λ)�� 54 <br>
�ѻ��� 53 <br>
������ 1 <br>
������¼�� 0 <br>
ʵʱ��¼�� 3 <br>
ʱ��ֵ��¼�� 0 <br>
-->
<%=w.get("0")%>

<br><b><%=w.get("name2")%></b><br><br>

<!--
����(λ)�� 54 <br>
�ѻ��� 53 <br>
������ 1 <br>
������¼�� 0 <br>
ʵʱ��¼�� 3 <br>
ʱ��ֵ��¼�� 0 <br>
-->
<%=w.get("1")%>
<!--
<br><b>����</b><br><br>


����(λ)�� 54 <br>
�ѻ��� 53 <br>
������ 1 <br>
������¼�� 0 <br>
ʵʱ��¼�� 3 <br>
ʱ��ֵ��¼�� 0 <br>

<%=w.get("2")%>
-->

