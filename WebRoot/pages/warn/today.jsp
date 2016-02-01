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

   RowSet rs1 = w.rs("warn");//��������
   RowSet rs2 = w.rs("infectantList");//�������
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
<title>���߼��ͼ�ع���ϵͳ</title>
<link rel="stylesheet" href="../../web/index.css"/>
</head>
<body>
<div id='div_excel_content'>
<table class="nui-table-inner" >
<thead class="nui-table-head">
	<tr class="nui-table-row">
    <th class="nui-table-cell">���</th>
    <th class="nui-table-cell">վλ����</th>
    <th class="nui-table-cell">��������</th>
    <%while(rs2.next()){
       if(!rs2.get("infectant_name").equals("����2"))
     	{

    %>
    <th class="nui-table-cell" title="<%=rs2.get("infectant_unit")%>">
        <%=rs2.get("infectant_name")%>
        <!--
        <br>
        <%=rs2.get("infectant_unit")%>
        -->

     </th>
    <%}
     }
    %>
   <th class="nui-table-cell">&nbsp;&nbsp;&nbsp;&nbsp;</th>
	</tr>
</thead>
<tbody class="nui-table-body">
  <%while(rs1.next()){

   if(!rs1.get("infectant_name").equals("����2"))
   {

    station_id = rs1.get("station_id");
    //m_time = rs1.get("m_time");
    total = rs1.get("total");
    if(f.getDouble(total,0)<1){continue;}
    index++;
  %>
  <tr class="nui-table-row">
        <td class="nui-table-cell"><%=index%></td>
        <td class="nui-table-cell"><%=rs1.get("station_desc")%></td>
        <td class="nui-table-cell"><%=rs1.get("total")%></td>
        <%
        	rs2.reset();
        	while(rs2.next()){
        	   if(!rs2.get("infectant_name").equals("����2")){
	        	col = rs2.get("infectant_column");
	        	//System.out.println(rs2.get("infectant_name"));
	        	if(col==null){col="";}
	        	//System.out.println(col);
	        	col=col.toLowerCase();//�����ֶ�����
	        	v = rs1.get(col);
	        	//v= f.format(v,"#.####");
	        	if(f.getDouble(v,0)<1){v="";}
        	%>
        	<td class="nui-table-cell"><%=v%></td>
        	<%}
        	  }
        	%>

        	<td class="nui-table-cell"><a href="javascript:f_view('<%=station_id%>')">��ʷ��������</a></td>
  </tr>
  <%}
   }
  %>
  </tbody>
</table>
</div>
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
</body>
</html>