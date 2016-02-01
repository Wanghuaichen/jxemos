<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>

<%
String sql = null;
Connection cn = null;
Properties prop = null;
String user_id = null;
String user_pwd = null;
String user_pwd2 = null;

Map map = null;
String t = "t_sys_user";
String cols="user_id,user_pwd";
String msg = null;
String back = "<input type=button value='返回' onclick=history.back() class=btn>";
try{

prop = JspUtil.getReqProp(request);


user_pwd =prop.getProperty("user_pwd","");
user_pwd2 =prop.getProperty("user_pwd2","");


if(user_pwd.length()<5 || user_pwd.length()>20){
msg = "密码长度为5到20个字符";
JspUtil.go2error(request,response,msg);
return;
}

if(!StringUtil.equals(user_pwd,user_pwd2)){
msg = "输入的密码不一致，请重新输入";
JspUtil.go2error(request,response,msg);
return;
}


DBUtil.updateRow(t,cols,prop,request);
out.println("<br><br><center>用户密码已成功修改 "+back);
}catch(Exception e){
JspUtil.go2error(request,response,e);
return;
}
%>

<form name=form1 method="post" action="user_query.jsp">

</form>
<script>

//form1.submit();
</script>


