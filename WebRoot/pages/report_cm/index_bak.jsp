<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

    RowSet station,flist;



    try{

      SwjUpdate.report_cm_index(request);

    }catch(Exception e){
     w.error(e);
     return;
    }
    
    String sh_flag = request.getParameter("sh_flag");
    String shOption = SwjUpdate.getShState(sh_flag);
    String hzOption = SwjUpdate.gethzbbtype("");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>汇总报表</title>
<link href="../../styles/reset-min.css" rel="stylesheet" type="text/css" />
<link href="../../styles/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<link href="../../styles/common/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../scripts/core/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.core.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.widget.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.tabs.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.check.js"></script>
<script type="text/javascript" src="../../scripts/common.js"></script>
<script type="text/javascript" src="../../scripts/jquery.js"></script>
<script type="text/javascript" src="../../scripts/calendar.js"></script>

<style>
.search {font-family: "宋体"; font-size: 12px;width:auto; BEHAVIOR: url('<%=request.getContextPath() %>/styles/selectBox.htc'); cursor: hand; }
.input {
   border: #ccc 1px solid;
   font-family: "微软雅黑";
   font-size: 12px;
   padding-top:2px;
   width: 80px;
   background:expression((this.readOnly &&this.readOnly==true)?"#f9f9f9":"")
}

.btn1{  background:url(<%=request.getContextPath() %>/images/common/btn1.gif) no-repeat; border:none; text-align:center; }

</style>

</head>


<script type="text/javascript">

function f_save(){
//alert(window.frames["frm_station"].window.frames["q"]);
    var obj = window.frames["frm_station"].window.document.getElementById('div_excel_content');
    // alert(obj);
    //alert(obj.innerHTML);
    //var form2 = window.document.getElementById('excel_form');
    //alert(form2);
    form1.txt_excel_content.value=obj.innerHTML;
    
    var date1 = form1.date1.value;
    var date2 = form1.date2.value;
    if(date1 == date2){
        form1.title.value = date1+"日的汇总报表";
    }else {
        form1.title.value = "从"+date1+"到"+date2+"间的汇总报表";
    }
    

    form1.action='/<%=ctx%>/pages/commons/save2excel.jsp';
    form1.submit();
}

</script>

<body scroll=no onload=form1.submit() style="background-color: #f7f7f7;overflow-x:hidden">

<form name="form1" method=post action="rpt.jsp" target="frm_station">
<input type=hidden name='title' value='汇总报表' />
<input type=hidden name='txt_excel_content' />
<input type=hidden name='w_cols' value='val01,val02,val03,val04,val05,val06,val07,val08,val16,val17' />
<input type=hidden name='w_gross_cols' value='val01,val02,val05,val16,val17'  />
<input type=hidden name='w_q_col' value='val04'  />


<input type=hidden name='w_ph' value='val03'  />
<input type=hidden name='w_cod' value='val02'  />
<input type=hidden name='w_toc' value='val01'  />
<input type=hidden name='w_q' value='val04'  />
<input type=hidden name='w_q_lj' value='val08'  />
<input type=hidden name='w_nh3n' value='val05'  />
<input type=hidden name='w_tn' value='val17'  />
<input type=hidden name='w_tp' value='val16'  />
<input type=hidden name='station_id' value=''  />


<input type=hidden name='g_cols' value='val05,val06,val07,val04,val09,val11,val22'  />
<input type=hidden name='g_gross_cols' value='val05,val06,val07'  />
<input type=hidden name='g_q_col' value='val11'  />

<input type=hidden name='g_so2' value='val05'  />
<input type=hidden name='g_pm' value='val06'  />
<input type=hidden name='g_nox' value='val07'  />
<input type=hidden name='g_op' value='val04'  />
<input type=hidden name='g_t' value='val09'  />
<input type=hidden name='g_q' value='val11'  />
<input type=hidden name='g_s' value='val11'  />
<input type=hidden name='g_q_lj' value='valxx'  />

<div class="fieldArea" id="fieldArea" >
    <fieldset>
    <div class="selarea">
    
    <div class="item">
          报表类型:
		<select name="hzbb_type"  onchange=f_r()  style="width:120px;">
		<%=hzOption %>
       </select>
   </div>

   <div class="item">
          站位类型:
		<select name=station_type  onchange=f_r() >
			<%=w.get("stationTypeOption")%>
		</select>
   </div>
    <%--
   <div class="item">
          地区:
		<select name=area_id id="area" onchange="select_area(form.area_id.options[form.area_id.selectedIndex].value)">
			<%=w.get("areaOption")%>
		</select>
   </div>
    --%>
  
  
   <div class="item">
          地区:
		<select name=area_id id="area" onchange=f_r()>
			<%=w.get("areaOption")%>
		</select>
   </div>
   
   <div class="item">
          行业:
		<select name=trade_id onchange=f_r()  >
			<option value='root'>请选择行业</option>
			<%=w.get("tradeOption")%>
		</select>
   </div>
   
   
   <br/>
   <br/>
   <span style="width:100%;height:5px"></span>
   <%--<div class="item">
          &nbsp;&nbsp;&nbsp;&nbsp;流域:
		<select name=valley_id onchange=f_r() >
			<option value='1100000000'>请选择流域</option>
			<%=w.get("valleyOption")%>
		</select>
   </div>--%>
   
    
   <div class="item">
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;从:
      <input type='text' class='input' name='date1' id='date1' value='<%=w.get("date1")%>' readonly="readonly" onclick="new Calendar().show(this);" /> 
           到:
      <input type='text' class='input' name='date2' id='date2' value='<%=w.get("date2")%>' readonly="readonly" onclick="new Calendar().show(this);" /> 
   </div>

   <div class="item">
           数据状态:
		<select name="sh_flag"  onchange=f_submit()  style="width:80px;">
		<%=shOption %>
       </select>
   </div>
   
   <div class="item">
        <input type="button" value='查看' title="查看" style="width:80px" class="btn1 button" onclick='f_submit()' id='btn_view' />
    </div>
    <div class="item">
       <input type="button" value='保存为excel' title="保存为excel" class="btn1 button"  onclick=f_save() />
   </div>
</div>
</fieldset>

</div>
</form>

<iframe name="frm_station" id="frm_station"  width=100% height=450px  frameborder="0"  style="border:0px" allowtransparency="true">
</iframe>

<script>
function f_submit(){
  form1.action='rpt.jsp';
  form1.target='frm_station';
  form1.submit();

}
 function f_r(){
   form1.action='rpt.jsp';
   form1.target='frm_station';
   form1.submit();
   
 }
 
 function select_area(id){
       var id = id;
       
       if(id !="" && id.length<=4){
		   var url="<%=request.getContextPath() %>/servlet/ServletSys?area_id="+id;
	       $.post(url,null,select_area_databack);
	       return false;
	   }
	   f_r();
 }
 
 function select_area_databack(databack){
    var area = document.getElementById("area");
   // alert(databack);
    area.innerHTML = "";
    $("#area").append(databack);
    f_r();
 }

//alert("您显示器的分辨率为:\n" + screen.width + "×" + screen.height + "像素");

if(screen.height>=900 && screen.height<=1024 ){
   document.getElementById("frm_station").height=490;
}else if(screen.height>=800 && screen.height<900){
  document.getElementById("frm_station").height=390;
}else if(screen.height>=768 && screen.height<800){
  document.getElementById("frm_station").height=350;
}else if(screen.height>=720 && screen.height<768){
  document.getElementById("frm_station").height=314;
}


</script>




