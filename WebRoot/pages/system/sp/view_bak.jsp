<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      //String now = StringUtil.getNowDate()+"";
      List list = null;
      RowSet rs = null;
      Map sbMap = null;
      String station_id = request.getParameter("station_id");
      String station_name = null;
      String sb_id = null;
      String sql = null;
      String station_type= request.getParameter("station_type");
      String area_id = request.getParameter("area_id");
       String p_station_name = JspUtil.getParameter(request,"station_name");
      Connection cn = null;
     Map map = null;
     
     String bar = null;
     String station_ip = null;
     String sp_type = null;
     String spTypeOption = null;
     String sp_port,sp_user,sp_pwd=null;
     XBean b = null;
     
     
      try{
      if(StringUtil.isempty(station_id)){throw new Exception("站位编号不能为空");}
      //JspAction.hour_today_form(request);
      cn = DBUtil.getConn();
      sql = "select station_id,station_desc,station_ip,sp_type,sb_id,sp_port,sp_user,sp_pwd,sp_channel from t_cfg_station_info where station_id=?";
      map = DBUtil.queryOne(cn,sql,new Object[]{station_id});
      if(map==null){throw new Exception("站位不存在");}
      station_name = (String)map.get("station_desc");
      station_ip = (String)map.get("station_ip");
      sp_type = (String)map.get("sp_type");
      sb_id=(String)map.get("sb_id");
      
      sb_id=(String)map.get("sb_id");
      
      
      if(station_ip==null){station_ip="";}
      if(sp_type==null){sp_type="";}
       if(sb_id==null){sb_id="";}
     
      b = new XBean(map);
      
       spTypeOption = JspPageUtil.getSpTypeOption(cn,sp_type);
      
      
      }catch(Exception e){
      JspUtil.go2error(request,response,e);
      return;
      }finally{DBUtil.close(cn);}
     
      
      
%>
<body scroll=no>
<form name=form1 method=post action=update.jsp>
<%=JspUtil.getHiddenHtml("station_id,station_type,station_name,area_id,page,page_size",request)%>
<table border=0 cellspacing=1>

<!--
<tr>
<td>站位名称</td>
<td class=left><%=b.get("station_desc")%></td>
</tr>
-->

<tr>
<td class='tdtitle'>站位名称</td>
<td class=left ><input style="width:500px" type=text name=station_desc value="<%=b.get("station_desc")%>"></td>
</tr>



<tr>
<td class='tdtitle'>视频ip</td>
<td class=left>
<input type=text name=station_ip value="<%=b.get("station_ip")%>"></td>
</tr>



<tr>
<td class='tdtitle'>视频端口</td>
<td class=left>
<input type=text name=sp_port value="<%=b.get("sp_port")%>"></td>
</tr>


<tr>
<td class='tdtitle'>视频帐号</td>
<td class=left>
<input type=text name=sp_user value="<%=b.get("sp_user")%>"></td>
</tr>



<tr>
<td class='tdtitle'>视频密码</td>
<td class=left>
<input type=text name=sp_pwd value="<%=b.get("sp_pwd")%>"></td>
</tr>


<tr>
<td class='tdtitle'>通道号</td>
<td class=left>
<input type=text name=sp_channel value="<%=b.get("sp_channel")%>"></td>
</tr>


<tr>
<td class='tdtitle'>设备编号</td>
<td class=left >
<input type=text name=sb_id value="<%=b.get("sb_id")%>" style="width:500px"></td>
</tr>


<tr>
<td class='tdtitle'>视频类型</td>
<td class=left  >
<select name=sp_type>
<option value=""></option>
<%=spTypeOption%>
</select>
</tr>

<tr>
<td class='tdtitle'></td>
<td class=left>
<input type=submit value="保存" class=btn>

<input type=button value="返回" onclick=history.back()  class=btn>



</td>
</tr>

</table>


</form>








