<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.f,java.util.*,com.hoson.zdxupdate.*,com.hoson.XBean"%>
<%

    Map data;
    
    RowSet data_jcxm = null;
    RowSet data_xm = null;

    String id = "";
    String user_area_id = (String)request.getSession().getAttribute("area_id");
    String flag = request.getParameter("flag");
    try{
      id = request.getParameter("id");
      SwjUpdate.queryBdjcInfoByID(request);
    }catch(Exception e){
       w.error(e);
       return;
    }
    
    data = (Map)w.a("data_bdjc");
    
    data_jcxm = w.rs("data_jcxm");
    
    data_xm = w.rs("data_xm");
	//String drop_css = "";
	String checked = "";


  	Map map = null;

%>

<form action="bdjc_updateaction.jsp" method="post">
<br>
<br>
<table border=0 cellspacing=1  style="width: 800px">
   <caption style="font-size: 16px">国控企业污染源自动监测设备比对监测结果表</caption>
    <tr>
        <td colspan="2" style="text-align: center">企业名称</td>
        <td colspan="4"> 
            <input type="text" name="qymc" value="<%=data.get("qymc") %>">
            <input type="hidden" name="qyid" value="<%=data.get("qyid") %>">
            <input type="hidden" name="id" value="<%=id%>">
            <input type="hidden" name="flag" value="<%=flag %>">
        </td>
    </tr>
    <tr>
        <td colspan="2" style="text-align: center">比对监测单位</td>
        <td colspan="2"> <input type="text" name="bddw" value="<%=data.get("bddw") %>"> </td>
        <td style="text-align: center">监测日期</td>
        <td > <input type="text" name="bdrq" value="<%=data.get("bdrq") %>" readonly="readonly"  onclick="new Calendar().show(this);"> </td>
    </tr>
    
    <tr>
        <td colspan="2" style="text-align: center">点位名称</td>
        <td colspan="4">
          <input type="text" name="zwmc" value="<%=data.get("zwmc") %>">
        </td>
    </tr>
    <tr>
        <td colspan="2" style="text-align: center">自动监测设备名称 </td>
        <td colspan="4"><input type="text" name="sbmc" value="<%=data.get("sbmc") %>"></td>
    </tr>
    <tr>
        <td colspan="2" style="text-align: center"> 制造单位</td>
        <td colspan="4"><input type="text" name="zzdw" value="<%=data.get("zzdw") %>"></td>
    </tr>
    <tr>
        <td colspan="2" style="text-align: center">型号及编号</td>
        <td colspan="4"><input type="text" name="xhbh" value="<%=data.get("xhbh") %>"></td>
    </tr>

    
    <tr>
        <td rowspan="2" colspan="2">监测项目</td>
        <td colspan="4"> 分析比对方法</td>
    </tr>
    
    <tr>
        <td colspan="2"> 比对方法</td>
        <td colspan="2">
              自动监测方法
        </td>
        
    </tr>
    
    
    
   <%
      int i=0;
      while(data_jcxm.next()){
 
   %>
   
   <tr id="tr_jc_<%=i %>">
        <td colspan="2">
           <input type="text" name="jcxm_name_<%=i %>" id="jcxm_name_<%=i %>" value="<%=data_jcxm.get("jcxm_name") %>"> 
           <input type="hidden" name="jcxm_id_<%=i %>" value="<%=data_jcxm.get("id") %>">
       </td>
        <td colspan="2">
            <input type="text" name="jcxm_bdff_<%=i %>" id="jcxm_bdff_<%=i %>" value="<%=data_jcxm.get("jcxm_bdff") %>">
        </td>
        <td colspan="2">
            <input type="text" name="jcxm_jcff_<%=i %>" id="jcxm_jcff_<%=i %>" value="<%=data_jcxm.get("jcxm_jcff") %>">
        </td>
    </tr>
   
   <%  
        i++;
    } 
   %>
   
   <%
      for(int j =i;j<7;j++){
   %>
     <tr id="tr_jc_<%=j %>">
        <td colspan="2">
            <input type="text" name="jcxm_name_<%=j %>" id="jcxm_name_<%=j %>" > 
            <input type="hidden" name="jcxm_id_<%=j %>" value="">
       </td>
        <td colspan="2">
            <input type="text" name="jcxm_bdff_<%=j %>" id="jcxm_bdff_<%=j %>" >
        </td>
        <td colspan="2">
            <input type="text" name="jcxm_jcff_<%=j %>" id="jcxm_jcff_<%=j %>" >
        </td>
    </tr>
    
   <%
     }
   %>
    <tr>
        <td>项目</td>
        <td>比对监测数据</td>
        <td>自动监测数据</td>
        <td>标准限值</td>
        <td>比对结果</td>
        <td>  
               达标情况
        </td>
    </tr>
    
    
    <%
      i=0;
      while(data_xm.next()){
 
   %>
   
   <tr id="tr_xm_<%=i %>">
        <td>
           <input type="text" name="xm_name_<%=i %>"  name="xm_name_<%=i %>" value="<%=data_xm.get("xm_name") %>">
           <input type="hidden" name="xm_id_<%=i %>" value="<%=data_xm.get("id") %>">
        </td>
        <td><input type="text" name="xm_bdsj_<%=i %>" name="xm_bdsj_<%=i %>" value="<%=data_xm.get("xm_bdsj") %>"></td>
        <td><input type="text" name="xm_zdsj_<%=i %>" name="xm_zdsj_<%=i %>" value="<%=data_xm.get("xm_zdsj") %>"></td>
        <td><input type="text" name="xm_bzxz_<%=i %>" name="xm_bzxz_<%=i %>" value="<%=data_xm.get("xm_bzxz") %>"></td>
        <td><input type="text" name="xm_bdjg_<%=i %>" name="xm_bdjg_<%=i %>" value="<%=data_xm.get("xm_bdjg") %>"></td>
        <td><input type="text" name="xm_dbqk_<%=i %>" name="xm_dbqk_<%=i %>" value="<%=data_xm.get("xm_dbqk") %>"></td>
    </tr>
   
   <%  
        i++;
    } 
   %>
   
   <%
      for(int j =i;j<7;j++){
   %>
     <tr id="tr_xm_<%=j %>">
        <td>
            <input type="text" name="xm_name_<%=j %>"  name="xm_name_<%=j %>" >
            <input type="hidden" name="xm_id_<%=j %>" value="">
        </td>
        <td><input type="text" name="xm_bdsj_<%=j %>" name="xm_bdsj_<%=j %>"  ></td>
        <td><input type="text" name="xm_zdsj_<%=j %>" name="xm_zdsj_<%=j %>" ></td>
        <td><input type="text" name="xm_bzxz_<%=j %>" name="xm_bzxz_<%=j %>"  ></td>
        <td><input type="text" name="xm_bdjg_<%=j %>" name="xm_bdjg_<%=j %>"  ></td>
        <td><input type="text" name="xm_dbqk_<%=j %>" name="xm_dbqk_<%=j %>"  ></td>
    </tr>
    
   <%
     }
   %>
    
     <tr>
        <td style="text-align: center">经办人</td>
        <td colspan="2">
            <input type="text" name="jbr" value="<%=data.get("jbr") %>"> 
        </td>
        <td style="text-align: center">审核人</td>
        <td colspan="2"><input type="text" name="spr" value="<%=data.get("spr") %>"></td>
    </tr>
    
    <tr>
        <td>比对监测结论</td>
        <td >
             <select name="bdjg">
                  <%=f.getOption("1,0","合格,不合格",(String)data.get("bdjg")) %>
             </select>
         
        </td>
        <td>备注</td>
        <td colspan="3"><input type="text" name="bdjcjl" style="width:350px;" value="<%=data.get("bdjcjl") %>"></td>
    </tr>

    
    <% if(!"".equals(user_area_id) && user_area_id.equals("36") && !"".equals(flag) && flag.equals("1")){ %>
	    <tr >
	       <td colspan="6" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="修改" class="btn">
	           <input type="button" value="关闭" class="btn" onclick="window.close();">&nbsp;&nbsp;&nbsp; &nbsp;<input type="button" value="导出信息" class="btn" onclick="export_info('<%=id %>','export_BdjcInfo')">
	        </td>
	    </tr>
	<%}else if(!"".equals(user_area_id) && !user_area_id.equals("36") && !"".equals(flag) && !flag.equals("1")){ %>
	    <tr >
	       <td colspan="6" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="修改" class="btn">
	           <input type="button" value="关闭" class="btn" onclick="window.close();">&nbsp;&nbsp;&nbsp; &nbsp;<input type="button" value="导出信息" class="btn" onclick="export_info('<%=id %>','export_BdjcInfo')">
	        </td>
	    </tr>
    <%} %>
    
     <tr>
	      <td style='height:100%' colspan="6">
	         <iframe name='frm_zw_list' id='frm_zw_list' width=100% height=100% frameborder=0 allowtransparency="true"></iframe>
	       <br></td>
     </tr>
   
    
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

function export_info(id,method){
   window.open("export_page.jsp?id="+id+"&method="+method,"frm_zw_list");
   
}

</script>



