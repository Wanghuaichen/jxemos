<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

           String ph,cod,toc,q,q_lj,nh3n,tn,tp,temp,data_table;
           String avg_cod,avg_toc,avg_nh3n,avg_tn,avg_tp,sum_q;
          try{
            SjReport.water(request);
            ph = w.p("w_ph");
            cod = w.p("w_cod");
            toc = w.p("w_toc");
            q = w.p("w_q");
            q_lj = w.p("w_q_lj");
            nh3n = w.p("w_nh3n");
            tn = w.p("w_tn");
            tp = w.p("w_tp");
            data_table = request.getAttribute("r_data_table")+"";

          }catch(Exception e){
            w.error(e);
            return;
          }
          RowSet rs = w.rs("list");
          XBean tj = w.b("tj");
          int r = 1000;
          String format = "0.0000";
          Integer lenobj = (Integer)request.getAttribute("len");
          int len = lenobj.intValue();
          String v_flag = "";//状态标志
          String css = "zc";

          avg_cod = tj.get(cod+"_avg",1,format);
          avg_toc = tj.get(toc+"_avg",1,format);
          avg_nh3n = tj.get(nh3n+"_avg",1,format);
          avg_tn = tj.get(tn+"_avg",1,format);
          avg_tp = tj.get(tp+"_avg",1,format);
          sum_q = tj.get(q+"_sum",1,format);
          String t_ljz = "";//某时间段的累积值
          float z_ljz = 0;//总的累积值
          String ljll = "";
          
          String t_cod = "";//COD
          float z_cod = 0;//COD排放量
          String t_nh3n = "";//
          float z_nh3n = 0;//氨氮排放量
          String t_tn = "";
          float z_tn = 0;//总氮
          String t_tp = "";
          float z_tp = 0;//总磷

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<TITLE></TITLE>
<link href="../../styles/reset-min.css" rel="stylesheet" type="text/css" />
<link href="../../styles/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<link href="../../styles/common/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../scripts/core/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.core.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.widget.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.tabs.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.check.js"></script>
<script type="text/javascript" src="../../scripts/common.js"></script>
<style>
.title{color:#000; font-size:14px; font-weight:bold;position: relative; top: expression(this.offsetParent.scrollTop);}
</style>
</HEAD>
<body style="background-color: #f7f7f7;overflow-x:hidden">
<div id="div_excel_content" class="tableSty1 view3">

<div class=title>
 当前统计：<%=w.get("station_name")%> <%=w.get("area_name")%> <%=w.get("data_table")%>
 <%=w.get("date1")%> 到 <%=w.get("date2")%>
</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr class='title'>
  <!--
   <td rowspan=3>站位名称</td>
   <td rowspan=3>区域</td>
   -->

   <th >监测时间</th>
   <th colspan=6>排放浓度</th>
   <th colspan=6>排放量</th>
  </tr>

  <tr class='title'>
  	<td></td>
    <td>PH</td>
    <td>COD</td>
    <%--<td>TOC</td>
    --%><td>氨氮</td>
    <td>总氮</td>
    <td>总磷</td>
    <td>流量</td>

    <td>COD</td>
    <%--<td>TOC</td>
    --%><td>氨氮</td>
    <td>总氮</td>
    <td>总磷</td>
    <td>累积流量</td>
  </tr>

  <tr class='title'>
  	<td colspan=2></td>

    <td>mg/L</td>
    <td>mg/L</td>
    <%--<td>mg/L</td>
    --%><td>mg/L</td>
    <td>mg/L</td>
    <%--<td>m<sup>3</sup>/h</td>--%>
    <td>L/s</td>
    
    
    <td>Kg</td>
    <%--<td>Kg</td>
    --%><td>Kg</td>
    <td>Kg</td>
    <td>Kg</td>
    <td>m<sup>3</sup></td>
  </tr>

  <%
     while(rs.next()){
      v_flag = rs.get("v_flag");
      if(!"".equals(v_flag) && v_flag.equals("5") ){
        css = "wx";
      }else if(!"".equals(v_flag) && v_flag.equals("7")){
        css = "bl";
      }
      t_ljz = f.format(f.getljll(rs.get(q,1,format),data_table,1+"")+"","0.0000");
      if(t_ljz !=null && !"".equals(t_ljz) && !"null".equals(t_ljz)){
         z_ljz = z_ljz + Float.valueOf(t_ljz);
      }
      
      t_cod = f.format(f.getljll(rs.get(cod+"_q",r,format),data_table,1+"")+"","0.0000");
      if(t_cod !=null && !"".equals(t_cod) && !"null".equals(t_cod)){
         z_cod = z_cod + Float.valueOf(t_cod);
      }
      
      t_nh3n = f.format(f.getljll(rs.get(nh3n+"_q",r,format),data_table,1+"")+"","0.0000");
      if(t_nh3n !=null && !"".equals(t_nh3n) && !"null".equals(t_nh3n)){
         z_nh3n = z_nh3n + Float.valueOf(t_nh3n);
      }
      
      t_tn= f.format(f.getljll(rs.get(tn+"_q",r,format),data_table,1+"")+"","0.0000");
      if(t_tn !=null && !"".equals(t_tn) && !"null".equals(t_tn)){
         z_tn = z_tn + Float.valueOf(t_tn);
      }
      
      t_tp = f.format(f.getljll(rs.get(tp+"_q",r,format),data_table,1+"")+"","0.0000");
      if(t_tp !=null && !"".equals(t_tp) && !"null".equals(t_tp)){
         z_tp = z_tp + Float.valueOf(t_tp);
      }

  %>
    <tr>
   <td><%=f.sub(rs.get("m_time"),0,len)%></td>

      <td><%=rs.get(ph)%></td>


      <td><%=rs.get(cod,1,format)%></td><%--
      <td><%=rs.get(toc,1,format)%></td>
      --%><td><%=rs.get(nh3n,1,format)%></td>
      <td><%=rs.get(tn,1,format)%></td>
      <td><%=rs.get(tp,1,format)%></td>
      <td><%=rs.get(q,1,format)%></td>

      <%--<td><%=rs.get(cod+"_q",r,format)%></td>
      <td><%=rs.get(toc+"_q",r,format)%></td>
      <td><%=rs.get(nh3n+"_q",r,format)%></td>
      <td><%=rs.get(tn+"_q",r,format)%></td>
      <td><%=rs.get(tp+"_q",r,format)%></td>--%>
      
      <td><%=t_cod%></td>
      <td><%=t_nh3n%></td>
      <td><%=t_tn%></td>
      <td><%=t_tp%></td>
      
      <%--<td><%=rs.get(q,1,format)%></td>--%>
      <td><%=t_ljz %></td>
    </tr>
  <%}%>

  <tr>
        <td>最小值</td>

        <td><%=tj.get(ph+"_min")%></td>

        <td><%=tj.get(cod+"_min")%></td>
        <%--<td><%=tj.get(toc+"_min")%></td>
        --%><td><%=tj.get(nh3n+"_min")%></td>
        <td><%=tj.get(tn+"_min")%></td>
        <td><%=tj.get(tp+"_min")%></td>
        <td><%=tj.get(q+"_min")%></td>

        <td colspan=6></td>

  </tr>

  <tr>
        <td>最大值</td>

        <td><%=tj.get(ph+"_max")%></td>
        <td><%=tj.get(cod+"_max")%></td><%--
        <td><%=tj.get(toc+"_max")%></td>
        --%><td><%=tj.get(nh3n+"_max")%></td>
        <td><%=tj.get(tn+"_max")%></td>
        <td><%=tj.get(tp+"_max")%></td>
        <td><%=tj.get(q+"_max")%></td>
 		<%--<td><%=f.format2((z_cod/1000)+"",format)%></td>
        <td><%=f.format((z_toc/1000)+"",format)%></td>
        <td><%=f.format2((z_nh3n/1000)+"",format)%></td>
        <td><%=f.format2((z_tn/1000)+"",format)%></td>
        <td><%=f.format2((z_tp/1000)+"",format)%></td>
        --%><%--<td><%=tj.get(q+"_sum",1,format)%></td>--%>
        
        <%--<td><%=f.format(f.getljll((z_cod/1000)+"",data_table,1+"")+"","0.0000")%></td>
        <td><%=f.format(f.getljll((z_nh3n/1000)+"",data_table,1+"")+"","0.0000")%></td>
        <td><%=f.format(f.getljll((z_tn/1000)+"",data_table,1+"")+"","0.0000")%></td>
        <td><%=f.format(f.getljll((z_tp/1000)+"",data_table,1+"")+"","0.0000")%></td> --%>
        
        <td><%=f.format3(z_cod,"0.0000")%></td>
      <td><%=f.format3(z_nh3n,"0.0000")%></td>
      <td><%=f.format3(z_tn,"0.0000")%></td>
      <td><%=f.format3(z_tp,"0.0000")%></td>
        
       <td><%=f.format3(z_ljz,"0.0000")%></td>
      </tr>
   <tr>
        <td>平均值</td>

        <td><%=tj.get(ph+"_avg",1,format)%></td>
        <td><%=tj.get(cod+"_avg",1,format)%></td>
        <%--<td><%=tj.get(toc+"_avg",1,format)%></td>
        --%><td><%=tj.get(nh3n+"_avg",1,format)%></td>
        <td><%=tj.get(tn+"_avg",1,format)%></td>
        <td><%=tj.get(tp+"_avg",1,format)%></td>
        <td><%=tj.get(q+"_avg",1,format)%></td>
 		<td colspan=6></td>
  </tr>

</table>

</div>
</body>
</html>