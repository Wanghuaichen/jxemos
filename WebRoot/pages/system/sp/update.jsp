<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      //String now = StringUtil.getNowDate()+"";
      List list = null;
      RowSet rs = null;
      Map sbMap = null;
      String station_id = JspUtil.getParameter(request,"station_id");
      String station_name = null;
      String sb_id = JspUtil.getParameter(request,"sb_id");;
      String sql = null;
      String station_type= JspUtil.getParameter(request,"station_type");
      String area_id = JspUtil.getParameter(request,"area_id");
      String station_ip = JspUtil.getParameter(request,"station_ip");
      String sp_type  = JspUtil.getParameter(request,"sp_type");
      
      String sp_port = JspUtil.getParameter(request,"sp_port");
      String sp_user = JspUtil.getParameter(request,"sp_user");
      String sp_pwd = JspUtil.getParameter(request,"sp_pwd");
      String station_desc = null;
      
      String sp_channel = JspUtil.getParameter(request,"sp_channel");
      
       String p_station_name = JspUtil.getParameter(request,"station_name");
   		 station_desc = JspUtil.getParameter(request,"station_desc");
      Connection cn = null;
     Map map = null;
     
     String bar = null;
     int num =0;
     
     
      try{
     // station_desc = JspUtil.getParameter(request,"station_desc");
     
      if(StringUtil.isempty(station_id)){throw new Exception("站位编号不能为空");}
      
      if(StringUtil.isempty(station_desc)){throw new Exception("站位名称不能为空");}
      
      //JspAction.hour_today_form(request);
      cn = DBUtil.getConn();
      Object[]p=new Object[]{station_desc,station_ip,sb_id,sp_type,sp_port,sp_user,sp_pwd,sp_channel,station_id};
      sql = "update t_cfg_station_info set station_desc=?,station_ip=?,sb_id=?,sp_type=?,sp_port=?,sp_user=?,sp_pwd=?,sp_channel=? where station_id=?";
     DBUtil.update(cn,sql,p);
      



      
      }catch(Exception e){
      JspUtil.go2error(request,response,e);
      return;
      }finally{DBUtil.close(cn);}
     
      
      
%>
<body onload=form1.submit()>
<form name=form1 method=post action=q.jsp>



<%-- <%
System.out.println(station_desc);
System.out.print(request.getParameter("station_desc"));

 %> --%>
<%=JspUtil.getHiddenHtml("station_id,station_type,station_name,area_id,page,page_size",request)%>
</form>






