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
<link rel="stylesheet" href="../../web/index.css" />

</head>
<body>
<table class="nui-table-inner" width="70%" border="0" cellspacing="0" cellpadding="0">
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
  <thead class="nui-table-head">
		<tr id="trHead" class="nui-table-row">
			<th colspan=6 class="nui-table-cell" style="text-align:center;"><%=name%></th>
		</tr>
		 <tr class="nui-table-row">
		  <th class="nui-table-cell">地区</th>
		  <th class="nui-table-cell">站位数</th>
		  <th class="nui-table-cell">联机数</th>
		  <th class="nui-table-cell">脱机数</th>
		  <th class="nui-table-cell">实时记录数</th>
		  <th class="nui-table-cell">小时数据个数</th>
		 </tr>
		 </thead>
		 <tbody class="nui-table-body">
	<%while(rs.next()){%>
	 
	  <tr class="nui-table-row">
	    <td class="nui-table-cell"><%=rs.get("area_name")%></td>
	    <td class="nui-table-cell"><%=rs.get("station")%></td>
	    <td class="nui-table-cell"><%=rs.get("on")%></td>
	    <td class="nui-table-cell"><%=rs.get("off")%></td>
	    <td class="nui-table-cell"><%=rs.get("minute")%></td>
	    <td class="nui-table-cell"><%=rs.get("hour")%></td>
	  </tr>
	 <%}%>  
	<tr class="nui-table-row">
	  <td class="nui-table-cell">合计</td>
	  <td class="nui-table-cell"><%=station_num%></td>
	  <td class="nui-table-cell"><%=on_num%></td>
	  <td class="nui-table-cell"><%=off_num%></td>
	  <td class="nui-table-cell"><%=minite_num%></td>
	  <td class="nui-table-cell"><%=hour_num%></td>
	 </tr>
	
	<%}%>
	</tbody>
 </table>
</body>
</html>