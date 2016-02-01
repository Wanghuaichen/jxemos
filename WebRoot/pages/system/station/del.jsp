<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
   String station_id = request.getParameter("station_id");
   String sql = "delete from t_cfg_station_info where station_id=?";
   try{
   
      f.update(sql,new Object[]{station_id});
      response.sendRedirect("q.jsp");
     
      }catch(Exception e){
      JspUtil.go2error(request,response,e);
      return;
      }
   
%>