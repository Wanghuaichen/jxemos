<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
   BaseAction action = null;
   String now = StringUtil.getNowDate() + "";
   String date1, date2 = null;
   date1 = now;
   date2 = now;
   try{
    action = new WarnAction();
    action.run(request,response,"form");

   }catch(Exception e){
      w.error(e);
      return;
   }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title></title>
<script type="text/javascript" src="../../scripts/calendar.js"></script>
<script>
//alert(1);
function hello(){
// alert(1);
 //alert(form1);
form1.action='today.jsp';
  form1.submit();
}
 function f_1(){
  form1.action='today.jsp';
  document.getElementById("time_select").style.display="";
  form1.submit();
 }
 function f_his(){
  form1.action='his.jsp';
  document.getElementById("time_select").style.display="none";
  form1.submit();
 }
 
 
</script>

<style>
.search {font-family: "宋体";  BEHAVIOR: url('<%=request.getContextPath() %>/styles/selectBox.htc'); cursor: hand; }
.input {
   border: #ccc 1px solid;
   font-family: "微软雅黑";
   padding-top:2px;
   width: 100px;
   background:expression((this.readOnly &&this.readOnly==true)?"#f9f9f9":"")
}

.btn1{width:80px; height:23px; line-height:23px;  background:url(<%=request.getContextPath() %>/images/common/btn1.gif) no-repeat; border:none; text-align:center; }

</style>
</head>
<body onload=f_1() style="background-color: #f7f7f7;overflow-x:hidden">
<form name=form1 method=post target=q>
<table border=0 width=100% cellspacing=0 style="font-size: 13px;color: #01538a;font-weight: bold">

<tr>
<td style="height:20px;font-size: 12px;">
站位类型:
<select name="station_type" onchange=form1.submit() class="search">
<%=w.get("stationTypeOption")%>
</select>




地区:
<select name="area_id" onchange=form1.submit() class="search">
<%=w.get("areaOption")%>
</select>
<span id="time_select">
从:
<input type=text name=date1 id='date1' value="<%=date1%>" class=input readonly="readonly" onclick="new Calendar().show(this)" />
到:
<input type=text name=date2 id='date2' value="<%=date2%>" class=input readonly="readonly" onclick="new Calendar().show(this)" />
</span>
站位名称:
<input type=text name=station_name class="input" />
<input type=hidden name='txt_excel_content' />
<input type=button value="查看"  title="查看" class="btn1 button"  onclick=f_1() />

<input type=button value="历史超标"   class="btn1 button"  onclick=f_his() />
<%--<input type=button value="保存为excel" title="保存为excel" style=" background:url(<%=request.getContextPath() %>/images/common/btn1.gif) no-repeat; border:none;  width:80px;height:25px " onclick=f_save() />

--%>
<iframe name=q id="q" width=100% frameborder=0></iframe>
</td>
</tr>
</table>

</form>


<script>

function f_save(){
    var obj = window.frames["q"].window.document.getElementById('div_excel_content');
    //alert(obj);
    form1.txt_excel_content.value=obj.innerHTML;

    form1.action='/<%=ctx%>/pages/commons/save2excel.jsp';
    form1.submit();
}

//alert("您显示器的分辨率为:\n" + screen.width + "×" + screen.height + "像素");
if(screen.height>=900 && screen.height<=1024 ){
   document.getElementById("q").height=500;
}else if(screen.height>=800 && screen.height<900){
  document.getElementById("q").height=410;
}else if(screen.height>=768 && screen.height<800){
  document.getElementById("q").height=380;
}else if(screen.height>=720 && screen.height<768){
  document.getElementById("q").height=314;
}

</script>

</body>
</html>

