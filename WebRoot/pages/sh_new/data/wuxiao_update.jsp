<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.search.*" %>
<%
 	Map model = null;
 	 String sql = "update T_MONITOR_REAL_HOUR_V set v_desc=?,v_flag='5',operator=? where station_id=? and m_time>=? and m_time<=? and v_flag !='5'";
 	 String date1,date2,hour1,hour2;
 try{
 
  String station_id = request.getParameter("station_id");
  String v_desc = java.net.URLDecoder.decode(request.getParameter("v_desc"),"UTF-8");

  	date1 = request.getParameter("date1");
	date2 = request.getParameter("date2");
	hour1 = request.getParameter("hour1");
	hour2 =request.getParameter("hour2");
	String user_name = (String)session.getAttribute("user_name");
	Timestamp t1 = f.time(date1+" "+hour1+":0:0");
	Timestamp t2 = f.time(date2+" "+hour2+":59:59");
    Object[]p=new Object[]{v_desc,user_name,station_id,t1,t2};
    Connection cn = DBUtil.getConn();
    DBUtil.update(cn,sql,p);
     Log.insertLog("编号为："+station_id+"的站位数据中从："+date1+" "+hour1+":0:0"+"到："+date2+" "+hour2+":59:59 的数据被标识为无效数据，无效原因为："+v_desc, request);
 
 }catch(Exception e){
      JspUtil.go2error(request,response,e);
      return;
      }
 

%>
<script>
alert("修改成功！");
</script>