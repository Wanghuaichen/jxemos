<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc_station.jsp" %>
<%

    RowSet station,flist;
    
     

    try{
    
      SwjUpdate.station_index(request);//开始是默认的数据，后可动态查询
    
    }catch(Exception e){
     w.error(e);
     return;
    }
    station = w.rs("stationList");
    flist = w.rs("flist");
    boolean iswry = f.iswry(w.get("station_type"));
    String index = null;
    int td_width=200;
    String station_id_0 = null;
    String station_desc_0 = null;
    String wry_display = "yes";
    if(!iswry){wry_display = "none";}
    
    
    
%>
<style>
 .bgclick{
 background-color:#FDCC7E;
 border:solid 1px #E8A947;
  /*font-color:white;*/
 }
 
  .bg{
 /*background-color: white;*/
 background-color:;
 border:0;
 /*font-color:balck;*/
 }
 
 
 .search {font-family: "宋体";
 width: 95%;
  font-size: 12px; BEHAVIOR: url('<%=request.getContextPath() %>/styles/selectBox.htc'); cursor: hand; }
.input {
   border: #ccc 1px solid;
   font-family: "微软雅黑";
   font-size: 13px;
   width: 150px;
   background:expression((this.readOnly &&this.readOnly==true)?"#f9f9f9":"")
}
 
</style>
<body scroll=no>
<!--<%=w.get("sql")%>-->

<form name=form1 method=post action='./data/index.jsp' target='frm_station'>
<input type=hidden name='w'>
<input type=hidden name='h'>
<input type=hidden name='show_zb_flag' value='0'>
<input type=hidden name='show_btn_flag' value='0'>
<input type=hidden name='station_id'>
<input type=hidden name='station_name'>

<input type=hidden name='sh_flag' value='0'>

<table border=0 style='width:100%;height=100%' cellspacing=0>
 <tr>
  <td style='width:<%=td_width%>px;height:20px' class='top' valign='top'>
       
<select name=area_id onchange=f_r() class='search'>
<%=w.get("areaOption")%>
</select>
<select name=station_type  onchange=f_r()  class='search'>
<%=w.get("stationTypeOption")%>
</select>

<select name=ctl_type onchange=f_r()  class='search'>
<option value=''>重点源属性</option>
<%=w.get("ctlTypeOption")%>
</select>


<select name=valley_id onchange=f_r() class='search'>
<option value=''>请选择流域</option>
<%=w.get("valleyOption")%>
</select>

<select name=trade_id onchange=f_r() class='search' >
<option value=''>请选择行业
<%=w.get("tradeOption")%>
</select>

<input type=text name=p_station_name value='<%=w.get("p_station_name")%>' class="input" style='width:150px'>
<input type=button value='查看' class=btn onclick='f_r()'>

  </td>
  
  
  <td rowspan=2>
                 <table style='width:100%;height:100%;border:solid 0px red' border=0 cellspacing=0>
                 <tr>
                   <td height=10px>
                   <%-- 
                   <div>
                  <!--
                   <input type='button' value='数据' onclick='f_data()' class=btn>
                   <input type='button' value='曲线' onclick='f_chart()' class=btn>

                   <input type='button' value='报表' onclick='f_report()'  class=btn style='display:none'>
                   
                   <input type='button' value='视频' onclick='f_sp()'  class=btn>
                   <input type='button' value='远程控制' onclick='f_ctl()' class=btn>
                   <input type='button' value='属性' onclick='f_info()' class=btn>
                   <%if(iswry){%>
                   <input type='button' value='污染源信息' onclick='f_wry()' class=btn>
                   <%}%>
                   <input type='button' value='监测指标' onclick='f_zb()' class=btn>
                 -->
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                 <tr>
                 <td height="27" align="left" background="../../images/index_em_03.jpg"><table  class="table2"  width="480" height="27" border="0" cellpadding="0" cellspacing="0">
                 	<tr>
                 		<td width="94" id='menu0' onclick="f_data()" style="cursor:hand;" align="center"><font class="gray12_w_6" id="font0">数据</font></td>
                 		<td><img src="../../images/fg01.jpg" width="2" height="26" alt=""></td>
                 		<td width="94" id='menu1' onclick="f_chart()" style="cursor:hand;" align="center"><font class="gray12_w_6" id="font1">曲线</font></td>
                 		<td><img src="../../images/fg01.jpg" width="2" height="26" alt=""></td>
                 		<td width="94" id='menu2' style="display:none;" style="cursor:hand;" onclick="f_rpt()" align="center" class="gray12_w_6"><font id="font2">报表</font></td>
                 		<td width="94" id='menu3' onclick="f_sp()" style="cursor:hand;" align="center"><font class="gray12_w_6" id="font3">视频</font></td>
                 		<td><img src="../../images/fg01.jpg" width="2" height="26" alt=""></td>
                 		<td width="94" id='menu4' style="display:none;" style="cursor:hand;" onclick="f_ctl()" align="center" class="gray12_w_6"><font id="font4">远程控制</font></td>
                 		<td width="94" id='menu5' onclick="f_info()" style="cursor:hand;" align="center"><font class="gray12_w_6" id="font5">属性</font></td>
                 		<td><img src="../../images/fg01.jpg" width="2" height="26" alt=""></td>
                 		<td width="94" id='menu6' style="display:none;" style="cursor:hand;" onclick="f_wry()" align="center" class="gray12_w_6"><font id="font6">污染源信息</font></td>
                 		<td width="94" id='menu7' onclick="f_zb()" style="cursor:hand;" align="center"><font class="gray12_w_6" id="font7">监测指标</font></td>
                 		<td><img src="../../images/fg01.jpg" width="2" height="26" alt=""></td>
                 <!--<font id='menu1' onclick="f_chart()">曲线</font>
                 <font id='menu2' onclick="f_rpt()" style='display:none'>报表</font>
                 <font id='menu3' onclick="f_sp()">视频</font>
                 <font id='menu4' onclick="f_ctl()" style='display:none'>远程控制</font>
                 <font id='menu5' onclick="f_info()">属性</font>
                 <font id='menu6' onclick="f_wry()" style='display:none'>污染源信息</font>
                 <font id='menu7' onclick="f_zb()">监测指标</font> -->
                 	</tr></table>
                 </td></tr>
              </table>    
                   <font style='font-weight:bold;font-size:15px;display:none' id='font_station_name'></font>
                  
                   </div>
                   --%>
                   <div style='padding-top:8px'>
                       <select name='data_table' id='data_table' onchange='f_btn();f_submit()' class='search' style="width:120px">
                         <!--  <option value='t_monitor_real_minute'>实时数据-->
                         <option value='t_monitor_real_hour_v' selected>时均值
                         <option value='t_monitor_real_day_v'>日均值
                         <option value='t_monitor_real_month_v'>月均值
                       </select>
                       
                       <%--<select name='infectant_id' id='infectant_id' onchange='infectant_submit()'>
                        <%while(flist.next()){%>
                         <option value='<%=flist.get("infectant_id")%>'>
                         <%=flist.get("infectant_name")%> <%=flist.get("infectant_unit")%>
                        <%}%>
                       </select>
                       
                       --%><input type='text' class='input' style="height:20px" name='date1' id='date1' value='<%=w.get("date1")%>' onclick="new Calendar().show(this);">
                       <select name=hour1 id='hour1' class='search' style="width:50px">
                       <%=w.get("hour1Option")%>
                       </select>
                       
                       <input type='text' class='input' style="height:20px" name='date2' id='date2' value='<%=w.get("date2")%>' onclick="new Calendar().show(this);">
                       <select name=hour2 id='hour2' class='search' style="width:50px">
                       <%=w.get("hour2Option")%>
                       </select>
                       
                       <%--<input type='text' class='date' name='date3' id='date3' value='<%=f.today()%>' onclick="new Calendar().show(this);">
                       <select name=hour3 id='hour3'>
                       <%=w.get("hour2Option")%>
                       </select>
                       <select name="chart_form" onchange="f_chart()">
						             <option value="1">曲线图</option>
						             <option value="0">柱状图</option>
						             </select>
                       
                       --%><input type="hidden" name="view_flag" id="view_flag" value="false">
                       <input type='button' value='查看' class='btn' onclick='f_view()' id='btn_view'>
			
			<%--<input type='button' value='完好率统计' class='btn' onclick='f_wh()' id='btn_bulu'>
			
			<input type='button' value='数据补录' class='btn' onclick="f_bulu()" id='btn_bulu'>--%>
			
			<input type='button' value='无效数据标识' class='btn' onclick='f_wuxiao()' id='btn_wuxiao'>
			&nbsp;&nbsp;&nbsp;
     <img src="../../images/color_mark01.jpg" />
     <img src="../../images/color_mark02.png" />
     <img src="../../images/color_mark06.png" />
      <img src="../../images/color_mark05.png" />
                       
                    </div>
                       <div style='height:10px;width:100%'></div>
                   </td>
                 </tr>
                 
                 <tr>
                   <td style='height:100%;padding:0px'>
                     <iframe id='frm_station_id' name='frm_station' src='../commons/empty.jsp' width=100% height=100% frameborder=0></iframe>
                   </td>
                 </tr>
                 </table>
  </td>
 </tr>
 
 <tr>
     <td style='height:100%' class='top'>
     
  
  <div class='scrolldiv'>
                     <table style="cursor:hand" border=0 cellspacing=0 style='width:<%=td_width-10%>px'>
										<%
										station.reset();
										while(station.next()){
										index = station.getIndex()+"";
										if(f.empty(station_id_0)){
										station_id_0=station.get("station_id");
										station_desc_0 = station.get("station_desc");
										}
										%>
										<tr >
										<td  style="padding-top:4px;" id='td<%=index%>' title="<%=station.get("station_desc")%>" onclick=f_station_click(<%=index%>,'<%=station.get("station_id")%>','<%=station.get("station_desc") %>') >
									<font id='station_desc_<%=index%>' style="width:<%=td_width-10%>px;font-size:13px;overflow:hidden;white-space:nowrap;"><%=station.get("station_desc")%></font>
									      <input type="hidden" value="" id="station_desc_title" name="station_desc_title">
										</td>
										</tr>
										<%}%>
										</table>
										</div>
  
     </td>
 </tr>
 
 
</table>

</form>
</body>
<script>

var station_sel_index = -1;
var flag_first = 0;
var menu_num=8;



<%if(!f.empty(station_id_0)){%>
  f_station_click(0,'<%=station_id_0%>','<%=station_desc_0%>');
<%}%>

  function f_station_click(index,station_id,station_name){
       form1.station_id.value=station_id;
       //alert(station_name);
       document.getElementById("station_desc_title").value=station_name;
       //alert(document.getElementById("station_desc").value);
       f_submit();
       var obj = null;
       if(station_sel_index>=0){
        obj = document.getElementById("td"+station_sel_index);
            obj.className="bg"; 
       }
       station_sel_index=index;
       obj = document.getElementById("td"+index);
    obj.className="bgclick";
    // var obj1,obj2=null;
       // obj1 = getobj("station_desc_"+index);
       //obj2 = getobj("font_station_name");
       //obj2.innerHTML=obj1.innerHTML
       
  }




   f_btn_real(); 
   
function f_submit(){
     f_get_wh();
  
	if(flag_first<1){
	  f_data();
	  flag_first=1;
	  return;
	}
	
	
	 form1.target='frm_station';
	 form1.submit();
}

 function infectant_submit(){
 	form1.view_flag.value="false";
 	f_submit();
 }
 
 function f_r(){
   form1.action='bzdatawx.jsp';
   form1.target='';
   form1.submit();
   form1.target='frm_station';
 }
 
 
 function f_data(){
 //f_hide_all();

 f_ajf_show("data_table,date1,date2,btn_view");
 f_btn();
   //form1.action='./data/index.jsp';
  form1.action='./data/bzsjwux.jsp';
  form1.submit();
  //f_set_css(0);
  
 }
 function f_get_wh(){
  var obj  = document.getElementById('frm_station_id');
        var w = obj.offsetWidth;
        var h = obj.offsetHeight;
 var x = 50;
         w = w-x;
         h = h-x;
         if(w<=0){w=w+x;}
         if(h<=0){h=h+x;}
        form1.w.value = w;
        form1.h.value = h;
 }
 
 
 
 
 function f_hide_all(){
  var ids="infectant_id,data_table,date1,date2,date3,hour1,hour2,hour3,btn_view,chart_form";
  f_ajf_hide(ids);
 }
 
  function f_view(){
 	form1.view_flag.value="false";
 	form1.action='./data/bzsjwux.jsp';
 	form1.target='frm_station';
	form1.submit();
 }
 
 function f_btn_real(){
        //f_hide_all();
       // f_ajf_hide("date3,hour3");
      f_ajf_show("date1,date2,hour1,hour2");
 }
 function f_btn_avg(){
   // f_hide_all();
  // f_ajf_hide("date3,hour3,hour1,hour2");
  f_ajf_hide("hour1,hour2,btn_wuxiao");
    f_ajf_show("date1,date2");
 }
 
 function f_btn(){
  var obj = form1.data_table;
   var i = obj.selectedIndex;
   if(i>=1){
    f_btn_avg()
   }else{
   f_btn_real();
   }
 }
 
	 function f_bulu(){
	//if(data_table!='t_monitor_real_hour_v'){
		//return false;
	//}
	//alert();
	var station_id = form1.station_id.value;
	var date1 = form1.date1.value;
	var date2 = form1.date2.value;
	var hour1 = form1.hour1.value;
	var hour2 = form1.hour2.value;
	var data_table = form1.data_table.value;
 	var url = "./data/bulu.jsp";
	url = url+"?station_id="+station_id+"&station_desc="+escape(escape(document.getElementById("station_desc").value))+"&date1="+date1+"&date2="+date2+"&hour1="+hour1+"&hour2="+hour2+"&data_table="+data_table;
	var width = 1024;
	var height = 568;
	//alert("scrollbars=yes,resizable=yes"+",height="+height+"px,width="+width+"px,left="+(window.screen.width-width)/2+",top="+(window.screen.height-height)/2);
	   window.open(url,"", "height=400, width=812, ,left="+(window.screen.width-width)/2+",top="+(window.screen.height-height)/2);
	   //var ret=window.showModalDialog(url,"","");
	   //window.open(url, '', 'height=100, width=400, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=n o, status=no'); 
	 }
	 function f_wuxiao(){
	 var station_id = form1.station_id.value;
	 	var url = "./data/wuxiao.jsp";
	url = url+"?station_id="+station_id+"&station_desc_title="+escape(escape(document.getElementById("station_desc_title").value));
	var width = 812;
	var height = 356;
	window.open(url,"","scrollbars=yes,resizable=yes,height=356,width=812,left="+(window.screen.width-width)/2+",top="+(window.screen.height-height)/2);
	
	 }
	 function f_wh(){
	 	var station_id = form1.station_id.value;
	 	var date1 = form1.date1.value;
		var date2 = form1.date2.value;
		var hour1 = form1.hour1.value;
		var hour2 = form1.hour2.value;
	 	var url = "./search/p_wh.jsp"+"?station_id="+station_id+"&date1="+date1+"&date2="+date2+"&hour1="+hour1+"&hour2="+hour2;
	 	//form1.action=url+"?station_id="+station_id;
	 	//form1.submit();
	 	var width = 800;
		var height = 400;
		window.open(url,"","scrollbars=yes,resizable=yes"+",height="+height+",width="+width+",left="+(window.screen.width-width)/2+",top="+(window.screen.height-height)/2);
	 }
</script>


