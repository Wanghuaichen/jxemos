<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/file/inc.jsp" %>
<%
        String file = JspUtil.getParameter(request,"file");
      
        try{
        code=StringUtil.md5(code);
        
        
        }catch(Exception e){
        out.println(e);
        return;
        }
        
        
%>

<form action="up.jsp" method="post" enctype="multipart/form-data" name="form1">
<input type=hidden name=md5 value="1">
<input type=hidden name=code value="<%=code%>">
  <input name="file_name" type="file" style="width:700px">
 <br>
  <input type="submit"  value="up">
</form>
