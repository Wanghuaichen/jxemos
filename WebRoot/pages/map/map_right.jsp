<%@ page contentType="text/html;charset=GBK" %>
<%
  String url = "map.swf";
%>
<center>
    <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0" width="498" height="472">
      <param name="movie" value="<%=url%>" style='background-color:#F7F7F7;'>
      <param name="quality" value="high">
      <embed src="<%=url%>" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="498" height="472"></embed>
    </object>
</center>
 
  