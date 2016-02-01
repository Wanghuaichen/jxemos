<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/file/inc.jsp" %>
<%
    String file = request.getParameter("file");
    
    try{
    java.io.File f= new java.io.File(file);
    if(f.exists()){
    throw new Exception("exist,file="+file);
  
    }
    FileUtil.createDirs(file);
    
    }catch(Exception e){
    out.println(e);
    return;
    }finally{out.println(StringUtil.getNowTime());}

%>