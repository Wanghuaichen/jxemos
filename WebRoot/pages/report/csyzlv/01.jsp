<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    List list = null;
    RowSet rs = null;

    String year = "";//年份
   	String jidu = "";//季度
   	String area_name = "";
    String station_type = "";
  try{
    
    SwjUpdate.csyzlv_data(request);//初始化数据
     list = (List)request.getAttribute("list");

    year = request.getAttribute("year")+"";//年份
   	jidu = request.getAttribute("jidu")+"";//季度
   	area_name = request.getAttribute("area_name")+"";
     rs = new RowSet(list);

    station_type = w.get("station_type");
  }catch(Exception e){
   w.error(e);
   return;
  }

%>
<link href="/<%=ctx%>/styles/css.css" rel="stylesheet" type="text/css">
<style>
 .up{color:#FF8000;}
 .yc{color:red;};
 .drop{color:#B5B5B5;}
</style>
<form name=form1 method=post>

<div id='div_excel_content'>
<span style="font-size: 16px"><%=area_name%><%=year %>年<%=jidu %>季度的设备运转率和数据传输率统计情况</span>
<table border=0 cellspacing=1 style="width: 100%" >

  <%--<tr class=title style="position: relative; top: expression(this.offsetParent.scrollTop);text-align: center" >
    --%>
 <tr class=title  >   
    <td width=5%>序号</td>
    <td >站位名称</td>
    <td >设备运转率(%)</td>
    <td >数据传输率(%)</td>
  </tr>

  <%while(rs.next()){
    
  
  %>
    <tr style="height:30px;font-family: Tahoma;">
	    <td width=5%>

	    <%=rs.getIndex()+1%></td>

	    <td width=20%><%=rs.get("station_desc")%></td>
        <td width=10%> <%=rs.get("sb_sbyzl") %> </td>
        <td width=10%><%=rs.get("sb_sjcsl") %></td>
      </tr>
  <%} %>
  
  <%
    
     
     
  
  %>
  
  
</table>

</div>

 </form>
<script type="text/javascript">
   function open_khjl(id,name){
     window.open("add_page.jsp?station_id="+id+"&station_desc="+escape(escape(name)));
   }
   
   function open_detail(id,name,flag){
     window.open("stationkhdetail.jsp?station_id="+id+"&station_desc="+escape(escape(name))+"&flag="+flag);
   }
   
   function f_shlv(){
      form1.action="shhglv_top.jsp";
	  form1.target='frm_zw_list2';
	  form1.submit();
   }
   
   function jdkh_4(page,id,station_desc,flag){
      //alert(page+"?id="+id+"&station_desc="+escape(escape(station_desc))+"&flag="+flag);
      window.open(page+"?id="+id+"&station_desc="+escape(escape(station_desc))+"&flag="+flag);
   }
   
   function export_info(id,method){
      //alert("export_page.jsp?id="+id+"&method="+method+"&year=<%=year%>&jidu=<%=jidu%>");
      window.open("export_page.jsp?id="+id+"&method="+method+"&year=<%=year%>&jidu=<%=jidu%>&station_type=<%=station_type%>","frm_zw_list2");
   
   }

function f_save(year,jidu){
//alert(window.frames["frm_station"].window.frames["q"]);
    var obj = window.document.getElementById('div_excel_content');
    // alert(obj);
    //alert(obj.innerHTML);
    //var form2 = window.document.getElementById('excel_form');
    //alert(form2);
    form1.txt_excel_content.value=obj.innerHTML;
    
    form1.action='<%=request.getContextPath() %>/pages/jdkh/save2excel.jsp?year='+year+'&jidu='+jidu;
    form1.submit();
}
</script>



