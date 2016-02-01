<%@page import="java.sql.*,com.hoson.zdxupdate.*,com.hoson.*,com.hoson.app.*,com.hoson.action.*,com.hoson.mvc.*,com.hoson.util.*,java.util.*,java.text.*"%>
<%!
    static String gross_css(RowSet rs,String col,String std_col,int r)throws Exception{
     String s1,s2 = null;
	
		s1=rs.get(col);
		s2=rs.get(std_col);
		
		if(f.empty(s1)){return "gross_ok";}
		if(f.empty(s2)){return "gross_ok";}
		
		double v1,v2 = 0;
		
		v1 = f.getDouble(s1,0);
		v2 = f.getDouble(s2,0);
		v1 = v1/r;
		if(v2>0 && v1>v2){return "gross_alert";}
		
		return "gross_ok";
		
    } 
%>
<%
String ctx = JspUtil.getCtx(request);

  if(f.empty((String)session.getAttribute("user_name"))){
   response.sendRedirect("/"+ctx+"/pages/home/login/nologin.jsp");
   return;
  }
int acl_flag =0;
String acl_alert_flag = "0";
String acl_url = "/pages/commons/no_acl.jsp";
String acl_url2 = "/pages/commons/no_acl_alert.jsp";


//JspWrapper w = new JspWrapper(request);
  //w.set(request,response);
  JspWrapperNew w = new JspWrapperNew();
  w.set(request,response);

try{
acl_flag = SysAclUtil.check(request,session);
acl_alert_flag = SysAclUtil.getAclAlertFlag(request);

//f.sop(acl_flag+","+SysAclUtil.getResName(request));

  if(acl_flag==1){
  w.rd("/pages/commons/nologin.jsp");
  return;
  }

  //if(acl_flag==2 ){
  // if(f.eq(acl_alert_flag,"1")){acl_url=acl_url2;}
 // w.fd(acl_url);
  //return;
 // }

 


}catch(Exception e){
 w.error(e);
 return;
}

%>


<SCRIPT language=JavaScript src="/<%=ctx%>/scripts/ajf_common.js"></SCRIPT>
<SCRIPT language=JavaScript src="/<%=ctx%>/scripts/newdate.js"></SCRIPT>
