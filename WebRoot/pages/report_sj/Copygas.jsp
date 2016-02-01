<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

           String so2,pm,nox,op,t,q,q_lj,temp;
           float z_so2=0,z_pm=0,z_nox=0;
           String avg_so2 ,avg_pm ,avg_nox,sum_q,data_table;

          try{
            SjReport.gas(request);
            so2 = w.p("g_so2");
            pm = w.p("g_pm");
            nox = w.p("g_nox");
            q = w.p("g_q");
            q_lj = w.p("g_q_lj");
            op = w.p("g_op");
            t = w.p("g_t");
            data_table = request.getAttribute("r_data_table")+"";



          }catch(Exception e){
            w.error(e);
            return;
          }
          RowSet rs = w.rs("list");
          XBean tj = w.b("tj");
          int r = 1000*1000;
          String format = "0.0000";
          Integer lenobj = (Integer)request.getAttribute("len");
          int len = lenobj.intValue();
           String v_flag = "";//状态标志
          String css = "zc";
          double llzl = 0;//流量总量
           String t_ljz = "";//某时间段的累积值
          float z_ljz = 0;//总的累积值


          avg_so2 = tj.get(so2+"_avg",1,format);
          avg_pm = tj.get(pm+"_avg",1,format);
          avg_nox = tj.get(nox+"_avg",1,format);

          sum_q = tj.get(q+"_sum",1,format);
          

          if(!"".equals(avg_so2) && !"".equals(sum_q)){
             z_so2 = Float.parseFloat(avg_so2)  * Float.parseFloat(sum_q);
          }

          if(!"".equals(avg_pm) && !"".equals(sum_q)){
             z_pm = Float.parseFloat(avg_pm)  * Float.parseFloat(sum_q);
          }

          if(!"".equals(avg_nox) && !"".equals(sum_q)){
             z_nox = Float.parseFloat(avg_nox)  * Float.parseFloat(sum_q);
          }


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title></title>
<link href="../../styles/reset-min.css" rel="stylesheet" type="text/css" />
<link href="../../styles/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<link href="../../styles/common/common.css" rel="stylesheet" type="text/css" />
<link href="../../styles/common/select1.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../scripts/core/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.core.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.widget.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.tabs.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.check.js"></script>
<script type="text/javascript" src="../../scripts/jSelect/jselect.js"></script>
<script type="text/javascript" src="../../scripts/common.js"></script>
<style>
.title{color:#000; font-size:14px; font-weight:bold;position: relative; top: expression(this.offsetParent.scrollTop);}
</style>
</head>
<body>
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
   <th colspan=4>排放浓度</th>
   <th colspan=4>排放量</th>
  </tr>

  <tr class="title">
     <td></td>
    <td>颗粒物</td>
    <td>SO<sub>2</sub></td>
    <td>NO<sub>x</sub></td>
    <%--<td>烟气温度</td>
    <td>含氧量</td>--%>
    <td>标况流量</td>


   <td>颗粒物</td>
    <td>SO<sub>2</sub></td>
    <td>NO<sub>x</sub></td>
    <td>累积流量</td>
  </tr>

  <tr class="title">

    <td></td>
    <td>mg/m<sup>3</sup></td>
    <td>mg/m<sup>3</sup></td>
    <td>mg/m<sup>3</sup></td>
    <%--<td>mg/m<sup>3</sup></td>
    <td>mg/m<sup>3</sup></td>
    --%><td>m<sup>3</sup>/h</td>

    <td>Kg</td>
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
      
      t_ljz = f.format(f.getljll(rs.get(q,1,format),data_table,rs.get("m_time"),2+"")+"","0.0000");
      if(t_ljz !=null && !"".equals(t_ljz) && !"null".equals(t_ljz)){
         z_ljz = z_ljz + Float.valueOf(t_ljz);
      }
  %>
    <tr class="<%=css %>">
    <td><%=f.sub(rs.get("m_time"),0,len)%></td>

     <td><%=rs.get(pm,1,format)%></td>
      <td><%=rs.get(so2,1,format)%></td>
      <%--<td><%=rs.get(nox,1,format)%></td>
      <td><%=rs.get(t,1,format)%></td>
      --%><td><%=rs.get(op,1,format)%></td>
      <%--<td><%=rs.get(q,1,format)%></td>--%>
      <td><%=f.getwyliuliang(rs.get(q,1,format),data_table,rs.get("m_time"),2+"") %></td>

     <td><%=rs.get(pm+"_q",r,format)%></td>
      <td><%=rs.get(so2+"_q",r,format)%></td>
      <td><%=rs.get(nox+"_q",r,format)%></td>
      <td><%=t_ljz%></td>
     </tr>
  <%}%>

   <tr class='tj'>
        <td>最小值</td>


        <td><%=tj.get(pm+"_min")%></td>
        <td><%=tj.get(so2+"_min")%></td>
        <td><%=tj.get(nox+"_min")%></td><%--
        <td><%=tj.get(t+"_min")%></td>
        <td><%=tj.get(op+"_min")%></td>
        --%>
        <%--<td><%=tj.get(q+"_min")%></td>--%>
        <td><%=f.getwyliuliangp(tj.get(q+"_min"),data_table,2+"") %></td>

        <td ><%=f.format((z_pm/r)+"",format)%></td>
        <td ><%=f.format((z_so2/r)+"",format)%></td>
        <td ><%=f.format((z_nox/r)+"",format)%></td>
        <%--<td ><%=f.format(sum_q,format) %></td>--%>
        <td ><%=z_ljz %></td>
  </tr>

  <tr class='tj'>
        <td>最大值</td>


         <td><%=tj.get(pm+"_max")%></td>
        <td><%=tj.get(so2+"_max")%></td>
        <td><%=tj.get(nox+"_max")%></td>
        <%--<td><%=tj.get(t+"_max")%></td>
        <td><%=tj.get(op+"_max")%></td>
        --%>
        <%--<td><%=tj.get(q+"_max")%></td>--%>
        <td><%=f.getwyliuliangp(tj.get(q+"_max"),data_table,2+"") %></td>
        <td colspan=6></td>
  </tr>


   <tr class='tj'>
        <td>平均值</td>


         <td><%=tj.get(pm+"_avg",1,format)%></td>
        <td><%=tj.get(so2+"_avg",1,format)%></td>
        <td><%=tj.get(nox+"_avg",1,format)%></td>
        <%--<td><%=tj.get(t+"_avg",1,format)%></td>
        <td><%=tj.get(op+"_avg",1,format)%></td>
        --%>
        <%--<td><%=tj.get(q+"_avg",1,format)%></td> --%>
        <td><%=f.getwyliuliangp(tj.get(q+"_avg",1,format),data_table,2+"") %></td>
         <td colspan=6></td>
  </tr>



</table>
</div>
</body>
</html>
