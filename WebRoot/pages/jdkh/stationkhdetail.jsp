<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.util.Scape"%>
<%
    List list = null;
    RowSet rs = null;
    int size = 0;
    Map dataMap = null;
    String station_desc  = request.getParameter("station_desc");
    String flag = request.getParameter("flag");
  
	if(!"".equals(station_desc) && station_desc != null){
	    station_desc= Scape.unescape(station_desc);
	}
    try{
    
     SwjUpdate.stationkhdetail_data(request);//初始化数据
     list = (List)request.getAttribute("list");
     size = list.size();
     //rs = new RowSet(list);
    }catch(Exception e){
      e.printStackTrace();
     w.error(e);
     return;
    }

%>

<br>
<table border=0 cellspacing=1  style="width:80%">
  <caption style="font-size: 16px"><%=station_desc %>的考核历史记录(空白处表示未进行任何的考核操作)</caption>

  <tr class=title  style="text-align: center" >
    <td width=15%>年份</td>
    <td width=15%>季度</td>
    <td width=15%>现场核查</td>
    <td width=15%>比对监测</td>
    <td width=15%>考核结论</td>
    <td width=15%>合格标志</td>
  </tr>
  
  <%  
     for(int i=0; i<size;i=i+4){
         dataMap = (Map)list.get(i);
     
  %>
     <tr style="height:30px;">
	    <td width=5% rowspan="4"><%=dataMap.get("year") %></td>
	    <td width=10%>第一季度</td>
        <td width=10%><a href="xchc_update.jsp?id=<%=dataMap.get("xchc_id") %>&flag=<%=flag %>" target="_blank"> <%=dataMap.get("xchc_jg") %> </a></td>
        <td width=10%><a href="bdjc_update.jsp?id=<%=dataMap.get("bdjc_id") %>&flag=<%=flag %>" target="_blank"><%=dataMap.get("bdjc_jg") %></a></td>
        <td width=10%><a href="khjl_update.jsp?id=<%=dataMap.get("khjl_id") %>&flag=<%=flag %>" target="_blank"><%=dataMap.get("khjl_jg") %></a></td>
        <td width=10%><a href="hgbz_update.jsp?id=<%=dataMap.get("hgbz_id") %>&flag=<%=flag %>" target="_blank"><%=dataMap.get("hgbz_jg") %></a></td>
     </tr>
     <%
        dataMap = (Map)list.get(i+1);
     %>
     <tr style="height:30px;">
	    <td width=10%>第二季度</td>
        <td width=10%><a href="xchc_update.jsp?id=<%=dataMap.get("xchc_id") %>&flag=<%=flag %>" target="_blank"> <%=dataMap.get("xchc_jg") %> </a></td>
        <td width=10%><a href="bdjc_update.jsp?id=<%=dataMap.get("bdjc_id") %>&flag=<%=flag %>" target="_blank"><%=dataMap.get("bdjc_jg") %></a></td>
        <td width=10%><a href="khjl_update.jsp?id=<%=dataMap.get("khjl_id") %>&flag=<%=flag %>" target="_blank"><%=dataMap.get("khjl_jg") %></a></td>
        <td width=10%><a href="hgbz_update.jsp?id=<%=dataMap.get("hgbz_id") %>&flag=<%=flag %>" target="_blank"><%=dataMap.get("hgbz_jg") %></a></td>
     </tr>
     <%
        dataMap = (Map)list.get(i+2);
     %>
     <tr style="height:30px;">
	    <td width=10%>第三季度</td>
        <td width=10%><a href="xchc_update.jsp?id=<%=dataMap.get("xchc_id") %>&flag=<%=flag %>" target="_blank"> <%=dataMap.get("xchc_jg") %> </a></td>
        <td width=10%><a href="bdjc_update.jsp?id=<%=dataMap.get("bdjc_id") %>&flag=<%=flag %>" target="_blank"><%=dataMap.get("bdjc_jg") %></a></td>
        <td width=10%><a href="khjl_update.jsp?id=<%=dataMap.get("khjl_id") %>&flag=<%=flag %>" target="_blank"><%=dataMap.get("khjl_jg") %></a></td>
        <td width=10%><a href="hgbz_update.jsp?id=<%=dataMap.get("hgbz_id") %>&flag=<%=flag %>" target="_blank"><%=dataMap.get("hgbz_jg") %></a></td>
     </tr>
     <%
        dataMap = (Map)list.get(i+3);
     %>
     <tr style="height:30px;">
	    <td width=10%>第四季度</td>
        <td width=10%><a href="xchc_update.jsp?id=<%=dataMap.get("xchc_id") %>&flag=<%=flag %>" target="_blank"> <%=dataMap.get("xchc_jg") %> </a></td>
        <td width=10%><a href="bdjc_update.jsp?id=<%=dataMap.get("bdjc_id") %>&flag=<%=flag %>" target="_blank"><%=dataMap.get("bdjc_jg") %></a></td>
        <td width=10%><a href="khjl_update.jsp?id=<%=dataMap.get("khjl_id") %>&flag=<%=flag %>" target="_blank"><%=dataMap.get("khjl_jg") %></a></td>
        <td width=10%><a href="hgbz_update.jsp?id=<%=dataMap.get("hgbz_id") %>&flag=<%=flag %>" target="_blank"><%=dataMap.get("hgbz_jg") %></a></td>
     </tr>
     
     
     
  <%
     }
  %>

</table>

<script type="text/javascript">
   function open_khjl(id,name){
     window.open("add_page.jsp?station_id="+id+"&station_desc="+escape(escape(name)));
   }
</script>



