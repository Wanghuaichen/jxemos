<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

    RowSet data,flist;
    String id,m_time,m_value;
    SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    try{
    
      SwjUpdate.real(request);
    }catch(Exception e){
     w.error(e);
     return;
    }
    data = w.rs("data");
    flist = w.rs("flist");
    //boolean iswry = f.iswry(w.get("station_type"));
 
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
</head>
<body>
<div class="tableSty1 view3" style="overflow: hidden;margin-top: -6px">

<table width="100%" border="1" cellspacing="0" cellpadding="0" >
   <tr class=title style="position: relative; top: expression(this.offsetParent.scrollTop);"> 
     <th width=40px>序号</th>
     <th width=220px>监测时间</th>
     <%while(flist.next()){%>
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
     <%}}%>
     
   </tr>
   
   <%while(data.next()){
     flist.reset();
     
   %>
   <tr>
      <td><%=data.getIndex()+1%></td>
      <td><%=format.format(format.parse(data.get("m_time").toString()))%></td>
      <%while(flist.next()){
        id = flist.get("infectant_id");
        m_value=data.get(id);
        m_value=f.v(m_value);
          m_value=f.format(m_value,"0.#####");
      %>
      <%
      if(request.getParameter("zh_flag").equals("yes")){
      if(flist.get("infectant_id").equals(request.getParameter("infectant_id"))){ %>
      <td><%=m_value%></td>
      <%}}else{%>
      <td><%=m_value%></td>
      <%}}%>
    </tr>
   <%}%>
   
   
   
</table>