<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%


          try{
            SjReport.hzbb_water(request);
        
          }catch(Exception e){
            w.error(e);
            e.printStackTrace();
            return;
          }
          RowSet rs = w.rs("datalist");
          Map zongji = (Map)request.getAttribute("zongji");
          String date1 = request.getAttribute("date1")+"";
          String date2 = request.getAttribute("date2")+"";
          String format = "0.0000";
          int i =1;

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
<span style="text-align: center;font-size:16px;font-family: '华文中宋';width: 100%">报表为各个监测因子在<%=date1 %>到<%=date2 %>时间段内的排放量统计</span>
<table width="99%" border="1" cellspacing="0" cellpadding="0">


<thead>
  <tr style="font-size: 14px;text-align: center;background-color: #f7f7f7;cursor: pointer;" title="点击可排序">
    <th  style="font-size: 14px;width: 50px;">序号</th>
    <th  style="font-size: 14px">名称</th>
    <th style="font-size: 14px">COD(Kg)</th>
    <th style="font-size: 14px">氨氮(Kg)</th>
    <th style="font-size: 14px">总氮(Kg)</th>
    <th style="font-size: 14px">总磷(Kg)</th>
    <th style="font-size: 14px">累积流量(m<sup>3</sup>)</th>
  </tr>
</thead>
<tbody>
  <%
     while(rs.next()){

  %>
    <tr >
       <td style="width:50px"> <%=i++ %> </td>
       <td width="320px"> <%=rs.get("name") %> </td>
       <%--<td class="{sortValue: 0}"><%=rs.get("val02_q") %></td>
       <td class="{sortValue: 1}"><%=rs.get("val05_q")%></td>
       <td class="{sortValue: 2}"><%=rs.get("val17_q") %></td>
       <td class="{sortValue: 3}"><%=rs.get("val16_q")%></td>
       <td class="{sortValue: 4}"><%=rs.get("val04") %></td>--%>
    
      <td class="{sortValue: 0}"><%=f.format(f.getljll(rs.get("val02_q",1,format),"",1+"")+"","0.0000")%></td>
       <td class="{sortValue: 1}"><%=f.format(f.getljll(rs.get("val05_q",1,format),"",1+"")+"","0.0000")%></td>
       <td class="{sortValue: 2}"><%=f.format(f.getljll(rs.get("val17_q",1,format),"",1+"")+"","0.0000") %></td>
       <td class="{sortValue: 3}"><%=f.format(f.getljll(rs.get("val16_q",1,format),"",1+"")+"","0.0000")%></td>
       <td class="{sortValue: 4}"><%=f.format(f.getljll(rs.get("val04",1,format),"",1+"")+"","0.0000")%></td>
      
     </tr>
  <%
    }
  %>
  </tbody>
  <tr  style="font-size: 15px;text-align: left;font-weight: 700">
  <td > <%=i %> </td>
       <td > 总计 </td>
       <%--<td><%=zongji.get("z_val02_q") %></td>
       <td><%=zongji.get("z_val05_q")%></td>
       <td><%=zongji.get("z_val17_q") %></td>
       <td><%=zongji.get("z_val16_q")%></td>
       <td><%=zongji.get("z_val04") %></td>--%>
       
       <td><%=f.format(f.getljll(zongji.get("z_val02_q")+"","",1+"")+"","0.0000")%></td>
       <td><%=f.format(f.getljll(zongji.get("z_val05_q")+"","",1+"")+"","0.0000")%></td>
       <td><%=f.format(f.getljll(zongji.get("z_val17_q")+"","",1+"")+"","0.0000") %></td>
       <td><%=f.format(f.getljll(zongji.get("z_val16_q")+"","",1+"")+"","0.0000")%></td>
       <td><%=f.format(f.getljll(zongji.get("z_val04")+"","",1+"")+"","0.0000") %></td>
    </tr>


</table>

</div>
</body>
</html>