<%@ page contentType="text/html;charset=GBK" %>
<%@page import="com.hoson.*"%>
<%
    String s = null;
    s = StringUtil.getNowTime()+","+JspUtil.getAppPath(request);
    out.println(s);
        
        
%>
<style>
body{text-align:left;}
</style>

<form name=form1 method=post target=q>
<input type=hidden name=sql>
<input type=password name=code style="width:250px">
<input type=text name=split value=";">
<input type=text name=num value="50">
<br>
<!--
<input type=text name=file style="width:500px"><br>
-->
<textarea name=file cols=80 rows=8></textarea>
<!--
<input type="file" name="upfile"  style="width:500px">
-->

<input type=button value=l onclick=f_l()>
<input type=button value=v onclick=f_v()>
<input type=button value=md onclick=f_md()>
<input type=button value=mf onclick=f_mf()>
<input type=button value=d onclick=f_d()>

<input type=button value=q onclick=f_q()>
<input type=button value=dbu onclick=f_dbu()>
<input type=button value=up onclick=f_up()>
</form>
<iframe name="q" id="q" width=100% height=60%  scrolling="auto" frameborder="0"  style="border:0px" allowtransparency="true">
</iframe>

<script>
function f_l(){
form1.action="l.jsp";
form1.submit();
}

function f_v(){
form1.action="v.jsp";
form1.submit();
}


function f_up(){
form1.action="upf.jsp";
form1.submit();
}
function f_md(){
form1.action="md.jsp";
form1.submit();
}


function f_mf(){
form1.action="mf.jsp";
form1.submit();
}


function f_d(){
if(!confirm("del?")){return;}
form1.action="d.jsp";
form1.submit();
}


function f_q(){
form1.sql.value=form1.file.value;
form1.action="q.jsp";
form1.submit();
}


function f_dbu(){
if(!confirm("dbu?")){return;}
form1.sql.value=form1.file.value;
form1.action="dbu.jsp";
form1.submit();
}

</script>