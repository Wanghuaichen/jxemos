<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%

    try{
    
      SwjUpdate.offline(request);
    
    }catch(Exception e){
     w.error(e);
     return;
    }


    RowSet rs = w.rs("list");
   String station_id = null;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title></title>
<link href="../../styles/reset-min.css" rel="stylesheet" type="text/css" />
<link href="../../styles/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<link href="../../styles/common/common.css" rel="stylesheet" type="text/css" />
<link href="../../styles/common/select1.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../scripts/core/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.core.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.widget.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.tabs.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.check.js"></script>
<script type="text/javascript" src="../../scripts/jSelect/jselect.js"></script>
<script type="text/javascript" src="../../scripts/common.js"></script>
<script type="text/javascript">
	$(function() {
		$("input[name='check1']").chkCss();
		$(".tableSty1 table tr").hover(
			function(){
				$(this).addClass("hover");
			},function(){
				$(this).removeClass("hover");
				}
			);
		$(".tableSty1 table th").hover(
			function(){
				$(this).addClass("thh");
			},function(){
				$(this).removeClass("thh");
				}
			);
	});
</script>
</head>
<div class="tableSty1">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
 <tr>
  <th>序号</th>
  <%--<th>站位编号</th>--%>
  <th>站位名称</th>
  <th>备注</th>
 </tr>
  <%while(rs.next()){
    station_id = rs.get("station_id");
  %>
    <tr>
    <td><%=rs.getIndex()+1%></td>

    <%--<td><%=rs.get("station_id")%></td>--%>
         <td><a href="javascript:f_real_view('<%=station_id%>')"><%=rs.get("station_desc")%></a></td>
    <td><%=rs.get("station_bz")%></td>
     </tr>
  <%}%>
</table>
</div>
</html>

<script>
 function f_real_view(station_id){
var url = "real_view_jx.jsp";
url = "../station_new/index_one.jsp";
url = url+"?station_id="+station_id;
var width = 1024;
var height = 568;
window.open(url,"","scrollbars=yes"+",height="+height+",width="+width+",left="+(window.screen.width-width)/2+",top="+(window.screen.height-height)/2);

}
</script>
