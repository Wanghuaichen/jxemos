<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>

<%

 String parentValleyOption = null;
 String levelOption = null;
 String sql = null;
 String ts = "3,4,5,6";
 //String vs = null;
 String valley_level = null;
 String parent_id = null;
 Properties prop = null;
 String[]arr = null;
 String pageBar = null;
 String data = null;
 String is_main = null;
 String is_main_option = null;
 String valley_name = null;
 Map map = null;
 try{
 prop = JspUtil.getReqProp(request);
 valley_level = prop.getProperty("valley_level","3");
 parent_id = prop.getProperty("parent_id","0");
 valley_name = JspUtil.getParameter(request,"valley_name","");
 is_main = prop.getProperty("is_main","1");
 is_main="";
 is_main_option = JspUtil.getOption("0,1","��,��",is_main);
 
 sql = "select valley_id,valley_name from t_cfg_valley ";
 sql=sql+"where parent_id='0'";
 
 parentValleyOption = JspUtil.getOption(sql,parent_id,request);
 
 levelOption = JspUtil.getOption(ts,ts,valley_level);
 
 sql="select valley_id,valley_name,valley_note ";
 sql=sql+"from t_cfg_valley where 2>1 ";
 if(!StringUtil.isempty(valley_level)){
 sql=sql+"and valley_level='"+valley_level+"' ";
 }
 if(!StringUtil.isempty(parent_id)){
 sql=sql+"and parent_id like '"+parent_id+"%' ";
 }
  if(!StringUtil.isempty(valley_name)){
 sql=sql+"and valley_name like '%"+valley_name+"%' ";
 }
 
 /*
 if(StringUtil.equals(is_main,"1")){
 sql=sql+"and is_main='1' ";
 }
 
 if(StringUtil.equals(is_main,"0")){
 sql=sql+"and (is_main<>'1' or is_main is null) ";
 }
 */
 sql=sql+" order by valley_id asc";
 
 //out.println(sql);
 
 /*
 arr=PagedUtil.query(sql,1,";",1,request);
 data=arr[0];
 pageBar=arr[1];
 
 */
 map =PagedUtil2.queryStringWithUrl(sql, 1,0,request);
data=(String)map.get("data");
pageBar=(String)map.get("page_bar");
 
 }catch(Exception e){
 //out.println(e);
    JspUtil.go2error(request,response,e+","+sql);
 return;
 }



%>

<html>
<head>
<link rel="stylesheet" href="../../../web/index.css"/>
</head>
<body>

<form name=form1 method=post action="valley_query.jsp">

<div class='query_form'>
�ϼ����� 
<select name="parent_id" class="selectoption" >
<option value="">ȫ��</option>
<%=parentValleyOption%>
</select>

������
<select name="valley_level" class="selectoption" >
<option value="">ȫ��</option>
<%=levelOption%>
</select>

����

<input type=text name="valley_name" value="<%=valley_name%>" class="selectoption" >
<input type="submit" value="��ѯ" class="tiaojianbutton">
</div>



<table class="">


<tr class="title">

<td>������</td>
<td>��������</td>
<td>˵��</td>
</tr>
<
<%=data%>

</table>

<div class='page_bar'><%=pageBar%></div>

</form>
</body>
</html>