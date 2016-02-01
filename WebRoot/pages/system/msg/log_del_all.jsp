<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
  String sql = null;
  String date1,date2 = null;
   String log_id = null;
   
  
  try{
    log_id = w.p("log_id");
    date1 = w.p("date1");
    date2 = w.p("date2");
    
    sql = "truncate table t_sys_msg_log";
    f.update(sql,null);
    String url = "log.jsp?date1="+date1+"&date2="+date2;
    response.sendRedirect(url);
  }catch(Exception e){
    w.error(e);
    return;
  }

%>