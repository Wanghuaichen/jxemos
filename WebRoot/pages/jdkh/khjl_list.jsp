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
          ѡ��
      </td>
      --%><td width=5%> 
          ���
      </td>
      <td>
        ��ҵ����
      </td>
      <td> 
          ���
      </td>
      <td> 
          ����
      </td>
      <td> 
          ���˽��
      </td>
      <td> 
          ������
      </td>
     
   </tr>
   
   <%
      String jd_jg = "���ϸ�";
      while(data.next()){
       jd_jg = data.get("jd_jg");
       if(!"".equals(jd_jg) && jd_jg.equals("1")){
           jd_jg = "�ϸ�";
       }else{
           jd_jg = "���ϸ�";
       }
  %>
    <tr style="height:30px;font-family: Tahoma;">
    <%--<td> <input type="checkbox" onclick="check(this,'khjls_id','')"  name="khjl_ids" value="<%=data.get("id") %>"> </td>
	    --%><td width=5%>
	    <%=data.getIndex()+1%></td>
	    <td width=10%><a href="khjl_update.jsp?id=<%=data.get("id") %>" target="_blank"><%=data.get("qy_mc")%></td>
	    <td width=20%>����[<%=data.get("jd_zhi")%>]<%=data.get("jd_hao")%>��</td>
	    <td width=10%><%=data.get("jd_rq")%></td>
        <td width=10%><%=jd_jg%></td>
        <td width=10%><%=data.get("jd_name")%></td>
 
     </tr>
  <%} %>
    <tr>
      <td class=right colspan=6>
         <%--<input type="checkbox" id="khjls_id" onclick="checkall(this.form,this)"/><span class="span">����ȫѡ</span>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button"  class="btn" onclick="YN_delete(this.form)" value="ɾ��"/>
         --%><input type=button value='����' onclick="open_new('<%=station_id %>','<%=station_desc %>')" class='btn'><%=w.get("bar")%>
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
    var station_desc = '<%=station_desc%>';
    for(var objL=0;objL<objLength; objL++){
       if(objForm.elements[objL].type=="checkbox"){
         if(objForm.elements[objL].checked==true){
           var flag=window.confirm("ȷ��Ҫɾ����Щ��¼?");
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
    alert("��ѡ��Ҫɾ���ļ�¼");
 }
</script>
