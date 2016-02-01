<%@ page contentType="text/html;charset=gbk" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

    try{

      SwjUpdate.station_index(request);//��ʼ��ҳ������

      //w��װ�˱�ҳ��request��response����

    }catch(Exception e){
     w.error(e);
     return;
    }

    boolean iswry = f.iswry(w.get("station_type"));//�Ƿ�����ȾԴ


    RowSet rs = w.rs("flist");

    String session_id = (String)session.getAttribute("session_id");
    String user_name = (String)session.getAttribute("user_name");
    String infectant_ids =""; 
   boolean b = zdxUpdate.isReal(user_name,session_id);//��ָ�
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title></title>
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
.select {font-family: "����"; font-size: 12px; BEHAVIOR: url('<%=request.getContextPath() %>/styles/selectBox.htc'); cursor: hand; }

</style>
</head>

<body onload='f_real()' style="overflow:hidden"> 
<form name=form1 method=post target='frm_real_data'>
<%--<input type="button" class="btn1 button" value="���ز�ѯ����" id="displayButton" onclick="query_display()" style="clear: both;"/>
<input type="button" class="btn1 button" value="��ʾ��ѯ����" style="display: none" id="displayButton2" onclick="query_display2()" style="clear: both;"/>
--%>

	<div class="fieldArea" id="fieldArea" >
    <fieldset>
    <div class="selarea">
    	<div class="item">
        <label>վλ���ͣ�</label>
        <div class="f-l">
    	<select class="select" name=station_type  onchange=f_rr()>
    		<%=w.get("stationTypeOption")%>
    	</select>
    	</div>
        </div>
        <div class="item">
        <label>������</label>
        <div class="f-l">
    	<select class="select" name=area_id id="area_id" onchange=f_r()>
    		<%=w.get("areaOption")%>
    	</select>
    	</div>
        </div>
        <div class="item">
        <label>�ص�Դ��</label>
        <div class="f-l">
    	<select class="select" name=ctl_type onchange=f_r()>
    		<option value=''>����</option>
			<%=w.get("ctlTypeOption")%>
    	</select>
    	</div>
        </div>


        <%--<div class="item">
        <label>����</label>
        <div class="f-l">
    	<select class="select" name=valley_id id=valley_id onchange=f_r()>
    		<option value=''>����</option>
			<%=w.get("valleyOption")%>
    	</select>
    	</div>
        </div>--%>

        <%--<div class="item">
        <label>״̬���ͣ�</label>
        <div class="f-l">
    	<select class="select" name=state onchange=f_r()>
    		<option value=''>ȫ��</option>
			<option value='zc'>����</option>
			<option value='yj'>Ԥ��</option>
			<option value='bj'>����</option>
			<option value='tj'>�ѻ�</option>
    	</select>
    	</div>
        </div> --%>

        <input type="hidden" name="state" id="state" value="zc"/>

       <div class="item">
        <label>��ҵ��</label>
        <div class="f-l">
    	<select class="select" name=trade_id onchange=f_r()>
    		<option value=''>����</option>
			<%=w.get("tradeOption")%>
    	</select>
    	</div>
        </div>
        <div class="item">
        <label>�������ͣ�</label>
        <div class="f-l">
    	<select class="select" name=build_type onchange=f_r()>
    		<option value=''>����</option>
			<%=w.get("buildTypeOption")%>
    	</select>
    	</div>
        </div>

        <div class="clear" style="height: 5px"></div>
    </div>

    <div class="query2" >
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="220"><label>վλ���ƣ�</label>
    <input type="text" class="input1" name='station_desc' value='' onkeydown="KeyDown(event,this.form)" style="width:150px;" /></td>
     
    <%while(rs.next()){
     	if(!rs.get("infectant_name").equals("����2")){
     %>
       <td style="display: none" id="<%=rs.get("infectant_id")%>"><input type="checkbox" id="<%=rs.get("infectant_id")%>" name='infectant_id' value='<%=rs.get("infectant_id")%>' checked><label for="<%=rs.get("infectant_id")%>"><%=rs.get("infectant_name")%></label></td>
     <%
         if("".equals(infectant_ids))infectant_ids=rs.get("infectant_id");
         else infectant_ids = infectant_ids+","+rs.get("infectant_id");
        }
     }%>
     <td><input type="button" class="btn1 button" id="infectant_show" value="��ʾ�������" onclick='f_show_all()' /></td>
    <td><input type="button" class="btn1 button" id="infectant_hide" style="display: none" value="���ؼ������" onclick='f_hide_all()' /></td>
    <%--<td><input type="button" class="btn1 button" value="ʵʱ����" onclick='f_real()' /></td>
    <td><input type="button" class="btn1 button" value="ʱ��ֵ" onclick='f_hour()' /></td>
    <td><input type="button" class="btn1 button" value="�ѻ�" onclick='f_yc()' /></td>--%>
    <!-- <td><input type="button" class="btn1 button" value="��ӡ" onclick='f_print()' /></td>  -->
    <td><input type="button" class="btn1 button" value="��ˢ��"  name="b_fresh" id="b_fresh" onclick='f_fresh()' /></td>
    <td><input type="button" class="btn1 button" value="�������" onclick='export_real_data()' /></td>
    <td><input type="button" class="btn1 button" value="������Ϣ" onclick='f_hz()' /></td>
    		  <td><span id="decimal"></span></td>
		      <td><input type="hidden" name="station_ids" id="station_ids"></td>
		      <td><input type="hidden" name="data_flag" id="data_flag" value="real"></td>
</tr>

</table>
    </div>

    </fieldset>
    </div>
    <div class="clear" style="height: 5px"></div>
    <div class="State" style="width: 98%;border-bottom: 1px solid #d0d0d0;margin-left:6px">
		    <ul>
		    <%--<li onclick="count_click('')" style="cursor: pointer;"><img src="../../images/common/active5.gif" width="18" height="18" />ȫ��<span id="all" style="font-size:12px;font-weight:bold"></span></li>
		    --%>
		    <li onclick="count_click('')" style="cursor: pointer;" title="�ɵ��"><img src="../../images/common/active5.gif" width="18" height="18" />ȫ��<span id="all" style="font-size:12px;font-weight:bold"></span></li>
		    <li onclick="count_click('zc')" style="cursor: pointer;" title="�ɵ��"><img src="../../images/common/active1.gif" width="18" height="18" />����<span id="zc" style="font-size:12px;font-weight:bold"></span></li>
		    <li onclick="count_click('yj')" style="cursor: pointer;" title="�ɵ��"><img src="../../images/common/active2.gif" width="18" height="18" />Ԥ��<span id="yj" style="font-size:12px;font-weight:bold"></span></li>
		    <li onclick="count_click('bj')" style="cursor: pointer;" title="�ɵ��"><img src="../../images/common/active3.gif" width="18" height="18" />����<span id="bj" style="font-size:12px;font-weight:bold"></span></li>
		    <li onclick="count_click('tj')" style="cursor: pointer;" title="�ɵ��"><img src="../../images/common/active4.gif" width="18" height="18" />�ѻ�<span id="tj" style="font-size:12px;font-weight:bold"></span></li>
		    </ul>
	</div>
<%--
    <div class="fieldArea">
    <fieldset>
    <legend>��ѯ2</legend>
    <div class="query2" >
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="220"><label>վλ���ƣ�</label><input type="text" class="input1" name='station_desc' value='' style="width:150px;" /></td>
    <%while(rs.next()){
     	if(!rs.get("infectant_name").equals("����2")){
     %>
       <td><input type="checkbox" id="<%=rs.get("infectant_id")%>" name='infectant_id' value='<%=rs.get("infectant_id")%>' checked><label for="<%=rs.get("infectant_id")%>"><%=rs.get("infectant_name")%></label></td>
     <%}}%>
  </tr>
</table>
<div width="100%" class="clear" style="height:8px;"></div>
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><input type="button" class="btn1 button" value="ʵʱ����" onclick='f_real()' /></td>
    <td><input type="button" class="btn1 button" value="ʱ��ֵ" onclick='f_hour()' /></td>
    <td><input type="button" class="btn1 button" value="�ѻ�" onclick='f_yc()' /></td>
    <!-- <td><input type="button" class="btn1 button" value="��ӡ" onclick='f_print()' /></td>  -->
    <td><input type="button" class="btn1 button" value="��ˢ��"  name="b_fresh" id="b_fresh" onclick='f_fresh()' /></td>
    <td><input type="button" class="btn1 button" value="�������" onclick='f_excel()' /></td>
    <td><input type="button" class="btn1 button" value="������Ϣ" onclick='f_hz()' /></td>
    		  <td><span id="decimal"></span></td>
		      <td><input type="hidden" name="station_ids" id="station_ids"></td>
		      <td><input type="hidden" name="data_flag" id="data_flag" value="real"></td>
  </tr>
</table>
    </div>
    </fieldset>
    </div>

<div class="State">
		    <ul>
		    <li onclick="count_click('')" style="cursor: pointer;"><img src="../../images/common/active5.gif" width="18" height="18" />ȫ��<span id="all" style="font-size:12px;font-weight:bold"></span></li>
		    <li onclick="count_click('zc')" style="cursor: pointer;"><img src="../../images/common/active1.gif" width="18" height="18" />����<span id="zc" style="font-size:12px;font-weight:bold"></span></li>
		    <li onclick="count_click('yj')" style="cursor: pointer;"><img src="../../images/common/active2.gif" width="18" height="18" />Ԥ��<span id="yj" style="font-size:12px;font-weight:bold"></span></li>
		    <li onclick="count_click('bj')" style="cursor: pointer;"><img src="../../images/common/active3.gif" width="18" height="18" />����<span id="bj" style="font-size:12px;font-weight:bold"></span></li>
		    <li onclick="count_click('tj')" style="cursor: pointer;"><img src="../../images/common/active4.gif" width="18" height="18" />�ѻ�<span id="tj" style="font-size:12px;font-weight:bold"></span></li>
		    </ul>
	    </div>
--%>
   	<div style="clear: both;height:100%">
	  <iframe name='frm_real_data' id='frm_real_data' width=100% height=400px frameborder="no" scrolling="yes"></iframe>

      <%--<iframe name='frm_real_data_excel' id='frm_real_data_excel' width=0% height=0% frameborder="no" ></iframe> --%>
   </div>
    <%--<div class="State">
    <ul>
    <li><img src="../../images/common/active1.gif" width="18" height="18" />����<span id="zc" style="font-size:12px;font-weight:bold"></span></li>
    <li><img src="../../images/common/active2.gif" width="18" height="18" />Ԥ��<span id="yj" style="font-size:12px;font-weight:bold"></span></li>
    <li><img src="../../images/common/active3.gif" width="18" height="18" />����<span id="bj" style="font-size:12px;font-weight:bold"></span></li>
    <li><img src="../../images/common/active4.gif" width="18" height="18" />�ѻ�<span id="tj" style="font-size:12px;font-weight:bold"></span></li>
    </ul>
    </div>--%>

</form>

<form name=form2 method=post>
<input type=hidden name='txt_excel_content' />
<input type=hidden name='title' value="ʵʱ����" />
</form>
</body>
</html>
<script>
function get(zc,yj,bj,tj){
	Ob=document.all("zc");
	Ob.innerHTML=zc;
	Ob=document.all("yj");
	Ob.innerHTML=yj;
	Ob=document.all("bj");
	Ob.innerHTML=bj;
	Ob=document.all("tj");
	Ob.innerHTML=tj;
	Ob=document.all("all");
	Ob.innerHTML= parseInt(zc)+parseInt(tj);

}

function f_rr(){
 by_excel();
 form1.action='index.jsp';
 form1.target='';
 form1.submit();
}
function f_submit(){
	//document.all("frm_real_data_excel").src= "";
	//by_excel();
 if(<%=b %>)
 	{
   by_excel();
 	form1.submit();
  }
}


function f_r(){
	by_excel();
 	form1.submit();
}

function count_click(state){
	document.getElementById("state").value=state;
 	form1.submit();
}

 function f_real(){

   		if(<%=b %>)
 	{
   		form1.data_flag.value= "real";
   		by_excel();
    	form1.submit();
    }
 }

  function f_hour(){
   	form1.data_flag.value= "hour";
   	by_excel();
    form1.submit();
 }

  function f_yc(){
	by_excel();
    form1.action='offline.jsp';
    //alert(form1.action);
    form1.submit();
 }
 function f_print(){
  by_excel();
  var obj = getobj("frm_real_data");
  //window.frames["q"].document.execCommand('print');
  obj.document.execCommand('print');
}

 function by_excel(){
 	if(form1.data_flag.value=='real'){
		form1.action="real.jsp";
	}else{
		form1.action="hour.jsp";
	}

	form1.station_ids.value = "";
	form1.target='frm_real_data';
 }
 //ˢ��
 var thread = window.setInterval('f_submit()',60000);
 function f_fresh(){
 	if(form1.b_fresh.value=="��ˢ��"){
 		window.clearInterval(thread);
 		form1.b_fresh.value = "ˢ��";
 	}else{
 		thread = window.setInterval('f_submit()',60000);
 		form1.b_fresh.value = "��ˢ��";
 	}
 }

 function f_excel(){
    //alert("ddd");
   // alert(form1.data_flag.value);
 	if(form1.data_flag.value=='real'){
		 var r = window.frames["frm_real_data"].window.document.all('station_ids');
		 if(r == null){
		   alert("û�е�������");
		   return false;
		 }
		 var str = "";
		 for(var i=0;i<r.length;i++){

				str = str + "'"+r[i].value+"'" + ",";
         }
		    form1.station_ids.value = str;
		 	form1.action='select_real.jsp';
		 	form1.target='frm_real_data_excel';
		 	form1.submit();
	}
 }

 function export_real_data(){

 	 var obj = window.frames["frm_real_data"].window.document.getElementById('div_excel_content');

    form2.txt_excel_content.value=obj.innerHTML;

    form2.action='/<%=ctx%>/pages/commons/save2excel.jsp';
    form2.submit();
 }

 function f_hz(){
 	var url = "../map/all_area_info.jsp";
	var width = 1024;
	var height = 668;
	window.open(url,"","scrollbars=yes,resizable=yes"+",height="+height+",width="+width+",left="+(window.screen.width-width)/2+",top="+(window.screen.height-height)/2);
}
 <%--
 Ext.onReady(function(){
  var combo = new Ext.form.ComboBox({
 	emptyText:'��ѡ��',
    mode:'local',
    triggerAction:'all',
    transform:'area_id'
    });
  });
  --%>

  function f_ajf_hide(ids){
   	var arr=ids.split(",");
  	var i,num=0;
	var obj = null;
   	num=arr.length;
   	for(i=0;i<num;i++){
    obj = document.getElementById(arr[i]);
    obj.style.display='none';  
    }
  }
  
   function f_ajf_show(ids){
   	var arr=ids.split(",");
   	var i,num=0;
	var obj = null;
   	num=arr.length;
   	for(i=0;i<num;i++){
    obj = document.getElementById(arr[i]);
    obj.style.display='';  
    }
  }
  
   function f_hide_all(){
     var ids="<%=infectant_ids%>";
     document.getElementById("infectant_show").style.display="";
     document.getElementById("infectant_hide").style.display="none";
     f_ajf_hide(ids);
  }
  
  function f_show_all(){
     var ids="<%=infectant_ids%>";
     document.getElementById("infectant_show").style.display="none";
     document.getElementById("infectant_hide").style.display="";
     f_ajf_show(ids);
  }
  
    function KeyDown(e,form)
{
   //var keycode =window.event?e.keyCode:e.which;
   
����if (e.keyCode == 13)
����{
��������e.returnValue=false;
��������e.cancel = true;
       by_excel();
��������form1.submit();
����}
}

//alert("����ʾ���ķֱ���Ϊ:\n" + screen.width + "��" + screen.height + "����");
if(screen.height>=1024){
  document.getElementById("frm_real_data").height=600;
}else if(screen.height>=900  && screen.height<1024 ){
  document.getElementById("frm_real_data").height=500;
}else if(screen.height>=800  && screen.height<900 ){
  document.getElementById("frm_real_data").height=380;
}else if(screen.height>=768  && screen.height<800 ){
  document.getElementById("frm_real_data").height=345;
}else if(screen.height>=720  && screen.height<768 ){
  document.getElementById("frm_real_data").height=344;
}




</script>




