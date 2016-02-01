<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

          try{
             SjReport.hzbb_gas(request);
            
          }catch(Exception e){
            w.error(e);
            return;
          }
           RowSet rs = w.rs("datalist");
          Map zongji = (Map)request.getAttribute("zongji");
           String date1 = request.getAttribute("date1")+"";
          String date2 = request.getAttribute("date2")+"";
          int i=1;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<link rel="stylesheet" href="../../web/index.css"/>
<title>在线检测和监控管理系统</title>


</head>
<body >
<div id="div_excel_content">
<table class="nui-table-inner">
	<thead class="nui-table-head">
		<tr>	<th class="nui-table-cell" colspan="6">报表为各个监测因子在<%=date1 %>到<%=date2 %>时间段内的排放量统计</th></tr>
		<tr class="nui-table-row">
		<th  class="nui-table-cell">序号</th>
	   <th class="nui-table-cell">名称</th>
	   <th class="nui-table-cell">颗粒物(Kg)</th>
	    <th class="nui-table-cell">SO<sub>2</sub>(Kg)</th>
	    <th class="nui-table-cell">NO<sub>x</sub>(Kg)</th>
	    <th class="nui-table-cell">累积流量(M<sup>3</sup>)</th>
		</tr>
	</thead>
	<tbody class="nui-table-body">
		 <%
     while(rs.next()){
  %>
    <tr>
       <th class="nui-table-cell"> <%=i++ %> </th>
       <th class="nui-table-cell"> <%=rs.get("name") %> </th>
       <th class="nui-table-cell"><%=rs.get("val06_q") %></th>
       <th class="nui-table-cell"><%=rs.get("val05_q")%></th>
       <th class="nui-table-cell"><%=rs.get("val07_q") %></th>
       <th class="nui-table-cell"><%=rs.get("val11") %></th>
    </tr>
  <%
    }
  %>
   <tr>
       <th class="nui-table-cell"> <%=i %> </th>
       <th class="nui-table-cell"> 总计 </th>
       <th class="nui-table-cell"><%=zongji.get("z_val06_q") %></th>
       <th class="nui-table-cell"><%=zongji.get("z_val05_q")%></th>
       <th class="nui-table-cell"><%=zongji.get("z_val07_q") %></th>
       <th class="nui-table-cell"><%=zongji.get("z_val11") %></th>
    </tr>
	</tbody>

</table>
</div>
</body>
</html>
