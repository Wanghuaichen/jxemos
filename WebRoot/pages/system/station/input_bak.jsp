<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    
      Connection cn = null;
      String stationTypeOption,areaOption = null;
      String top_area_id = App.get("area_id","33");
      String sql = null;
      
      
      try{
      
     
      
      cn = DBUtil.getConn();
      
      stationTypeOption = JspPageUtil.getStationTypeOption(cn,null);
      
     
      
      areaOption = JspPageUtil.getAreaOption(cn,null);
      
      
      
      
      
      }catch(Exception e){
      JspUtil.go2error(request,response,e);
      return;
      }finally{DBUtil.close(cn);}
      
      
      
%>
<style>
td{
text-align:left;
}
</style>


<body scroll=no>
<form name="form1" action="insert.jsp" method="post">
<table border=0 cellspacing=1>

<tr>
<td class='tdtitle'>վλ���</td>
<td>
<input type=text name="station_id">
<%=App.require()%>
</td>
</tr>


<tr>
<td class='tdtitle'>վλ����</td>
<td>
<input type=text name="station_desc">
<%=App.require()%>
</td>
</tr>


<tr>
<td class='tdtitle'>������</td>
<td>
<select name="station_type"><%=stationTypeOption%></select>
</td>
</tr>


<tr>
<td class='tdtitle'>����</td>
<td>
<select name="area_id"><%=areaOption%></select>
</td>
</tr>

<tr>
<td class='tdtitle'></td>
<td>
<input type="submit" value=" �� �� " class=btn>
 <!--
 <input type="button" value="����" onclick="history.back()">
 -->
 
</td>
</tr>

</form>
