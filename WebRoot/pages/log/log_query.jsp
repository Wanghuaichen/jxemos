<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>

<%
	String sql =null;
	String[]arr=null;
	String data = null;
	String pageBar = null;
    String user_name = JspUtil.getParameter(request,"p_user_name");
    String memo = JspUtil.getParameter(request,"p_memo");
    String ip = JspUtil.getParameter(request,"p_ip");
    String type = JspUtil.getParameter(request,"type");
    if(type ==null)type="";
    String hour1,hour2,date1,date2;
    String t1,t2 = null;
	    hour1 = request.getParameter("hour1");
	    hour2 = request.getParameter("hour2");
	    date1 = (String)request.getParameter("date1");
	    date2 = (String)request.getParameter("date2");
	    if(f.empty(hour1)){hour1 = "0";}
		if(f.empty(hour2)){hour2 = "23";}
		if(f.empty(date1)){date1 = "";}
		if(f.empty(date2)){date2 = "";}
		t1 = date1+" "+hour1+":00:00";
		t2 = date2+" "+hour2+":59:59";
    Map map = null;
    
    if(user_name==null){user_name="";}
    if(memo==null){memo="";}
    if(ip==null){ip="";}
	sql = "select ";
	sql=sql+"id,operation_date,user_name,memo,ip ";
	sql=sql+"from t_sys_sh_log ";

    
    if(date1!=null&&!date1.equals("")&&date2!=null&&!date2.equals("")){
    	sql=sql+"where operation_date>='"+t1+"' and operation_date<='"+t2+"'";
    }else  if(date1!=null&&!date1.equals("")){
    	sql=sql+"where operation_date>='"+t1+"'";
    }else  if(date2!=null&&!date2.equals("")){
    	sql=sql+"where operation_date<='"+t2+"'";
    }else{
    	sql=sql+"where 1=1 ";
    }
    if(!user_name.equals("")){
    sql = sql + " and user_name like '%"+user_name+"%'";
    }
	if(!memo.equals("")){
    sql = sql +" and memo like '%"+memo+"%' ";
    }
	if(!ip.equals("")){
    sql = sql +" and ip like '%"+ip+"%' ";
    }
    
    if(!"".equals(type)){
    sql = sql +" and type ='"+type+"'";
    }
    
	sql = sql +" order by id desc";
	System.out.println("sql=="+sql);
	try{
	map =PagedUtil2.queryStringWithUrl(sql, 1,0,request);
    data=(String)map.get("data");
    pageBar=(String)map.get("page_bar");;
    
    
	}catch(Exception e){
		//out.println(e);
		JspUtil.go2error(request,response,e+","+sql);
		return;
	}


%>

<style>

.input {
   border: #ccc 1px solid;
   font-family: "微软雅黑";
   font-size: 13px;
   width: 150px;
   background:expression((this.readOnly &&this.readOnly==true)?"#f9f9f9":"")
}
</style>

<form name=form1 method=post action="log_query.jsp">


<div class='query_form'>
用户名称：
<input type="text" name="p_user_name" value="<%=user_name%>" class="input">
日志内容：
<input type="text" name="p_memo" value="<%=memo%>"  class="input">
操作者IP：
<input type="text" name="p_ip" value="<%=ip%>"  class="input">
<input type='text' class='input' name='date1' id='date1'	value='<%=date1 %>' onclick="new Calendar().show(this);">
<select name=hour1 id='hour1'>
	<%=f.getHourOption(hour1)%>
</select>

<input type='text' class='input' name='date2' id='date2'	value='<%=date2 %>' onclick="new Calendar().show(this);">
<select name=hour2 id='hour2'>
	<%=f.getHourOption(hour2)%>
</select>

<select name=type id='type'>
	<%=f.getOption(",bulu,wuxiao","--选择--,补录,无效",type) %>
</select>

<input type="submit" value="查询" class="btn">
</div>
<div class='page_bar'><%=pageBar%></div>
<table border=0 cellspacing=1>

<tr class=title>

<td width="5%">日志编号</td>
<td width="14%">操作时间</td>
<td width="10%">用户名称</td>
<td>日志内容</td>
<td width="10%">操作者IP</td>

</tr>
<%=data%>
</table>
</form>