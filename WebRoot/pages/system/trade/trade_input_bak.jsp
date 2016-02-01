<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="../../../web/index.css" />
<style type="text/css">
.tiaojianbutton {
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



	<form name="form1" method="post" action="trade_insert.jsp">

		<table>





			<tr class=tr1>
				<td class='tdtitle'>行业名称</td>
				<td class=left><input type="text" style="width: 220px"  name="trace_name" > <%=App.require()%>
				</td>
			</tr>



			<tr class=tr1>
				<td class='tdtitle'>行业说明</td>
				<td class=left><input type="text" style="width: 220px" name="trade_desc">
				</td>
			</tr>






		</table>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="submit" name="Submit" class="tiaojianbutton"
			value=" 保 存 "> &nbsp;&nbsp;&nbsp;<input type="button" name="Submit2"
			value=" 返 回 " class="tiaojianbutton" onclick="history.back()">
	</form>
	<br>
</body>
</html>




