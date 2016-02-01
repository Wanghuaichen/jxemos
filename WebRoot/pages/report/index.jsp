<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc_empty.jsp" %>
<%
  
String areaOption = null;
String date1 = null;
String date2 = null;
String now = StringUtil.getNowDate()+"";
date1=date2=now;
String area_id = null;

try{

area_id = request.getParameter("area_id");
if(f.empty(area_id)){
area_id=App.getAreaId();
}
date1 = request.getParameter("date1");
date2 = request.getParameter("date2");
if(f.empty(date1)){date1=now;}
if(f.empty(date2)){date2=now;}

areaOption = JspPageUtil.getAreaOption(area_id);
}catch(Exception e){
//out.println(e);
        JspUtil.go2error(request,response,e);
return;
}
    
     
%>
<SCRIPT language=JavaScript src="/<%=ctx%>/scripts/newdate.js"></SCRIPT>

<form name=form1 method=post target=reportq>
<table border=0 width=100% height=100%>
<tr>
<td height=20>
      <select name=rpt_name onchange=f_rpt()>
        <option value='../fx/report/air_rpt.jsp'>空气日报
        <option value='../fx/report/water_rpt.jsp'>水质日报
        <option value='./hz01.jsp'>污染源脱机联机报表
        <option value='../jx/rpt/07_form.jsp'>污染源水报表
        <option value='../jx/rpt/09_form.jsp'>污染源烟气报表
      </select>
      <br>
      
      <select name=area_id onchange=f_submit()>
      <%=areaOption%>
      </select>
      
<input name="date1" type="text" value="<%=date1%>" class=date onclick="new Calendar().show(this);">

<input name="date2" type="text" value="<%=date2%>" class=date onclick="new Calendar().show(this);"
 style="display:none">
   
   
    <input type=button name=rptbtn value='查看' onclick='f_submit()' class=btn>  
      
</td>
</tr>

<tr>
<td>
  <iframe id=reportq name=reportq width=100% height=100% frameborder=0></iframe>
</td>
</tr>
</table>

</form>

<script>


function f_hide_all(){
form1.area_id.style.display='none';
    form1.date1.style.display='none';
    form1.date2.style.display='none';
    form1.rptbtn.style.display='none';
}
function f_hide(){
    form1.date1.style.display='none';
    form1.date2.style.display='none';
}

function f_submit(){
 form1.submit();
}

 function f_rpt(){
 f_hide_all();
 
   var i = form1.rpt_name.selectedIndex;
   var s = form1.rpt_name.options[i].value;
   form1.action=s;
   form1.submit();
   //f_hide();
   
   if(i==2){
    form1.area_id.style.display='';
      // form1.date1.style.display='';
    //form1.date2.style.display='none';
    form1.rptbtn.style.display='';
   
   }
   
   if(i<2){
   form1.area_id.style.display='';
       form1.date1.style.display='';
    //form1.date2.style.display='none';
    form1.rptbtn.style.display='';
   }
 }
 f_rpt();
</script>