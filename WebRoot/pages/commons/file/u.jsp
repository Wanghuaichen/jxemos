<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/file/inc.jsp" %>
<%
        String file = JspUtil.getParameter(request,"file");
        String s = null;
        
        try{
        s =JspUtil.getParameter(request,"content");
        FileUtil.write(file,s,0);
        
        }catch(Exception e){
        out.println(e);
        return;
        }finally{
        out.println(StringUtil.getNowTime());
        }
%>