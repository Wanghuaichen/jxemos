<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
 Map model = null;
 String table = "t_cfg_station_info";

  String cols = "station_id,station_desc,station_no,station_addr,trade_id,area_id,valley_id,pfqx,";
  cols=cols+"ywdw,ywdw_man,ywdw_man_phone,jsdw,ctl_type,";
  cols=cols+"ssgl_man,ssgl_man_phone,scqk,show_flag,station_bz";
 try{
 
 model = f.model(request);
 
 Check.station_wry_update(model,request);
 
 f.save(table,cols,1,model);
  
 
 
 }catch(Exception e){
      JspUtil.go2error(request,response,e);
      return;
      }
 

%>
<br><br><br><br><br><br>
   <b>信息已保存</b>



