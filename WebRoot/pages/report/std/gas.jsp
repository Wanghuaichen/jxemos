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
                   if(f.eq(report_type,"month")){return "日期";}
                    if(f.eq(report_type,"year")){return "月份";}
                     return "时";
}

public int getIndex(int i,String report_type){
                           if(f.eq(report_type,"day")){return i;}else{return i+1;}
                 }


public String getTimeString(Timestamp time,String report_type)throws Exception{
                 String format = "yy年mm月dd日";
                 if(f.eq(report_type,"month")){format="yy年mm月";}
                  if(f.eq(report_type,"year")){format="yy年";}
                   return StringUtil.format(time,format);
}

public String getTitle(String report_type){
        
        if(f.eq(report_type,"month")){
        return "烟气排放连续监测日平均值月报表";
        }
         if(f.eq(report_type,"year")){
        return "烟气排放连续监测月平均值年报表";
        }
        
        return "烟气排放连续监测小时平均值日报表";
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


<div>排放源名称:<%=w.get("station_name")%></div>
	<span style="visibility: hidden;">hold space</span>
<div>排放源编号:<%=w.get("station_id")%> 监测日期:<%=getTimeString(time,report_type)%></div>

	<table class="nui-table-inner major">
		<thead class="nui-table-head">
			<tr class="nui-table-row">
<th class="nui-table-cell" rowspan=2>时间(<%=getIndexTitle(report_type)%>)</th>
<th class="nui-table-cell" colspan=3>颗粒物</th>
<th class="nui-table-cell" colspan=3>SO<sub>3</sub></th>
<th class="nui-table-cell" colspan=3>NO<sub>x</sub></th>

<th class="nui-table-cell" rowspan=2>流量m<sup>3</sup></th>
<th class="nui-table-cell" rowspan=2>O<sub>2</sub>%</th>
<th class="nui-table-cell" rowspan=2>温度</th>
<th class="nui-table-cell" rowspan=2>水分含量%</th>
<th class="nui-table-cell" rowspan=2>负荷%</th>
<th class="nui-table-cell" rowspan=2>备注</th>

</tr>

<tr>
<th class="nui-table-cell">mg/m<sup>3</sup></th>
<th class="nui-table-cell">折算mg/m<sup>3</sup></th>
<th class="nui-table-cell">kg</th>

<th class="nui-table-cell">mg/m<sup>3</sup></th>
<th class="nui-table-cell">折算mg/m<sup>3</sup></th>
<th class="nui-table-cell">kg</th>

<th class="nui-table-cell">mg/m<sup>3</sup></th>
<th class="nui-table-cell">折算mg/m<sup>3</sup></th>
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
<th class="nui-table-cell">平均值</th>
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
<th class="nui-table-cell">最大值</th>
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
<th class="nui-table-cell">最小值</th>
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
<th class="nui-table-cell">样本数</th>
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
<th class="nui-table-cell">排放总量</th>
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
<div>上报单位（盖章）： &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
负责人： &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
报告人： &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
报告日期：  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  年 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 月  
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 日</div>
</div>