<%@ page contentType="text/html;charset=GBK" %>
<%@page import="com.hoson.*"%>



<%!
   public static String getErrorMsg(String msg){
   
   if(msg==null){return "";}
   
   String s = null;
   s = msg.toLowerCase();
   if(s.indexOf("java.lang.outofmemory")>0){
   msg = "web服务器可用内存不足,请重新启动,建议调整JVM最大可用内存";
   return msg;
   }
  
   msg = msg.replaceAll("java.lang.Exception:"," ");   
   msg = msg.replaceAll("java.lang.IllegalArgumentException","输入参数格式不正确");
   msg = msg.replaceAll("java.sql.SQLException:","");
   msg = msg.replaceAll("javax.servlet.ServletException:","");
   
    //msg = msg.replaceAll(":","");
   
   return msg;
   
   }

%>

<%
String msg_old = null;
String msg = null;
String ctx = JspUtil.getCtx(request);
String no_log_msg = "未登录";
msg = JspUtil.getErrorMsg(request);

if(msg.indexOf(no_log_msg)>=0){
    //response.sendRedirect("./nologin.jsp");
   // System.out.println("no log");
      //JspUtil.rd(request,reponse,"/pages/commons/nologin.jsp");
    response.sendRedirect("/"+ctx+"/pages/commons/nologin.jsp");
   
     return;
}


msg_old = msg+"";
//msg_old = msg_old.replaceAll("<br>","");
//msg_old = StringUtil.encodeHtml(msg_old);
if(msg==null){msg="";}
msg = getErrorMsg(msg);


%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<style>
td{font-size:12px}
.big{font-size:16px}

.title{background-color:pink;
/*background-color:#E8A947*/}
.left{
text-align:left;
}
.right{
text-align:right;
}

table{
border-collapse:collapse;
WORD-BREAK: break-all;
} 

td{
font-size:9pt;
 padding-left:5px;
 border:1px;

border-style:   dashed;

border-color:silver;
WORD-BREAK: break-all;
}
body{
/*background-color:#999B98;
background-color:#F7F7F7;*/
padding:0;
margin:0;
}

</style>

</head>

<body>

<br><br><br><br>
<center>

<table style = "WORD-BREAK: break-all;width:80%" align="center" border=0 cellspacing=1>
<tr class=title>
<td class=right>

<a href=# onclick=history.back()>返回</a>
&nbsp;
</td>
</td>
</tr>

<tr>
<td class=left>
<br>




<%=msg%>






</td>
</tr>

</table>
<div id=msg style="display:none">
<%=msg_old%>
</div>
</body>
</html>
