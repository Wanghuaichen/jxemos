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
<title>在线检测和监控管理系统</title>
<link rel="stylesheet" href="../../web/index.css"/>
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
</head>
<body onload=f_1() style="overflow: hidden;">
<form name=form1 method=post target=q>
	<div class="frame-main-content" style="left:0; top:0;position: static;">
	    <div class="nt">
	    	<p class="tiaojiao-p">
	    	站位类型:
			<select name="station_type" onchange=form1.submit() class="selectoption" >
			<%=w.get("stationTypeOption")%>
			</select>
	    	</p>
	    	<p class="tiaojiao-p">
	    	地区:
			<select name="area_id" onchange=form1.submit() class="selectoption" >
			<%=w.get("areaOption")%>
			</select>
	    	</p>
	    	 <p class="tiaojiao-p">
	    	 <span id="time_select">
	    	 	从:
				<input type=text name=date1 id='date1' value="<%=date1%>" class="c1" readonly="readonly" onclick="new Calendar().show(this)" />
				到:
				<input type=text name=date2 id='date2' value="<%=date2%>" class="c1" readonly="readonly" onclick="new Calendar().show(this)" />
	    	 </span>
	    	 </p>
	    	 <p class="tiaojiao-p">
	    	 	站位名称：<input type=text name=station_name class="c1" />
	    	 </p>
	    	 
	    	 <input type=hidden name='txt_excel_content' />
			<input id="buttonSee" type=button value="查看"  title="查看" class="tiaojianbutton"  onclick="f_1();" />
			<input id="buttonHis" type=button value="历史超标"  class="tiaojianbutton"  onclick="f_his();f_click1()" />
	    	 <input id="buttonBak" type=button value="返回"  title="返回" class="tiaojianbutton"  onclick="f_1();f_click2()" style="display: none;"/>
	    </div>
	    
	</div>
	 
</form><iframe name=q id="q" width=100% style="height: 85%" frameborder=0></iframe>
<script>
function f_click1(){
	document.getElementById("buttonSee").style.display="none";
	document.getElementById("buttonHis").style.display="none";
	document.getElementById("buttonBak").style.display="";
}
function f_click2(){
	document.getElementById("buttonSee").style.display="";
	document.getElementById("buttonHis").style.display="";
	document.getElementById("buttonBak").style.display="none";
}
function f_save(){
    var obj = window.frames["q"].window.document.getElementById('div_excel_content');
    //alert(obj);
    form1.txt_excel_content.value=obj.innerHTML;

    form1.action='/<%=ctx%>/pages/commons/save2excel.jsp';
    form1.submit();
}

//alert("您显示器的分辨率为:\n" + screen.width + "×" + screen.height + "像素");
if(screen.height>=1024){
	  document.getElementById("q").height=800;
	}else if(screen.height>=900  && screen.height<1024 ){
	  document.getElementById("q").height=680;
	}else if(screen.height>=800  && screen.height<900 ){
	  document.getElementById("q").height=580;
	}else if(screen.height>=768  && screen.height<800 ){
	  document.getElementById("q").height=540;
	}else if(screen.height>=720  && screen.height<768 ){
	  document.getElementById("q").height=500;
	}

</script>
</body>
</html>
