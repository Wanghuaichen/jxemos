<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
        String jsgs_id = null;
        Map m = null;
        String sql = null;
        XBean b = null;
        try{
          jsgs_id = w.p("jsgs_id");
          if(f.empty(jsgs_id)){f.error("计算公式编号为空");}
          sql = "select * from t_cfg_jsgs where jsgs_id="+jsgs_id;
          m = f.queryOne(sql,null);
          if(m==null){f.error("记录不存在");}
          
          b =new XBean(m);
          
          
          
          }catch(Exception e){
           w.error(e);
           return;
          }
          
%>

<body scroll=no>

<form name=form1 methos=post action='update.jsp'>

<div class='input_error_msg'><%=w.msg()%></div>
<table border=0  cellspacing=1>

 <tr>
  <td width=100 class='tdtitle'>公式编号</td>
  <td><input type=text name='jsgs_id' readonly value='<%=b.get("jsgs_id")%>' style='width:250px' ></td>
 </tr>

 <tr>
  <td width=100 class='tdtitle'>公式名称</td>
  <td><input type=text name='jsgs_name' value='<%=b.get("jsgs_name")%>' style='width:250px'></td>
 </tr>
 <tr>
  <td class='tdtitle'>公式描述</td>
  <td><textarea name='jsgs_desc'  cols=80 rows=9><%=b.get("jsgs_desc")%></textarea></td>
 </tr>
 
 <tr>
  <td class='tdtitle'></td>
  <td>
    <input type=button value='保存' onclick='f_update()' class=btn>
    <input type=button value='删除' onclick='f_del()' class=btn>
    <a href='index.jsp'>返回</a>
  </td>
 </tr>
 
</table>
</form>
<script>
 function f_update(){
  //alert('add');
  form1.action='update.jsp';
  form1.submit();
 }
 function f_del(){
  //alert('add');
  if(confirm("确认要删除吗")){
	 form1.action='del.jsp';
  form1.submit();
	 }else{}
 
 }
 
</script>