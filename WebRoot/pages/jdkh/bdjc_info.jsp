<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.util.Scape"%>
<%
  String station_id  = request.getParameter("id");
  String station_desc = request.getParameter("station_desc");
  if(!"".equals(station_desc) && station_desc != null){
	   station_desc= Scape.unescape(station_desc);
	   //station_desc = new String(station_desc.getBytes("ISO-8859-1"), "gbk"); 
  }
  String user_area_id = (String)request.getSession().getAttribute("area_id");
  String flag = request.getParameter("flag");
  String now = StringUtil.getNowDate() + "";
   String date1=null;
   date1 = now;
%>

<form action="bdjc_action.jsp" method="post">
<br>
<br>
<table border=0 cellspacing=1  style="width: 800px">
   <caption style="font-size: 16px">国控企业污染源自动监测设备比对监测结果表</caption>
    <tr>
        <td colspan="2" style="text-align: center">企业名称</td>
        <td colspan="4"> 
            <input type="text" name="qymc" value="<%=station_desc %>">
            <input type="hidden" name="qyid" value="<%=station_id %>">
            <input type="hidden" name="flag" value="<%=flag %>">
        </td>
    </tr>
    <tr>
        <td colspan="2" style="text-align: center">比对监测单位</td>
        <td colspan="2"> <input type="text" name="bddw"> </td>
        <td style="text-align: center">监测日期</td>
        <td > <input type="text" name="bdrq" readonly="readonly" value="<%=date1 %>"  onclick="new Calendar().show(this);"> </td>
    </tr>
    
    <tr>
        <td colspan="2" style="text-align: center">点位名称</td>
        <td colspan="4">
          <input type="text" name="zwmc">
        </td>
    </tr>
    <tr>
        <td colspan="2" style="text-align: center">自动监测设备名称 </td>
        <td colspan="4"><input type="text" name="sbmc"></td>
    </tr>
    <tr>
        <td colspan="2" style="text-align: center"> 制造单位</td>
        <td colspan="4"><input type="text" name="zzdw"></td>
    </tr>
    <tr>
        <td colspan="2" style="text-align: center">型号及编号</td>
        <td colspan="4"><input type="text" name="xhbh"></td>
    </tr>

    
    <tr>
        <td rowspan="2" colspan="2">监测项目</td>
        <td colspan="4"> 分析比对方法</td>
    </tr>
    
    <tr>
        <td colspan="2"> 比对方法</td>
        <td colspan="2">
              自动监测方法
              <input type=button value="增加" class="btn" onclick="jc_clickmore('tr_jc',7)"><><input type=button value="减少" class="btn" onclick="jc_clickless('tr_jc',7)">
        </td>
        
    </tr>
    
    <tr id="tr_jc_0">
        <td colspan="2"><input type="text" name="jcxm_name_0"> </td>
        <td colspan="2">
            <input type="text" name="jcxm_bdff_0" id="jcxm_bdff_0">
        </td>
        <td colspan="2">
            <input type="text" name="jcxm_jcff_0" id="jcxm_jcff_0">
        </td>
    </tr>
    
 <% for (int i=1;i<=6;i++){ %>
    
    <tr id="tr_jc_<%=i %>" style="display:none";>
        <td colspan="2"><input type="text" name="jcxm_name_<%=i %>"> </td>
        <td colspan="2">
            <input type="text" name="jcxm_bdff_<%=i %>" id="jcxm_bdff_<%=i %>">
        </td>
        <td colspan="2">
            <input type="text" name="jcxm_jcff_<%=i %>" id="jcxm_jcff_<%=i %>">
        </td>
    </tr>
  <% } %>  
    
    
    <tr>
        <td>项目</td>
        <td>比对监测数据</td>
        <td>自动监测数据</td>
        <td>标准限值</td>
        <td>比对结果</td>
        <td>  
               达标情况
               <br>
            <input type=button value="增加" class="btn" onclick="xm_clickmore('tr_xm',7)"><><input type=button value="减少" class="btn" onclick="xm_clickless('tr_xm',7)">
        </td>
    </tr>
    
    <tr id="tr_xm_0">
        <td><input type="text" name="xm_name_0"  name="xm_name_0"></td>
        <td><input type="text" name="xm_bdsj_0" name="xm_bdsj_0"></td>
        <td><input type="text" name="xm_zdsj_0" name="xm_zdsj_0"></td>
        <td><input type="text" name="xm_bzxz_0" name="xm_bzxz_0"></td>
        <td><input type="text" name="xm_bdjg_0" name="xm_bdjg_0"></td>
        <td><input type="text" name="xm_dbqk_0" name="xm_dbqk_0"></td>
    </tr>
    
  <% for (int i=1;i<=6;i++){ %>
    
    <tr id="tr_xm_<%=i %>" style="display:none";>
        <td><input type="text" name="xm_name_<%=i %>" name="xm_name_<%=i %>"></td>
        <td><input type="text" name="xm_bdsj_<%=i %>" name="xm_bdsj_<%=i %>"></td>
        <td><input type="text" name="xm_zdsj_<%=i %>" name="xm_zdsj_<%=i %>"></td>
        <td><input type="text" name="xm_bzxz_<%=i %>" name="xm_bzxz_<%=i %>"></td>
        <td><input type="text" name="xm_bdjg_<%=i %>" name="xm_bdjg_<%=i %>"></td>
        <td><input type="text" name="xm_dbqk_<%=i %>" name="xm_dbqk_<%=i %>"></td>
    </tr>
  <% } %>  
    
    <tr>
        <td style="text-align: center">经办人</td>
        <td colspan="2">
            <input type="text" name="jbr" > 
        </td>
        <td style="text-align: center">审核人</td>
        <td colspan="2"><input type="text" name="spr" ></td>
    </tr>
    
    <tr>
        <td>比对监测结论</td>
        <td >
             <select name="bdjg">
                  <option value="1">合格</option>
                  <option value="0">不合格</option>
             </select>
         
        </td>
        <td>备注</td>
        <td colspan="3"><input type="text" name="bdjcjl" style="width:350px;"></td>
    </tr>

    <% if(!"".equals(user_area_id) && user_area_id.equals("36") && !"".equals(flag) && flag.equals("1")){ %>
    <tr >
       <td colspan="6" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="确定" class="btn">
           <input type="button" value="关闭" class="btn" onclick="window.parent.window.close();"> </td>
    </tr>
    <%}else if(!"".equals(user_area_id) && !user_area_id.equals("36") && !"".equals(flag) && !flag.equals("1")) {%>
    <tr >
       <td colspan="6" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="确定" class="btn">
           <input type="button" value="关闭" class="btn" onclick="window.parent.window.close();"> </td>
    </tr>
    <%} %>
   
    
</table>

</form>

<script type="text/javascript">

var tr_jc_Show=0;
var tr_xm_show=0;
function jc_clickmore(m_id,count){
    if (0<=tr_jc_Show && tr_jc_Show<count-1){
         tr_jc_Show++;
         document.all(m_id+"_"+tr_jc_Show).style.display="";
    }else {
         alert("最多有"+count+"个窗口!");
    }
}

function jc_clickless(m_id,count){
   if (0<tr_jc_Show && tr_jc_Show<=count-1){
         document.all(m_id +"_"+ tr_jc_Show).style.display="none";
         tr_jc_Show--;
   }else{
         alert("至少留一个窗口！");
   }
}


function xm_clickmore(m_id,count){
    if (0<=tr_xm_show && tr_xm_show<count-1){
         tr_xm_show++;
         document.all(m_id+"_"+tr_xm_show).style.display="";
    }else {
         alert("最多有"+count+"个窗口!");
    }
}

function xm_clickless(m_id,count){
   if (0<tr_xm_show && tr_xm_show<=count-1){
         document.all(m_id +"_"+ tr_xm_show).style.display="none";
         tr_xm_show--;
   }else{
         alert("至少留一个窗口！");
   }
}

function check_form(form){
   if(form.qymc.value == ""){
      alert("请填写企业名称!");
      return false;
   }
   
   if(form.bddw.value == ""){
      alert("请填写比对监测单位!");
      return false;
   }
   
   if(form.bdrq.value == ""){
      alert("请填写监测日期!");
      return false;
   }
   
   if(form.zwmc.value == ""){
      alert("请填写点位名称!");
      return false;
   }
   
   if(form.sbmc.value == ""){
      alert("请填写自动监测设备名称!");
      return false;
   }
   
   if(form.zzdw.value == ""){
      alert("请填写制造单位!");
      return false;
   }
   
   if(form.xhbh.value == ""){
      alert("请填写型号及编号!");
      return false;
   }
   

   var jcxm_name = document.getElementById("jcxm_name_0").value;
   var jcxm_bdff = document.getElementById("jcxm_bdff_0").value;
   var jcxm_jcff = document.getElementById("jcxm_jcff_0").value;
   
   
   if(jcxm_name =="" || jcxm_bdff =="" || jcxm_jcff==""){
      alert("至少填写一个监测项目!");
      return false;
   }
   

   for(var i=1;i<7;i++){
      jcxm_name = document.getElementById("jcxm_name_"+i).value;
      jcxm_bdff = document.getElementById("jcxm_bdff_"+i).value;
      jcxm_jcff = document.getElementById("jcxm_jcff_"+i).value;
      
      if(jcxm_name !="" && (jcxm_bdff =="" || jcxm_jcff=="")){
         alert("请把监测项目信息填写完整!");
         return false;
      }
   }
   
   
  var  xm_name = document.getElementById("xm_name_0").value;
  var  xm_bdsj = document.getElementById("xm_bdsj_0").value;
  var  xm_zdsj = document.getElementById("xm_zdsj_0").value;
  var  xm_bzxz = document.getElementById("xm_bzxz_0").value;
  var  xm_bdjg = document.getElementById("xm_bdjg_0").value;
  var  xm_dbqk = document.getElementById("xm_dbqk_0").value;
   
   
   if(xm_name =="" || xm_bdsj =="" || xm_zdsj=="" || xm_bzxz=="" || xm_bdjg=="" || xm_dbqk==""){
      alert("至少填写一个项目信息!");
      return false;
   }
   

   for(var i=1;i<7;i++){
       xm_name = document.getElementById("xm_name_"+i).value;
       xm_bdsj = document.getElementById("xm_bdsj_"+i).value;
       xm_zdsj = document.getElementById("xm_zdsj_"+i).value;
       xm_bzxz = document.getElementById("xm_bzxz_"+i).value;
       xm_bdjg = document.getElementById("xm_bdjg_"+i).value;
       xm_dbqk = document.getElementById("xm_dbqk_"+i).value;
      
      if(xm_name !="" && (xm_bdsj =="" || xm_zdsj=="" || xm_bzxz=="" || xm_bdjg=="" || xm_dbqk=="")){
         alert("请把项目信息填写完整!");
         return false;
      }
   }
   
   if(form.jbr.value == ""){
      alert("请填写经办人!");
      return false;
   }
    if(form.spr.value == ""){
      alert("请填写审批人!");
      return false;
   }
   
   form.submit();
  
}

</script>



