<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.ps.*"%>
<%
        try{
    
      AreaInfo.area_info_all(request);
      
      }catch(Exception e){
      w.error(e);
      return;
      }
      String types="1,2,5,6";
      String[]arr=types.split(",");
      RowSet rs = null;
      XBean b = w.b("map");
      String type,name;
      int i,num=0;
      num=arr.length;
     
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>汇总信息</title>
<link href="../../styles/reset-min.css" rel="stylesheet" type="text/css" />
<link href="../../styles/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<link href="../../styles/common/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../scripts/core/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.core.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.widget.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.tabs.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.check.js"></script>
<script type="text/javascript" src="../../scripts/common.js"></script>

</head>
<body>
<div class="tableSty1">
<table width="70%" border="0" cellspacing="0" cellpadding="0">
 
<%for(i=0;i<num;i++){
  type=arr[i];
    rs = w.rs("list_"+type);
    name = b.get(type);
    int station_num = 0;
    int on_num = 0;
    int off_num = 0;
    int minite_num = 0;
    int hour_num = 0;
    while(rs.next()){
    	station_num = station_num+lshUpdate.getInt(rs.get("station"));
    	on_num = on_num+lshUpdate.getInt(rs.get("on"));
    	off_num = off_num+lshUpdate.getInt(rs.get("off"));
    	minite_num = minite_num+lshUpdate.getInt(rs.get("minute"));
    	hour_num = hour_num+lshUpdate.getInt(rs.get("hour"));
    }
    rs = w.rs("list_"+type);
  %>
   <tr><th colspan=6 style="font-size:18px"><%=name%></th></tr>
   
   
 <tr>
  <th>地区</th>
  <th>站位数</th>
  <th>联机数</th>
  <th>脱机数</th>
  <th>实时记录数</th>
  <th>小时数据个数</th>
 </tr>
 <%while(rs.next()){%>
 
  <tr>
    <td><%=rs.get("area_name")%></td>
    <td><%=rs.get("station")%></td>
    <td><%=rs.get("on")%></td>
    <td><%=rs.get("off")%></td>
    <td><%=rs.get("minute")%></td>
    <td><%=rs.get("hour")%></td>
  </tr>
 <%}%>  
<tr>
  <td>合计</td>
  <td><%=station_num%></td>
  <td><%=on_num%></td>
  <td><%=off_num%></td>
  <td><%=minite_num%></td>
  <td><%=hour_num%></td>
 </tr>

<%}%>
 </table>
 </div>
</body>
</html>