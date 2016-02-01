<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.f"%>
<%

    try{
    
      SwjUpdate.jdkh_index(request);//初始化页面数据
      
      
      //w封装了本页的request和response对象。
    
    }catch(Exception e){
     w.error(e);
     return;
    }

    boolean iswry = f.iswry(w.get("station_type"));//是否是污染源
    
    
    RowSet rs = w.rs("flist");

    String now = StringUtil.getNowDate() + "";
    int year = f.getYear(now);
    int month= f.getMonth(now);
    String season = f.getThisSeasonTime(month);
  // boolean b = zdxUpdate.isReal(user_name,session_id);//需恢复
%>

<style>


</style>

<body scroll=no onload='f_r()' style="background-color: #f7f7f7">
<form name=form1 method=post action="01.jsp" target='q'>
<table style='height:100%;width:100%' border=0 cellspacing=0>
   <tr>
     <td style='height:20px' colspan="2">
         
       <table border=0 cellspacing=0 style="font-size:13px">
          <tr>
              <td> 
                      站位类型:<select name=station_type  onchange=f_r() style="width:100px;"  class="search"><%=w.get("stationTypeOption")%></select>
              <%--</td>
 
              <%--<td>
                           重点源:<select name=ctl_type onchange=f_r()  class="search" style="width:120px">
						<option value=''>所有</option>
						<%=w.get("ctlTypeOption")%>
						</select>
              </td>

              <td>
                       行业:<select name=trade_id onchange=f_r()  class="search">
					<option value=''>所有
					<%=w.get("tradeOption")%>
					</select>
              </td>
              <td>--%>
                  地区:<select name=area_id onchange=f_r()  style="width:120px;" class="search">
					<%=w.get("areaOption")%>
                  </select>
              行业:<select name=trade_id onchange=f_r()  class="search">
					<option value=''>所有
					<%=w.get("tradeOption")%>
					</select>
                  年份:<select name=year onchange=f_r()  style="width:70px;" class="search">
						
						<%=f.getOption("2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030","2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030",String.valueOf(year)) %>
					</select>
				季度:<select name=jidu onchange=f_r()  style="width:80px;" class="search">
						
						<%=f.getOption("1,2,3,4","第一季度,第二季度,第三季度,第四季度",season) %>
						</select>
              
		       站位名称:<input type=text name='station_desc' value='' class="input">
		     <input type=button value='查询' onclick='f_jdkh()' class='btn'>
		    
		     
		  <td>
              
          </tr>
       </table>  
     </td>

     
   
   <tr>
     <td style='height:100%' colspan="2"><%--<div id="topDiv"></div>
      --%><iframe name='q' id='q' width=100% height=100% frameborder=0 allowtransparency="true"></iframe>
 
     <br></td>
   </tr>
   
</table>
</form>
</body>


<script>

function f_r(){
 	form1.submit();
}
 function f_jdkh(){
    	
    	form1.submit();
 }
 
</script>


