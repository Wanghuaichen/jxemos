<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.util.Scape"%>

<%@page import="com.hoson.f,java.util.*,com.hoson.zdxupdate.*,com.hoson.XBean"%>
<%

    Map data;

    String id = "";
    String user_area_id = (String)request.getSession().getAttribute("area_id");
  String flag = request.getParameter("flag");
    try{
      id = request.getParameter("id");
      SwjUpdate.queryKhjlInfoByID(request);
    }catch(Exception e){
       w.error(e);
       return;
    }
    
    data = (Map)w.a("data");


	//String drop_css = "";
	String checked = "";


  	Map map = null;

%>

<form action="khjl_updateaction.jsp" method="post">
<br>
<br>
<table border=0 cellspacing=1  style="width: 800px">
   <caption style="font-size: 16px">责任环保部门监督考核结论(修改页面)</caption>
    <tr>
        <td colspan="4" style="text-align: right">
              环验[<input type="text" name="jd_zhi" value="<%=data.get("jd_zhi") %>">]<input type="text" name="jd_hao" value="<%=data.get("jd_hao") %>">号
           <input type="hidden" name="qy_id" value="<%=data.get("qy_id") %>">
           <input type="hidden" name="qy_mc" value="<%=data.get("qy_mc") %>">
           <input type="hidden" name="id" value="<%=data.get("id") %>">
           <input type="hidden" name="flag" value="<%=flag %>">
        </td>
    </tr>
    
    <tr>
        <td style="text-align: center">结论</td>
        <td >
            <select name="jd_jg">
                   <%=f.getOption("1,0","合格,不合格",(String)data.get("jd_jg")) %>
            </select>
        </td>
        <td style="text-align: center">日期</td>
        <td ><input type="text" name="jd_rq" value="<%=data.get("jd_rq") %>" readonly="readonly"  onclick="new Calendar().show(this);"></td>
    </tr>
    <tr>
        <td style="text-align: center">经办人</td>
        <td >
            <input type="text" name="jbr" value="<%=data.get("jbr") %>"> 
        </td>
        <td style="text-align: center">审核人</td>
        <td ><input type="text" name="spr" value="<%=data.get("spr") %>"></td>
    </tr>
    
    <tr>
        <td>备注 </td>
        <td colspan="3">
             <textarea rows="20" cols="100%" name="jd_jl" ><%=data.get("jd_jl") %></textarea>
        </td>
    </tr>
     <% if(!"".equals(user_area_id) && user_area_id.equals("36") && !"".equals(flag) && flag.equals("1")){ %>
	    <tr >
	       <td colspan="4" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="修改" class="btn">
	           <input type="button" value="关闭" class="btn" onclick="window.close();">&nbsp;&nbsp;&nbsp; &nbsp;<input type="button" value="导出信息" class="btn" onclick="export_info('<%=id %>','export_KhjlInfo')">
	        </td>
	    </tr>
	<%}else if(!"".equals(user_area_id) && !user_area_id.equals("36") && !"".equals(flag) && !flag.equals("1")){ %>
	    <tr >
	       <td colspan="4" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="修改" class="btn">
	           <input type="button" value="关闭" class="btn" onclick="window.close();">&nbsp;&nbsp;&nbsp; &nbsp;<input type="button" value="导出信息" class="btn" onclick="export_info('<%=id %>','export_KhjlInfo')">
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

function check_form(form){
   
   var jd_zhi = form.jd_zhi.value;
   var jd_hao = form.jd_hao.value;
   var jd_rq = form.jd_rq.value;
   var jd_jl = form.jd_jl.value;
   var jbr = form.jbr.value;
   var spr = form.spr.value;
   //alert("=="+jd_jl+"==");
   if(jd_zhi == "" || jd_hao == "" || jd_rq == "" || jd_jl == ""){
      alert("请把信息填写完整!");
      return false;
   }
   
   if(jd_jl.length>399){
      alert("备注信息长度不能大于400");
      return false;
   }
   
   form.submit();

}

function export_info(id,method){
   window.open("export_page.jsp?id="+id+"&method="+method,"frm_zw_list");
   
}

</script>



