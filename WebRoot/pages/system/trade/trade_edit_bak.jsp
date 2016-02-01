<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
String sql = null;
Map dynaBean = null;
String objectid = null;
String msg = null;
try{
objectid = JspUtil.getParameter(request,"objectid");
sql = "select * from t_cfg_trade where trade_id='"+objectid+"'";
dynaBean = DBUtil.queryOne(sql,null,request);
if(dynaBean==null){
 //out.println("指定的记录不存在 objectid="+objectid);
 msg = "指定的记录不存在 objectid="+objectid;
 JspUtil.go2error(request,response,msg);
return;
}
}catch(Exception e){
JspUtil.go2error(request,response,e);
return;
}
%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
.btn {
	background: #58b044;
	border: 1px solid #459830;
	padding: 0 15px;
	height: 20px;
	cursor: pointer;
	color: #fff;
	border-radius: 3px;
	line-height: 20px;
}
td{font-size: 12px}
</style>
</head>

<body>
<form name="form1" method="post" action="trade_update.jsp">
<input type=hidden name=objectid    value="<%=JspUtil.get(dynaBean,"trade_id","")%>">
<table border="0" cellspacing="1">
   <tr class=tr0>
<td  class='tdtitle'>行业编号</td>
<td class=left>
<input type="text" name="trade_id"  style="width: 220px" readonly   value="<%=JspUtil.get(dynaBean,"trade_id","")%>">
</td>
</tr>


<tr class=tr1>
<td  class='tdtitle'>行业名称</td>
<td class=left>
<input type="text" name="trace_name" style="width: 220px"   value="<%=JspUtil.get(dynaBean,"trace_name","")%>">
<%=App.require()%>
</td>
</tr>



<tr class=tr0>
<td  class='tdtitle'>描述</td>
<td class=left>
<input type="text" name="trade_desc"   style="width: 220px"  value="<%=JspUtil.get(dynaBean,"trade_desc","")%>">
</td>
</tr>




<tr class=tr1>
      <td class='tdtitle'></td>
      <td class=left>
     
 <input type="button"  value="保存" class=btn onclick="f_update()">
     <input type="button"  value="删除" class=btn onclick="f_del()">
      <input type="button"  value="返回" onclick="history.back()" class=btn>
 </td>
    </tr>
</table>
</form>
</body>
</html>




<script>

function f_update(){
form1.action="trade_update.jsp";
form1.submit();
}


function f_del(){
var msg = "您确认要删除吗?";
if(!confirm(msg)){return;}
form1.action="trade_del.jsp";
form1.submit();
}


</script>






