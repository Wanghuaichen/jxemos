<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.util.Scape"%>

<%
  String station_id  = request.getParameter("station_id");
  String station_desc  = request.getParameter("station_desc");
  
  if(!"".equals(station_desc) && station_desc != null){
	    station_desc= Scape.unescape(station_desc);
  }
  String now = StringUtil.getNowDate() + "";
   String date1=null;
   date1 = now;
%>



<body scroll=no onload='f_r()'>
<form name=form1 method=post action="xchc_info.jsp" target='frm_zw_list'>
<table  border=0 cellspacing=1  style="width: 850px;height:100%">
   <tr>
     <td style='height:20px' colspan="2">
         
       <table border=0 cellspacing=0>
          <caption>为<%=station_desc %>站位添加相关的信息</caption>
          <tr>
              <td> 
                      <input type=button value='新增现场核查' onclick='f_r()' class='btn'>
                      <input type="hidden" name="station_id" value="<%=station_id %>">
                      <input type="hidden" name="station_desc" value="<%=station_desc %>">
              </td>
 
              <td>
                           <input type=button value='新增比对监测' onclick='f_r2()' class='btn'>
              </td>

              <td>
                       <input type=button value='新增考核结论' onclick='f_r3()' class='btn'>
              </td>
              
              
              <td >
		         <input type=button value='颁发合格标志' onclick='f_r4()' class='btn'>
		    
		     
		      <td>
              
          </tr>
       </table>  
     </td>

     
   
   <tr>
     <td style='height:100%' colspan="2"><%--<div id="topDiv"></div>
      --%><iframe name='frm_zw_list' id='frm_zw_list' width=100% height=100% frameborder=0 allowtransparency="true"></iframe>
 
     <br></td>
   </tr>
   
</table>
</form>
</body>


<script>
 function f_r(){
	form1.action="xchc_info.jsp";
	form1.target='frm_zw_list';
	form1.submit();
 }
 
 function f_r2(){
	form1.action="bdjc_info.jsp";
	form1.target='frm_zw_list';
	form1.submit();
 }
 
 function f_r3(){
	form1.action="khjl_info.jsp";
	form1.target='frm_zw_list';
	form1.submit();
 }
 
 function f_r4(){
	form1.action="hgbz_info.jsp";
	form1.target='frm_zw_list';
	form1.submit();
 }

 
 
 function f_excel(){
    //alert("ddd");
   // alert(form1.data_flag.value);
 	if(form1.data_flag.value=='real'){
		 var r = window.frames["frm_real_data"].window.document.all('station_ids');
		 //alert(r);
		 var str = "";
		 for(var i=0;i<r.length;i++){
		 	if(r[i].checked){
				str = str + r[i].value + ",";
		 	}
		    }
		    form1.station_ids.value = str;
		 	form1.action='select_real.jsp';
		 	form1.target='frm_real_data_excel';
		 	form1.submit();
	}
 }
 function f_hz(){
 	var url = "../map/all_area_info.jsp";
	var width = 1024;
	var height = 668;
	window.open(url,"","scrollbars=yes,resizable=yes"+",height="+height+",width="+width+",left="+(window.screen.width-width)/2+",top="+(window.screen.height-height)/2);
}

</script>


