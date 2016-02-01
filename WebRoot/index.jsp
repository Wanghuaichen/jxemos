<%@ page contentType="text/html;charset=GBK"%>
<%@page import="com.hoson.f,java.util.*"%>
<%@page import="com.hoson.zdxupdate.zdxUpdate"%>
<%@page import="com.hoson.JspUtil"%>
<%
	//String session_id = (String)request.getParameter("session_id");//统一认证时用到
	//if(session_id.equals("wwlogin")){
	//response.sendRedirect("pages/home/wwlogin.jsp");
	//}else if(f.empty(session_id)||session_id.length()<10||request.getParameter("account")==null){
	//response.sendRedirect("pages/home/login/nologin.jsp");
	//return;
	//}else{
	//response.sendRedirect("pages/home/login_action.jsp?user_name="+request.getParameter("account")+"&session_id="+session_id);//统一认证时用到
	//}
%>



<%--
<%
	boolean admin = true;//是否管理员登录
	if (admin == true) {
		session.setAttribute("user_name", "admin");
		session.setAttribute("user_id", "1");
	} else {
		session.setAttribute("user_name", "123");
		session.setAttribute("user_id", "2");
	}
%>
--%>
<%
	if (session.getAttribute("user_name") == null) {
%>
<script type='text/javascript'>
	window.top.location.href = "pages/login/login.jsp";
</script>
<%
	//response.sendRedirect("/" + JspUtil.getCtx(request) + "/pages/home/login/login.jsp");
	} else {
%>
<script type='text/javascript'>
	window.top.location.href = "pages/home/index.jsp";
</script>
<%
	//response.sendRedirect("/" + JspUtil.getCtx(request) + "/pages/home/index.jsp");
	}
%>


<%--
<%
	String session_id = "login_success_xcgs_hb";//方便现在开发试用
	String accout = "abc";
	if (session_id.equals("wwlogin")) {
		response.sendRedirect("pages/home/wwlogin.jsp");
	} else if (f.empty(session_id) || session_id.length() < 10
			|| accout == null) {
		response.sendRedirect("pages/home/login/nologin.jsp");
		return;
	} else {
		response.sendRedirect("pages/home/login_action.jsp?user_name="
				+ accout + "&session_id=" + session_id);//方便现在开发试用
	}
%>
--%>

<%--
<%
	String session_id = zdxUpdate.getSessionID("abc","1234");
	String user_name = "abc";
	if(session_id.equals("wwlogin")){
		response.sendRedirect("pages/home/wwlogin.jsp");
	}else if(f.empty(session_id)||session_id.length()<10){
   	   response.sendRedirect("pages/home/login/nologin.jsp");
   	    return;
   }else{
  		response.sendRedirect("pages/home/login_action.jsp?user_name="+user_name+"&session_id="+session_id);//统一认证时用到
   }
%>
--%>
