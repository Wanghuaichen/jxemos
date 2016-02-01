<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
        String date1 = request.getParameter("date1");
     BaseAction action = null;
     int i=0;
     
      try{
   
   action = new FyReport();
  action.run(request,response,"rpt08");
  
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   RowSet rs = w.rs("data");  
%>

<script>
function f_save(){
//alert(window.frames["reportq"]);
    //var obj = window.frames["reportq"].window.frames["q"].window.document.getElementById('div_excel_content');
   var obj = document.getElementById('div_excel_content');
    //alert(obj);
    //alert(obj.innerHTML);
    //var form2 = window.document.getElementById('excel_form');
    //alert(form2);
    form1.txt_excel_content.value=obj.innerHTML;
    
    form1.action='/<%=ctx%>/pages/commons/save2excel.jsp';
    form1.submit();
}

</script>

<form name=form1 method=post>
<input type=hidden name='txt_excel_content'>
</form>
<div style="text-align:left"><input type=button value='保存为excel' onclick=f_save() class=btn></div>
<div id='div_excel_content'>
<div  style="font-size:18px;font-weight:bold;text-align:center">

  <%=f.df(date1,"yy年mm月")%> <%=w.get("station_name")%>  企业超标情况
</div>
<table border=0 cellspacing=1 style="width:200%">
<tr class=title>
   <td></td>
   <%for(i=0;i<24;i++){%>
    <td><%=i+1%></td>  
   <%}%>
   <td>当日COD最大值</td>
   <td>超标时段COD平均值</td>
   <td>备注</td>
</tr>
  <%while(rs.next()){%>
    <tr>
    <td><%=rs.get("dd")%></td>
    <%for(i=0;i<24;i++){%>
    <td><%=rs.get(i+"")%></td>  
   <%}%>
    <td><%=rs.get("max")%></td>
    <td><%=rs.get("avg",1,"0.##")%></td>
    <td></td>
    </tr>
  <%}%>

</table>

</div>
