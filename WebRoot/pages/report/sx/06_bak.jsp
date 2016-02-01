<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
      String q_col,toc_col,ph_col,cod_col = null;
      String f = "0.##";
      double r = 1000;
   try{
   
    action = new SxReport();
    action.run(request,response,"rpt06");
   q_col = w.p("q_col");
   toc_col = w.p("toc_col");
   cod_col = w.p("cod_col");
   ph_col = w.p("ph_col");
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   RowSet rs = w.rs("data");
   
   
%>
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
<div id='div_excel_content'>
<div  style="font-size:18px;font-weight:bold;text-align:center">
 <%=SxReportUtil.getTitleTime(request)%> ��ˮ���߼��������ͳ�Ʊ���
</div>


<table border=0 cellspacing=1>

<tr class=title>
<td rowspan=2>���</td>
<td rowspan=2>����</td>
<td colspan=5>��������</td>
<td colspan=5>COD����</td>
<%--<td colspan=5>TOC����</td>--%>
<td colspan=5>PH</td>
<td rowspan=2>ƽ�������(%)</td>
</tr>

<tr class=title>

<td>Ӧ�ø���</td>	
<td>ʵ�ø���</td>		
<td>ȱʧ����	</td>	
<td>�����	</td>	
<td>ȱʧԭ��</td>	


<td>Ӧ�ø���</td>	
<td>ʵ�ø���</td>		
<td>ȱʧ����	</td>	
<td>�����	</td>	
<td>ȱʧԭ��</td>	


<%--<td>Ӧ�ø���</td>	
<td>ʵ�ø���</td>		
<td>ȱʧ����	</td>	
<td>�����	</td>	
<td>ȱʧԭ��</td>	--%>


<td>Ӧ�ø���</td>	
<td>ʵ�ø���</td>		
<td>ȱʧ����	</td>	
<td>�����	</td>	
<td>ȱʧԭ��</td>	





</tr>

<%while(rs.next()){%>
<tr>
   <td><%=rs.getIndex()+1%></td>
   <td><%=rs.get("station_desc")%></td>
   
   <td><%=rs.get(q_col+"_num_all")%></td>
   <td><%=rs.get(q_col+"_num")%></td>
   <td><%=rs.get(q_col+"_num_no")%></td>
   <td><%=rs.get(q_col+"_r",1,f)%></td>
   <td></td>
   
     <td><%=rs.get(cod_col+"_num_all")%></td>
   <td><%=rs.get(cod_col+"_num")%></td>
   <td><%=rs.get(cod_col+"_num_no")%></td>
   <td><%=rs.get(cod_col+"_r",1,f)%></td>
   <td></td>
   
   <%--<td><%=rs.get(toc_col+"_num_all")%></td>
   <td><%=rs.get(toc_col+"_num")%></td>
   <td><%=rs.get(toc_col+"_num_no")%></td>
   <td><%=rs.get(toc_col+"_r",1,f)%></td>
   <td></td> --%>
   
  <td><%=rs.get(ph_col+"_num_all")%></td>
   <td><%=rs.get(ph_col+"_num")%></td>
   <td><%=rs.get(ph_col+"_num_no")%></td>
   <td><%=rs.get(ph_col+"_r",1,f)%></td>
   <td></td>
   
   <td><%=rs.get("r_avg",1,f)%></td>
   </tr>
   <%}%>


</table>
</div>