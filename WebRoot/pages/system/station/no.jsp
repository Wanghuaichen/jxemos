<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<link rel="stylesheet" href="../../../web/index.css" />

<%
      String station_type,area_id,station_name,sql=null;

      Map map = null;
      List list = null;
      RowSet rs = null;

      Map params = new HashMap();
      
      String station_id,station_no,station_desc;
      int index  =0;
      
      
      try{
      
      station_type = JspUtil.getParameter(request,"p_station_type","1");
     area_id = JspUtil.getParameter(request,"p_area_id",f.cfg("default_area_id","3301"));
      //area_id = JspUtil.getParameter(request,"p_area_id",f.cfg("area_id","3301"));
      station_name = JspUtil.getParameter(request,"p_station_name","");
      
      if(f.empty(station_type)){station_type="1";}
      
      params.put("cols","station_id,station_desc,station_no");
      params.put("station_type",station_type);
      params.put("area_id",area_id);
      params.put("station_desc",station_name);
      params.put("order_cols","station_no,area_id,station_desc");
      
      sql = f.getStationQuerySql(params,request);
      
      list = f.query(sql,null);
     
      rs = new RowSet(list);
      
      
      }catch(Exception e){
      w.error(e);
      return;
      }
      
      
      
%>

<form name=form1 action='no_save.jsp' target='frm_no_save' >
 <table border=0 cellspacing=1>
 <thead >

  <tr class=title>
    <td></td>
    <td width=120px >站位ID</td>
    <td width=180px >站位名称</td>
    <td >站位序号</td>
    <td></td>
  </tr>
  </thead>
  <form id=no_form_0>
  </form>
  
  <%while(rs.next()){
   index = rs.getIndex();
   station_id = rs.get("station_id");
   station_no = rs.get("station_no");
   station_desc = rs.get("station_desc");
  %>
    <form id='no_form_<%=index+1%>' method=post action='no_save.jsp' target='frm_no_save'>
    <tr>
     <td><%=(index+1)%></td>
     <td><input type=text readonly name='station_id' value='<%=station_id%>'></td>
     <td><input type=text readonly name='station_desc' value='<%=station_desc%>' style='width:300px'></td>
     <td>
     <input type=text name='station_no' value='<%=station_no%>'>
     </td>
     <td>
     <input type=button value=' 保 存 ' onclick="f_save(<%=index+1%>)" class="tiaojianbutton tj2 ">
    </td>
    </tr>
    </form>
  <%}%>
  
 </table>
 
 </form>
 <iframe name='frm_no_save' width=0 height=0></iframe>
 
 <script>
  function f_save(i){
  var obj = document.getElementById("no_form_"+i);
  //alert(obj);
  //alert(obj.station_id.value+","+obj.station_desc.value);
   obj.submit();
  }
 </script>
 
 





