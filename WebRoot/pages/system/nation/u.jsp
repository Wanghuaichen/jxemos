<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

   Connection cn = null;
   String sql = null;
   String msg = null;
   String station_id = null;
   String key,v = null;
   
   
   try{
   
   station_id = request.getParameter("station_id");
   key = "x"+station_id;
   v = request.getParameter(key);
   
   cn = DBUtil.getConn();
   sql = "update t_cfg_station set station_id_nation=? where station_id=?";
   DBUtil.update(cn,sql,new Object[]{v,station_id});
   
   msg = "数据已保存";
   
   
   
   }catch(Exception e){
   //JspUtil.go2error(request,response,e);
   //return;
   msg = "保存时发生错误,"+e;
   }finally{DBUtil.close(cn);}

%>

<form name=form1>
<textarea name=msg><%=msg%></textarea>
</form>
<script>
alert(form1.msg.value);
</script>




