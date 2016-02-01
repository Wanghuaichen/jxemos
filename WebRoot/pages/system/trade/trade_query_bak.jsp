<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
String sql = "select trade_id,trace_name,COMMENTS from t_cfg_trade";
String tableHtml = null;
String[]arr = null;
String pageBar = null;
Map map = null;

try{
/*
arr = PagedUtil.query(sql,request,1);
tableHtml=arr[0];
pageBar=arr[1];
*/
map =PagedUtil2.queryStringWithUrl(sql, 1,1,request);
tableHtml=(String)map.get("data");
pageBar=(String)map.get("page_bar");
}catch(Exception e){
JspUtil.go2error(request,response,e);
return;
}

%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../../../web/index.css"/>
<style type="text/css">
td{border-width: 0;
    line-height: 1.666;
    padding:8px;
    border-bottom:1px solid #eee;
    font-weight: bold;
    }
</style>
</head>


<body>


<form name=form1 method=post action="trade_query.jsp">

<input type=hidden name=objectid>&nbsp;<input type="button" value="添加行业" class="tiaojianbutton" onclick="f_input()" style="margin-top:0.25cm">

<table  class="nui-table-inner">

<thead class="nui-table-head">
<tr class=title>
<!--<td></td>-->

<th class="nui-table-cell">行业名称</th>

<th class="nui-table-cell">行业说明</th>


</tr>
</thead>
<%=tableHtml%>
</table>
<div class='page_bar' style="text-align: center;">
<%=pageBar%>
</div>
</form>


<script>
function f_input(){
form1.action="trade_input.jsp";
form1.submit();
}

function f_view_object(id){
form1.objectid.value=id;
form1.action="trade_edit.jsp";
form1.submit();
}

</script>





