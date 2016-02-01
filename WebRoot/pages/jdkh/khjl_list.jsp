<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.util.Scape"%>
<%@page import="com.hoson.f,java.util.*,com.hoson.zdxupdate.*,com.hoson.XBean"%>
<%

    RowSet data;
    String col,m_time,m_value;
	SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String station_id = "";
    String station_desc = "";
    try{
      station_id = request.getParameter("station_id");
      station_desc = request.getParameter("station_desc");
      if(!"".equals(station_desc) && station_desc != null){
	    	station_desc = new String(station_desc.getBytes("ISO-8859-1"), "gbk"); 
		}
      SwjUpdate.queryKhjlHisByID(request);
    }catch(Exception e){
     w.error(e);
     return;
    }
    data = w.rs("data");


	//String drop_css = "";
	String checked = "";


  	Map map = null;

%>

<form name=form1 method=post action='khjl_list.jsp'>

<table border=0 cellspacing=1>
    <tr class=title> 
    <%--<td width=5%> 
          选择
      </td>
      --%><td width=5%> 
          序号
      </td>
      <td>
        企业名称
      </td>
      <td> 
          编号
      </td>
      <td> 
          日期
      </td>
      <td> 
          考核结果
      </td>
      <td> 
          考核人
      </td>
     
   </tr>
   
   <%
      String jd_jg = "不合格";
      while(data.next()){
       jd_jg = data.get("jd_jg");
       if(!"".equals(jd_jg) && jd_jg.equals("1")){
           jd_jg = "合格";
       }else{
           jd_jg = "不合格";
       }
  %>
    <tr style="height:30px;font-family: Tahoma;">
    <%--<td> <input type="checkbox" onclick="check(this,'khjls_id','')"  name="khjl_ids" value="<%=data.get("id") %>"> </td>
	    --%><td width=5%>
	    <%=data.getIndex()+1%></td>
	    <td width=10%><a href="khjl_update.jsp?id=<%=data.get("id") %>" target="_blank"><%=data.get("qy_mc")%></td>
	    <td width=20%>环验[<%=data.get("jd_zhi")%>]<%=data.get("jd_hao")%>号</td>
	    <td width=10%><%=data.get("jd_rq")%></td>
        <td width=10%><%=jd_jg%></td>
        <td width=10%><%=data.get("jd_name")%></td>
 
     </tr>
  <%} %>
    <tr>
      <td class=right colspan=6>
         <%--<input type="checkbox" id="khjls_id" onclick="checkall(this.form,this)"/><span class="span">以上全选</span>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button"  class="btn" onclick="YN_delete(this.form)" value="删除"/>
         --%><input type=button value='新增' onclick="open_new('<%=station_id %>','<%=station_desc %>')" class='btn'><%=w.get("bar")%>
         <input type="hidden" value="<%=w.get("station_id") %>" name="station_id">
         <input type="hidden" value="<%=w.get("date1") %>" name="date1">
         <input type="hidden" value="<%=w.get("date2") %>" name="date2">
         <input type="hidden" value="<%=w.get("jd_jg") %>" name="jd_jg">
      </td>
  </tr>
   
</table>
</form>

<script type="text/javascript">
   function open_new(id,name){
       window.open("khjl_info.jsp?station_id="+id+"&station_desc="+escape(escape(name)));
   }
</script>


<script type="text/javascript">
//选中其中的一个
function check(thisCheckbox,id,nameId){
    if(thisCheckbox.checked==false){
      document.getElementById(id).checked=false;
    }
    if(nameId !=""){
      if(document.getElementById(nameId).checked==true){
          document.getElementById(nameId).checked=false;
      }  
    }
    
 }
 
 //全部选择操作，复选框
function checkall(form,Tcheck){
    //alert(form);
    var objForm=form;
    var objLength=objForm.length;
    for(var objC=0; objC<objLength; objC++){
      if(Tcheck.checked==true){
        if(objForm.elements[objC].type == "checkbox"){
            objForm.elements[objC].checked=true;
         }
      }else{
        if(objForm.elements[objC].type == "checkbox"){
            objForm.elements[objC].checked=false;
         }
      }
    }
 }
 
 //删除判断操作
function YN_delete(form){
    var objForm=form;
    var objLength=objForm.length;
    var station_desc = '<%=station_desc%>';
    for(var objL=0;objL<objLength; objL++){
       if(objForm.elements[objL].type=="checkbox"){
         if(objForm.elements[objL].checked==true){
           var flag=window.confirm("确定要删除这些记录?");
            if(flag){
              objForm.action="khjl_delete.jsp?station_id="+<%=station_id%>+"&station_desc="+escape(escape(station_desc));
              //alert(objForm.action);
              objForm.submit();
              return ;
            }else{
              return ;
            }
         }
       }
    }
    alert("请选中要删除的记录");
 }
</script>
