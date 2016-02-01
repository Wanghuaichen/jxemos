<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      //String now = StringUtil.getNowDate()+"";
      List list = null;
      RowSet rs = null;
      Map sbMap = null;
      String station_id = null;
      String station_name = null;
      String sb_id = null;
      String sql = null;
      String station_type= request.getParameter("station_type");
      String area_id = request.getParameter("area_id");
      String sp_type = request.getParameter("sp_type");
       String p_station_name = JspUtil.getParameter(request,"station_name");
      Connection cn = null;
     Map map = null;
     String bar = null;
  
      try{
    
      //JspAction.hour_today_form(request);
      cn = DBUtil.getConn();
      sql = "select station_id,station_desc,station_ip,sp_type,sb_id,sp_channel from t_cfg_station_info where 2>1 ";
      if(!StringUtil.isempty(station_type)){
      sql = sql +" and station_type='"+station_type+"' ";
      }
       if(!StringUtil.isempty(area_id)){
      sql = sql +" and area_id like '"+area_id+"%' ";
      }
      
       if(!StringUtil.isempty(sp_type)){
      sql = sql +" and sp_type='"+sp_type+"' ";
      }
      
       if(!StringUtil.isempty(p_station_name)){
      sql = sql +" and station_desc like '%"+p_station_name+"%' ";
      }
      //System.out.println(sql);
      list = DBUtil.query(cn,sql,null);
      map = PagedQuery.query(cn,sql,null,request);
      sql = "select station_id,sb_id from t_sp_sb_station";
      //sbMap = DBUtil.getMap(cn,sql);
      
      }catch(Exception e){
      JspUtil.go2error(request,response,e);
      return;
      }finally{DBUtil.close(cn);}
      list = (List)map.get("data");
      bar = (String)map.get("bar");
      rs = new RowSet(list);
      
      
%>
<style>
td{
text-align:left;
}
</style>
<form name=form1 method=post>
<input type=hidden name=station_type value="<%=station_type%>">
<input type=hidden name=area_id value="<%=area_id%>">
<input type=hidden name=station_name value="<%=p_station_name%>">
<input type=hidden name=station_id >


<div class='page_bar'><%=bar%></div>

<table border=0 cellspacing=1>

<tr class=title>
<td style="width:120px">站位编号</td>
<td  style="width:120px">站位名称</td>
<td>
视频IP
<div><img width=100px height=0></div>
</td>
<td>通道号</td>
<td>设备编号</td>



</tr>

<%
	while(rs.next()){
	station_id = rs.get("station_id");
	//sb_id = (String)sbMap.get(station_id);
	//if(sb_id==null){sb_id="";}
	
	%>
<tr>
<td>
<a href=javascript:view('<%=station_id%>')><%=station_id%></a>
</td>
<td><%=rs.get("station_desc")%></td>
<td><%=rs.get("station_ip")%></td>
<td><%=rs.get("sp_channel")%></td>

<td class=left><%=rs.get("sb_id")%></td>

<%}%>


</table>
</form>
<script>
function view(id){
 form1.station_id.value=id;
 form1.action = "view.jsp";
 form1.submit();
}
</script>











