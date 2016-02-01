<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
    List list = null;
    RowSet rs = null;
    try{
    
      SwjUpdate.select_real(request);
     list = (List)request.getAttribute("list");
     list = SwjUpdate.getFocusList(request,list);
     rs = new RowSet(list);
    }catch(Exception e){
     w.error(e);
     return;
    }

    boolean iswry = f.iswry(w.get("station_type"));
   
    RowSet rsf = w.rs("flist");
    
    String id = null;
    String v = null;
    String station_id = null;
    Map m = (Map)request.getAttribute("m");
    String css = null;
    boolean is_q_zero =false;
    
    
    
%>
<style>
 .vover{color:red;}
 .drop{color:#B5B5B5;}
</style>
<div id='div_excel_content'>
<table border=0 cellspacing=1>
  <tr class=title style="position: relative; top: expression(this.offsetParent.scrollTop);" >
    <td style='width:40px'>序号</td>
    <td style='width:200px'>站位名称</td>
    <td style='width:130px'>监测时间</td>
    <%while(rsf.next()){
    	if(!rsf.get("infectant_name").equals("流量2")){
    %>
      <td style='width:60px'>
      <%=rsf.get("infectant_name")%><br>
      <%=rsf.get("infectant_unit")%>
      </td>
    <%}}%>
    <td style='width:100px'>备注</td>

  </tr>
  
  <%while(rs.next()){
    station_id = rs.get("station_id");
     is_q_zero = f.is_q_zero(rs);
     //f.sop("is_q_zero="+is_q_zero);
  %>
    <tr>
    <td>
    <%=rs.getIndex()+1%></td>
    <td><%=rs.get("station_desc")%></td>
    <td><%=f.sub(rs.get("m_time"),10,9)%></td>
      <%
      rsf.reset();
      while(rsf.next()){
      id = rsf.get("infectant_id");
      v = rs.get(id);
      
      v = f.v(v);
      //if(is_q_zero){v="";}
      css = f.get_css(m,station_id,id,v);
      %>
        <td class='<%=css%>'><%=f.format(v,"0.#####")%></td>
      <%}%>
      <td><%=rs.get("comments")%></td>
     
     </tr>
  <%}%>
</table>
</div>
<form name=form2 method=post>
<input type=hidden name='txt_excel_content'>
</form>

<script>
 function f_real_view(station_id){
var url = "real_view_jx.jsp";
//url = "real_view.jsp";
url = "../station_new/index_one.jsp";
url = url+"?station_id="+station_id;
var width = 1024;
var height = 568;
window.open(url,"","scrollbars=yes"+",height="+height+",width="+width+",left="+(window.screen.width-width)/2+",top="+(window.screen.height-height)/2);

}

var obj = document.getElementById('div_excel_content');
    form2.txt_excel_content.value=obj.innerHTML;
    form2.action='../commons/save2excel.jsp';
    form2.submit();

</script>



