<%@ page contentType="text/html;charset=GBK"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="com.hoson.*"%>
<%@page import="com.hoson.app.*"%>
<%
int action_flag = JspUtil.getInt(request,"action_flag",0);
if(action_flag<0 || action_flag>4){action_flag=0;}
%>



<frameset name="fx_main" id="fx_main" cols="200,*" framespacing="0" frameborder="no" border="0" scrolling="no">
<!--
<frame src="../compare/compare_left.jsp" name="fx_left" id="fx_left" scrolling="auto" />
-->
<frame src="../compare/left2.jsp" name="fx_left" id="fx_left" scrolling="auto" />


<frame src="./sjfx.jsp?action_flag=<%=action_flag%>" name="fx_right" id="fx_right" scrolling="auto" />

</frameset>
