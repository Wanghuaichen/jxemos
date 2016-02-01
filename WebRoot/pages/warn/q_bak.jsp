<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
   try{
    action = new WarnAction();
    action.run(request,response,"hisq");
   
   }catch(Exception e){
      w.error(e);
      return;
   }
    String min = "";
    String max = "";
   RowSet rs1 = w.rs("data");
   RowSet rs2 = w.rs("infectant");
   String v,col = null;
   String station_id,m_time = null;
   
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
<body style="background-color: #f7f7f7">
<div id='div_excel_content' class="tableSty1" >
<table width="100%" border="1" cellspacing="0" cellpadding="0">

<tr>
    <th>序号</th>
    <th style="width:100px">监测时间</th>
    
    <%while(rs2.next()){%>
    <th title="<%=rs2.get("infectant_unit")%>">
        <%=rs2.get("infectant_name")%>
   
     </th>
    <%}%>
    <!--
   <th></th>
   -->
   
</tr>

  <%while(rs1.next()){
    station_id = rs1.get("station_id");
    m_time = rs1.get("m_time");
  %>
  <tr>
        <td><%=rs1.getIndex()+1%></td>
        <td><%=rs1.get("m_time")%></td>
        <%
        	rs2.reset();
        	min="";
        	max="";
        	while(rs2.next()){
        	col = rs2.get("infectant_column");
        	v = rs1.get(col);
        	//v= f.format(v,"#.####");//黄宝修改
        	if(!rs2.get("infectant_name").equals("流量2"))
	        {
	        min="";
        	max="";
	         String[] arr = v.split(",");
       		 if(arr.length>=1){
	           v=arr[0];
	           v = v.split(";")[0];
	         }
	         if(arr.length>=2){
	            min=arr[1];
	         }
	         if(arr.length>=3){
	            max=arr[2];
	         }
	       }else{
	       		v=f.v(v);
	       }
       	%>
       	<td title="最大值(<%=max %>)最小值(<%=min %>)" style="cursor: pointer;"><%=v%></td>
       	<%}%>
        	<!--
        	<td><a href="javascript:f_msg('<%=station_id%>','<%=m_time%>')">发送报警信息</a></td>
 -->
 
  </tr>
  <%}%>

  

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
</script>
