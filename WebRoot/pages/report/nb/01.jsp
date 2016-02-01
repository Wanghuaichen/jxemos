<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
   try{
   
    action = new ReportNbAction();
    action.run(request,response,"rpt01");
   
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   RowSet rs = w.rs("data");
   int i,num=0;
   num = 24;
   
   
%>
<link rel="stylesheet" href="../../../web/index.css" />
<div id='div_excel_content'>
<!--
<div class=h2 align=right>
����ʱ��:<%=request.getParameter("date1")%>
</div>
-->
<table class="nui-table-inner major">
	<thead class="nui-table-head">
		<tr class="nui-table-row">
		  <th class="nui-table-cell" style="width:110">վλ����</th>
		   <th class="nui-table-cell" style="width:80">����</th>
		   <th class="nui-table-cell" style="width:60">ʱ��</th>
		  <%for(i=0;i<num;i++){%>
		   <th class="nui-table-cell"><%=i%></th>
		  <%}%>
		   <th class="nui-table-cell" style="width:50">�ѻ���</th>
		   <th class="nui-table-cell" style="width:50">������%</th>
		</tr>
	</thead>
	<tbody class="nui-table-body">
	<%while(rs.next()){%>
  <tr class="nui-table-row">
     <th class="nui-table-cell"><%=rs.get("station_desc")%></th>
     <th class="nui-table-cell"><%=rs.get("area_name")%> </th>
      <th class="nui-table-cell"><%=rs.get("m_time")%> </th>
    <%for(i=0;i<num;i++){%>
   <th class="nui-table-cell"><%=rs.get(i+"")%></th>
  <%}%>
    
     <th class="nui-table-cell"><%=rs.get("off")%></th>
     <th class="nui-table-cell"><%=rs.get("online")%></th>
  </tr>
  <%}%>
</tbody>
</div>