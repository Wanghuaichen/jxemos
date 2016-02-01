<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>

<%
	String sql =null;
	String[]arr=null;
	String data = null;
	String pageBar = null;
    //String area_name = JspUtil.getParameter(request,"p_area_name");
    String area_name =JspUtil.getParameter(request,"p_area_name");
    Map map = null;
    
    if(area_name==null){area_name="";}
	sql = "select ";
	sql=sql+"a.area_id,a.area_name,a.area_pid,b.area_name ";
	sql=sql+"from t_cfg_area a,t_cfg_area b ";
	sql=sql+"where a.area_pid=b.area_id ";

    if(!StringUtil.isempty(area_name)){
    sql=sql+"and a.area_name like '%"+area_name+"%' ";
    }
	sql = sql +"order by a.area_id";
	try{
	/*
	arr=PagedUtil.query(sql,request,1);
	data=arr[0];
	pageBar=arr[1];
	*/
	map =PagedUtil2.queryStringWithUrl(sql, 1,0,request);
    data=(String)map.get("data");
    pageBar=(String)map.get("page_bar");;
	}catch(Exception e){
		//out.println(e);
		JspUtil.go2error(request,response,e+","+sql);
		return;
	}


%>
<html>
<head>
<link rel="stylesheet" href="../../../web/index.css"/>
<style type="text/css">
td{border-width: 0;
    line-height: 1.666;
    padding:8px;
    border-bottom:1px solid #eee;
    font-weight: bold;}
</style>
</head>
<body>
<form name=form1 method=post action="area_query.jsp">


<div style="margin: 10px 10px 10px 10px;">
地区名称:
<input type="text" name="p_area_name" value="<%=area_name%>"   class="selectoption">
<input type="submit" value="查询" class="tiaojianbutton">
</div>

<table class="nui-table-inner">
<thead class="nui-table-head" >
<tr class="title">

<th class="nui-table-cell">地区编号</th>
<th class="nui-table-cell">地区名称</th>
<th class="nui-table-cell">所属地区编号</th>
<th class="nui-table-cell">所属地区名称</th>
</tr>

</thead>

<%=data%>
<tr class="nui-table-row">
<th class="nui-table-cell" colspan="4"><%=pageBar%></th>
</tr>
</table>
</form>
</body>
</html>