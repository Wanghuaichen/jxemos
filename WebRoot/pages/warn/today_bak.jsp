<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
   BaseAction action = null;
   String date1, date2 = null;

   date1 = request.getParameter("date1");
   date2 = request.getParameter("date2");

   try{
    action = new WarnAction();
    action.run(request,response,"today");

   }catch(Exception e){
      w.error(e);
      return;
   }

   RowSet rs1 = w.rs("warn");//报警数据
   RowSet rs2 = w.rs("infectantList");//监测因子
   String v,col = null;
   String station_id,m_time = null;
   int index = 0;
   String total = null;
   String snum  =null;


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title></title>
<link href="../../styles/reset-min.css" rel="stylesheet" type="text/css" />
<link href="../../styles/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<link href="../../styles/common/common.css" rel="stylesheet" type="text/css" />
<link href="../../styles/common/select1.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../scripts/core/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.core.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.widget.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.tabs.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.check.js"></script>
<script type="text/javascript" src="../../scripts/jSelect/jselect.js"></script>
<script type="text/javascript" src="../../scripts/common.js"></script>
</head>
<body style="background-color: #f7f7f7;overflow-x:hidden">
<div id='div_excel_content' class="tableSty1" >
<table width="100%" border="1" cellspacing="0" cellpadding="0"  >
<tr style="position: relative; top: expression(this.offsetParent.scrollTop);margin-top:-6">
    <th>序号</th>
    <th style="width:120px">站位名称</th>
    <th>报警次数</th>
    <%while(rs2.next()){
       if(!rs2.get("infectant_name").equals("流量2"))
     	{

    %>
    <th title="<%=rs2.get("infectant_unit")%>">
        <%=rs2.get("infectant_name")%>
        <!--
        <br>
        <%=rs2.get("infectant_unit")%>
        -->

     </th>
    <%}
     }
    %>
   <th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
</tr>

  <%while(rs1.next()){

   if(!rs1.get("infectant_name").equals("流量2"))
   {

    station_id = rs1.get("station_id");
    //m_time = rs1.get("m_time");
    total = rs1.get("total");
    if(f.getDouble(total,0)<1){continue;}
    index++;
  %>
  <tr>
        <td><%=index%></td>
        <td><%=rs1.get("station_desc")%></td>
        <td><%=rs1.get("total")%></td>
        <%
        	rs2.reset();
        	while(rs2.next()){
        	   if(!rs2.get("infectant_name").equals("流量2")){
	        	col = rs2.get("infectant_column");
	        	//System.out.println(rs2.get("infectant_name"));
	        	if(col==null){col="";}
	        	//System.out.println(col);
	        	col=col.toLowerCase();//因子字段列名
	        	v = rs1.get(col);
	        	//v= f.format(v,"#.####");
	        	if(f.getDouble(v,0)<1){v="";}
        	%>
        	<td><%=v%></td>
        	<%}
        	  }
        	%>

        	<td><a href="javascript:f_view('<%=station_id%>')">历史报警数据</a></td>
  </tr>
  <%}
   }
  %>
</table>
</div>
</body>
</html>

<script>
function f_msg(station_id,m_time){
 //alert(station_id+","+m_time);
 var url = "msg.jsp?station_id="+station_id+"&m_time="+m_time;
  window.open(url,"","width=500,height=300");
}


function f_view(station_id){
 //alert(station_id+","+m_time);
 var url = "view.jsp?station_id="+station_id+"&date1=<%=date1%>&date2=<%=date2%>";
  window.open(url,"","width=760,height=500,scrollbars=yes");
}

</script>
