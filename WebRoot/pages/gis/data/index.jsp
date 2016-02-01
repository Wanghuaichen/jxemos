<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

    RowSet flist;
    try{
    
      SwjUpdate.station_one_index(request);
    
    }catch(Exception e){
     w.error(e);
     return;
    }
    flist = w.rs("flist");
    boolean iswry = f.iswry(w.get("station_type")); 
    String wry_display = "yes";
    if(!iswry){wry_display = "none";}
    
      
%>
<title><%=w.get("station_desc")%></title>
<body scroll=no onload="f_data()">
<form name=form1 method=post target="frm_station">
<input type=hidden name='station_id' value="<%=w.get("station_id")%>">
<input type=hidden name='station_type' value="<%=w.get("station_type")%>">

<input type=hidden name='w'>
<input type=hidden name='h'>
<input type=hidden name='show_zb_flag' value='0'>
<input type=hidden name='show_btn_flag' value='0'>


  <table style='width:100%;height:100%' border=0 cellspacing=0>
    <tr>
      <td height=10px>
      
        <div class='menu_bg_div'>
        
                   
                 <font id='menu0' onclick="f_data()" class='menu_click'>数据</font>
                 
                 <font id='menu1' onclick="f_chart()">曲线</font>
                 
                 <font id='menu2' onclick="f_rpt()" style='display:none'>报表</font><font id='menu3' onclick="f_sp()" style='display:none'>视频</font><font id='menu4' onclick="f_ctl()" style='display:none'>远程控制</font><font id='menu5' onclick="f_info()">属性</font>
                 <font id='menu6' onclick="f_wry()" style='display:<%=wry_display%>'>污染源信息</font>
                 <font id='menu7' onclick="f_zb()">监测指标</font> 
                 <font id='menu8' onclick="f_bz()" style='display:none'>备注</font>   
                  
                   
                   <!--<b><%=w.get("station_desc")%></b>-->
                   
                   </div>
                   
                   <div style='padding-top:8px'>
                       <select name='data_table' id='data_table' onchange='f_btn();f_submit()'>
                         <option value='t_monitor_real_minute'>实时数据
                         <option value='t_monitor_real_hour' selected>小时数据
                         <option value='t_monitor_real_day'>日数据
                         <option value='t_monitor_real_month'>月汇总数据
                       </select>
                       
                       <select name='infectant_id' id='infectant_id'>
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
                       
                       
                       
                       <input type='button' value='查看' class='btn' id='btn_view' onclick='f_submit()'>
      
      </td>
    </tr>
    
    <tr>
      <td  style='height:100%;padding:0px'>
                           <iframe id='frm_station_id' name='frm_station' width=100% height=100% frameborder=0></iframe>
      </td>
    </tr>
  </table>
</form>
</body>

<script>

var station_sel_index = -1;
var flag_first = 0;
var menu_num=9;

  function f_station_click(index,station_id){
     //alert(index+"_"+station_id);
      //alert(form1.station_id.value);
       form1.station_id.value=station_id;
       //alert(form1.station_id.value);
       
       //form1.submit();
       f_submit();
       var obj = null;
       if(station_sel_index>=0){
        obj = document.getElementById("td"+station_sel_index);
            obj.className="bg"; 
       }
       station_sel_index=index;
       obj = document.getElementById("td"+index);
    obj.className="bgclick";
     
       
  }




   f_btn_avg(); 
   
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

 function f_r(){
   form1.action='index.jsp';
   form1.target='';
   form1.submit();
   form1.target='frm_station';
 }
 
 function f_chart(){
  //alert('chart');
 f_hide_all();
 f_ajf_show("data_table,infectant_id,date1,date2,btn_view");
  f_btn();
  f_get_wh();
  
  f_ajf_show("infectant_id");
  form1.action='../../site/chart/chart.jsp';
  form1.target='frm_station';
  form1.submit();
   f_set_css(1);
 }
 
 function f_data(){
 f_hide_all();
 f_ajf_show("data_table,date1,date2,btn_view");
 f_btn();
  //alert('data');
  //f_ajf_hide("infectant_id");
   form1.action='../../station_new/data/index.jsp';
  form1.submit();
   f_set_css(0);
 }
 
 function f_report(){
 f_hide_all();
  //alert('report');
  form1.action='../site/report/report.jsp';
  form1.submit();
   f_set_css(2);
 }
 
 function f_sp(){
  //alert('sp');
 f_hide_all();
  form1.action='../../site/sp/sp_one.jsp';
  form1.submit();
   f_set_css(3);
  
 }
 
 function f_info(){
  //alert('info');
f_hide_all();
  form1.action='station_info.jsp';
  form1.submit();
   f_set_css(5);
  
 }
 
 function f_wry(){
  //alert('wry');
   f_hide_all();
   form1.action='../../system/station/wry/site_view.jsp';
   form1.submit();
    f_set_css(6);
 }
 
 function f_zb(){
  //alert('zb');
   f_hide_all();
   form1.action='../../system/station/infectant/list.jsp';
   form1.submit();
    f_set_css(7);
 }
 
 function f_bz(){
  //alert('zb');
   f_hide_all();
   form1.action='bz.jsp';
   form1.submit();
   f_set_css(8);
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

        form1.w.value = w;
        form1.h.value = h;
 }
 
 
 
 
 function f_hide_all(){
  var ids="infectant_id,data_table,date1,date2,date3,hour1,hour2,hour3,btn_view";
  f_ajf_hide(ids);
 }
 
 function f_btn_real(){
        //f_hide_all();
        f_ajf_hide("date1,date2");
      f_ajf_show("date3,hour3");
 }
 function f_btn_avg(){
   // f_hide_all();
   f_ajf_hide("date3,hour3");
    f_ajf_show("date1,date2");
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



