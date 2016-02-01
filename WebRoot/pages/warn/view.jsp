<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
     BaseAction action = null;
   try{
    action = new WarnAction();
    action.run(request,response,"view");
   
   }catch(Exception e){
      w.error(e);
      return;
   }
   
   RowSet rs1 = w.rs("data");
   RowSet rs2 = w.rs("infectant");
   String v,col = null;
   String station_id,m_time = null;
     String[] arr = null;
    String min = "";
    String max = "";
   
%>

<link rel="stylesheet" href="../../web/index.css"/>
<script type="text/javascript" src="../../scripts/calendar.js"></script>
<body>

<form name=form1 method=post action=view.jsp>
<input type=hidden name=station_id value='<%=w.get("station_id")%>'>
<div class="frame-main-content" style="left:0; top:0;position: static;">
	    <div class="nt">
	    	 <p class="tiaojiao-p">
	    	 	<%=w.get("station_desc")%>:&nbsp;&nbsp;
	    	 从<input type=text name=date1 value='<%=w.get("date1")%>' class="c1" onclick="new Calendar().show(this);">
   			 到<input type=text name=date2 value='<%=w.get("date2")%>' class="c1" onclick="new Calendar().show(this);">	    	 
   			 </p>
	    	 
	    	<input type=button value='查看' onclick=f_submit() class="tiaojianbutton">
   			<input type=button value="保存为excel" title="保存为excel" class="tiaojianbutton" onclick=f_save() />
	    	 
	    </div>	    
	</div>
</form>

<div id='div_excel_content' style="float:left;">
<table class="nui-table-inner major" >
<thead class="nui-table-head">
	<tr class="nui-table-row">
    <th class="nui-table-cell">序号</th>
    <th class="nui-table-cell">监测时间</th>
 <%while(rs2.next()){%>
    <th class="nui-table-cell">
        <%=rs2.get("infectant_name")%><br>
        <%=rs2.get("infectant_unit")%>
     </th>
    <%}%>
	</tr>
	<tr class="nui-table-row">
	<th class="nui-table-cell"></th>
    <th class="nui-table-cell">报警上限</th>
    
    <%
      rs2.reset();
    while(rs2.next()){%>
    <th class="nui-table-cell">
        <%=rs2.get("hihi")%>
     </th>
    <%}%>
	</tr>
	<tr class="nui-table-row">
	<th class="nui-table-cell"></th>
    <th class="nui-table-cell">报警下限</th>
    
    <%
      rs2.reset();
    while(rs2.next()){%>
    <th class="nui-table-cell">
        <%=rs2.get("lolo")%>
     </th>
    <%}%>
	</tr>
</thead>
<tbody class="nui-table-body">
	 <%while(rs1.next()){
    station_id = rs1.get("station_id");
    m_time = rs1.get("m_time");
  %>
  <tr class="nui-table-row">
         <th class="nui-table-cell"><%=rs1.getIndex()+1%></th>
         <th class="nui-table-cell"><%=rs1.get("m_time")%></th>
        <%
        	rs2.reset();
        	while(rs2.next()){
        	col = rs2.get("infectant_column");
        	v = rs1.get(col);
        	//v= f.format(v,"#.####");
        	max ="";  min = "";
        	if(!"".equals(v)){
	           arr = v.split(",");
	           if(arr.length>=1){
	              v=arr[0];
	           }
	           if(arr.length>=2){
	              min=arr[1];
	           }
	           if(arr.length>=3){
	              max=arr[2];
	           }
	        } 
        %>
        	<th class="nui-table-cell" style="cursor: pointer;" title="最大值(<%=max %>)最小值(<%=min %>)"><%=v%></th>
        <%}%>

  
  </tr>
  <%}%>
</tbody>
</table>
</div>
<form name=form2 method=post>
<input type=hidden name='txt_excel_content' />
<input type=hidden name='title' value=""/>
</form>

<script>

function f_save(){
    var obj = document.getElementById('div_excel_content');
    //alert(obj);
    form2.txt_excel_content.value=obj.innerHTML;
    var name = '<%=w.get("station_desc")%>';
    var date1 = form1.date1.value;
    var date2 = form1.date2.value;
    form2.title.value = name+"在"+date1+"至"+date2+"间的报警数据";
    //alert(form2.title.value);  
    form2.action='/<%=ctx%>/pages/commons/save2excel.jsp';
    form2.submit();
}

</script>

<script>
function f_msg(station_id,m_time){
 //alert(station_id+","+m_time);
 var url = "msg.jsp?station_id="+station_id+"&m_time="+m_time;
  window.open(url,"","width=500,height=300");
}
function time(s){
  var a=s.split("-");
  var yy = a[0];
  var mm=a[1]-1;
  var dd = a[2];
  return new Date(yy,mm,dd);
}
function timecheck(date1,date2){
var d1=time(date1);
var d2=time(date2);
  var dif = d2.getTime()-d1.getTime();
  //alert(dif);
  dif = dif/(1000*24*60*60);
  if(dif>80){
  
  alert("时间间隔不能超过80天");
  return 0;
  }
  
  return 1;
}

function f_submit(){
var date1 = form1.date1.value;
var date2 = form1.date2.value;
//alert(date1+","+date2);

 var r = timecheck(date1,date2);
  if(r<1){return;}
  form1.submit();
  
}
</script>
