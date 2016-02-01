<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
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
<div style="text-align:center;font-weight:bold;font-size:15px"><%=getTitle(report_type)%></div>

<div>�ŷ�Դ����:<%=w.get("station_name")%></div>
<div>�ŷ�Դ���:<%=w.get("station_id")%>  �������: <%=getTimeString(time,report_type)%></div>



<table width=100% cellspacing=1 border=0>
<tr>
<td rowspan=2>ʱ��(<%=getIndexTitle(report_type)%>)</td>

<td colspan=2>COD</td>
<td colspan=2>SS</td>
<td colspan=2>TN</td>
<td colspan=2>TP</td>
<td colspan=2>NH<SUB>3</SUB>-N</td>

<td rowspan=2>����m<sup>3</sup></td>
<td rowspan=2>PH</td>
<td rowspan=2>������%</td>
<td rowspan=2>����%</td>
<td rowspan=2>��ע</td>

</tr>

<tr>
<td>mg/l</td>
<td>kg</td>

<td>mg/l</td>
<td>kg</td>

<td>mg/l</td>
<td>kg</td>

<td>mg/l</td>
<td>kg</td>

<td>mg/l</td>
<td>kg</td>
</tr>

<%while(rs.next()){%>
<tr>
<td><%=getIndex(rs.getIndex(),report_type)%></td>

<td><%=rs.get("w_cod")%></td>
<td><%=v(rs.get("w_cod_q"),q_r,format)%></td>

<td><%=v(rs.get("w_ss"),1,format)%></td>
<td><%=v(rs.get("w_ss_q"),q_r,format)%></td>

<td><%=v(rs.get("w_tn"),1,format)%></td>
<td><%=v(rs.get("w_tn_q"),q_r,format)%></td>

<td><%=v(rs.get("w_tp"),1,format)%></td>
<td><%=v(rs.get("w_tp_q"),q_r,format)%></td>

<td><%=v(rs.get("w_nh3n"),1,format)%></td>
<td><%=v(rs.get("w_nh3n_q"),q_r,format)%></td>

<td><%=v(rs.get("w_q"),1,"0.####")%></td>
<td><%=rs.get("w_ph")%></td>
<td><%=rs.get("w_runr")%></td>
<td><%=rs.get("w_fh")%></td>
<td><%=rs.get("w_bz")%></td>



</tr>
<%}%>


<tr>
<td>ƽ��ֵ</td>

<td><%=f.format(b.get("w_cod_avg"),format)%></td>
<td><%=v(b.get("w_cod_q_avg"),q_r,format)%></td>

<td><%=v(b.get("w_ss_avg"),1,format)%></td>
<td><%=v(b.get("w_ss_q_avg"),q_r,format)%></td>

<td><%=v(b.get("w_tn_avg"),1,format)%></td>
<td><%=v(b.get("w_tn_q_avg"),q_r,format)%></td>

<td><%=v(b.get("w_tp_avg"),1,format)%></td>
<td><%=v(b.get("w_tp_q_avg"),q_r,format)%></td>

<td><%=v(b.get("w_nh3n_avg"),1,format)%></td>
<td><%=v(b.get("w_nh3n_q_avg"),q_r,format)%></td>

<td><%=v(b.get("w_q_avg"),1,"0.##")%></td>
<td><%=v(b.get("w_ph_avg"),1,"0.##")%></td>
<td><%=b.get("w_runr_avg")%></td>
<td><%=b.get("w_fh_avg")%></td>
<td><%=b.get("w_bz_avg")%></td>

</tr>

<tr>
<td>���ֵ</td>

<td><%=b.get("w_cod_max")%></td>
<td><%=v(b.get("w_cod_q_max"),q_r,format)%></td>

<td><%=b.get("w_ss_max")%></td>
<td><%=v(b.get("w_ss_q_max"),q_r,format)%></td>

<td><%=b.get("w_tn_max")%></td>
<td><%=v(b.get("w_tn_q_max"),q_r,format)%></td>

<td><%=b.get("w_tp_max")%></td>
<td><%=v(b.get("w_tp_q_max"),q_r,format)%></td>

<td><%=b.get("w_nh3n_max")%></td>
<td><%=v(b.get("w_nh3n_q_max"),q_r,format)%></td>

<td><%=b.get("w_q_max")%></td>
<td><%=b.get("w_ph_max")%></td>
<td><%=b.get("w_runr_max")%></td>
<td><%=b.get("w_fh_max")%></td>
<td><%=b.get("w_bz_max")%></td>

</tr>

<tr>
<td>��Сֵ</td>

<td><%=b.get("w_cod_min")%></td>
<td><%=v(b.get("w_cod_q_min"),q_r,format)%></td>

<td><%=b.get("w_ss_min")%></td>
<td><%=v(b.get("w_ss_q_min"),q_r,format)%></td>

<td><%=b.get("w_tn_min")%></td>
<td><%=v(b.get("w_tn_q_min"),q_r,format)%></td>

<td><%=b.get("w_tp_min")%></td>
<td><%=v(b.get("w_tp_q_min"),q_r,format)%></td>

<td><%=b.get("w_nh3n_min")%></td>
<td><%=v(b.get("w_nh3n_q_min"),q_r,format)%></td>

<td><%=b.get("w_q_min")%></td>
<td><%=b.get("w_ph_min")%></td>
<td><%=b.get("w_runr_min")%></td>
<td><%=b.get("w_fh_min")%></td>
<td><%=b.get("w_bz_min")%></td>

</tr>



<tr>
<td>������</td>

<td><%=b.get("w_cod_count")%></td>
<td><%=b.get("w_cod_q_count")%></td>

<td><%=b.get("w_ss_count")%></td>
<td><%=b.get("w_ss_q_count")%></td>

<td><%=b.get("w_tn_count")%></td>
<td><%=b.get("w_tn_q_count")%></td>

<td><%=b.get("w_tp_count")%></td>
<td><%=b.get("w_tp_q_count")%></td>

<td><%=b.get("w_nh3n_count")%></td>
<td><%=b.get("w_nh3n_q_count")%></td>

<td><%=b.get("w_q_count")%></td>
<td><%=b.get("w_ph_count")%></td>
<td><%=b.get("w_runr_count")%></td>
<td><%=b.get("w_fh_count")%></td>
<td><%=b.get("w_bz_count")%></td>

</tr>


<tr>
<td>�ŷ�����</td>

<td>
<!--
<%=b.get("w_cod_sum")%>
-->
-
</td>
<td><%=v(b.get("w_cod_q_sum"),q_r,format)%></td>

<td>-</td>
<td><%=v(b.get("w_ss_q_sum"),q_r,format)%></td>

<td>-</td>
<td><%=v(b.get("w_tn_q_sum"),q_r,format)%></td>

<td>-</td>
<td><%=v(b.get("w_tp_q_sum"),q_r,format)%></td>

<td>-</td>
<td><%=v(b.get("w_nh3n_q_sum"),q_r,format)%></td>
<td><%=v(b.get("w_q_sum"),1,"0.##")%></td>
<!--
<td><%=b.get("w_ph_sum")%></td>
<td><%=b.get("w_runr_sum")%></td>
<td><%=b.get("w_fh_sum")%></td>
<td><%=b.get("w_bz_sum")%></td>
-->
<td colspan=4>-</td>

</tr>
</table>
<br>
<div>�ϱ���λ�����£��� &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
�����ˣ� &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
�����ˣ� &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
�������ڣ�  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  �� 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ��  
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ��</div>
   
   </div>