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
      SwjUpdate.queryXchcHisByID(request);
    }catch(Exception e){
     w.error(e);
     return;
    }
    data = w.rs("data");


	//String drop_css = "";
	String checked = "";


  	Map map = null;

%>

<form name=form1 method=post action='xchc_list.jsp'>

<table style='width:100%;' border=0 cellspacing=1>
    <tr class=title> 
    <td width=5%> 
          ѡ��
      </td>
      <td width=5%> 
          ���
      </td>
      <td> 
          ��ҵ����
      </td>
      <td> 
          ��ҵ��ַ
      </td>
      <td> 
          �˲鵥λ
      </td>
      <td> 
          �˲�����
      </td>
      <td> 
          �˲���
      </td>
      <td> 
          �˲���
      </td>
     
   </tr>
   
   <%
   String hcjl = "���ϸ�";
      while(data.next()){
       hcjl = data.get("hcjl");
       if(!"".equals(hcjl) && hcjl.equals("1")){
           hcjl = "�ϸ�";
       }else{
          hcjl = "���ϸ�";
       }
  
  %>
    <tr style="height:30px;font-family: Tahoma;">
        <td> <input type="checkbox" onclick="check(this,'xchcs_id','')"  name="xchc_ids" value="<%=data.get("id") %>"> </td>
	    <td width=5%>
	    <%=data.getIndex()+1%></td>
	    <td width=20%><a href="xchc_update.jsp?id=<%=data.get("id") %>" target="_blank"> <%=data.get("qymc")%> </a></td>
	    <td width=10%><%=data.get("address")%></td>
	    <td width=10%><%=data.get("hcdw")%></td>
        <td width=10%><%=data.get("hcrq")%></td>
        <td width=10%><%=hcjl%></td>
        <td width=10%><%=data.get("username")%></td>
     </tr>
  <%} %>
    <tr>
      <td class=right colspan=8>
         <input type="checkbox" id="xchcs_id" onclick="checkall(this.form,this)"/><span class="span">����ȫѡ</span>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button"  class="btn" onclick="YN_delete(this.form)" value="ɾ��"/>
         <input type=button value='����' onclick='open_new(<%=station_id %>)' class='btn'><%=w.get("bar")%>
         <input type="hidden" value="<%=w.get("station_id") %>" name="station_id">
         <input type="hidden" value="<%=w.get("date1") %>" name="date1">
         <input type="hidden" value="<%=w.get("date2") %>" name="date2">
         <input type="hidden" value="<%=w.get("hcjl") %>" name="hcjl">
      </td>
  </tr>
   
</table>
</form>

<script type="text/javascript">
   function open_new(station_id){
       window.open('xchc_info.jsp?station_id='+station_id);
   }
</script>


<script type="text/javascript">
//ѡ�����е�һ��
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
 
 //ȫ��ѡ���������ѡ��
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
 
 //ɾ���жϲ���
function YN_delete(form){
    var objForm=form;
    var objLength=objForm.length;
    for(var objL=0;objL<objLength; objL++){
       if(objForm.elements[objL].type=="checkbox"){
         if(objForm.elements[objL].checked==true){
           var flag=window.confirm("ȷ��Ҫɾ����Щ��¼?");
            if(flag){
              objForm.action="xchc_delete.jsp?station_id=<%=station_id%>";
              objForm.submit();
              return ;
            }else{
              return ;
            }
         }
       }
    }
    alert("��ѡ��Ҫɾ���ļ�¼");
 }
</script>
