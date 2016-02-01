<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%!
    public static String v(RowSet rs,String key1,String key2,String format){
            String s1,s2 = null;
            s1 = rs.get(key1);
            s2=rs.get(key2);
            
            if(f.empty(s1)&& f.empty(s2)){return "";}
            
            double d1,d2,d3 = 0;
            
            d1 = f.getDouble(s1,0);
            d2 = f.getDouble(s2,0);
            d3 = d1-d2;
            
            String s = null;
            s=d3+"";
            s=f.format(s,format);
            return s;
               
    }
     
%>
<%
      BaseAction action = null;
      String[]colids = null;
      int coli,colidnum = 0;
      Map colMap = null;
      String cod_std = request.getParameter("cod_std");
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
 <%=w.get("yy")%> �� <%=w.get("mm")%>  �·����߼����ҵ��Ⱦ���ŷ�ͳ�ƻ��ܱ�
</div>


<table border=0 cellspacing=1>
 <tr class=title> 
    <td rowspan="3" >���</td>

    <td rowspan="3" >վλ����</td>
    
    <%for(coli=0;coli<colidnum;coli++){%>
    <td rowspan="3" ><%=FyReportUtil.getStationColName(colMap,colids[coli])%></td>
    <%}%>


    <td rowspan="3" >COD�»�������</td>
    <td colspan="3">��������</td>
    
    <td colspan="3">������������</td>
    
    <td colspan="3">�쳣��������</td>
    <td colspan="6">���߹���</td>
    <td rowspan="3" >����ˮ��</td>
    <td rowspan="3" >COD&gt; <%=cod_std%> ����</td>
    <td rowspan="3" >COD&gt; <%=cod_std%>ƽ��ֵ</td>
    <td rowspan="3">��ע</td>
  </tr>
  <tr class=title> 
    <td rowspan="2">����</td>
    <td rowspan="2">�վ�����</td>
    <td rowspan="2">��ˮ��</td>
    
     <td rowspan="2">����</td>
    <td rowspan="2">�վ�����</td>
    <td rowspan="2">��ˮ��</td>
    
    
    <td rowspan="2">����</td>
    <td rowspan="2">�վ�����</td>
    <td rowspan="2">��ˮ��</td>
    
    
    
    <td rowspan="2">����</td>
    <td colspan="2">�ѻ�</td>
    <td colspan="2">����ʧ��</td>
    <td rowspan="2">��ˮ��</td>
  </tr>
  <tr class=title> 
    <td >������������</td>
    <td >ͣ������</td>
    <td >������������</td>
    <td >ͣ������</td>
  </tr>

<%while(rs.next()){%>
<tr>
  <td><%=rs.getIndex()+1%></td>

  <td><%=rs.get("station_desc")%></td>

 <%for(coli=0;coli<colidnum;coli++){%>
    <td><%=rs.get("val"+colids[coli])%></td>
    <%}%>


  
  <td><%=f.format(rs.get("avg_cod"),"0.##")%></td>
  
  
  <td><%=rs.get("count_q_zc")%></td>
  <td><%=f.format(rs.get("avg_q_zc"),"0.##")%></td>
  <td><%=f.format(rs.get("sum_q_zc"),"0.##")%></td>
  
  <td><%=v(rs,"count_q_zc","count_q_yc","0.#")%></td>
  <td><%=rs.get("xxx")%></td>
  <td><%=v(rs,"sum_q_zc","sum_q_yc","0.##")%></td>
  
  
  
  <td><%=rs.get("count_q_yc")%></td>
  <td><%=f.format(rs.get("avg_q_yc"),"0.##")%></td>
  <td><%=f.format(rs.get("sum_q_yc"),"0.##")%></td>
  
  
  <td><%=rs.get("gznum_all")%></td>
  
  <td></td>
  <td></td>
  
  <td></td>
  <td></td>
  
  <td></td>
  
  
  <td><%=f.format(rs.get("sum_q"),"0.##")%></td>
  
  <td><%=rs.get("count_cod_over")%></td>
  <td><%=f.format(rs.get("avg_cod_over"),"0.##")%></td>
  
  <td></td>
</tr>
<%}%>


</table>

</div>




