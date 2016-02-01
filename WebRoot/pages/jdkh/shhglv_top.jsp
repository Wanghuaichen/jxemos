<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    String now = StringUtil.getNowDate() + "";
   String date1, date2 = null;
   date1 = now;
   date2 = now;
    
    try{
    
      SwjUpdate.jdkh_index(request);//初始化页面数据
      
      //w封装了本页的request和response对象。
    
    }catch(Exception e){
     w.error(e);
     return;
    }

    boolean iswry = f.iswry(w.get("station_type"));//是否是污染源
    
    
    //RowSet rs = w.rs("flist");
    
    String session_id = (String)session.getAttribute("session_id");
    String user_name = (String)session.getAttribute("user_name");
   //boolean b = zdxUpdate.isReal(user_name,session_id);//需恢复
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
<form name=form1 method=post action="shhglv_bom.jsp" target='frm_zw_list'>
<table style='width:100%;height:100%' border=0 cellspacing=0>
   <tr>
     <td style='height:20px' colspan="2">
         
       <table border=0 cellspacing=0>
          <tr>
              <td> 
                      站位类型:<select name=station_type  onchange=f_r()  class="search"><%=w.get("stationTypeOption")%></select>
                 <input type="hidden" value="36" name="area_id" id="area_id">

                           从:
<input type=text name=date1 id='date1' value="<%=date1%>" class=input readonly="readonly"  onclick="new Calendar().show(this);" >
到:
<input type=text name=date2 id='date2' value="<%=date2%>" class=input readonly="readonly"   onclick="new Calendar().show(this);">

		     <input type=button value='查询' onclick='f_jdkh()' class='btn'>

		  <td>
              
          </tr>
       </table>  
     </td>

     
   
   <tr>
     <td style='height:100%' colspan="2"><%--<div id="topDiv"></div>
      --%><iframe name='frm_zw_list' id='frm_zw_list' width=100% height=100% frameborder=0 allowtransparency="true"></iframe>
 
     <br></td>
   </tr>
   
</table>
</form>
</body>


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
 <%--
 Ext.onReady(function(){
  var combo = new Ext.form.ComboBox({
 	emptyText:'请选择',
    mode:'local',
    triggerAction:'all',
    transform:'area_id'
    });
  });
  --%>
</script>


