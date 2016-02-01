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
	<span style="visibility: hidden;">hold space</span>
<div style="text-align:center;font-weight:bold;font-size:15px"><%=getTitle(report_type)%></div>
	<span style="visibility: hidden;">hold space</span>


<div>�ŷ�Դ����:<%=w.get("station_name")%></div>
	<span style="visibility: hidden;">hold space</span>
<div>�ŷ�Դ���:<%=w.get("station_id")%> �������:<%=getTimeString(time,report_type)%></div>

	<table class="nui-table-inner major">
		<thead class="nui-table-head">
			<tr class="nui-table-row">
<th class="nui-table-cell" rowspan=2>ʱ��(<%=getIndexTitle(report_type)%>)</th>
<th class="nui-table-cell" colspan=3>������</th>
<th class="nui-table-cell" colspan=3>SO<sub>3</sub></th>
<th class="nui-table-cell" colspan=3>NO<sub>x</sub></th>

<th class="nui-table-cell" rowspan=2>����m<sup>3</sup></th>
<th class="nui-table-cell" rowspan=2>O<sub>2</sub>%</th>
<th class="nui-table-cell" rowspan=2>�¶�</th>
<th class="nui-table-cell" rowspan=2>ˮ�ֺ���%</th>
<th class="nui-table-cell" rowspan=2>����%</th>
<th class="nui-table-cell" rowspan=2>��ע</th>

</tr>

<tr>
<th class="nui-table-cell">mg/m<sup>3</sup></th>
<th class="nui-table-cell">����mg/m<sup>3</sup></th>
<th class="nui-table-cell">kg</th>

<th class="nui-table-cell">mg/m<sup>3</sup></th>
<th class="nui-table-cell">����mg/m<sup>3</sup></th>
<th class="nui-table-cell">kg</th>

<th class="nui-table-cell">mg/m<sup>3</sup></th>
<th class="nui-table-cell">����mg/m<sup>3</sup></th>
<th class="nui-table-cell">kg</th>

</tr>
		</thead>
		<tbody class="nui-table-body">


<%while(rs.next()){%>
<tr>
 <th class="nui-table-cell"><%=getIndex(rs.getIndex(),report_type)%></th>
 
 <th class="nui-table-cell"><%=rs.get("g_pm")%></th>
 <th class="nui-table-cell"><%=rs.get("g_pm2")%></th>
 <th class="nui-table-cell"><%=v(rs.get("g_pm2_q"),q_r,format)%></th>
 
 <th class="nui-table-cell"><%=rs.get("g_so2")%></th>
 <th class="nui-table-cell"><%=rs.get("g_so22")%></th>
 <th class="nui-table-cell"><%=v(rs.get("g_so22_q"),q_r,format)%></th>
 
 
 <th class="nui-table-cell"><%=rs.get("g_nox")%></th>
 <th class="nui-table-cell"><%=rs.get("g_nox2")%></th>
 <th class="nui-table-cell"><%=v(rs.get("g_nox2_q"),q_r,format)%></th>
 
 <th class="nui-table-cell"><%=v(rs.get("g_q"),1,"0.####")%></th>
 <th class="nui-table-cell"><%=rs.get("g_op")%></th>
 <th class="nui-table-cell"><%=rs.get("g_t")%></th>
 <th class="nui-table-cell"><%=rs.get("g_wp")%></th>
 
 <th class="nui-table-cell"><%=rs.get("g_fh")%></th>
 <th class="nui-table-cell"><%=rs.get("g_bz")%></th>
 
 
</tr>
<%}%>


<tr>
<th class="nui-table-cell">ƽ��ֵ</th>
<th class="nui-table-cell"><%=v(b.get("g_pm_avg"),1,"0.##")%></th>
 <th class="nui-table-cell"><%=v(b.get("g_pm2_avg"),1,"0.##")%></th>
 <th class="nui-table-cell"><%=v(b.get("g_pm2_q_avg"),q_r,format)%></th>
 
 <th class="nui-table-cell"><%=v(b.get("g_so2_avg"),1,"0.##")%></th>
 <th class="nui-table-cell"><%=v(b.get("g_so22_avg"),1,"0.##")%></th>
 <th class="nui-table-cell"><%=v(b.get("g_so22_q_avg"),q_r,format)%></th>
 
 
 <th class="nui-table-cell"><%=v(b.get("g_nox_avg"),1,"0.##")%></th>
 <th class="nui-table-cell"><%=v(b.get("g_nox2_avg"),1,"0.##")%></th>
 <th class="nui-table-cell"><%=v(b.get("g_nox2_q_avg"),q_r,format)%></th>
 
 <th class="nui-table-cell"><%=v(b.get("g_q_avg"),1,"0.##")%></th>
 <th class="nui-table-cell"><%=v(b.get("g_op_avg"),1,"0.##")%></th>
 <th class="nui-table-cell"><%=v(b.get("g_t_avg"),1,"0.##")%></th>
 <th class="nui-table-cell"><%=v(b.get("g_wp_avg"),1,"0.##")%></th>
 
 <th class="nui-table-cell"><%=v(b.get("g_fh_avg"),1,"0.##")%></th>
 <th class="nui-table-cell"><%=v(b.get("g_bz_avg"),1,"0.##")%></th>
</tr>

<tr>
<th class="nui-table-cell">���ֵ</th>
<th class="nui-table-cell"><%=b.get("g_pm_max")%></th>
 <th class="nui-table-cell"><%=b.get("g_pm2_max")%></th>
 <th class="nui-table-cell"><%=v(b.get("g_pm2_q_max"),q_r,format)%></th>
 
 <th class="nui-table-cell"><%=b.get("g_so2_max")%></th>
 <th class="nui-table-cell"><%=b.get("g_so22_max")%></th>
 <th class="nui-table-cell"><%=v(b.get("g_so22_q_max"),q_r,format)%></th>
 
 
 <th class="nui-table-cell"><%=b.get("g_nox_max")%></th>
 <th class="nui-table-cell"><%=b.get("g_nox2_max")%></th>
 <th class="nui-table-cell"><%=v(b.get("g_nox2_q_max"),q_r,format)%></th>
 
 <th class="nui-table-cell"><%=b.get("g_q_max")%></th>
 <th class="nui-table-cell"><%=b.get("g_op_max")%></th>
 <th class="nui-table-cell"><%=b.get("g_t_max")%></th>
 <th class="nui-table-cell"><%=b.get("g_wp_max")%></th>
 
 <th class="nui-table-cell"><%=b.get("g_fh_max")%></th>
 <th class="nui-table-cell"><%=b.get("g_bz_max")%></th>
</tr>

<tr>
<th class="nui-table-cell">��Сֵ</th>
<th class="nui-table-cell"><%=b.get("g_pm_min")%></th>
 <th class="nui-table-cell"><%=b.get("g_pm2_min")%></th>
 <th class="nui-table-cell"><%=v(b.get("g_pm2_q_min"),q_r,format)%></th>
 
 <th class="nui-table-cell"><%=b.get("g_so2_min")%></th>
 <th class="nui-table-cell"><%=b.get("g_so22_min")%></th>
 <th class="nui-table-cell"><%=v(b.get("g_so22_q_min"),q_r,format)%></th>
 
 
 <th class="nui-table-cell"><%=b.get("g_nox_min")%></th>
 <th class="nui-table-cell"><%=b.get("g_nox2_min")%></th>
 <th class="nui-table-cell"><%=v(b.get("g_nox2_q_min"),q_r,format)%></th>
 
 <th class="nui-table-cell"><%=b.get("g_q_min")%></th>
 <th class="nui-table-cell"><%=b.get("g_op_min")%></th>
 <th class="nui-table-cell"><%=b.get("g_t_min")%></th>
 <th class="nui-table-cell"><%=b.get("g_wp_min")%></th>
 
 <th class="nui-table-cell"><%=b.get("g_fh_min")%></th>
 <th class="nui-table-cell"><%=b.get("g_bz_min")%></th>
</tr>

<tr>
<th class="nui-table-cell">������</th>
<th class="nui-table-cell"><%=b.get("g_pm_count")%></th>
 <th class="nui-table-cell"><%=b.get("g_pm2_count")%></th>
 <th class="nui-table-cell"><%=b.get("g_pm2_q_count")%></th>
 
 <th class="nui-table-cell"><%=b.get("g_so2_count")%></th>
 <th class="nui-table-cell"><%=b.get("g_so22_count")%></th>
 <th class="nui-table-cell"><%=b.get("g_so22_q_count")%></th>
 
 
 <th class="nui-table-cell"><%=b.get("g_nox_count")%></th>
 <th class="nui-table-cell"><%=b.get("g_nox2_count")%></th>
 <th class="nui-table-cell"><%=b.get("g_nox2_q_count")%></th>
 
 <th class="nui-table-cell"><%=b.get("g_q_count")%></th>
 <th class="nui-table-cell"><%=b.get("g_op_count")%></th>
 <th class="nui-table-cell"><%=b.get("g_t_count")%></th>
 <th class="nui-table-cell"><%=b.get("g_wp_count")%></th>
 
 <th class="nui-table-cell"><%=b.get("g_fh_count")%></th>
 <th class="nui-table-cell"><%=b.get("g_bz_count")%></th>
</tr>

<tr>
<th class="nui-table-cell">�ŷ�����</th>
<th class="nui-table-cell"><!--<%=b.get("g_pm_sum")%>-->-</th>
 <th class="nui-table-cell"><!--<%=b.get("g_pm2_sum")%>-->-</th>
 <th class="nui-table-cell"><%=v(b.get("g_pm2_q_sum"),q_r,format)%></th>
 
 <th class="nui-table-cell"><!--<%=b.get("g_so2_sum")%>-->-</th>
 <th class="nui-table-cell"><!--<%=b.get("g_so22_sum")%>-->-</th>
 <th class="nui-table-cell"><%=v(b.get("g_so22_q_sum"),q_r,format)%></th>
 
 
 <th class="nui-table-cell"><!--<%=b.get("g_nox_sum")%>-->-</th>
 <th class="nui-table-cell"><!--<%=b.get("g_nox2_sum")%>-->-</th>
 <th class="nui-table-cell"><%=v(b.get("g_nox2_q_sum"),q_r,format)%></th>

 <th class="nui-table-cell"><%=v(b.get("g_q_sum"),1,"0.##")%></th>
<!--
 <th class="nui-table-cell"><%=b.get("g_op_sum")%></th>
 <th class="nui-table-cell"><%=b.get("g_t_sum")%></th>
 <th class="nui-table-cell"><%=b.get("g_wp_sum")%></th>
 
 <th class="nui-table-cell"><%=b.get("g_fh_sum")%></th>
 <th class="nui-table-cell"><%=b.get("g_bz_sum")%></th>
-->
  <th class="nui-table-cell" colspan=6>-</th>
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