<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.util.Scape"%>
<%@page import="com.hoson.f,java.util.*,com.hoson.zdxupdate.*,com.hoson.XBean"%>
<%

    String station_id = "";
    String station_desc = "";
    try{
      station_id = request.getParameter("station_id");
      station_desc = request.getParameter("station_desc");
      if(!"".equals(station_desc) && station_desc != null){
	    station_desc= Scape.unescape(station_desc);
      }

    }catch(Exception e){
     w.error(e);
     return;
    }
    
    String now = StringUtil.getNowDate() + "";
     String date1, date2 = null;
     date1 = now;
     date2 = now;


%>

<style>
.search {font-family: "宋体"; font-size: 12px; BEHAVIOR: url('<%=request.getContextPath() %>/styles/selectBox.htc'); cursor: hand; }
.input {
   border: #ccc 1px solid;
   font-family: "微软雅黑";
   font-size: 13px;
   width: 150px;
   background:expression((this.readOnly &&this.readOnly==true)?"#f9f9f9":"")
}

</style>
<body scroll=no onload='f_r()'>

<form name=form1 method=post action='khjl_list.jsp' target="frm_zw_list">

<table style='width:100%;height:100%' border=0 cellspacing=0>
<tr class=title> 
   <td style="font-size: 16px;text-align: center">考核结论历史记录</td>
</tr>
  <tr class=title> 
      <td>
           从:
           <input type=text name=date1 id='date1' value="<%=date1%>" class=input readonly="readonly"  onclick="new Calendar().show(this);" >
           到:
         <input type=text name=date2 id='date2' value="<%=date2%>" class=input readonly="readonly"   onclick="new Calendar().show(this);">
         状态:<select name=jd_jg  onchange=f_r()  class="search" style="width: 120px">
                <option value="">全部</option>
                <option value="1">合格</option>
                <option value="0">不合格</option>
           </select>
      <input type=button value='查询' onclick='f_jdkh()' class='btn'>
      <input type="hidden" value="<%=station_id %>" name="station_id">
      <input type="hidden" value="<%=station_desc %>" name="station_desc">
      </td>
  </tr>
   
  <tr>
      <td style='height:100%' colspan="2">
         <iframe name='frm_zw_list' id='frm_zw_list' width=100% height=100% frameborder=0 allowtransparency="true"></iframe>
     <br></td>
  </tr>
   
</table>
</form>

<script type="text/javascript">
   function open_new(id,name){
       window.open("khjl_info.jsp?station_id="+id+"&station_desc="+escape(escape(name)));
   }
</script>


<script type="text/javascript">
//选中其中的一个
function check(thisCheckbox,id,nameId){
    if(thisCheckbox.checked==false){
      document.getElementById(id).checked=false;
    }
    if(nameId !=""){
      if(document.getElementById(nameId).checked==true){
          document.getElementById(nameId).checked=false;
      }  
    }
    
 }
 
 //全部选择操作，复选框
function checkall(form,Tcheck){
    //alert(form);
    var objForm=form;
    var objLength=objForm.length;
    for(var objC=0; objC<objLength; objC++){
      if(Tcheck.checked==true){
        if(objForm.elements[objC].type == "checkbox"){
            objForm.elements[objC].checked=true;
         }
      }else{
        if(objForm.elements[objC].type == "checkbox"){
            objForm.elements[objC].checked=false;
         }
      }
    }
 }
 
 //删除判断操作
function YN_delete(form){
    var objForm=form;
    var objLength=objForm.length;
    var station_desc = '<%=station_desc%>';
    for(var objL=0;objL<objLength; objL++){
       if(objForm.elements[objL].type=="checkbox"){
         if(objForm.elements[objL].checked==true){
           var flag=window.confirm("确定要删除这些记录?");
            if(flag){
              objForm.action="khjl_delete.jsp?station_id="+<%=station_id%>+"&station_desc="+escape(escape(station_desc));
              //alert(objForm.action);
              objForm.submit();
              return ;
            }else{
              return ;
            }
         }
       }
    }
    alert("请选中要删除的记录");
 }
 
 function get(zc,yj,bj,tj){ 
	Ob=document.all("zc");
	Ob.innerHTML=zc;
	Ob=document.all("yj");
	Ob.innerHTML=yj;
	Ob=document.all("bj");
	Ob.innerHTML=bj;
	Ob=document.all("tj");
	Ob.innerHTML=tj;
} 

function f_rr(){
 by_excel();
 form1.action='index.jsp';
 form1.target='';
 form1.submit();
}
function f_submit(){
	document.all("frm_real_data_excel").src= "";
	by_excel();
 	form1.submit();
}
function f_r(){
 	form1.submit();
}
 function f_jdkh(){
    	
    	form1.submit();
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
	form1.action="jdkh_list.jsp";
	form1.target='frm_zw_list';
 }

 
 
 function f_excel(){
    //alert("ddd");
   // alert(form1.data_flag.value);
 	if(form1.data_flag.value=='real'){
		 var r = window.frames["frm_real_data"].window.document.all('station_ids');
		 //alert(r);
		 var str = "";
		 for(var i=0;i<r.length;i++){
		 	if(r[i].checked){
				str = str + r[i].value + ",";
		 	}
		    }
		    form1.station_ids.value = str;
		 	form1.action='select_real.jsp';
		 	form1.target='frm_real_data_excel';
		 	form1.submit();
	}
 }
 function f_hz(){
 	var url = "../map/all_area_info.jsp";
	var width = 1024;
	var height = 668;
	window.open(url,"","scrollbars=yes,resizable=yes"+",height="+height+",width="+width+",left="+(window.screen.width-width)/2+",top="+(window.screen.height-height)/2);
}
 
</script>
