<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp" %>
<%
String[]arr=null;
String pageBar = null;
String data = null;
String sql = "";
String p_parameter_type_id = null;
String param_type_option = null;
Map map = null;

p_parameter_type_id = request.getParameter("p_parameter_type_id");
if(p_parameter_type_id==null){p_parameter_type_id="";}

//sql = "select parameter_type_id as pk1,";

//sql=sql+"parameter_value as pk2,";
sql=sql+"select parameter_name,";
sql=sql+"parameter_value,";
sql=sql+"parameter_type_name,";
sql=sql+"parameter_desc ";
sql=sql+"from t_cfg_parameter ";

if(!StringUtil.isempty(p_parameter_type_id)){
sql=sql+"where parameter_type_id = '"+p_parameter_type_id+"' ";
}

sql=sql+" order by parameter_type_name ";


try{
//arr=AppPagedUtil.queryUsingGetString(sql,2,";",request,1);
//arr=AppPagedUtil.queryUsingGetString(sql,2,";",request,0);
map=PagedUtil2.queryStringWithUrl(sql,1,0,request);
data=(String)map.get("data");
pageBar=(String)map.get("page_bar");
sql="select distinct parameter_type_id,";
sql=sql+"parameter_type_name  ";
sql=sql+"from t_cfg_parameter";
 param_type_option = JspUtil.getOption(sql,p_parameter_type_id,request);


}catch(Exception e){
	//out.println(e);
	   JspUtil.go2error(request,response,e);
	return;
	}


%>
<html>
<head>


</head>

<body>
<form name=form1 method=post action="param_query.jsp" class="selectoption">

<input type="hidden" name="param_type"  value="<%=p_parameter_type_id%>">



<div class='query_form'>
参数类型
<!--
<input type="text" name="p_parameter_type_id" value="<%=p_parameter_type_id%>">
-->
<select name="p_parameter_type_id" class="selectoption" onchange=form1.submit()>
<option value="">全部</option>
<%= param_type_option%>
</select>
</div>



<table  class="nui-table-inner">


<thead class="nui-table-head" >
<tr class="title">
<!--
<td></td>
-->
<th class="nui-table-cell">参数名称</th>
<th class="nui-table-cell">参数值</th>
<th class="nui-table-cell">参数类型<br><img width=120 height=0></th>
<th class="nui-table-cell">参数说明</th>
<td>参数名称</td>
<td>参数值</td>
<td></td>
<td>参数说明</td>
</tr>
</thead>
<%=data%>
</table>
<div class='page_bar'><%=pageBar%></div>
</form>


</body>
<script>
function f_new_param(){
var i = form1.p_parameter_type_id.selectedIndex;
	   if(i<0){
	   alert("请选择参数类型");
	   return;
	   }
	   var param_type = form1.p_parameter_type_id.options[i].value;
	   if(param_type.length<1){
	   alert("请选择参数类型");
	   return;
	   }else{
	   form1.action="param_input.jsp";
	   form1.submit();
	   }
}
</script>
</html>