<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

           String ph,cod,toc,q,q_lj,nh3n,tn,tp,temp,data_table;
           String avg_cod,avg_toc,avg_nh3n,avg_tn,avg_tp,sum_q;
          try{
            SjReport.water(request);
            ph = w.p("w_ph"); //val03
            cod = w.p("w_cod");//val02
            toc = w.p("w_toc");//val01
            q = w.p("w_q"); //val04
            q_lj = w.p("w_q_lj");//
            nh3n = w.p("w_nh3n");//val05
            tn = w.p("w_tn");//val17
            tp = w.p("w_tp");//val16
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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>在线检测和监控管理系统</title>
<!-- <link rel="stylesheet" href="../../web/index.css" /> -->
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css" />
</head>
<body >
<div id="div_excel_content" >
<table class="nui-table-inner">
<thead class="nui-table-head">
	<tr class="nui-table-row">
		<th colspan=12 class="nui-table-cell"> 当前统计：<%=w.get("station_name")%> <%=w.get("area_name")%> <%=w.get("data_table")%>
 <%=w.get("date1")%> 到 <%=w.get("date2")%></th>
	</tr>
	<tr class="nui-table-row">
		<th class="nui-table-cell">监测时间</th>
		<th colspan=6 class="nui-table-cell">排放浓度</th>
		<th colspan=5 class="nui-table-cell">排放量</th>
	</tr>
	 <tr class='nui-table-row'>
  	<th class="nui-table-cell"></th>
    <th class="nui-table-cell">PH</th>
    <th class="nui-table-cell">COD(mg/L)</th>
    <%--<th class="nui-table-cell">TOC</th>
    --%><th class="nui-table-cell">氨氮(mg/L)</th>
    <th class="nui-table-cell">总氮(mg/L)</th>
    <th class="nui-table-cell">总磷(mg/L)</th>
    <th class="nui-table-cell">流量(L/s)</th>

    <th class="nui-table-cell">COD(Kg)</th>
    <%--<th class="nui-table-cell">TOC</th>
    --%><th class="nui-table-cell">氨氮(Kg)</th>
    <th class="nui-table-cell">总氮(Kg)</th>
    <th class="nui-table-cell">总磷(Kg)</th>
    <th class="nui-table-cell">累积流量(m<sup>3</sup>)</th>
  </tr>

<!--   <tr class='nui-table-row'> -->
<!--   	<th colspan=2 class='nui-table-cell'></th> -->

<!--     <th class="nui-table-cell">mg/L</th> -->
<!--     <th class="nui-table-cell">mg/L</th> -->
<!--     <%--<th class="nui-table-cell">mg/L</th> -->
<!--     --%><th class="nui-table-cell">mg/L</th> -->
<!--     <th class="nui-table-cell">mg/L</th> -->
<!--     <%--<th class="nui-table-cell">m<sup>3</sup>/h</th>--%> -->
<!--     <th class="nui-table-cell">L/s</th> -->
    
    
<!--     <th class="nui-table-cell">Kg</th> -->
<!--     <%--<th class="nui-table-cell">Kg</th> -->
<!--     --%><th class="nui-table-cell">Kg</th> -->
<!--     <th class="nui-table-cell">Kg</th> -->
<!--     <th class="nui-table-cell">Kg</th> -->
<!--     <th class="nui-table-cell">m<sup>3</sup></th> -->
<!--   </tr> -->
</thead>
<tbody class="nui-table-body">
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
     <tr class='nui-table-row'>
   <th class="nui-table-cell"><%=f.sub(rs.get("m_time"),0,len)%></th>

      <th class="nui-table-cell"><%=rs.get(ph,1,"0.00")%></th>


      <th class="nui-table-cell"><%=rs.get(cod,1,format)%></th><%--
      <th class="nui-table-cell"><%=rs.get(toc,1,format)%></th>
      --%><th class="nui-table-cell"><%=rs.get(nh3n,1,format)%></th>
      <th class="nui-table-cell"><%=rs.get(tn,1,format)%></th>
      <th class="nui-table-cell"><%=rs.get(tp,1,format)%></th>
      <th class="nui-table-cell"><%=rs.get(q,1,format)%></th>

      <%--<th class="nui-table-cell"><%=rs.get(cod+"_q",r,format)%></th>
      <th class="nui-table-cell"><%=rs.get(toc+"_q",r,format)%></th>
      <th class="nui-table-cell"><%=rs.get(nh3n+"_q",r,format)%></th>
      <th class="nui-table-cell"><%=rs.get(tn+"_q",r,format)%></th>
      <th class="nui-table-cell"><%=rs.get(tp+"_q",r,format)%></th>--%>
      
      <th class="nui-table-cell"><%=t_cod%></th>
      <th class="nui-table-cell"><%=t_nh3n%></th>
      <th class="nui-table-cell"><%=t_tn%></th>
      <th class="nui-table-cell"><%=t_tp%></th>
      
      <%--<th class="nui-table-cell"><%=rs.get(q,1,format)%></th>--%>
      <th class="nui-table-cell"><%=t_ljz %></th>
    </tr>
  <%}%>

   <tr class='nui-table-row'>
        <th class="nui-table-cell">最小值</th>

        <th class="nui-table-cell"><%=tj.get(ph+"_min",1,"0.00")%></th>

        <th class="nui-table-cell"><%=tj.get(cod+"_min",1,format)%></th>
        <%--<th class="nui-table-cell"><%=tj.get(toc+"_min")%></th>
        --%><th class="nui-table-cell"><%=tj.get(nh3n+"_min",1,format)%></th>
        <th class="nui-table-cell"><%=tj.get(tn+"_min",1,format)%></th>
        <th class="nui-table-cell"><%=tj.get(tp+"_min",1,format)%></th>
        <th class="nui-table-cell"><%=tj.get(q+"_min",1,format)%></th>
       <th colspan="5" class="nui-table-cell"></th>

  </tr>

   <tr class='nui-table-row'>
        <th class="nui-table-cell">最大值</th>

        <th class="nui-table-cell"><%=tj.get(ph+"_max",1,"0.00")%></th>
        <th class="nui-table-cell"><%=tj.get(cod+"_max",1,format)%></th><%--
        <th class="nui-table-cell"><%=tj.get(toc+"_max")%></th>
        --%><th class="nui-table-cell"><%=tj.get(nh3n+"_max",1,format)%></th>
        <th class="nui-table-cell"><%=tj.get(tn+"_max",1,format)%></th>
        <th class="nui-table-cell"><%=tj.get(tp+"_max",1,format)%></th>
        <th class="nui-table-cell"><%=tj.get(q+"_max",1,format)%></th>
 		<%--<th class="nui-table-cell"><%=f.format2((z_cod/1000)+"",format)%></th>
        <th class="nui-table-cell"><%=f.format((z_toc/1000)+"",format)%></th>
        <th class="nui-table-cell"><%=f.format2((z_nh3n/1000)+"",format)%></th>
        <th class="nui-table-cell"><%=f.format2((z_tn/1000)+"",format)%></th>
        <th class="nui-table-cell"><%=f.format2((z_tp/1000)+"",format)%></th>
        --%><%--<th class="nui-table-cell"><%=tj.get(q+"_sum",1,format)%></th>--%>
        
        <%--<th class="nui-table-cell"><%=f.format(f.getljll((z_cod/1000)+"",data_table,1+"")+"","0.0000")%></th>
        <th class="nui-table-cell"><%=f.format(f.getljll((z_nh3n/1000)+"",data_table,1+"")+"","0.0000")%></th>
        <th class="nui-table-cell"><%=f.format(f.getljll((z_tn/1000)+"",data_table,1+"")+"","0.0000")%></th>
        <th class="nui-table-cell"><%=f.format(f.getljll((z_tp/1000)+"",data_table,1+"")+"","0.0000")%></th> --%>
        
        <th colspan="5" class="nui-table-cell"></th>
      </tr>
    <tr class='nui-table-row'>
        <th class="nui-table-cell">平均值</th>

        <th class="nui-table-cell"><%=tj.get(ph+"_avg",1,"0.00")%></th>
        <th class="nui-table-cell"><%=tj.get(cod+"_avg",1,format)%></th>
        <%--<th class="nui-table-cell"><%=tj.get(toc+"_avg",1,format)%></th>
        --%><th class="nui-table-cell"><%=tj.get(nh3n+"_avg",1,format)%></th>
        <th class="nui-table-cell"><%=tj.get(tn+"_avg",1,format)%></th>
        <th class="nui-table-cell"><%=tj.get(tp+"_avg",1,format)%></th>
        <th class="nui-table-cell"><%=tj.get(q+"_avg",1,format)%></th>
        <th colspan="5" class="nui-table-cell"></th>
  </tr>
   <tr class='nui-table-row'>
        <th class="nui-table-cell">总计</th>
        <th colspan="6"  class="nui-table-cell"></th>
        <th class="nui-table-cell"><%=z_cod %></th>
        <th class="nui-table-cell"><%=z_nh3n %></th>
        <th class="nui-table-cell"><%=z_tn %></th>
        <th class="nui-table-cell"><%=z_tp%></th>
        <th class="nui-table-cell"><%=z_ljz%></th>
    </tr>
</tbody>
</table>

</div>
</body>
</html>
