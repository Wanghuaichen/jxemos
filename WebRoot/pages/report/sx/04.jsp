<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
      String q_col,cod_col = null;
      String f = "0.##";
      double r = 1000;
      List list = null;
      
   try{
   
    action = new SxReport();
    action.run(request,response,"rpt04");
   q_col = w.p("q_col");
   cod_col = w.p("cod_col");

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
   //c.setCompareCol(cod_col+"_p_over");
   //c.setCompareCol(cod_col+"_q_over");
   String sort_col = request.getParameter("sort_col");
   c.setCompareCol(sort_col);
   //System.out.println(sort_col);
    //System.out.println(c);
   Collections.sort(list,c);
   rs  =new RowSet(list);
   
%>
<link rel="stylesheet" href="../../../web/index.css" />
<div id='div_excel_content'>
	<span style="visibility: hidden;">hold space</span>
<div  style="font-size:18px;font-weight:bold;text-align:center">
  <%=SxReportUtil.getTitleTime(request)%> ��ˮ���߼���CODŨ�ȷֶ�ͳ�Ʊ���
</div>
	<span style="visibility: hidden;">hold space</span>

	<table class="nui-table-inner major">
		<thead class="nui-table-head">
			<tr class="nui-table-row">
<th class="nui-table-cell" width="30px">���</th>
<th class="nui-table-cell" width="240px">����</th>
<th class="nui-table-cell">�ŷ���(m<sup>3</sup>)</th>
<th class="nui-table-cell">COD�ŷű�׼</th>
<th class="nui-table-cell">CODŨ�ȷֶ�</th>
<th class="nui-table-cell">ƽ��Ũ��</th>
<th class="nui-table-cell">�ŷ�����(m<sup>3</sup>)</th>
<th class="nui-table-cell">COD�ŷ���(KG)</th>
<th class="nui-table-cell">�ŷ���%</th>
<th class="nui-table-cell">��ע</th>
</tr>
		</thead>
		<tbody class="nui-table-body">

<%while(rs.next()){%>
<tr>
   <th class="nui-table-cell" rowspan=2><%=rs.getIndex()+1%></th>
   <th class="nui-table-cell" rowspan=2><%=rs.get("station_desc")%></th>
   <th class="nui-table-cell" rowspan=2><%=rs.get(q_col+"_sum",1,f)%></th>
   <th class="nui-table-cell" rowspan=2><%=rs.get(cod_col+"_std",1,f)%></th>
   
   <th class="nui-table-cell"> <�ŷű�׼ </th>
   
   <th class="nui-table-cell"><%=rs.get(cod_col+"_avg_c_ok",1,f)%></th>
   <th class="nui-table-cell"><%=rs.get(cod_col+"_q_ok",1,f)%></th>
   <th class="nui-table-cell"><%=rs.get(cod_col+"_p_ok",r,f)%></th>
   <th class="nui-table-cell"><%=rs.get(cod_col+"_ok_r",1,f)%></th>
   
   <th class="nui-table-cell" rowspan=2></th>
   
   </tr>
   <tr>
    <th class="nui-table-cell"> >�ŷű�׼ </th>
   <th class="nui-table-cell"><%=rs.get(cod_col+"_avg_c_over",1,f)%></th>
   <th class="nui-table-cell"><%=rs.get(cod_col+"_q_over",1,f)%></th>
   <th class="nui-table-cell"><%=rs.get(cod_col+"_p_over",r,f)%></th>
   <th class="nui-table-cell"><%=rs.get(cod_col+"_over_r",1,f)%></th>
   </tr>
   <%}%>
   </tbody>
</table>
</div>

