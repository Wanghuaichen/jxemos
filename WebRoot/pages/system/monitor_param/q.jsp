<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      String station_type=request.getParameter("station_type");
      String area_id = request.getParameter("area_id");
      String station_name = null;
      Connection cn = null;
      String sql = null;
      List stationList = null;
      List list = null;
      Map map = null;
      Map m = null;
      int i,num=0;
      
      
      
      try{
      station_name = JspUtil.getParameter(request,"station_name");
      cn = DBUtil.getConn();
      
      sql = "select station_id,station_desc from t_cfg_station_info ";
      sql = sql +" where  station_type='"+station_type+"' ";
      sql = sql +" and area_id like '"+area_id+"%'";
      if(!StringUtil.isempty(station_name)){
      sql = sql +" and station_desc like '%"+station_name+"%' ";
      }
      
      stationList = DBUtil.query(cn,sql,null);
   
      
      
      }catch(Exception e){
      JspUtil.go2error(request,response,e);
      return;
      }finally{DBUtil.close(cn);}
      
      
      
            
%>

