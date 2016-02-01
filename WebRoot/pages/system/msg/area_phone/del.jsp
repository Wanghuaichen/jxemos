<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
     String area_id=w.p("area_id");
     String phone_no = w.p("phone_no");
     String sql = null;
     Object[]params=null;
     try{
            sql = "delete from t_sys_msg_area_phone where area_id=? and phone_no=?";
            params=new Object[]{area_id,phone_no};
            f.update(sql,params);
            response.sendRedirect("q.jsp");
    
     }catch(Exception e){
      w.error(e);
      return;
     }
%>