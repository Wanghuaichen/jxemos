<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
       String[]colids = null;
      int coli,colidnum = 0;
      Map colMap = null;
   try{
   
    action = new FyReport();
   action.run(request,response,"rpt02");
   colids = request.getParameterValues("station_col_id");
   if(colids==null){colids=new String[0];}
   colidnum = colids.length;
   colMap = FyReportUtil.getStationColMap();
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   RowSet rs = w.rs("list");
   int i,num=0;
   num = 24;
   String key = null;
   
   
%>
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
<div id='div_excel_content'>
<div class=center style="font-size:18px;font-weight:bold">
 <%=w.get("yy")%> �� <%=w.get("mm")%>  �·����߼����ʩ���Ϸ���ʱ��ͳ�Ʊ�
</div>


<table border=0 cellspacing=1>
<tr class=title>
<td>���</td>
<td>վλ����</td>


    <%for(coli=0;coli<colidnum;coli++){%>
    <td><%=FyReportUtil.getStationColName(colMap,colids[coli])%></td>
    <%}%>



<td style="width:50px">��������</td>
<td style="width:500px">������ϸ����</td>
<td>��ע</td>

</tr>



<%while(rs.next()){%>
<tr>
  <td><%=rs.getIndex()+1%></td>
  <td><%=rs.get("station_desc")%></td>
  
  
 <%for(coli=0;coli<colidnum;coli++){%>
    <td><%=rs.get("val"+colids[coli])%></td>
    <%}%>
  
  
  <td><%=rs.get("gznum_all")%></td>
  
  <td><%=rs.get("gz_date")%></td>
  
  
  <td></td>
  
</tr>
<%}%>


</table>

</div>
