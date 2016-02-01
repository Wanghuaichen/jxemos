<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc_empty.jsp" %>

<script>
function h(){
alert(1);
}
function f_submit(){

  var i = form1.rpt_name.selectedIndex;
   var s = form1.rpt_name.options[i].value;
   form1.action=s;
   form1.submit();
}

function f_save(){
//alert(window.frames["reportq"]);
    var obj = window.frames["reportq"].window.frames["q"].window.document.getElementById('div_excel_content');
    //alert(obj);
    //alert(obj.innerHTML);
    //var form2 = window.document.getElementById('excel_form');
    //alert(form2);
    form1.txt_excel_content.value=obj.innerHTML;
    
    form1.action='/<%=ctx%>/pages/commons/save2excel.jsp';
    form1.submit();
}

</script>

<body scroll=no onload=f_submit()>

<form name=form1  method=post target=reportq>
<input type=hidden name='txt_excel_content'>
<table border=0 width=100% height=100%>
<tr>
<td height=20px>
  <select name=rpt_name onchange=f_submit()>
  <option value='01_form.jsp'>脱机统计报表
  <option value='02_form.jsp'>污染源在线监测日报表
  </select>
  <!--
  <input type=button value='查看' onclick=f_submit()>
  -->
  <input type=button value="保存为excel" class="btn" onclick=f_save()>
  </td>
  </tr>
  
  <tr>
  <td>
  <iframe name=reportq width=100% height=100% frameborder=0>
  </td>
  </tr>
</table>
</form>



<form id='excel_form' method=post>
<input type=hidden name='txt_excel_content'>
</form>

</body>



