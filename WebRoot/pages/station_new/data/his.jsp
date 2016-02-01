<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

    RowSet data,flist;
    String col,m_time,m_value;
    String l_value = "";//最后修改的值
    String min = "";
    String max = "";
    String cols = "station_id,data_table,date1,date2,date3,hour1,hour2,hour3,infectant_id,zh_flag,sh_flag_select";
	SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    try{
    
      SwjUpdate.his_station(request);
    }catch(Exception e){
     w.error(e);
     return;
    }
    data = w.rs("data");
    flist = w.rs("flist");
    
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>汇总信息</title>
<link href="../../../styles/reset-min.css" rel="stylesheet" type="text/css" />
<link href="../../../styles/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<link href="../../../styles/common/common.css" rel="stylesheet" type="text/css" />
<link href="../../../styles/common/select1.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../../scripts/core/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../../../scripts/core/jquery.ui.core.js"></script>
<script type="text/javascript" src="../../../scripts/core/jquery.ui.widget.js"></script>
<script type="text/javascript" src="../../../scripts/core/jquery.ui.tabs.js"></script>
<script type="text/javascript" src="../../../scripts/core/jquery.ui.check.js"></script>
<script type="text/javascript" src="../../../scripts/jSelect/jselect.js"></script>
<script type="text/javascript" src="../../../scripts/common.js"></script>

<style >
.btn{
  width:30px;
}

</style>

</head>
<body>
<div class="tableSty1 view3">
<form name=form1 method=post action='his.jsp'>
<%=f.hide(cols,request)%>
<table width="100%" border="1" cellspacing="1" cellpadding="1">
    <tr style="position: relative; top: expression(this.offsetParent.scrollTop);cursor: pointer;margin-top:-100px"> 
     <th width=40px>序号</th>
     <th style="width: 120px">监测时间</th>
     <%while(flist.next()){
     	if(!flist.get("infectant_name").equals("流量2"))
     	{
     %>
     <%
     if(request.getParameter("zh_flag").equals("yes")){
     if(flist.get("infectant_id").equals(request.getParameter("infectant_id"))){ %>
       <th>
       <%=flist.get("infectant_name")%>
       <%=flist.get("infectant_unit")%>
       </th>
     <%}}else{%>
      	<th>
	       <%=flist.get("infectant_name")%>
	       <%=flist.get("infectant_unit")%>
       </th>
     <%}}}%>
     
   </tr>
   
    <%while(data.next()){
     flist.reset();
     
   %>
   <tr>
      <td><%=data.getIndex()+1%></td>
      <td style="width: 120px"><%=format.format(format.parse(data.get("m_time").toString()))%></td>
      <%while(flist.next()){
        col = flist.get("infectant_column");
        if(col==null){col="";}
        col=col.toLowerCase();
        m_value=data.get(col);
        max ="";  min = "";
        if (m_value.indexOf(",") >= 0) {
       		String[] arr = m_value.split(",");
       		
       		//这个是原始的
       		//if(arr.length>=2){
       			//v = arr[0]+"["+arr[1]+"]";
       			//flag = 1;
       		//}else{
       			//v = arr[0];
       		//}
       		 if(arr.length>=1){
	           m_value=arr[0];
	           m_value = m_value.split(";")[0];
	         }
	         if(arr.length>=2){
	            min=arr[1];
	         }
	         if(arr.length>=3){
	            max=arr[2];
	         }
       }else{
       		m_value=f.v(m_value);
       }
        
        m_value=f.v(m_value);
        if(!flist.get("infectant_name").equals("流量2"))
        {
      %>
      <%
      if(request.getParameter("zh_flag").equals("yes")){
      if(flist.get("infectant_id").equals(request.getParameter("infectant_id"))){ %>
      <td title="最大值(<%=max %>)最小值(<%=min %>)" style="cursor: pointer;"><%=m_value%></td>
      <%}}else{%>
      <td title="最大值(<%=max %>)最小值(<%=min %>)" style="cursor: pointer;"><%=m_value%></td>
      <%}}}%>
    </tr>
   <%}%>
   
   <tr><td class=right colspan=100><%=w.get("bar")%></td></tr>
</table>

</form>
</div>
</body>
</html>