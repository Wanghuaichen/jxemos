<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
           String stationTypeOption = null;
           String areaOption = null;
           Connection cn = null;
           
           try{
           cn = DBUtil.getConn();
           
           stationTypeOption = JspPageUtil.getStationTypeOption(cn);
           areaOption = JspPageUtil.getAreaOption(cn,null);
           
           
           
           }catch(Exception e){
           JspUtil.go2error(request,response,e);
           return;
           }finally{DBUtil.close(cn);}
           
           
             
%>

<form name=form1 method=post action=q.jsp target=q>
  
    <select name=station_type><%=stationTypeOption%></select>
    <select name=area_id>
    <option value="">全部</option>
    <%=areaOption%>
    </select>
    <input type=text name=station_name>
    <input type=submit value=查看>
  
</form>

<iframe name="q"width=100% height=96%  scrolling="auto" frameborder="0"  style="border:0px" allowtransparency="true">
</iframe>
