<%@ page contentType="text/html;charset=gbk" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

try{
    
    SwjUpdate.station_index(request);//初始化页面数据
    
    //w封装了本页的request和response对象。
    
    }catch(Exception e){
    w.error(e);
    return;
}

boolean iswry = f.iswry(w.get("station_type"));//是否是污染源


RowSet rs = w.rs("flist");

String session_id = (String)session.getAttribute("session_id");
String user_name = (String)session.getAttribute("user_name");
String infectant_ids ="";
boolean b = zdxUpdate.isReal(user_name,session_id);//需恢复
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<link rel="stylesheet" href="../../web/index.css"/>
<title>在线检测和监控管理系统</title>
</head>
<body onload='f_real()'  style="overflow: hidden;">
<form name=form1 method=post target='frm_real_data' >

<div class="frame-main-content" style="left:0; top:0;position: static;white-space: nowrap;">

<div class="nt">
<input type="hidden" name="state" id="state" value="zc"/>
<ul class="">
<li>
<label>
站位类型：
<select class="selectoption" name=station_type  onchange="f_rr()">
<%=w.get("stationTypeOption")%>
</select>
</label>
</li>
<li>
<label>
地区：
<select class="selectoption" name=area_id id="area_id" onchange=f_r()>
<%=w.get("areaOption")%>
</select>
</label>
</li>
<li>
<label>
重点源：
<select class="selectoption" name=ctl_type onchange=f_r()>
<option value=''>所有</option>
<%=w.get("ctlTypeOption")%>
</select>
</label>
</li>
<li>
<label>
行业：
<select class="selectoption" name=trade_id onchange=f_r()>
<option value=''>所有</option>
<%=w.get("tradeOption")%>
</select>
</label>
</li>
<li>
<label>
建设类型：
<select class="selectoption" name=build_type onchange=f_r()>
<option value=''>所有</option>
<%=w.get("buildTypeOption")%>
</select>
</label>
</li>
</ul>

</div>

<div class="tiaojian" style="float: left;clear: none;">
<p class="tiaojiao-p">
站位名称： <input type="text" class="c1" name='station_desc' value='' onkeydown="KeyDown(event,this.form)"/>
</p>
<input type="submit" class="tiaojianbutton" value="查看" />
<input type="button" class="tiaojianbutton" id="infectant_show" value="显示监测因子" onclick='f_show_all()' />
<input type="button" class="tiaojianbutton" id="infectant_hide" value="隐藏监测因子" onclick='f_hide_all()' style="display: none"/>
<input type="button" class="tiaojianbutton" value="不刷新"  name="b_fresh" id="b_fresh" onclick='f_fresh()' />
<input type="button" class="tiaojianbutton" value="导出表格" onclick='export_real_data()' />
<input type="button" class="tiaojianbutton" value="汇总信息" onclick='f_hz()' />

<input type="hidden" name="station_ids" id="station_ids" />
<input type="hidden" name="data_flag" id="data_flag" value="real" />
</div>

<div class="tiaojian" style="float:right;clear: none;">
<p class="tiaojiao-p" onclick="count_click('')" style="cursor: pointer;" title="可点击">
<img src="../../images/common/active5.gif" width="18" height="18" />全部<span id="all" style="font-size:12px;font-weight:bold"></span>
</p>
<p class="tiaojiao-p" onclick="count_click('zc')" style="cursor: pointer;" title="可点击">
<img src="../../images/common/active1.gif" width="18" height="18" />正常<span id="zc" style="font-size:12px;font-weight:bold"></span>
</p>
<p class="tiaojiao-p" onclick="count_click('yj')" style="cursor: pointer;" title="可点击">
<img src="../../images/common/active2.gif" width="18" height="18" />预警<span id="yj" style="font-size:12px;font-weight:bold"></span>
</p>
<p class="tiaojiao-p" onclick="count_click('bj')" style="cursor: pointer;" title="可点击">
<img src="../../images/common/active3.gif" width="18" height="18" />报警<span id="bj" style="font-size:12px;font-weight:bold"></span>
</p>
<p class="tiaojiao-p" onclick="count_click('tj')" style="cursor: pointer;" title="可点击">
<img src="../../images/common/active4.gif" width="18" height="18" />脱机<span id="tj" style="font-size:12px;font-weight:bold"></span>
</p>
</div>

<div class="tiaojian">
<%while(rs.next()){
    if(!rs.get("infectant_name").equals("流量2")){
        %>
        <p class="tiaojiao-p" style="display: none;margin-top:5;" id="<%=rs.get("infectant_id")%>">
        <input type="checkbox" id="<%=rs.get("infectant_id")%>" name='infectant_id' value='<%=rs.get("infectant_id")%>' checked="checked" onchange="form1.submit();" />
        <label for="<%=rs.get("infectant_id")%>"><%=rs.get("infectant_name")%></label>
        </p>
        <%
        if("".equals(infectant_ids))infectant_ids=rs.get("infectant_id");
        else infectant_ids = infectant_ids+","+rs.get("infectant_id");
    }
}%></div>


</div>
</form>
<iframe name='frm_real_data' id='frm_real_data'  frameborder="0" marginheight="0" marginwidth="0" frameborder="0" scrolling="auto"  width="100%"></iframe>

<form name=form2 method=post>
<input type=hidden name='txt_excel_content' />
<input type=hidden name='title' value="实时数据" />
</form>
<form name=form3 method=post>
<input type=hidden name='station_id' />
<input type=hidden name='area_id'  />
</form>
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
        form1.action="real_ifr.jsp";
        }else{
        form1.action="hour.jsp";
    }
    
    form1.station_ids.value = "";
//     form1.target='frm_real_data';
}
//刷新
var thread = window.setInterval('f_submit()',60000);
function f_fresh(){
    if(form1.b_fresh.value=="不刷新"){
        window.clearInterval(thread);
        form1.b_fresh.value = "刷新";
        }else{
        thread = window.setInterval('f_submit()',60000);
        form1.b_fresh.value = "不刷新";
    }
}

function f_excel(){
    //alert("ddd");
    // alert(form1.data_flag.value);
    if(form1.data_flag.value=='real'){
        var r = window.frames["frm_real_data"].window.document.all('station_ids');
        if(r == null){
            alert("没有导出数据");
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
        emptyText:'请选择',
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
    
    if (e.keyCode == 13)
    {
        e.returnValue=false;
        e.cancel = true;
        by_excel();
        form1.submit();
    }
}

//alert("您显示器的分辨率为:\n" + screen.width + "×" + screen.height + "像素");
if(screen.height>=1024){
    document.getElementById("frm_real_data").height=800;
    }else if(screen.height>=900  && screen.height<1024 ){
    document.getElementById("frm_real_data").height=680;
    }else if(screen.height>=800  && screen.height<900 ){
    document.getElementById("frm_real_data").height=580;
    }else if(screen.height>=768  && screen.height<800 ){
    document.getElementById("frm_real_data").height=540;
    }else if(screen.height>=720  && screen.height<768 ){
    document.getElementById("frm_real_data").height=500;
}


</script>

</body>
</html> 
