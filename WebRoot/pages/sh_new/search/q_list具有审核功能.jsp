<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
      BaseAction action = null;
   try{//异常数据主要是查询时均值数据
    action = new WarnAction();
    action.run(request,response,"getWarnData");
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   
   RowSet rs1 = w.rs("data");
   RowSet rs2 = w.rs("infectant");
   String v,col = null;
   String station_id,m_time = null;
   
   int i=0;
   
%>

<style>
.selected{
background-color:#CFDBF1;
font-weight:bold;
} 
 .up{color:#FF8000;}
 .yc{color:red;};
 .drop{color:#B5B5B5;}
</style>
<table border=0 cellspacing=1>
<tr class="title">
	<td colspan="<%=rs2.size()+3 %>"><center><span style="font-size:20px"><%=w.get("title") %></span>(蓝色数据表示审核过数据或补录的数据，暗色表无效数据)</center></td>
</tr>
<tr class="title" >
    <td>序号</td>
    <td>站位名称</td>
    <td>监测时间</td>
    
    <%while(rs2.next()){%>
    <td>
        <%=rs2.get("infectant_name")%><br>
        <%=rs2.get("infectant_unit")%>
     </td>
    <%}%>
    <!--
   <td></td>
   -->
   
</tr>

  <%while(rs1.next()){
    station_id = rs1.get("station_id");
    m_time = rs1.get("m_time");
     i++;
    int flag = Integer.valueOf(rs1.get("v_flag"));
  %>
  <tr style="cursor: pointer;"  onClick="selected('<%=i %>')"  id="tr<%=i %>" ondblclick="f_wuxiao('<%=rs1.get("station_id") %>','<%=rs1.get("station_desc") %>')">
        <td><%=rs1.getIndex()+1%></td>
        <td><%=rs1.get("station_desc") %></td>
        <td><%=rs1.get("m_time")%></td>
        <%
        	rs2.reset();
        	while(rs2.next()){
        	col = rs2.get("infectant_column").toLowerCase();
        	v = rs1.get(col);
        	v= f.format(v,"#.####");
        	%>
        	
        	<%
       if(flag==5){
       //String css = zdxUpdate.get_css(m_time,v,null,col,request,rs1.get("v_flag").toString());
     %>
     <td class='drop'><%=v%></td>
     <%}else if(flag==7){ %>
     <td><font style='color:blue'><%=v%></font></td>
     <%}else{%>
     <td><font style='color:#000'><%=v%></font></td>
     <%} %>
        	
        	<%}%>
  </tr>
  <%}%>
</table>


<script type="text/javascript">

function selected(id){
	var i = <%=i%>;
	for(var n=1;n<=i;n++){
		document.getElementById("tr"+n).className='';
	}
	document.getElementById("tr"+id).className='selected';
}

function sh_data(station_id,station_desc,m_time,data_table){
if(data_table!='t_monitor_real_hour_v'){
	return false;
}



 var url = "<%=request.getContextPath() %>/pages/sh_new/data/sjsh.jsp";
	url = url+"?station_id="+station_id+"&station_desc="+escape(escape(station_desc))+"&m_time="+m_time+"&data_table="+data_table;
	var width = 1024;
	var height = 568;
	window.open(url,"","scrollbars=yes,resizable=yes"+",height="+height+",width="+width+",left="+(window.screen.width-width)/2+",top="+(window.screen.height-height)/2);
	
}


function f_wuxiao(station_id,station_desc){
	 //var station_id = form1.station_id.value;
	 	var url = "<%=request.getContextPath() %>/pages/sh_new/data/wuxiao.jsp";
	url = url+"?station_id="+station_id+"&station_desc="+escape(escape(station_desc));
	var width = 812;
	var height = 356;
	window.open(url,"","scrollbars=yes,resizable=yes"+",height="+height+",width="+width+",left="+(window.screen.width-width)/2+",top="+(window.screen.height-height)/2);
	
}
</script>
