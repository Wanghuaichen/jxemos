<%@page import="java.sql.*,com.hoson.*,com.hoson.app.*,com.hoson.action.*,com.hoson.mvc.*,com.hoson.util.*,java.util.*"%>
<%
String ctx = JspUtil.getCtx(request);

JspWrapper w = new JspWrapper(request);
  //w.set(request,reponse);


%>


<link href="/<%=ctx%>/styles/css1.css" rel="stylesheet" type="text/css">
<SCRIPT language=JavaScript src="/<%=ctx%>/scripts/ajf_common.js"></SCRIPT>
<SCRIPT language=JavaScript src="/<%=ctx%>/scripts/newdate.js"></SCRIPT>
<SCRIPT language=JavaScript src="/<%=ctx%>/scripts/table_sort.js"></SCRIPT>

<%

    String code = request.getParameter("code");
    int md5 = JspUtil.getInt(request,"md5",0);
    String code0 = null;
    if(code==null){code="";}
    
    code0=SupportUtil.getCode();
    if(md5>0){code0=StringUtil.md5(code0);}
    if(!code0.equals(code)){
       out.println("error code,"+StringUtil.getNowTime());
       return;
    }
    
    
%>