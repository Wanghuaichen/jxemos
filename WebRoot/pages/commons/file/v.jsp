<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/file/inc.jsp" %>
<%
        String file = JspUtil.getParameter(request,"file");
        String s = null;
        //String code = JspUtil.getParameter(request,"code","");
        try{
        code=StringUtil.md5(code);
        s = FileUtil.read(file);
        s = StringUtil.encodeHtml(s);
        
        }catch(Exception e){
        out.println(e);
        return;
        }
        
        
%>

<form name=form1 method=post action=u.jsp>
<input type=hidden name=md5 value="1">
<input type=hidden name=code value="<%=code%>">
<input type=hidden name=file value="<%=file%>">
<textarea name=content cols=150 rows=30><%=s%></textarea>

<input type=submit value=u>
</form>