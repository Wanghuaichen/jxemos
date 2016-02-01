<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

    RowSet station,flist;
    
     

    try{
    
      SwjUpdate.ww_station_index(request);
    
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
    String wry_display = "yes";
    if(!iswry){wry_display = "none";}
    
    
%>
<style>
*{ padding:0px; margin:0px; font-size:12px; line-height:18px;}
.bgclick {
	BORDER-RIGHT: #e8a947 1px solid; BORDER-TOP: #e8a947 1px solid; BORDER-LEFT: #e8a947 1px solid; BORDER-BOTTOM: #e8a947 1px solid; BACKGROUND-COLOR:
#FFFFCC
}
  .bg{
 /*background-color: white;*/
 background-color:;
 border:0;
 /*font-color:balck;*/
 }
 .trayyellow12{ color:#ce4f00; font-weight:bold;}
</style>
<body scroll=no>
<!--<%=w.get("sql")%>-->

<form name=form1 method=post action='./data/ww_index.jsp' target='frm_station'>
<input type=hidden name='w'>
<input type=hidden name='h'>
<input type=hidden name='show_zb_flag' value='0'>
<input type=hidden name='show_btn_flag' value='0'>
<input type=hidden name='station_id'>
<input type=hidden name='station_name'>

<input type=hidden name='area_id'>
<input type=hidden name='station_type'>
<input type=hidden name='ctl_type'>
<input type=hidden name='valley_id'>
<input type=hidden name='trade_id'>
<input type=hidden name='p_station_name'>

<input type=hidden name='sh_flag' value='0'>

<table border=0 style='width:100%;height=100%' cellspacing=0>

 <tr>
  <td style='width:<%=td_width%>px' class='top' valign='top' >
</td>
  <td width="8" rowspan=2 valign="middle" bgcolor="#add1f8"></td>
  
  <td rowspan=2 height="89"  width="100%" style="padding-left:0px;padding-top:0px;">
                 <table  style='width:100%;height:100%;border:solid 0px red' border="0" cellspacing="0" cellpadding="0">
                 <tr>
                   <td height=10px background="../../images/index_table_topbg.jpg">
                  
                   <div style='padding-top:15px'>
                 
                 <font id='menu0' onclick="f_data()" class='menu_click'>数据</font>
                 <font id='menu1' onclick="f_chart()">曲线</font>
                 <font id='menu2' onclick="f_rpt()" style='display:none'>报表</font>
                 <font id='menu3' onclick="f_sp()" style='display:none'>视频</font>
                 <font id='menu4' onclick="f_ctl()" style='display:none'>远程控制</font>
                 <font id='menu5' onclick="f_info()" style='display:none'>属性</font>
                 <font id='menu6' onclick="f_wry()" style='display:none'>污染源信息</font>
                 <font id='menu7' onclick="f_zb()" style='display:none'>监测指标</font> 
                   
                  
                   <font style='font-weight:bold;font-size:15px;display:none' id='font_station_name'></font>
                  
                   </div>
                   <div style='padding-top:5px'>
                       <select name='data_table' id='data_table' onchange='f_btn();f_submit()'>
                         <option value='t_monitor_real_minute' selected>实时数据
                         <option value='t_monitor_real_hour' >小时数据
                         <option value='t_monitor_real_day'>日数据
                         <option value='t_monitor_real_month'>月汇总数据
                       </select>
                       
                       <select name='infectant_id' id='infectant_id' onchange='infectant_submit()'>
                        <%while(flist.next()){%>
                         <option value='<%=flist.get("infectant_id")%>'>
                         <%=flist.get("infectant_name")%> <%=flist.get("infectant_unit")%>
                        <%}%>
                       </select>
                       
                       <input type='text' class='date' name='date1' id='date1' value='<%=w.get("date1")%>' onclick="new Calendar().show(this);">
                       <select name=hour1 id='hour1'>
                       <%=w.get("hour1Option")%>
                       </select>
                       
                       <input type='text' class='date' name='date2' id='date2' value='<%=w.get("date2")%>' onclick="new Calendar().show(this);">
                       <select name=hour2 id='hour2'>
                       <%=w.get("hour2Option")%>
                       </select>
                       
                       <input type='text' class='date' name='date3' id='date3' value='<%=f.today()%>' onclick="new Calendar().show(this);">
                       <select name=hour3 id='hour3'>
                       <%=w.get("hour2Option")%>
                       </select>
                       <select name="chart_form" onchange="f_chart()">
						             <option value="1">曲线图</option>
						             <option value="0">柱状图</option>
						             </select>
                       
                       <input type="hidden" name="view_flag" id="view_flag" value="false">
                       <input type='button' value='查看' class='btn' onclick='f_view()' id='btn_view'>

			<input type='button' value='查看全部' class='btn' onclick='f_all_view()' id='btn_view_all'>
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
     <td style='height:100%;padding-top:0px;'  class='top' bgcolor="#FFFFFF">
     
  
  <div class='scrolldiv' style='padding-left:3px;padding-right:10px;'>
                     <table style="cursor:hand" border=0  cellspacing=5 style='width:<%=td_width-30%>px;background-color:#FFFFFF;'>
										<%
										station.reset();
										while(station.next()){
										index = station.getIndex()+"";
										if(f.empty(station_id_0)){
										station_id_0=station.get("station_id");
										}
										%>
										<tr >
										<td height="28" align="center" style="padding-top:5px;border:#4f8ac6 dashed 2px;"  id='td<%=index%>' onclick="f_station_click(<%=index%>,'<%=station.get("station_id")%>')" >
									<font id='station_desc_<%=index%>'><%=station.get("station_desc")%></font>
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


 function ff_submit(){
 	form1.target='frm_station';
 	form1.submit();
 }
 

<%if(!f.empty(station_id_0)){%>
  f_station_click(0,'<%=station_id_0%>');
<%}%>

  function f_station_click(index,station_id,station_name){
       form1.station_id.value=station_id;
       
       f_submit();
       var obj = null;
       if(station_sel_index>=0){
        obj = document.getElementById("td"+station_sel_index);
            obj.className="bg"; 
       }
       station_sel_index=index;
       obj = document.getElementById("td"+index);
    obj.className="bgclick";
     var obj1,obj2=null;
        obj1 = getobj("station_desc_"+index);
       obj2 = getobj("font_station_name");
       obj2.innerHTML=obj1.innerHTML
       
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

 function f_chart(){
  //alert('chart');
 f_hide_all();
 f_ajf_show("data_table,infectant_id,date1,date2,btn_view,btn_view_all,chart_form");
  f_btn();
  f_get_wh();
  
  f_ajf_show("infectant_id");
  form1.action='../site/chart/chart.jsp';
  form1.target='frm_station';
  form1.submit();
  f_set_css(1);
 }
 
 function f_r(){
   form1.action='index.jsp';
   form1.target='';
   form1.submit();
   form1.target='frm_station';
 }
 
 
 function f_data(){
 f_hide_all();
 f_ajf_show("data_table,date1,date2,btn_view");
 f_btn();
  //alert('data');
  //f_ajf_hide("infectant_id");
   form1.action='./data/ww_index.jsp';
  form1.submit();
  f_set_css(0);
  
 }
 function f_view(){
 	form1.view_flag.value="false";
 	form1.target='frm_station';
	form1.submit();
 }
 
 function f_info(){
  //alert('info');
f_hide_all();
  form1.action='../system/station/sx_view.jsp';
  form1.submit();
  f_set_css(5);
  
 }

function f_all_view(){
 	form1.view_flag.value="true";
 	f_submit();
 }
 function infectant_submit(){
 	form1.view_flag.value="false";
 	f_submit();
 }
 
 function f_zb(){
  //alert('zb');
   f_hide_all();
   form1.action='../system/station/infectant/list.jsp';
   form1.submit();
   f_set_css(7);
 }
 
  function f_ctl(){
  //alert('ctl');
   f_hide_all();
  form1.action='../site/yckz.jsp';
   form1.submit();
   f_set_css(4);
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
  var ids="infectant_id,data_table,date1,date2,date3,hour1,hour2,hour3,btn_view,btn_view_all,chart_form";
  f_ajf_hide(ids);
 }
 
 function f_btn_real(){
        //f_hide_all();
        f_ajf_hide("date1,date2,hour1,hour2");
      f_ajf_show("date3,hour3");
 }
 function f_btn_avg(){
   // f_hide_all();
   f_ajf_hide("date3,hour3");
    f_ajf_show("date1,date2,hour1,hour2");
 }
 
 function f_btn(){
  var obj = form1.data_table;
   var i = obj.selectedIndex;
   if(i<1){
   f_btn_real();
   }else{
   f_btn_avg()
   }
 }
 
  function f_set_css(index){
    var i=0;
    var obj = null;
    
    for(i=0;i<menu_num;i++){
     obj = getobj("menu"+i);
     f_css(obj,"menu_click_no");
    }
    obj = getobj("menu"+index);
     f_css(obj,"menu_click");
    
 }
 
 
</script>


