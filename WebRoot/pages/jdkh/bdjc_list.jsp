<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.f,java.util.*,com.hoson.zdxupdate.*,com.hoson.XBean"%>
<%

    RowSet data;
    String col,m_time,m_value;

	SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String station_id = "";
    try{
      station_id = request.getParameter("station_id");
      SwjUpdate.queryBdjcHisByID(request);
    }catch(Exception e){
     w.error(e);
     return;
    }
    data = w.rs("data");


	//String drop_css = "";
	String checked = "";


  	Map map = null;

%>

<form name=form1 method=post action='bdjc_list.jsp'>

<table border=0 cellspacing=1>
    <tr class=title> 
    <td width=5%> 
          选择
      </td>
      <td width=5%> 
          序号
      </td>
      <td> 
          企业名称
      </td>
      <td> 
          比对监测单位
      </td>
      <td> 
          监测日期
      </td>
      <td> 
          监测结果
      </td>
      <td> 
          监测人
      </td>
     
   </tr>
   
   <%
     String bdjg = "不合格";
      while(data.next()){
       bdjg = data.get("bdjg");
       if(!"".equals(bdjg) && bdjg.equals("1")){
           bdjg = "合格";
       }else{
           bdjg = "不合格";
       }
  %>
    
     <tr style="height:30px;font-family: Tahoma;">
        <td> <input type="checkbox" onclick="check(this,'bdjcs_id','')"  name="bdjc_ids" value="<%=data.get("id") %>"> </td>
	    <td width=5%>
	    <%=data.getIndex()+1%></td>
	    <td width=20%><a href="bdjc_update.jsp?id=<%=data.get("id") %>" target="_blank"><%=data.get("qymc")%></a></td>
	    <td width=10%><%=data.get("zzdw")%></td>
        <td width=10%><%=data.get("bdrq")%></td>
        <td width=10%><%=bdjg%></td>
        <td width=10%><%=data.get("username")%></td>
     </tr>
  <%} %>
    <tr>
      <td class=right colspan=7>
      <input type="checkbox" id="bdjcs_id" onclick="checkall(this.form,this)"/><span class="span">以上全选</span>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button"  class="btn" onclick="YN_delete(this.form)" value="删除"/>
        <input type=button value='新增'  onclick='open_new(<%=station_id %>)' class='btn'><%=w.get("bar")%>
         <input type="hidden" value="<%=station_id %>" name="station_id">
         <input type="hidden" value="<%=w.get("date1") %>" name="date1">
         <input type="hidden" value="<%=w.get("date2") %>" name="date2">
         <input type="hidden" value="<%=w.get("bdjg") %>" name="bdjg">
      </td>
  </tr>
   
</table>
</form>

<script type="text/javascript">
   function open_new(id){
       window.open('bdjc_info.jsp?station_id='+id);
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
    for(var objL=0;objL<objLength; objL++){
       if(objForm.elements[objL].type=="checkbox"){
         if(objForm.elements[objL].checked==true){
           var flag=window.confirm("确定要删除这些记录?");
            if(flag){
              objForm.action="bdjc_delete.jsp?station_id=<%=station_id%>";
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

