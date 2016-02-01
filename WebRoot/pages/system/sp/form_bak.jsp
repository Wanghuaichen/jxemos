<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      //String now = StringUtil.getNowDate()+"";
      String stationTypeOption = null;
      String areaOption = null;
      Connection cn = null;
      String spTypeOption = null;
      
      try{
    
      //JspAction.hour_today_form(request);
      cn = DBUtil.getConn();
      stationTypeOption = JspPageUtil.getStationTypeOption(cn,null);
      areaOption = JspPageUtil.getAreaOptionNoAll(cn,null);
      spTypeOption = JspPageUtil.getSpTypeOption(cn,null);
      
      
      }catch(Exception e){
      JspUtil.go2error(request,response,e);
      return;
      }finally{DBUtil.close(cn);}
      
%>
<body onload=form1.submit() scroll=no>
<form name=form1 method=post action=q.jsp target=q>
<table border=0 cellspacing=0>
<tr><td class=left>
<select name=station_type onchange=form1.submit()>
<%=stationTypeOption%>
</select>
地区
<select name=area_id  onchange=form1.submit()>
<option value="">全部</option>
<%=areaOption%>
</select>
<!--
视频类型
<select name=sp_type  onchange=form1.submit()>
<option value="">全部</option>
<%=spTypeOption%>
</select>
-->

站位名称
<input type=text name=station_name>
<input type=button value=查看 onclick=form1.submit() class=btn>
</td>
</tr>
</table>

</form>
<iframe name="q" id="q" width=100% height=96%  scrolling="auto" frameborder="0"  style="border:0px" allowtransparency="true">
</iframe>



