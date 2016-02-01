<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

   try{
      Demo.view(request);
      //response.sendRedirect("query.jsp");
   }catch(Exception e){
      w.error(e);
      return;
   }
   XBean b = w.b("user");
%>
<form name=form1 method=post action=update.jsp>
<table border=0 cellspacing=1>

 <tr>
    <td class=title>用户ID</td>
    <td><input type='text' name='user_id' value='<%=b.get("user_id")%>'></td>
  </tr>
  

  <tr>
    <td class=title>用户名</td>
    <td><input type='text' name='user_name' value='<%=b.get("user_name")%>'></td>
  </tr>
  
    <tr>
    <td class=title>生日</td>
    <td><input type='text' name='birth_day' value='<%=f.sub(b.get("birth_day"),0,19)%>' style='width:200px'></td>
  </tr>
  
    <tr>
    <td class=title>身高</td>
    <td><input type='text' name='hh' value='<%=b.get("hh")%>'></td>
  </tr>
  
    <tr>
    <td class=title>体重</td>
    <td><input type='text' name='ww' value='<%=b.get("ww")%>'></td>
  </tr>
  
    <tr>
    <td class=title></td>
    <td><input type='submit' value='保存'></td>
  </tr>
</table>
</form>