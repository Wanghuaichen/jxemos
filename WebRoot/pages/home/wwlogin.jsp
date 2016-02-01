<%@ page contentType="text/html;charset=GBK" %>
<%@page import="com.hoson.app.*"%>
<%@page import="com.hoson.*"%>
<%@page import="java.util.*"%>
<%
     Map cookieMap = null;
     String user_name = null;
     String user_pwd = null;
     String msg = null;
      try{ 
      msg = (String)request.getAttribute("msg");
      if(msg==null){msg = "";}
      cookieMap = JspUtil.getCookieMap(request);
      user_name = (String)request.getAttribute("user_name");
      if(StringUtil.isempty(user_name)){
      user_name=(String)cookieMap.get("user_name");
      }
      user_pwd=(String)cookieMap.get("user_pwd");
      if(user_name==null){user_name="";}
       if(user_pwd==null){user_pwd="";}
       }catch(Exception e){
       JspUtil.go2error(request,response,e);
       return;
       }
      
      
%>
<HTML><HEAD><TITLE>污染源自动监控系统</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<STYLE type=text/css>

BODY {
	FONT-SIZE: 12px; MARGIN: 0px; COLOR: #3772ae; LINE-HEIGHT: 24px; BACKGROUND-COLOR: #d8e6f7;
	
}
.blue12 {
	FONT-SIZE: 12px; COLOR: #3772ae; LINE-HEIGHT: 18px
}
</STYLE>


<BODY scroll=no>
<FORM name=form1 action='wwlogin_action.jsp' method=post>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD background=login.files/login_bg01.gif height=28>&nbsp; </TD></TR>
  <TR>
    <TD>
      <TABLE style="MARGIN-TOP: 70px" cellSpacing=0 cellPadding=0 width=685 
      align=center border=0>
        <TBODY>
        <TR>
          <TD><IMG height=193 src="./img/login_03_ww.jpg" width=685></TD></TR>
        <TR>
          <TD>
            <TABLE cellSpacing=0 cellPadding=0 width="100%" align=left 
              border=0><TBODY>
              <TR>
                <TD width=302><IMG height=142 src="login.files/login_05.jpg" 
                  width=302></TD>
                <TD style="PADDING-TOP: 30px" align=middle 
                background=login.files/login_06.gif>
                  <TABLE cellSpacing=0 cellPadding=0 width="90%" border=0>
                    <TBODY>
                    <TR>
                      <TD class=blue12 width="34%" height=28>用户名： </TD>
                      <TD width="66%"><INPUT class=blue12 size=14 
                        name=user_name> </TD></TR>
                    <TR>
                      <TD class=blue12 height=28>密&nbsp; 码： </TD>
                      <TD><INPUT class=blue12 type=password size=14 
                        name=user_pwd> </TD></TR>
                    <TR>
                    <td></td>
                      <TD><div style='padding:5px;padding-left:0px;color:red;font-size:12px'>
                    <%=msg%>
                    </div>
                    
                    </TD></TR></TBODY></TABLE></TD>
                <TD style="PADDING-TOP: 25px" width=150 
                background=login.files/login_06.gif><INPUT hideFocus 
                  onclick="form1.submit()" type=image 
                  src="login.files/login_09.gif" name=""> </TD>
                <TD align=right width=44><IMG height=142 
                  src="login.files/login_08.gif" 
        width=44></TD></TR></TBODY></TABLE></TD></TR>
        <TR>
          <TD><IMG height=126 alt="" src="login.files/login_12.jpg" width=685> 
          </TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></FORM><!-- <map name="Map"><area shape="rect" coords="40,83,150,95" href="#"></map> --></BODY></HTML>
