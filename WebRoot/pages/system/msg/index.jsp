<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<style>
 td{padding:5px}
 a{
 /*font-weight:bold;font-size:15px;*/
 }
 
</style>
<table border=0 cellspacing=0 style='width:100%;height:100%'>
<tr>
<td style='height:20px'>
<div class='menu_bg_div'>
<a href='./phone/q.jsp' target=q class='menu_click' id='menu0' onclick="f_set_css(0)" onfocus="this.blur()">联系人设置</a>
<a href='./area_phone/q.jsp' target=q class='menu_click_no'  id='menu1' onclick="f_set_css(1)" onfocus="this.blur()" style='width:150px'>地区管理员设置</a>
<a href='./his.jsp' target=q class='menu_click_no'  id='menu2' onclick="f_set_css(2)" onfocus="this.blur()">已发送信息</a>
<a href='./log.jsp' target=q class='menu_click_no'  id='menu3' onclick="f_set_css(3)" onfocus="this.blur()">日志</a>
<a href='./config/index.jsp' target=q class='menu_click_no'  id='menu4' onclick="f_set_css(4)" onfocus="this.blur()">参数设置</a>
</div>
</td>
</tr>


<tr>
<td style='height:100%'>
<iframe name=q frameborder=0 width=100% height=100% src='./phone/q.jsp'></iframe>
</td>
</tr>
</table>
<script>
var num=5;

 function f_set_css(index){
    var i=0;
    var obj = null;
    
    for(i=0;i<num;i++){
     obj = getobj("menu"+i);
     f_css(obj,"menu_click_no");
    }
    obj = getobj("menu"+index);
     f_css(obj,"menu_click");
    
 }
</script>
