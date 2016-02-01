<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

    try{
    
      SwjUpdate.station_index(request);
    
    }catch(Exception e){
     w.error(e);
     return;
    }

    boolean iswry = f.iswry(w.get("station_type"));
    RowSet rs = w.rs("flist");
    
    
%>
<body scroll=no onload='f_real()'>
<form name=form1 method=post target='frm_real_data'>
<table style='width:100%;height:100%' border=0 cellspacing=0>
   <tr>
     <td style='height:20px'>
   
<select name=station_type  onchange=f_rr()>
<%=w.get("stationTypeOption")%>
</select>
               
<select name=area_id onchange=f_r()>
<%=w.get("areaOption")%>
</select>

<br>

<select name=ctl_type onchange=f_r()>
<option value=''>重点源属性</option>
<%=w.get("ctlTypeOption")%>
</select>


<select name=valley_id onchange=f_r()>
<option value=''>流域</option>
<%=w.get("valleyOption")%>
</select>

<select name=trade_id onchange=f_r() >
<option value=''>行业
<%=w.get("tradeOption")%>
</select>
     
     <input type=text name='station_desc' value='' style='width:100px'>
     <input type=checkbox value='1' name='focus_flag'>只显示收藏
     <input type=button value='实时数据' onclick='f_real()' class='btn'>
    
     <input type=button value='小时数据' onclick='f_hour()' class='btn'>
     <!--<input type=button value='异常' onclick='f_yc()' class='btn'>--> 
     <input type=button value='打印' onclick='f_print()' class='btn'>  
     
     <br>
     |
     <%while(rs.next()){%>
       <input type=checkbox name='infectant_id' value='<%=rs.get("infectant_id")%>' checked>
       <%=rs.get("infectant_name")%> | 
     <%}%>
     
     </td>
   </tr>
   
   <tr>
     <td style='height:100%'>
      <iframe name='frm_real_data' id='frm_real_data' width=100% height=100% frameborder=0></iframe>
     </td>
   </tr>
   
</table>
</form>
</body>

<script>

function f_rr(){
 //form1.submit();
 form1.action='index_zj.jsp';
 form1.target='';
 form1.submit();
}
function f_submit(){
 form1.submit();
}
function f_r(){
 form1.submit();
}
 function f_real(){
   //alert('real');
    form1.action='real.jsp';
    form1.submit();
 }
 
  function f_hour(){
   //alert('hour');
   form1.action='hour.jsp';
    form1.submit();
 }
 
  function f_yc(){
   //alert('yc');
    form1.action='offline.jsp';
    form1.submit();
 }
 function f_print(){
  //document.frames['q'].print();
  //window.frames["q"].window.print();
  //window.frames["q"].window.f_print();
  var obj = getobj("frm_real_data");
  //window.frames["q"].document.execCommand('print');
  obj.document.execCommand('print');
}
 
 window.setInterval('f_submit()',60000);
 
 
</script>


