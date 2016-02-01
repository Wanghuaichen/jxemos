<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<link rel="stylesheet" href="../../../web/index.css" />
<%!
         public String v(String s,double dd,String format)throws Exception{
                  Double dobj = f.getDoubleObj(s,null);
                    if(dobj==null){return "";}
                 double d = dobj.doubleValue();
                  d =d/dd;
                  return f.format(d+"",format);  
}

public String getIndexTitle(String report_type){
                   if(f.eq(report_type,"month")){return "����";}
                    if(f.eq(report_type,"year")){return "�·�";}
                     return "ʱ";
}

public int getIndex(int i,String report_type){
                           if(f.eq(report_type,"day")){return i;}else{return i+1;}
                 }


public String getTimeString(Timestamp time,String report_type)throws Exception{
                 String format = "yy��mm��dd��";
                 if(f.eq(report_type,"month")){format="yy��mm��";}
                  if(f.eq(report_type,"year")){format="yy��";}
                   return StringUtil.format(time,format);
}
public String getTitle(String report_type){
        
        if(f.eq(report_type,"month")){
        return "��ˮ�ŷ����������ƽ��ֵ�±���";
        }
         if(f.eq(report_type,"year")){
        return "��ˮ�ŷ����������ƽ��ֵ�걨��";
        }
        
        return "��ˮ�ŷ��������Сʱƽ��ֵ�ձ���";
}
%>
<%
          RowSet rs = null;
          XBean b = null;
          
        
          
          String report_type = w.p("report_type");
          String s = null;
           double q_r = 1000;
          String format = "0.####";
           String date1 = w.p("date1");
          Timestamp time = f.time(date1);
          rs =w.rs("data");
          b = w.b("tj");
%>
<style>
body{
text-align:left;
}
</style>

<div id='div_excel_content'>
<br>
	<span style="visibility: hidden;">hold space</span>
<div style="text-align:center;font-weight:bold;font-size:15px"><%=getTitle(report_type)%></div>
	<span style="visibility: hidden;">hold space</span>

<div>�ŷ�Դ����:<%=w.get("station_name")%></div>
	<span style="visibility: hidden;">hold space</span>
<div>�ŷ�Դ���:<%=w.get("station_id")%>  �������: <%=getTimeString(time,report_type)%></div>



	<table class="nui-table-inner major">
		<thead class="nui-table-head">
			<tr class="nui-table-row">
<th class="nui-table-cell" rowspan=2>ʱ��(<%=getIndexTitle(report_type)%>)</th>

<th class="nui-table-cell" colspan=2>COD</th>
<th class="nui-table-cell" colspan=2>SS</th>
<th class="nui-table-cell" colspan=2>TN</th>
<th class="nui-table-cell" colspan=2>TP</th>
<th class="nui-table-cell" colspan=2>NH<SUB>3</SUB>-N</th>

<th class="nui-table-cell" rowspan=2>����m<sup>3</sup></th>
<th class="nui-table-cell" rowspan=2>PH</th>
<th class="nui-table-cell" rowspan=2>������%</th>
<th class="nui-table-cell" rowspan=2>����%</th>
<th class="nui-table-cell" rowspan=2>��ע</th>

</tr>

<tr>
<th class="nui-table-cell">mg/l</th>
<th class="nui-table-cell">kg</th>

<th class="nui-table-cell">mg/l</th>
<th class="nui-table-cell">kg</th>

<th class="nui-table-cell">mg/l</th>
<th class="nui-table-cell">kg</th>

<th class="nui-table-cell">mg/l</th>
<th class="nui-table-cell">kg</th>

<th class="nui-table-cell">mg/l</th>
<th class="nui-table-cell">kg</th>
</tr>
		</thead>
		<tbody class="nui-table-body">

<%while(rs.next()){%>
<tr>
<th class="nui-table-cell"><%=getIndex(rs.getIndex(),report_type)%></th>

<th class="nui-table-cell"><%=rs.get("w_cod")%></th>
<th class="nui-table-cell"><%=v(rs.get("w_cod_q"),q_r,format)%></th>

<th class="nui-table-cell"><%=v(rs.get("w_ss"),1,format)%></th>
<th class="nui-table-cell"><%=v(rs.get("w_ss_q"),q_r,format)%></th>

<th class="nui-table-cell"><%=v(rs.get("w_tn"),1,format)%></th>
<th class="nui-table-cell"><%=v(rs.get("w_tn_q"),q_r,format)%></th>

<th class="nui-table-cell"><%=v(rs.get("w_tp"),1,format)%></th>
<th class="nui-table-cell"><%=v(rs.get("w_tp_q"),q_r,format)%></th>

<th class="nui-table-cell"><%=v(rs.get("w_nh3n"),1,format)%></th>
<th class="nui-table-cell"><%=v(rs.get("w_nh3n_q"),q_r,format)%></th>

<th class="nui-table-cell"><%=v(rs.get("w_q"),1,"0.####")%></th>
<th class="nui-table-cell"><%=rs.get("w_ph")%></th>
<th class="nui-table-cell"><%=rs.get("w_runr")%></th>
<th class="nui-table-cell"><%=rs.get("w_fh")%></th>
<th class="nui-table-cell"><%=rs.get("w_bz")%></th>



</tr>
<%}%>


<tr>
<th class="nui-table-cell">ƽ��ֵ</th>

<th class="nui-table-cell"><%=f.format(b.get("w_cod_avg"),format)%></th>
<th class="nui-table-cell"><%=v(b.get("w_cod_q_avg"),q_r,format)%></th>

<th class="nui-table-cell"><%=v(b.get("w_ss_avg"),1,format)%></th>
<th class="nui-table-cell"><%=v(b.get("w_ss_q_avg"),q_r,format)%></th>

<th class="nui-table-cell"><%=v(b.get("w_tn_avg"),1,format)%></th>
<th class="nui-table-cell"><%=v(b.get("w_tn_q_avg"),q_r,format)%></th>

<th class="nui-table-cell"><%=v(b.get("w_tp_avg"),1,format)%></th>
<th class="nui-table-cell"><%=v(b.get("w_tp_q_avg"),q_r,format)%></th>

<th class="nui-table-cell"><%=v(b.get("w_nh3n_avg"),1,format)%></th>
<th class="nui-table-cell"><%=v(b.get("w_nh3n_q_avg"),q_r,format)%></th>

<th class="nui-table-cell"><%=v(b.get("w_q_avg"),1,"0.##")%></th>
<th class="nui-table-cell"><%=v(b.get("w_ph_avg"),1,"0.##")%></th>
<th class="nui-table-cell"><%=b.get("w_runr_avg")%></th>
<th class="nui-table-cell"><%=b.get("w_fh_avg")%></th>
<th class="nui-table-cell"><%=b.get("w_bz_avg")%></th>

</tr>

<tr>
<th class="nui-table-cell">���ֵ</th>

<th class="nui-table-cell"><%=b.get("w_cod_max")%></th>
<th class="nui-table-cell"><%=v(b.get("w_cod_q_max"),q_r,format)%></th>

<th class="nui-table-cell"><%=b.get("w_ss_max")%></th>
<th class="nui-table-cell"><%=v(b.get("w_ss_q_max"),q_r,format)%></th>

<th class="nui-table-cell"><%=b.get("w_tn_max")%></th>
<th class="nui-table-cell"><%=v(b.get("w_tn_q_max"),q_r,format)%></th>

<th class="nui-table-cell"><%=b.get("w_tp_max")%></th>
<th class="nui-table-cell"><%=v(b.get("w_tp_q_max"),q_r,format)%></th>

<th class="nui-table-cell"><%=b.get("w_nh3n_max")%></th>
<th class="nui-table-cell"><%=v(b.get("w_nh3n_q_max"),q_r,format)%></th>

<th class="nui-table-cell"><%=b.get("w_q_max")%></th>
<th class="nui-table-cell"><%=b.get("w_ph_max")%></th>
<th class="nui-table-cell"><%=b.get("w_runr_max")%></th>
<th class="nui-table-cell"><%=b.get("w_fh_max")%></th>
<th class="nui-table-cell"><%=b.get("w_bz_max")%></th>

</tr>

<tr>
<th class="nui-table-cell">��Сֵ</th>

<th class="nui-table-cell"><%=b.get("w_cod_min")%></th>
<th class="nui-table-cell"><%=v(b.get("w_cod_q_min"),q_r,format)%></th>

<th class="nui-table-cell"><%=b.get("w_ss_min")%></th>
<th class="nui-table-cell"><%=v(b.get("w_ss_q_min"),q_r,format)%></th>

<th class="nui-table-cell"><%=b.get("w_tn_min")%></th>
<th class="nui-table-cell"><%=v(b.get("w_tn_q_min"),q_r,format)%></th>

<th class="nui-table-cell"><%=b.get("w_tp_min")%></th>
<th class="nui-table-cell"><%=v(b.get("w_tp_q_min"),q_r,format)%></th>

<th class="nui-table-cell"><%=b.get("w_nh3n_min")%></th>
<th class="nui-table-cell"><%=v(b.get("w_nh3n_q_min"),q_r,format)%></th>

<th class="nui-table-cell"><%=b.get("w_q_min")%></th>
<th class="nui-table-cell"><%=b.get("w_ph_min")%></th>
<th class="nui-table-cell"><%=b.get("w_runr_min")%></th>
<th class="nui-table-cell"><%=b.get("w_fh_min")%></th>
<th class="nui-table-cell"><%=b.get("w_bz_min")%></th>

</tr>



<tr>
<th class="nui-table-cell">������</th>

<th class="nui-table-cell"><%=b.get("w_cod_count")%></th>
<th class="nui-table-cell"><%=b.get("w_cod_q_count")%></th>

<th class="nui-table-cell"><%=b.get("w_ss_count")%></th>
<th class="nui-table-cell"><%=b.get("w_ss_q_count")%></th>

<th class="nui-table-cell"><%=b.get("w_tn_count")%></th>
<th class="nui-table-cell"><%=b.get("w_tn_q_count")%></th>

<th class="nui-table-cell"><%=b.get("w_tp_count")%></th>
<th class="nui-table-cell"><%=b.get("w_tp_q_count")%></th>

<th class="nui-table-cell"><%=b.get("w_nh3n_count")%></th>
<th class="nui-table-cell"><%=b.get("w_nh3n_q_count")%></th>

<th class="nui-table-cell"><%=b.get("w_q_count")%></th>
<th class="nui-table-cell"><%=b.get("w_ph_count")%></th>
<th class="nui-table-cell"><%=b.get("w_runr_count")%></th>
<th class="nui-table-cell"><%=b.get("w_fh_count")%></th>
<th class="nui-table-cell"><%=b.get("w_bz_count")%></th>

</tr>


<tr>
<th class="nui-table-cell">�ŷ�����</th>

<th class="nui-table-cell">
<!--
<%=b.get("w_cod_sum")%>
-->
-
</th>
<th class="nui-table-cell"><%=v(b.get("w_cod_q_sum"),q_r,format)%></th>

<th class="nui-table-cell">-</th>
<th class="nui-table-cell"><%=v(b.get("w_ss_q_sum"),q_r,format)%></th>

<th class="nui-table-cell">-</th>
<th class="nui-table-cell"><%=v(b.get("w_tn_q_sum"),q_r,format)%></th>

<th class="nui-table-cell">-</th>
<th class="nui-table-cell"><%=v(b.get("w_tp_q_sum"),q_r,format)%></th>

<th class="nui-table-cell">-</th>
<th class="nui-table-cell"><%=v(b.get("w_nh3n_q_sum"),q_r,format)%></th>
<th class="nui-table-cell"><%=v(b.get("w_q_sum"),1,"0.##")%></th>
<!--
<th class="nui-table-cell"><%=b.get("w_ph_sum")%></th>
<th class="nui-table-cell"><%=b.get("w_runr_sum")%></th>
<th class="nui-table-cell"><%=b.get("w_fh_sum")%></th>
<th class="nui-table-cell"><%=b.get("w_bz_sum")%></th>
-->
<th class="nui-table-cell" colspan=4>-</th>

</tr>
</tbody>
</table>
<br>
<div>�ϱ���λ�����£��� &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
�����ˣ� &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
�����ˣ� &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
�������ڣ�  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  �� 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ��  
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ��</div>
   
   </div>