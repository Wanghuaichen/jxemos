<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
  String user_name = (String)session.getAttribute("user_name");
  String user_id = request.getParameter("user_id");
  String sql = "update t_sys_user set user_pwd=? where user_id=?";
  String user_pwd = "123456";
  Object[]p = null;
  String md5 = null;
  String msg = null;
  try{
  if(!f.eq(user_name,"admin")){
   throw new Exception("只有admin才能进行此操作");
    
  }
  md5 = f.cfg("md5","0");
  if(f.eq(md5,"1")){
  user_pwd = f.md5(user_pwd);
  }
  p = new Object[]{user_pwd,user_id};
  f.update(sql,p);
   msg = "密码已重置";
  
  }catch(Exception e){
    //w.error(e);
    msg = e.getMessage();
    //return;
  }
//String user_id = request.getParameter("user_id");

%>

<div style='width:100%;height:100px'></div>
<div style="font-size:15px;font-weight:bold">
<%=msg%>
</div>












