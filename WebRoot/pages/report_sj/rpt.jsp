<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
   String station_type; 
   
   try{
    station_type = request.getParameter("station_type");
   Check.station_report(request);
   
     if(f.eq(station_type,"1")){
       w.fd("water.jsp");
     }else{
      w.fd("gas.jsp");
     }
    }catch(Exception e){
     w.error(e);
     return;
    }
%>