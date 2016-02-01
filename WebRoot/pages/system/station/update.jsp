<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
 Map model = null;
 String table = "t_cfg_station_info";
// String cols = "station_id,uni_com_id,late_use_time,data_positon,check_flag,master_key,trans_key,pick_eqpt_state,start_date,charge_man,charge_man_phone,charge_man_mail,pick_eqpt_model,produce_comp,station_desc,msg_send_flag,station_ip,station_type,station_position,trade_id,station_bz,axisx,axisy,pic_url,pic_eqpt,pic_circuit,area_id,link_surface,target_passwd,comm_user,longitude,latitude,comm_mode,comm_passwd,comm_str,comm_port,absoluteno,valley_id,video_flag,valley_order,charge_area,station_seq,link_surface_type,sp_ip";
  String cols = "station_id,uni_com_id,data_positon,check_flag,master_key,trans_key,pick_eqpt_state,charge_man,charge_man_phone,charge_man_mail,pick_eqpt_model,produce_comp,station_desc,msg_send_flag,station_ip,station_type,station_position,trade_id,station_bz,axisx,axisy,pic_url,pic_eqpt,pic_circuit,area_id,link_surface,target_passwd,comm_user,longitude,latitude,comm_mode,comm_passwd,comm_str,comm_port,absoluteno,valley_id,video_flag,valley_order,charge_area,station_seq,link_surface_type,sp_ip,xydbsdm";
 //cols =cols+",val1,val2,val3,val4,val5,val6,val7,val8,val9";
// cols=cols+",gross_q,gross_cod,gross_so2,gross_nox";
 
 try{
 
 model = f.model(request);
 f.save(table,cols,1,model);
  
 
 
 }catch(Exception e){
      JspUtil.go2error(request,response,e);
      return;
      }
 

%>
<body onload=form1.submit()>
<form name=form1 method=post action=q.jsp>
 
<input type=hidden name=p_station_type value='<%=w.p("p_station_type")%>'>
<input type=hidden name=p_area_id value='<%=w.p("p_area_id")%>'>
<input type=hidden name=p_station_name value='<%=w.p("p_station_name")%>'>
<input type=hidden name=page value='<%=w.p("page")%>'>
<input type=hidden name=page_size value='<%=w.p("page_size")%>'>


</form>
</body>