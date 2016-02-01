<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
  String sql = null;
  String date1,date2 = null;
   String log_id = null;
   String station_id,m_time,phone_no = null;
   Object[]p = null;
   
  
  try{
    log_id = w.p("log_id");
    date1 = w.p("date1");
    date2 = w.p("date2");
    station_id=w.p("station_id");
    m_time = w.p("m_time");
    phone_no = w.p("phone_no");
    m_time = f.sub(m_time,0,19);
    p = new Object[]{station_id,m_time,phone_no};
    sql = "delete from t_sys_msg_his where station_id=? and m_time=? and phone_no=?";
    f.update(sql,p);
    String url = "his.jsp?date1="+date1+"&date2="+date2;
    response.sendRedirect(url);
  }catch(Exception e){
    w.error(e);
    return;
  }

%>