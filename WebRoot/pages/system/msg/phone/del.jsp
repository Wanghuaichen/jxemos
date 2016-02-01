<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
  String sql = null;
  Connection cn = null;
  String phone_no = null;
  
  try{
  
  phone_no=w.p("phone_no");
    sql = "delete from t_sys_msg_phone where phone_no='"+phone_no+"'";
    f.update(sql,null);
     sql = "delete from t_sys_msg_area_phone where phone_no='"+phone_no+"'";
    f.update(sql,null);
    response.sendRedirect("q.jsp");
  }catch(Exception e){
    w.error(e);
    return;
  }

%>