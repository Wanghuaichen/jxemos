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
    
     SwjUpdate.stationkhdetail_data(request);//��ʼ������
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
  <caption style="font-size: 16px"><%=station_desc %>�Ŀ�����ʷ��¼(�հ״���ʾδ�����κεĿ��˲���)</caption>

  <tr class=title  style="text-align: center" >
    <td width=15%>���</td>
    <td width=15%>����</td>
    <td width=15%>�ֳ��˲�</td>
    <td width=15%>�ȶԼ��</td>
    <td width=15%>���˽���</td>
    <td width=15%>�ϸ��־</td>
  </tr>
  
  <%  
     for(int i=0; i<size;i=i+4){
         dataMap = (Map)list.get(i);
     
  %>
     <tr style="height:30px;">
	    <td width=5% rowspan="4"><%=dataMap.get("year") %></td>
	    <td width=10%>��һ����</td>
        <td width=10%><a href="xchc_update.jsp?id=<%=dataMap.get("xchc_id") %>&flag=<%=flag %>" target="_blank"> <%=dataMap.get("xchc_jg") %> </a></td>
        <td width=10%><a href="bdjc_update.jsp?id=<%=dataMap.get("bdjc_id") %>&flag=<%=flag %>" target="_blank"><%=dataMap.get("bdjc_jg") %></a></td>
        <td width=10%><a href="khjl_update.jsp?id=<%=dataMap.get("khjl_id") %>&flag=<%=flag %>" target="_blank"><%=dataMap.get("khjl_jg") %></a></td>
        <td width=10%><a href="hgbz_update.jsp?id=<%=dataMap.get("hgbz_id") %>&flag=<%=flag %>" target="_blank"><%=dataMap.get("hgbz_jg") %></a></td>
     </tr>
     <%
        dataMap = (Map)list.get(i+1);
     %>
     <tr style="height:30px;">
	    <td width=10%>�ڶ�����</td>
        <td width=10%><a href="xchc_update.jsp?id=<%=dataMap.get("xchc_id") %>&flag=<%=flag %>" target="_blank"> <%=dataMap.get("xchc_jg") %> </a></td>
        <td width=10%><a href="bdjc_update.jsp?id=<%=dataMap.get("bdjc_id") %>&flag=<%=flag %>" target="_blank"><%=dataMap.get("bdjc_jg") %></a></td>
        <td width=10%><a href="khjl_update.jsp?id=<%=dataMap.get("khjl_id") %>&flag=<%=flag %>" target="_blank"><%=dataMap.get("khjl_jg") %></a></td>
        <td width=10%><a href="hgbz_update.jsp?id=<%=dataMap.get("hgbz_id") %>&flag=<%=flag %>" target="_blank"><%=dataMap.get("hgbz_jg") %></a></td>
     </tr>
     <%
        dataMap = (Map)list.get(i+2);
     %>
     <tr style="height:30px;">
	    <td width=10%>��������</td>
        <td width=10%><a href="xchc_update.jsp?id=<%=dataMap.get("xchc_id") %>&flag=<%=flag %>" target="_blank"> <%=dataMap.get("xchc_jg") %> </a></td>
        <td width=10%><a href="bdjc_update.jsp?id=<%=dataMap.get("bdjc_id") %>&flag=<%=flag %>" target="_blank"><%=dataMap.get("bdjc_jg") %></a></td>
        <td width=10%><a href="khjl_update.jsp?id=<%=dataMap.get("khjl_id") %>&flag=<%=flag %>" target="_blank"><%=dataMap.get("khjl_jg") %></a></td>
        <td width=10%><a href="hgbz_update.jsp?id=<%=dataMap.get("hgbz_id") %>&flag=<%=flag %>" target="_blank"><%=dataMap.get("hgbz_jg") %></a></td>
     </tr>
     <%
        dataMap = (Map)list.get(i+3);
     %>
     <tr style="height:30px;">
	    <td width=10%>���ļ���</td>
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



