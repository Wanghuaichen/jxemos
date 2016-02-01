<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

    RowSet station,flist;



    try{

      SwjUpdate.report_sj_index(request);

    }catch(Exception e){
     w.error(e);
     return;
    }
    station = w.rs("stationList");
    flist = w.rs("flist");
    boolean iswry = f.iswry(w.get("station_type"));
    String index = null;
    int td_width=150;
    String station_id_0 = null;
    String station_desc_0 = null;
    String sh_flag = request.getParameter("sh_flag");
    String shOption = SwjUpdate.getShState(sh_flag);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title>汇总信息</title>
<link href="../../styles/reset-min.css" rel="stylesheet" type="text/css" />
<link href="../../styles/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<link href="../../styles/common/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../scripts/core/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.core.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.widget.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.tabs.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.check.js"></script>
<script type="text/javascript" src="../../scripts/common.js"></script>
<script type="text/javascript" src="../../scripts/calendar.js"></script>
<style>
.search {font-family: "宋体"; font-size: 12px;width:200px; BEHAVIOR: url('<%=request.getContextPath() %>/styles/selectBox.htc'); cursor: hand; }
.input {
   border: #ccc 1px solid;
   font-family: "微软雅黑";
   font-size: 12px;
   padding-top:2px;
   width: 80px;
   background:expression((this.readOnly &&this.readOnly==true)?"#f9f9f9":"")
}


 .scrolldiv {
	height:320px; overflow:scroll;
	scrollbar-base-color: #ecf2f9;
	scrollbar-arrow-color: #336699;
	scrollbar-track-color: #ecf2f9;
	scrollbar-3dlight-color: #ecf2f9;
	scrollbar-darkshadow-color: #ecf2f9;
	scrollbar-highlight-color: #336699;
	scrollbar-shadow-color: #336699;
}

.scrolldiv ul{margin:10px 0px 0px 10px}
.scrolldiv ul li{height:26px}
.scrolldiv ul li a{display:block; width:189px; height:23px; line-height:23px; color:#000; text-indent:4px}
.scrolldiv ul li a:hover{background:url(<%=request.getContextPath() %>/images/common/viewbar.gif) no-repeat; text-decoration:none}
.scrolldiv ul li a:visited{background-color: #f7f7f7;text-decoration:none}


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

    form1.action='/<%=ctx%>/pages/commons/save2excel.jsp';
    form1.submit();
}

</script>

<body style="background-color: #f7f7f7">
<!--<%=w.get("sql")%>-->

<form name=form1 method=post action='rpt.jsp' target='frm_station'>
<input type=hidden name='txt_excel_content'>
<input type=hidden name='title' value='污染物排放总量报表' >
<input type=hidden name='w_cols' value='val01,val02,val03,val04,val05,val06,val07,val08,val16,val17'>
<input type=hidden name='w_gross_cols' value='val01,val02,val05,val16,val17'>
<input type=hidden name='w_q_col' value='val04'>


<input type=hidden name='w_ph' value='val03'>
<input type=hidden name='w_cod' value='val02'>
<input type=hidden name='w_toc' value='val01'>
<input type=hidden name='w_q' value='val04'>
<input type=hidden name='w_q_lj' value='val08'>
<input type=hidden name='w_nh3n' value='val05'>
<input type=hidden name='w_tn' value='val17'>
<input type=hidden name='w_tp' value='val16'>
<input type=hidden name='station_id' value=''>


<input type=hidden name='g_cols' value='val05,val06,val07,val04,val09,val11,val22'>
<input type=hidden name='g_gross_cols' value='val05,val06,val07'>
<input type=hidden name='g_q_col' value='val11'>

<input type=hidden name='g_so2' value='val05'>
<input type=hidden name='g_pm' value='val06'>
<input type=hidden name='g_nox' value='val07'>
<input type=hidden name='g_op' value='val04'>
<input type=hidden name='g_t' value='val09'>
<input type=hidden name='g_q' value='val11'>
<input type=hidden name='g_s' value='val11'>
<input type=hidden name='g_q_lj' value='valxx'>


<table border=0 style='width:100%;height=100%' cellspacing=0>
 <tr>
  <td width="210" class="left">
<div class="leftCon">
<div class="sub">
<select name=area_id onchange=f_r() class="search">
<%=w.get("areaOption")%>
</select>
</div>
<div class="sub">
<select name=station_type  onchange=f_r() class="search">
<%=w.get("stationTypeOption")%>
</select>
</div>
<div class="sub">
<select name=ctl_type onchange=f_r() class="search">
<option value=''>重点源属性</option>
<%=w.get("ctlTypeOption")%>
</select>
</div>
<div class="sub">
<select name=valley_id onchange=f_r() class="search">
<option value=''>请选择流域</option>
<%=w.get("valleyOption")%>
</select>
</div>
<div class="sub">
<select name=trade_id onchange=f_r() class="search" >
<option value=''>请选择行业</option>
<%=w.get("tradeOption")%>
</select>
</div>
<div class="leftLine2">
<input type=text name=p_station_name value='<%=w.get("p_station_name")%>' class="input1" />
<input type=button value='' class="viewbtn button" onclick='f_r()' />
</div>
			  <div class='scrolldiv'> 
			  <ul>
										<%
										station.reset();
										while(station.next()){
										index = station.getIndex()+"";
										if(f.empty(station_id_0)){station_id_0=station.get("station_id");station_desc_0 = station.get("station_desc");}
										%>
										<li style="cursor:hand">
										<a id='td<%=index%>' title="<%=station.get("station_desc")%>" href="#"  onclick=f_station_click(<%=index%>,'<%=station.get("station_id")%>') >
									<%=station.get("station_desc")%>
										</a>
										</li>
										<%}%>
			  </ul>
			  </div>
</div>
  </td>


 <td class="right">
                 <div class="rightCon">
                   <div class="view2">
                   <div class="view2Con">

                   <font style='font-weight:bold;font-size:15px;display:none' id='font_station_name'></font>

                   <div class="item">
                  	 均值类型:
                       <select name='rpt_data_table' id='rpt_data_table' onchange=f_submit() class="search" style="width:90px;">
                          <%--<option value='T_MONITOR_REAL_TEN_MINUTE' >十分钟数据</option>--%>
                         <option value='t_monitor_real_hour' selected>小时数据</option>
                         <option value='t_monitor_real_day'>日数据</option>
                         <option value='t_monitor_real_month'>月数据</option>
                       </select>
                   </div>
                       <!--
                       <select name='infectant_id' id='infectant_id'>
                        <%while(flist.next()){%>
                         <option value='<%=flist.get("infectant_id")%>'>
                         <%=flist.get("infectant_name")%> <%=flist.get("infectant_unit")%>
                        <%}%>
                       </select>
                       -->
                    <div class="item">
                            从:
                       <input type='text' class='input' name='date1' id='date1' value='<%=w.get("date1")%>' readonly="readonly" onclick="new Calendar().show(this);" />
                      到:
                       <input type='text' class='input' name='date2' id='date2' value='<%=w.get("date2")%>' readonly="readonly" onclick="new Calendar().show(this);" />
                    </div>

        <div class="item">
                      数据状态:
					<select name="sh_flag"  onchange=f_submit() class="search" style="width:80px;">
					<%=shOption %>
					</select>
        </div>
        <div class="item">
                       <input type="button" value='查看' title="查看" style="width:80px" class="btn1 button" onclick='f_submit()' id='btn_view' />
        </div>
        <div class="item">
                         <input type="button" value='保存为excel' title="保存为excel" class="btn1 button"  onclick=f_save() />
        </div>
                         <%--<img src="../../images/color_mark05.png" />
					     <img src="../../images/color_mark06.png" />--%>

                    </div>
                    </div>

                     <iframe id='frm_station_id' name='frm_station' src='../commons/empty.jsp' width=100% frameborder=0  onload='Javascript:SetCwinHeight(this)'  scrolling="auto"></iframe>

                 </div>
  </td>
 </tr>


</table>

</form>
</body>
</html>
<script>
var station_sel_index = -1;

<%if(!f.empty(station_id_0)){%>
  f_station_click(0,'<%=station_id_0%>','<%=station_desc_0%>');
<%}%>

function f_station_click(index,station_id){
       form1.station_id.value=station_id;
/*       var obj = null;
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
       obj2.innerHTML=obj1.innerHTML   */
       f_submit();
}
function f_submit(){
  form1.action='rpt.jsp';
  form1.target='frm_station';
  form1.submit();

}
 function f_r(){
   form1.action='index.jsp';
   form1.target='';
   form1.submit();
   form1.target='frm_station';
 }


</script>




