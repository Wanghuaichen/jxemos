<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      //String now = StringUtil.getNowDate()+"";
      String stationTypeOption = null;
      String areaOption = null;
      Connection cn = null;
      String spTypeOption = null;
      String area_id = null;
      try{
    
      //JspAction.hour_today_form(request);
      cn = DBUtil.getConn();
      stationTypeOption = JspPageUtil.getStationTypeOption(cn,null);
      
      //
      stationTypeOption = stationTypeOption.replace("value=\"1\"", "value=\"1\" selected");
      //
      //地区编号
	area_id = JspUtil.getParameter(request, "p_area_id",f.cfg("default_area_id", "3301"));
     //地区下拉列表
	areaOption = JspPageUtil.getAreaOption(cn, area_id);
     // areaOption = JspPageUtil.getAreaOptionNoAll(cn,null);
      spTypeOption = JspPageUtil.getSpTypeOption(cn,null);
      
      
      }catch(Exception e){
      JspUtil.go2error(request,response,e);
      return;
      }finally{DBUtil.close(cn);}
      
%>
<html>
<head>
<link rel="stylesheet" href="../../../web/index.css"/>
</head>


<body onload=form1.submit() >
<form name=form1 method=post action=q.jsp target=q style="margin-left: 10px;">
<table   class="nui-table-inner">
<tr>
<td class=left>
<select name=station_type class="selectoption" onchange=form1.submit()>
<%=stationTypeOption%>
</select>
地区:
<select name=area_id class="selectoption"  onchange=form1.submit()>
<!-- <option value="">全部</option> -->
<%=areaOption%>
</select>
视频类型:
<select name=sp_type  onchange=form1.submit()>
<option value="">全部</option>
<%=spTypeOption%>
</select>

站位名称:
<input type=text name=station_name class="selectoption">
<input type=button value=查看 onclick=form1.submit() class="tiaojianbutton">
</td>
</tr>
</table>

</form>
<iframe name="q" id="q" width=100% height=96%  scrolling="auto" frameborder="0"  style="border:0px" allowtransparency="true">
</iframe>

</html>

