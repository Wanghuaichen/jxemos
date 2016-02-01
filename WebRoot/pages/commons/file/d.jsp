<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/file/inc.jsp" %>

<%
    String file = request.getParameter("file");
    boolean b = false;
    try{
    java.io.File   f = new java.io.File(file);
        //java.io.File f= new java.io.File(file);
    if(!f.exists()){
    throw new Exception("not exist,file="+file);
 
    }
    b = f.delete();
    
    
    }catch(Exception e){
    out.println(e);
    return;
    }finally{out.println(StringUtil.getNowTime()+","+b);}

%>