<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    List list = null;
    RowSet rs = null;
    try{
    
      SwjUpdate.qsjdkh_data(request);//初始化数据
     list = (List)request.getAttribute("list");
    
     rs = new RowSet(list);
    }catch(Exception e){
     w.error(e);
     return;
    }

%>
<style>
 .up{color:#FF8000;}
 .yc{color:red;};
 .drop{color:#B5B5B5;}
</style>

<table border=0 cellspacing=1  >
  <tr class=title style="position: relative; top: expression(this.offsetParent.scrollTop);text-align: center" >
    <td width=5%>序号</td>
    <td width=20%>站位名称</td>
    <td width=10%>现场核查</td>
    <td width=10%>比对监测</td>
    <td width=10%>考核结论</td>
    <td width=10%>监督考核合格标志</td>
    <%--<td width=10%>新增</td>
  --%></tr>

  <%while(rs.next()){
  %>
    <tr style="height:30px;font-family: Tahoma;">
	    <td width=5%>

	    <%=rs.getIndex()+1%></td>
	    <%--<td width=10%><a style="cursor: pointer;"  onclick="open_detail('<%= rs.get("station_id")%>','<%=rs.get("station_desc") %>')"><%=rs.get("station_desc")%></td>
        <td width=10%><a href="<%=rs.get("xchc_url") %>" target="_blank"> <%=rs.get("xchc_jg") %> </a></td>
        <td width=10%><a href="<%=rs.get("bdjc_url") %>" target="_blank"><%=rs.get("bdjc_jg") %></a></td>
        <td width=10%><a href="<%=rs.get("khjl_url") %>" target="_blank"><%=rs.get("khjl_jg") %></a></td>
        <td width=10%><a href="<%=rs.get("hgbz_url") %>" target="_blank"><%=rs.get("hgbz_jg") %></a></td>
        --%><%--<td width=10%><a style="cursor: pointer;"  onclick="open_khjl('<%= rs.get("station_id")%>','<%=rs.get("station_desc") %>')"> <img src="<%=request.getContextPath() %>/images/edit.gif" > </a></td>
     --%>
        <td width=10%><a style="cursor: pointer;"  onclick="open_detail('<%= rs.get("station_id")%>','<%=rs.get("station_desc") %>','<%=rs.get("content_flag") %>')"><%=rs.get("station_desc")%></td>
        <td width=10%><a onclick="jdkh_4(<%=rs.get("xchc_url") %>)" style="cursor: pointer;" target="_blank"> <%=rs.get("xchc_jg") %> </a></td>
        <td width=10%><a onclick="jdkh_4(<%=rs.get("bdjc_url") %>)" style="cursor: pointer;" target="_blank"><%=rs.get("bdjc_jg") %></a></td>
        <td width=10%><a onclick="jdkh_4(<%=rs.get("khjl_url") %>)" style="cursor: pointer;" target="_blank"><%=rs.get("khjl_jg") %></a></td>
        <td width=10%><a onclick="jdkh_4(<%=rs.get("hgbz_url") %>)" style="cursor: pointer;" target="_blank"><%=rs.get("hgbz_jg") %></a></td>
     </tr>
  <%} %>

</table>

<script type="text/javascript">
   function open_khjl(id,name){
     window.open("add_page.jsp?station_id="+id+"&station_desc="+escape(escape(name)));
   }
   
   function open_detail(id,name,flag){
     window.open("stationkhdetail.jsp?station_id="+id+"&station_desc="+escape(escape(name))+"&flag="+flag);
   }
   
   function jdkh_4(page,id,station_desc,flag){
      //alert(page+"?id="+id+"&station_desc="+escape(escape(station_desc))+"&flag="+flag);
      window.open(page+"?id="+id+"&station_desc="+escape(escape(station_desc))+"&flag="+flag);
   }
</script>



