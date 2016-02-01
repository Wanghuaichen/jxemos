<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc_empty.jsp" %>
<%
      
BaseAction action = null;
   try{
    action = new FormAction();
    action.run(request,response,"form");
    //System.out.println("tableName====="+request.getParameter("tableName"));
   }catch(Exception e){
      w.error(e);
      return;
   }
    String now = StringUtil.getNowDate() + "";
    int year = f.getYear(now);
    String month= f.getStringMonth(now);

%>

<style>
.search {font-family: "宋体"; font-size: 12px;
    BEHAVIOR: url('<%=request.getContextPath() %>/styles/selectBox.htc'); cursor: hand;
 }
.input {
   border: #ccc 1px solid;
   font-family: "微软雅黑";
   font-size: 13px;
   width: 150px;
   background:expression((this.readOnly &&this.readOnly==true)?"#f9f9f9":"")
}

body{
background-color:#F7F7F7;
overflow: auto;
scrollbar-base-color: #ecf2f9;
	scrollbar-arrow-color: #336699;
	scrollbar-track-color: #ecf2f9;
	scrollbar-3dlight-color: #ecf2f9;
	scrollbar-darkshadow-color: #ecf2f9;
	scrollbar-highlight-color: #336699;
	scrollbar-shadow-color: #336699;

}

</style>

<body onload=rpt()  scroll=no>
<form name=form1 method=post >
<input type=hidden name=no_data_string value="--">
<input type=hidden name=not_config_string value="△">
<input type=hidden name=offline_string value="×">
<input type=hidden name=online_string value="√">
<input type=hidden name='tableName' value='<%=request.getParameter("tableName")%>'>

<table border=0 width=100% >
      <tr>
      <td >
      
       <select name=station_type onchange=r() >
     
      <%=w.get("stationTypeOption")%>
      </select>
      
      <select name=area_id onchange=r() >
      <%=w.get("areaOption")%>
      </select>
      
      
      <select name=trade_id onchange=r() >
       <option value=''>行业
      <%=w.get("tradeOption")%>
      </select>
      <select name=station_id onchange=rpt() >
      <option value=''>企业
      <%=w.get("stationOption")%>
      </select>
     
      年份:<select name=year onchange=rpt()  style="width:100px;" >
						
						<%=f.getOption("2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030","2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030",String.valueOf(year)) %>
					</select>
       月份:<select name=month onchange=rpt()  style="width:100px;"  >
						
						<%=f.getOption("01,02,03,04,05,06,07,08,09,10,11,12","1月,2月,3月,4月,5月,6月,7月,8月,9月,10月,11月,12月",month) %>
					</select><%--

      <input type=text class=input name=date2 value='<%=w.get("date2")%>'  onclick="new Calendar().show(this);">
      --%><input type=button value='查看' onclick=form1.submit() class="btn" >

      
      
      </td>
      </tr>
      <tr>
      <td >
      <iframe name=q frameborder=0 width=100% height=400px frameborder=0 allowtransparency="true"></iframe>
      </td>
      </tr>
</table>
</form>


<script>
function f_save(){
    var obj = window.frames["q"].window.document.getElementById('div_excel_content');
   //alert(obj);
    form2.txt_excel_content.value=obj.innerHTML;
    
    form2.action='/<%=ctx%>/pages/commons/save2excel.jsp';
    form2.submit();
}

 function r(){
   form1.action='tj_yue_form.jsp';
   form1.target='';
   form1.submit();
   
   
 }
 
 function rpt(){
   form1.action='tj_yue.jsp';
   form1.target='q';
   form1.submit();
   
   
 }

</script>