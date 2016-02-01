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
<TITLE></TITLE>
<link href="../../styles/reset-min.css" rel="stylesheet" type="text/css" />
<link href="../../styles/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<link href="../../styles/common/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/scripts/jquery-latest.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/scripts/jquery.metadata.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/scripts/jquery.tablesorter.js"></script>

<script type="text/javascript">
	
	$(function() {
		$("table").tablesorter();
	});
	
		</script>	

</head>
<body style="background-color: #f7f7f7;overflow-x:hidden">
<div id="div_excel_content" class="tableSty1 view3">
<div class=title>

</div>
<table width="99%" border="1" cellspacing="1" cellpadding="1">
<br/>
<caption style="text-align: center;font-size:16px;font-family: '华文中宋'">报表为各个监测因子在<%=date1 %>到<%=date2 %>时间段内的排放量统计</caption>
<thead>
  <tr style="font-size: 14px;text-align: center;background-color: #f7f7f7;cursor: pointer;" title="点击可排序">
   <th  style="font-size: 14px">序号</th>
   <th style="font-size: 14px">名称</th>
   <th style="font-size: 14px">颗粒物(Kg)</th>
    <th style="font-size: 14px">SO<sub>2</sub>(Kg)</th>
    <th style="font-size: 14px">NO<sub>x</sub>(Kg)</th>
    <th style="font-size: 14px">累积流量(M<sup>3</sup>)</th>
  </tr>
</thead>
<tbody>
  <%
     while(rs.next()){
  %>
    <tr>
       <td width="50px"> <%=i++ %> </td>
       <td width="320px"> <%=rs.get("name") %> </td>
       <td><%=rs.get("val06_q") %></td>
       <td><%=rs.get("val05_q")%></td>
       <td><%=rs.get("val07_q") %></td>
       <td><%=rs.get("val11") %></td>
    </tr>
  <%
    }
  %>
  </tbody>
  <tr  style="font-size: 14px;text-align: left;background-color: #f7f7f7;font-weight: 700">
        <td width="20px"> <%=i %> </td>
       <td width=""> 总计 </td>
       <td><%=zongji.get("z_val06_q") %></td>
       <td><%=zongji.get("z_val05_q")%></td>
       <td><%=zongji.get("z_val07_q") %></td>
       <td><%=zongji.get("z_val11") %></td>
    </tr>

</table>
</div>
</body>
</html>
