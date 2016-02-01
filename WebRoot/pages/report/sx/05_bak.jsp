<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
      String q_col,so2_col,nox_col,pm_col = null;
      String f = "0.##";
      double r = 1000*1000;
       List list = null;
       String sort_col = null;
       
   try{
   
    action = new SxReport();
    action.run(request,response,"rpt05");
   q_col = w.p("q_col");
   so2_col = w.p("so2_col");
   nox_col = w.p("nox_col");
   pm_col = w.p("pm_col");
   sort_col = w.p("sort_col");
   

   }catch(Exception e){
      w.error(e);
      return;
   }
   //RowSet rs = w.rs("data");
   RowSet rs =null;
   list = (List)w.a("data");
   //System.out.println(list.size());
   if(list==null){list=new ArrayList();}
   RowCompare c = new RowCompare();
   //c.setCompareCol(sort_col+"_p_over");
   c.setCompareCol(sort_col+"_q_over");
    //System.out.println(c);
   Collections.sort(list,c);
   rs  =new RowSet(list);
   
   
%>

<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
<div id='div_excel_content'>
<div  style="font-size:18px;font-weight:bold;text-align:center">
 <%=SxReportUtil.getTitleTime(request)%> �������߼���SO2��Nox���̳��ŷ�Ũ�ȷֶ�ͳ���ŷ�ͳ�Ʊ���
</div>


<table border=0 cellspacing=1>

<tr class=title>
<td>���</td>
<td>����</td>
<td>�ŷ���(nm<sup>3</sup>)</td>

<td>SO2�ŷű�׼</td>
<td>SO2����Ũ�ȷֶ�</td>
<td>�ŷ�����(nm<sup>3</sup>)</td>
<td>SO2ʵ���ŷ���(KG)</td>
<td>�ŷ���%</td>



<td>NOX�ŷű�׼</td>
<td>NOX����Ũ�ȷֶ�</td>
<td>�ŷ�����(nm<sup>3</sup>)</td>
<td>NOXʵ���ŷ���(KG)</td>
<td>�ŷ���%</td>


<td>�̳��ŷű�׼</td>
<td>�̳�����Ũ�ȷֶ�</td>
<td>�ŷ�����(nm<sup>3</sup>)</td>
<td>�̳�ʵ���ŷ���(KG)</td>
<td>�ŷ���%</td>

<td>��ע</td>

</tr>

<%while(rs.next()){%>
<tr>
   <td rowspan=2><%=rs.getIndex()+1%></td>
   <td rowspan=2><%=rs.get("station_desc")%></td>
   <td rowspan=2><%=rs.get(q_col+"_sum",1,f)%></td>

      <td rowspan=2><%=rs.get(so2_col+"_std",1,f)%></td>
   <td> <�ŷű�׼ </td>
   <td><%=rs.get(so2_col+"_q_ok",1,f)%></td>
   <td><%=rs.get(so2_col+"_p_ok",r,f)%></td>
   <td><%=rs.get(so2_col+"_ok_r",1,f)%></td>
   
      <td rowspan=2><%=rs.get(nox_col+"_std",1,f)%></td>
   <td> <�ŷű�׼ </td>
   <td><%=rs.get(nox_col+"_q_ok",1,f)%></td>
   <td><%=rs.get(nox_col+"_p_ok",r,f)%></td>
   <td><%=rs.get(nox_col+"_ok_r",1,f)%></td>
   
   
      <td rowspan=2><%=rs.get(pm_col+"_std",1,f)%></td>
   <td> <�ŷű�׼ </td>
   <td><%=rs.get(pm_col+"_q_ok",1,f)%></td>
   <td><%=rs.get(pm_col+"_p_ok",r,f)%></td>
   <td><%=rs.get(pm_col+"_ok_r",1,f)%></td>
   
   
   
   <td rowspan=2></td>
   
   </tr>
   <tr>
   
    <td> >�ŷű�׼ </td>
   <td><%=rs.get(so2_col+"_q_over",1,f)%></td>
   <td><%=rs.get(so2_col+"_p_over",r,f)%></td>
   <td><%=rs.get(so2_col+"_over_r",1,f)%></td>
   
    <td> >�ŷű�׼ </td>
   <td><%=rs.get(nox_col+"_q_over",1,f)%></td>
   <td><%=rs.get(nox_col+"_p_over",r,f)%></td>
   <td><%=rs.get(nox_col+"_over_r",1,f)%></td>
   
    <td> >�ŷű�׼ </td>
   <td><%=rs.get(pm_col+"_q_over",1,f)%></td>
   <td><%=rs.get(pm_col+"_p_over",r,f)%></td>
   <td><%=rs.get(pm_col+"_over_r",1,f)%></td>
   
   </tr>
   <%}%>


</table>
</div>