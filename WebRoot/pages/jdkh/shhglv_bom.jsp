<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    List list = null;
    List hg = null;
    List nhg = null;
    List noac = null;
    RowSet rs = null;
    try{
    
      SwjUpdate.jdkh_shhgl(request);//��ʼ������
     hg = (List)request.getAttribute("hg");
    
     rs = new RowSet(hg);
    }catch(Exception e){
     w.error(e);
     e.printStackTrace();
     return;
    }

    String hglv = (String)w.a("hglv");
    if("".equals(hglv))hglv="0";
%>
<style>
 .up{color:#FF8000;}
 .yc{color:red;};
 .drop{color:#B5B5B5;}
</style>
<div  style="width:90%;border:1px solid #ccc;">
<br>
<table border=0 cellspacing=1 style="width:80%" >
  <caption style="font-size: 16px">�ϸ�վλ----��ǰ�����ĺϸ��ʣ�<%=(Float.valueOf(hglv)*100)%>%</caption>
  <tr class=title style="text-align: center" >
    
    <td width=5%>���</td>
    <td width=20%>վλ����</td>
  </tr>

  <%while(rs.next()){
  %>
    <tr style="height:30px;font-family: Tahoma;">
	    <td width=5%>

	    <%=rs.getIndex()+1%></td>
	    <td width=20%>
	       <a style="cursor: pointer;"  onclick="open_detail('<%= rs.get("qy_id")%>','<%=rs.get("qy_mc") %>','<%=2 %>')"><%=rs.get("qy_mc")%></a>
	    </td>
     </tr>
  <%} %>

</table>

<%
  hg = (List)request.getAttribute("nhg");
    
  rs = new RowSet(hg);
  
  hglv = (String)w.a("bhglv");
  if("".equals(hglv))hglv="0";
%>

<br>
<table border=0 cellspacing=1  style="width:80%">
  <caption style="font-size: 16px">���ϸ�վλ----��ǰ�����Ĳ��ϸ��ʣ�<%=Float.valueOf(hglv)*100 %>%</caption>
  <tr class=title style="text-align: center" >
    
    <td width=5%>���</td>
    <td width=20%>վλ����</td>
  </tr>

  <%while(rs.next()){
  %>
    <tr style="height:30px;">
	    <td width=5%>

	    <%=rs.getIndex()+1%></td>
	    <td width=20%>
	    
	       <a style="cursor: pointer;"  onclick="open_detail('<%= rs.get("qy_id")%>','<%=rs.get("qy_mc") %>','<%=2 %>')"> <%=rs.get("qy_mc")%></a>
	    </td>
     </tr>
  <%} %>

</table>


<%
  hg = (List)request.getAttribute("noac");
    
  rs = new RowSet(hg);
  
  hglv = (String)w.a("wclv");
  if("".equals(hglv))hglv="0";
%>
<br>
<table border=0 cellspacing=1  style="width:80%">
  <caption style="font-size: 16px">ûִ�мල��վλ----��ǰ�����������Ϊ:<%=Float.valueOf(hglv)*100 %>%</caption>
  <tr class=title style="text-align: center" >
    
    <td width=5%>���</td>
    <td width=20%>վλ����</td>
  </tr>

  <%while(rs.next()){
  %>
    <tr style="height:30px;font-family: Tahoma;">
	    <td width=5%>

	    <%=rs.getIndex()+1%></td>
	    <td width=20%>
	       <a style="cursor: pointer;"  onclick="open_detail('<%= rs.get("station_id")%>','<%=rs.get("station_desc") %>','<%=2 %>')"> <%=rs.get("station_desc")%></a>
	    </td>
     </tr>
  <%} %>

</table>
<br>
</div>

<script type="text/javascript">
   function open_khjl(id,name){
     window.open("khjl_list.jsp?station_id="+id+"&station_desc="+escape(escape(name)));
   }
   
   function open_detail(id,name,flag){
     window.open("stationkhdetail.jsp?station_id="+id+"&station_desc="+escape(escape(name))+"&flag="+flag);
   }
</script>



