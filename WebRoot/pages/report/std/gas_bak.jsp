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
        return "�����ŷ����������ƽ��ֵ�±���";
        }
         if(f.eq(report_type,"year")){
        return "�����ŷ����������ƽ��ֵ�걨��";
        }
        
        return "�����ŷ��������Сʱƽ��ֵ�ձ���";
}


%>
<%
          RowSet rs = null;
          XBean b = null;
          BaseAction action = null;
          
          
     String report_type = w.p("report_type");
          String s = null;
           String date1 = w.p("date1");
            Timestamp time = f.time(date1);
           double q_r = 1000*1000;
          String format = "0.####";
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
<div>�ŷ�Դ���:<%=w.get("station_id")%> �������:<%=getTimeString(time,report_type)%></div>

<table width=100% cellspacing=1 border=0>
<tr>
<td rowspan=2>ʱ��(<%=getIndexTitle(report_type)%>)</td>
<td colspan=3>������</td>
<td colspan=3>SO<sub>3</sub></td>
<td colspan=3>NO<sub>x</sub></td>

<td rowspan=2>����m<sup>3</sup></td>
<td rowspan=2>O<sub>2</sub>%</td>
<td rowspan=2>�¶�</td>
<td rowspan=2>ˮ�ֺ���%</td>
<td rowspan=2>����%</td>
<td rowspan=2>��ע</td>

</tr>

<tr>
<td>mg/m<sup>3</sup></td>
<td>����mg/m<sup>3</sup></td>
<td>kg</td>

<td>mg/m<sup>3</sup></td>
<td>����mg/m<sup>3</sup></td>
<td>kg</td>

<td>mg/m<sup>3</sup></td>
<td>����mg/m<sup>3</sup></td>
<td>kg</td>

</tr>


<%while(rs.next()){%>
<tr>
 <td><%=getIndex(rs.getIndex(),report_type)%></td>
 
 <td><%=rs.get("g_pm")%></td>
 <td><%=rs.get("g_pm2")%></td>
 <td><%=v(rs.get("g_pm2_q"),q_r,format)%></td>
 
 <td><%=rs.get("g_so2")%></td>
 <td><%=rs.get("g_so22")%></td>
 <td><%=v(rs.get("g_so22_q"),q_r,format)%></td>
 
 
 <td><%=rs.get("g_nox")%></td>
 <td><%=rs.get("g_nox2")%></td>
 <td><%=v(rs.get("g_nox2_q"),q_r,format)%></td>
 
 <td><%=v(rs.get("g_q"),1,"0.####")%></td>
 <td><%=rs.get("g_op")%></td>
 <td><%=rs.get("g_t")%></td>
 <td><%=rs.get("g_wp")%></td>
 
 <td><%=rs.get("g_fh")%></td>
 <td><%=rs.get("g_bz")%></td>
 
 
</tr>
<%}%>


<tr>
<td>ƽ��ֵ</td>
<td><%=v(b.get("g_pm_avg"),1,"0.##")%></td>
 <td><%=v(b.get("g_pm2_avg"),1,"0.##")%></td>
 <td><%=v(b.get("g_pm2_q_avg"),q_r,format)%></td>
 
 <td><%=v(b.get("g_so2_avg"),1,"0.##")%></td>
 <td><%=v(b.get("g_so22_avg"),1,"0.##")%></td>
 <td><%=v(b.get("g_so22_q_avg"),q_r,format)%></td>
 
 
 <td><%=v(b.get("g_nox_avg"),1,"0.##")%></td>
 <td><%=v(b.get("g_nox2_avg"),1,"0.##")%></td>
 <td><%=v(b.get("g_nox2_q_avg"),q_r,format)%></td>
 
 <td><%=v(b.get("g_q_avg"),1,"0.##")%></td>
 <td><%=v(b.get("g_op_avg"),1,"0.##")%></td>
 <td><%=v(b.get("g_t_avg"),1,"0.##")%></td>
 <td><%=v(b.get("g_wp_avg"),1,"0.##")%></td>
 
 <td><%=v(b.get("g_fh_avg"),1,"0.##")%></td>
 <td><%=v(b.get("g_bz_avg"),1,"0.##")%></td>
</tr>

<tr>
<td>���ֵ</td>
<td><%=b.get("g_pm_max")%></td>
 <td><%=b.get("g_pm2_max")%></td>
 <td><%=v(b.get("g_pm2_q_max"),q_r,format)%></td>
 
 <td><%=b.get("g_so2_max")%></td>
 <td><%=b.get("g_so22_max")%></td>
 <td><%=v(b.get("g_so22_q_max"),q_r,format)%></td>
 
 
 <td><%=b.get("g_nox_max")%></td>
 <td><%=b.get("g_nox2_max")%></td>
 <td><%=v(b.get("g_nox2_q_max"),q_r,format)%></td>
 
 <td><%=b.get("g_q_max")%></td>
 <td><%=b.get("g_op_max")%></td>
 <td><%=b.get("g_t_max")%></td>
 <td><%=b.get("g_wp_max")%></td>
 
 <td><%=b.get("g_fh_max")%></td>
 <td><%=b.get("g_bz_max")%></td>
</tr>

<tr>
<td>��Сֵ</td>
<td><%=b.get("g_pm_min")%></td>
 <td><%=b.get("g_pm2_min")%></td>
 <td><%=v(b.get("g_pm2_q_min"),q_r,format)%></td>
 
 <td><%=b.get("g_so2_min")%></td>
 <td><%=b.get("g_so22_min")%></td>
 <td><%=v(b.get("g_so22_q_min"),q_r,format)%></td>
 
 
 <td><%=b.get("g_nox_min")%></td>
 <td><%=b.get("g_nox2_min")%></td>
 <td><%=v(b.get("g_nox2_q_min"),q_r,format)%></td>
 
 <td><%=b.get("g_q_min")%></td>
 <td><%=b.get("g_op_min")%></td>
 <td><%=b.get("g_t_min")%></td>
 <td><%=b.get("g_wp_min")%></td>
 
 <td><%=b.get("g_fh_min")%></td>
 <td><%=b.get("g_bz_min")%></td>
</tr>

<tr>
<td>������</td>
<td><%=b.get("g_pm_count")%></td>
 <td><%=b.get("g_pm2_count")%></td>
 <td><%=b.get("g_pm2_q_count")%></td>
 
 <td><%=b.get("g_so2_count")%></td>
 <td><%=b.get("g_so22_count")%></td>
 <td><%=b.get("g_so22_q_count")%></td>
 
 
 <td><%=b.get("g_nox_count")%></td>
 <td><%=b.get("g_nox2_count")%></td>
 <td><%=b.get("g_nox2_q_count")%></td>
 
 <td><%=b.get("g_q_count")%></td>
 <td><%=b.get("g_op_count")%></td>
 <td><%=b.get("g_t_count")%></td>
 <td><%=b.get("g_wp_count")%></td>
 
 <td><%=b.get("g_fh_count")%></td>
 <td><%=b.get("g_bz_count")%></td>
</tr>

<tr>
<td>�ŷ�����</td>
<td><!--<%=b.get("g_pm_sum")%>-->-</td>
 <td><!--<%=b.get("g_pm2_sum")%>-->-</td>
 <td><%=v(b.get("g_pm2_q_sum"),q_r,format)%></td>
 
 <td><!--<%=b.get("g_so2_sum")%>-->-</td>
 <td><!--<%=b.get("g_so22_sum")%>-->-</td>
 <td><%=v(b.get("g_so22_q_sum"),q_r,format)%></td>
 
 
 <td><!--<%=b.get("g_nox_sum")%>-->-</td>
 <td><!--<%=b.get("g_nox2_sum")%>-->-</td>
 <td><%=v(b.get("g_nox2_q_sum"),q_r,format)%></td>

 <td><%=v(b.get("g_q_sum"),1,"0.##")%></td>
<!--
 <td><%=b.get("g_op_sum")%></td>
 <td><%=b.get("g_t_sum")%></td>
 <td><%=b.get("g_wp_sum")%></td>
 
 <td><%=b.get("g_fh_sum")%></td>
 <td><%=b.get("g_bz_sum")%></td>
-->
  <td colspan=6>-</td>
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