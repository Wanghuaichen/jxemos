<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%--<%
      BaseAction action = null;
   try{
    action = new WarnAction();
    action.run(request,response,"getXgxx");
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   
   RowSet rs1 = w.rs("data");
   RowSet rs2 = w.rs("infectant");
   String v,col = null;
   String station_id,m_time = null;
   
%>
<table border=0 cellspacing=1>
<tr class="title">
	<td colspan="3"><center><span style="font-size:20px"><%=w.get("title") %></span></center></td>
</tr>
<tr class="title">
    <td>序号</td>
    <td>站位名称</td>
    <td>数据个数</td>
</tr>

  <%while(rs1.next()){
    station_id = rs1.get("station_id");
  %>
  <tr>
        <td><%=rs1.getIndex()+1%></td>
        <td><%=rs1.get("station_desc") %></td>
         <td><%=rs1.get("num") %></td>
  </tr>
  <%}%>
</table>--%>

<%
      BaseAction action = null;
   try{
    action = new WarnAction();
    action.run(request,response,"getBulu");
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   String station_type = request.getParameter("station_type");
   
   //System.out.println(station_type+"======");
   RowSet rs1 = w.rs("data");
   RowSet rs2 = w.rs("infectant");
   String v,col = null;
   String station_id,m_time = null;
   String m_value ="";
   String v_flag = "";
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
	<td colspan="<%=rs2.size()+3 %>"><center><span style="font-size:20px"><%=w.get("title") %></span></center></td>
</tr>
<tr class="title">
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
    v_flag = rs1.get("v_flag");
    i++;
  %>
  <tr onClick="selected('<%=i %>')"  id="tr<%=i %>" style="cursor: pointer;" title="双击进入审核"  ondblclick="sh_data('<%=station_id %>','<%=rs1.get("station_desc") %>','<%=m_time %>','t_monitor_real_hour_v','<%=rs1.get("v_flag") %>','<%=rs1.get("operator") %>','<%=rs1.get("operator2") %>','<%=station_type %>')">
        <td>
               <%=rs1.getIndex()+1%>
               <% if(v_flag.equals("5")){ %>
                   (无效数据)
               <%}else{ %>
               (补录数据)
               <%} %>
        </td>
        <td><%=rs1.get("station_desc") %></td>
        <td><%=rs1.get("m_time")%></td>
        <%
        	rs2.reset();
         while(rs2.next()){
        	col = rs2.get("infectant_column");
            int flag = 0;
	        if(col==null){col="";}
	        col=col.toLowerCase();
	        m_value=rs1.get(col);
	        //m_value=f.v(m_value);
	        if(!rs2.get("infectant_name").equals("流量2"))
	        {
	         if (m_value.indexOf(",") >= 0) {
	       		String[] arr = m_value.split(",");
	       		//if(arr[2].equals("-9")){
	       		if(arr.length>=3){
	       			m_value = "{"+arr[0]+"}"+"["+arr[1]+"]"+"("+arr[2]+")";
	       			flag = 1;
	       		}else if(arr.length>=2){
	       		    m_value = "{}"+"["+arr[0]+"]"+"("+arr[1]+")";
	       			flag = 1;
	       		}else{
	       			m_value = "{}"+"[]"+"("+arr[0]+")";
	       		}
	       	  }
	       }else{
	       		m_value=f.v(m_value);
	       }
     %>
        	<td><%=m_value%></td>
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

function sh_data(station_id,station_desc,m_time,data_table,v_flag,operator,operator2,station_type){

if(data_table!='t_monitor_real_hour_v'){
	return false;
}
//alert(operator2);
if(operator2 !=""){
	alert("已被审核过,不能再审核！");
	return false;
}


 var url = "<%=request.getContextPath() %>/pages/sh_new/data/sjsh2.jsp";
 //alert(url);
	url = url+"?station_id="+station_id+"&station_desc="+escape(escape(station_desc))+"&m_time="+m_time+"&data_table="+data_table+"&v_flag="+v_flag+"&operator="+operator+"&station_type="+station_type;
	var width = 1024;
	var height = 568;
	window.open(url,"","scrollbars=yes,resizable=yes"+",height="+height+",width="+width+",left="+(window.screen.width-width)/2+",top="+(window.screen.height-height)/2);
	
}
</script>
