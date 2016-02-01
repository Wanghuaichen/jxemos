<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
  
  Map map = null;
  String objectid = request.getParameter("objectid");
   String sql = "select * from t_sys_user where user_id='"+objectid+"'";
  String msg = null;
  
  try{
   map=DBUtil.queryOne(sql,null,request);
   if(map==null){
    //out.println("指定的记录不存在 objectid="+objectid);
    msg = "指定的记录不存在 objectid="+objectid;
   JspUtil.go2error(request,response,msg);
    return;
    }
   }catch(Exception e){
   //out.println(e);
   JspUtil.go2error(request,response,e);
   return;
   }
   
%>


<form name=form1 method=post action="user_pwd_update.jsp">
<input type="hidden" name="user_id" value="<%=map.get("user_id")%>">
<table border=0 cellspacing=1>

<tr>
<td>用户名</td>
<td class=left>
&nbsp; 
<input type="text" name="user_name" readonly value="<%=map.get("user_name")%>">
</td>
</tr>

<tr>
<td>用户密码</td>
<td class=left>
&nbsp; 
<input type="password" name="user_pwd" value="<%=map.get("user_pwd")%>">
<%=App.require()%>
</td>
</tr>


<tr>
<td>重复密码</td>
<td class=left>
&nbsp; 
<input type="password" name="user_pwd2" value="<%=map.get("user_pwd")%>">
<%=App.require()%>
</td>
</tr>

<tr>
<td>用户说明</td>
<td class=left>
&nbsp; 
<input type="text" name="user_desc" readonly value="<%=map.get("user_desc")%>">
</td>
</tr>

<tr>
<td></td>
<td class=left>
&nbsp;
<input type="submit" value="保存" class="btn">
<input type="button" value="返回" onclick="history.back()" class="btn">
</td>
</tr>
</table>
</form>