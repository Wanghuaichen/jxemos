<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<link href="/<%=JspUtil.getCtx(request)%>/styles/css1.css" rel="stylesheet" type="text/css">
<body scroll=no>
<form name="form1" method="post" action="tab_dept_insert.jsp">

  <table border="0" cellspacing="1">


<tr class=tr1>
<td class='tdtitle'>��������</td>
<td class=left>
<input type="text" name="dept_name">
<%=App.require()%>
</td>
</tr>

<tr class=tr0>
<td class='tdtitle'>����</td>
<td class=left>
<input type="text" name="dept_desc">
</td>
</tr>


<tr class=tr1>
      <td class='tdtitle'></td>
      <td class=left>
<input type="submit" name="Submit" value=" �� �� " class=btn>
    <input type="button" name="Submit2" value=" �� �� " onclick="history.back()" class=btn>
  </td>
    </tr>
 </table>
</form>
<br></div>
</body>
</html>




