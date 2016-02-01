<%@ page contentType="text/html;charset=gbk" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
  List list = null;
    RowSet rs = null;
    try{
    
      SwjUpdate.real_hour(request);
         list = (List)request.getAttribute("list");
     list = SwjUpdate.getFocusList(request,list);
     rs = new RowSet(list);
    }catch(Exception e){
     w.error(e);
     return;
    }
	String area_id = request.getParameter("area_id");
    boolean iswry = f.iswry(w.get("station_type"));
   
    RowSet rsf = w.rs("flist");
    int size = rsf.size();

    String id = null;
    String v = null;
    String station_id = null;
    Map m = (Map)request.getAttribute("m");
    String css = null;
    
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk" />
<title></title>
<link href="../../styles/reset-min.css" rel="stylesheet" type="text/css" />
<link href="../../styles/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<link href="../../styles/common/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../scripts/core/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.core.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.widget.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.tabs.js"></script>
<script type="text/javascript" src="../../scripts/core/jquery.ui.check.js"></script>
<script type="text/javascript" src="../../scripts/common.js"></script>

</head>
<body>
<div id="topDiv" class="tableSty1">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <th>序号</th>
    <th>站位名称</th>
    <th>监测时间</th>
    <%while(rsf.next()){%>
      <th>
      <%=rsf.get("infectant_name")%>
      <%=rsf.get("infectant_unit")%>
      </th>
    <%}%>
    <th>备注</th>
  </tr>
     
  <%while(rs.next()){
    station_id = rs.get("station_id");
  %>
    <tr>
    <td><%=rs.getIndex()+1%></td>
    <td ><a href="javascript:f_real_view('<%=station_id%>','<%=area_id%>')" ><%=rs.get("station_desc")%></a></td>
    <td><%=f.sub(rs.get("m_time"),0,19)%></td>
      <%
      rsf.reset();
      while(rsf.next()){
      id = rsf.get("infectant_column");
      if(id==null){id="";}
      id=id.toLowerCase();
      v = rs.get(id);
      
      v = f.v(v);
      css = f.get_css(m,station_id,id,v);
      %>
        <td class='<%=css%>'><%=f.format(v,"0.#####")%></td>
      <%}%>
     
    <td><a href="javascript:f_view_comment('<%=station_id%>')"><%=rs.get("station_bz")%></a></td>
     
     </tr>
  <%}%>
</table>
</div>
</body>
</html>
<script>
 function f_real_view(station_id,area_id){
var url = "real_view_jx.jsp";
//url = "real_view.jsp";
url = "../station_new/index_one.jsp";
url = url+"?station_id="+station_id+"&area_id="+area_id;
var width = 1024;
var height = 568;
window.open(url,"","scrollbars=yes"+",height="+height+",width="+width+",left="+(window.screen.width-width)/2+",top="+(window.screen.height-height)/2);

}
function f_view_comment(station_id){
	var url = "../station_new/comments.jsp";
	url = url+"?station_id="+station_id;
	var width = 1024;
	var height = 668;
	window.open(url,"","scrollbars=yes"+",height="+height+",width="+width+",left="+(window.screen.width-width)/2+",top="+(window.screen.height-height)/2);
	
}
var table1 = window.parent.document.getElementById("topDiv");
var table2 = window.document.getElementById("topDiv");
table1.innerHTML=table2.innerHTML;
</script>



