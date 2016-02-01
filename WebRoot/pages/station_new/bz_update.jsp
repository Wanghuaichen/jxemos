<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="java.util.Date"%>
<%
   
   //String s = JspUtil.getRequestModel(request)+"";
   //out.println(s);
   String station_id = request.getParameter("station_id");
   String station_bz = JspUtil.getParameter(request,"station_bz");
   String sql = "update t_cfg_station_info set station_bz=? where station_id=?";
   SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
   Date d = new Date();
   Properties prop = JspUtil.getReqProp(request);
   String username = session.getAttribute("user_name").toString();
   Object[]p=new Object[]{station_bz,station_id};
   prop.setProperty("INSERT_TIME",format.format(d));
   prop.setProperty("username",username);
   prop.setProperty("INFO",station_bz);
   prop.setProperty("station_id",station_id);
   String cols="INSERT_TIME,username,INFO,station_id";
   try{
   DBUtil.update(sql,p,request);
   DBUtil.insert(DBUtil.getConn(request),"T_CFG_STATION_COMMENT",cols,prop);
   try{
        JspPageUtil.saveEvent(station_id,station_bz);
   }catch(Exception e2){
     //out.println(e2);
   }
   
   }catch(Exception e){
   //JspUtil.go2error(request,response,e);
   w.error(e);
   return;
   }
%>

<br><br><br>
站位备注信息已保存