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
<div style="text-align:center;font-weight:bold;font-size:15px"><%=getTitle(report_type)%></div>


<div>排放源名称:<%=w.get("station_name")%></div>
<div>排放源编号:<%=w.get("station_id")%> 监测日期:<%=getTimeString(time,report_type)%></div>

<table width=100% cellspacing=1 border=0>
<tr>
<td rowspan=2>时间(<%=getIndexTitle(report_type)%>)</td>
<td colspan=3>颗粒物</td>
<td colspan=3>SO<sub>3</sub></td>
<td colspan=3>NO<sub>x</sub></td>

<td rowspan=2>流量m<sup>3</sup></td>
<td rowspan=2>O<sub>2</sub>%</td>
<td rowspan=2>温度</td>
<td rowspan=2>水分含量%</td>
<td rowspan=2>负荷%</td>
<td rowspan=2>备注</td>

</tr>

<tr>
<td>mg/m<sup>3</sup></td>
<td>折算mg/m<sup>3</sup></td>
<td>kg</td>

<td>mg/m<sup>3</sup></td>
<td>折算mg/m<sup>3</sup></td>
<td>kg</td>

<td>mg/m<sup>3</sup></td>
<td>折算mg/m<sup>3</sup></td>
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
<td>平均值</td>
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
<td>最大值</td>
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
<td>最小值</td>
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
<td>样本数</td>
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
<td>排放总量</td>
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
<div>上报单位（盖章）： &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
负责人： &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
报告人： &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
报告日期：  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  年 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 月  
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 日</div>
</div>