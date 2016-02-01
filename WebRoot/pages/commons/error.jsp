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

<link rel="stylesheet" href="../../web/index.css"/>

</head>

<body>

 <div class="tishi">
   	 <p>
	 	<strong><%=msg%> </strong>
	     	 </p>
   
   </div>
<div id=msg style="display:none">
<%=msg_old%>
</div>
</body>
</html>
