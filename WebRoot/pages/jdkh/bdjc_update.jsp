<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.f,java.util.*,com.hoson.zdxupdate.*,com.hoson.XBean"%>
<%

    Map data;
    
    RowSet data_jcxm = null;
    RowSet data_xm = null;

    String id = "";
    String user_area_id = (String)request.getSession().getAttribute("area_id");
    String flag = request.getParameter("flag");
    try{
      id = request.getParameter("id");
      SwjUpdate.queryBdjcInfoByID(request);
    }catch(Exception e){
       w.error(e);
       return;
    }
    
    data = (Map)w.a("data_bdjc");
    
    data_jcxm = w.rs("data_jcxm");
    
    data_xm = w.rs("data_xm");
	//String drop_css = "";
	String checked = "";


  	Map map = null;

%>

<form action="bdjc_updateaction.jsp" method="post">
<br>
<br>
<table border=0 cellspacing=1  style="width: 800px">
   <caption style="font-size: 16px">������ҵ��ȾԴ�Զ�����豸�ȶԼ������</caption>
    <tr>
        <td colspan="2" style="text-align: center">��ҵ����</td>
        <td colspan="4"> 
            <input type="text" name="qymc" value="<%=data.get("qymc") %>">
            <input type="hidden" name="qyid" value="<%=data.get("qyid") %>">
            <input type="hidden" name="id" value="<%=id%>">
            <input type="hidden" name="flag" value="<%=flag %>">
        </td>
    </tr>
    <tr>
        <td colspan="2" style="text-align: center">�ȶԼ�ⵥλ</td>
        <td colspan="2"> <input type="text" name="bddw" value="<%=data.get("bddw") %>"> </td>
        <td style="text-align: center">�������</td>
        <td > <input type="text" name="bdrq" value="<%=data.get("bdrq") %>" readonly="readonly"  onclick="new Calendar().show(this);"> </td>
    </tr>
    
    <tr>
        <td colspan="2" style="text-align: center">��λ����</td>
        <td colspan="4">
          <input type="text" name="zwmc" value="<%=data.get("zwmc") %>">
        </td>
    </tr>
    <tr>
        <td colspan="2" style="text-align: center">�Զ�����豸���� </td>
        <td colspan="4"><input type="text" name="sbmc" value="<%=data.get("sbmc") %>"></td>
    </tr>
    <tr>
        <td colspan="2" style="text-align: center"> ���쵥λ</td>
        <td colspan="4"><input type="text" name="zzdw" value="<%=data.get("zzdw") %>"></td>
    </tr>
    <tr>
        <td colspan="2" style="text-align: center">�ͺż����</td>
        <td colspan="4"><input type="text" name="xhbh" value="<%=data.get("xhbh") %>"></td>
    </tr>

    
    <tr>
        <td rowspan="2" colspan="2">�����Ŀ</td>
        <td colspan="4"> �����ȶԷ���</td>
    </tr>
    
    <tr>
        <td colspan="2"> �ȶԷ���</td>
        <td colspan="2">
              �Զ���ⷽ��
        </td>
        
    </tr>
    
    
    
   <%
      int i=0;
      while(data_jcxm.next()){
 
   %>
   
   <tr id="tr_jc_<%=i %>">
        <td colspan="2">
           <input type="text" name="jcxm_name_<%=i %>" id="jcxm_name_<%=i %>" value="<%=data_jcxm.get("jcxm_name") %>"> 
           <input type="hidden" name="jcxm_id_<%=i %>" value="<%=data_jcxm.get("id") %>">
       </td>
        <td colspan="2">
            <input type="text" name="jcxm_bdff_<%=i %>" id="jcxm_bdff_<%=i %>" value="<%=data_jcxm.get("jcxm_bdff") %>">
        </td>
        <td colspan="2">
            <input type="text" name="jcxm_jcff_<%=i %>" id="jcxm_jcff_<%=i %>" value="<%=data_jcxm.get("jcxm_jcff") %>">
        </td>
    </tr>
   
   <%  
        i++;
    } 
   %>
   
   <%
      for(int j =i;j<7;j++){
   %>
     <tr id="tr_jc_<%=j %>">
        <td colspan="2">
            <input type="text" name="jcxm_name_<%=j %>" id="jcxm_name_<%=j %>" > 
            <input type="hidden" name="jcxm_id_<%=j %>" value="">
       </td>
        <td colspan="2">
            <input type="text" name="jcxm_bdff_<%=j %>" id="jcxm_bdff_<%=j %>" >
        </td>
        <td colspan="2">
            <input type="text" name="jcxm_jcff_<%=j %>" id="jcxm_jcff_<%=j %>" >
        </td>
    </tr>
    
   <%
     }
   %>
    <tr>
        <td>��Ŀ</td>
        <td>�ȶԼ������</td>
        <td>�Զ��������</td>
        <td>��׼��ֵ</td>
        <td>�ȶԽ��</td>
        <td>  
               ������
        </td>
    </tr>
    
    
    <%
      i=0;
      while(data_xm.next()){
 
   %>
   
   <tr id="tr_xm_<%=i %>">
        <td>
           <input type="text" name="xm_name_<%=i %>"  name="xm_name_<%=i %>" value="<%=data_xm.get("xm_name") %>">
           <input type="hidden" name="xm_id_<%=i %>" value="<%=data_xm.get("id") %>">
        </td>
        <td><input type="text" name="xm_bdsj_<%=i %>" name="xm_bdsj_<%=i %>" value="<%=data_xm.get("xm_bdsj") %>"></td>
        <td><input type="text" name="xm_zdsj_<%=i %>" name="xm_zdsj_<%=i %>" value="<%=data_xm.get("xm_zdsj") %>"></td>
        <td><input type="text" name="xm_bzxz_<%=i %>" name="xm_bzxz_<%=i %>" value="<%=data_xm.get("xm_bzxz") %>"></td>
        <td><input type="text" name="xm_bdjg_<%=i %>" name="xm_bdjg_<%=i %>" value="<%=data_xm.get("xm_bdjg") %>"></td>
        <td><input type="text" name="xm_dbqk_<%=i %>" name="xm_dbqk_<%=i %>" value="<%=data_xm.get("xm_dbqk") %>"></td>
    </tr>
   
   <%  
        i++;
    } 
   %>
   
   <%
      for(int j =i;j<7;j++){
   %>
     <tr id="tr_xm_<%=j %>">
        <td>
            <input type="text" name="xm_name_<%=j %>"  name="xm_name_<%=j %>" >
            <input type="hidden" name="xm_id_<%=j %>" value="">
        </td>
        <td><input type="text" name="xm_bdsj_<%=j %>" name="xm_bdsj_<%=j %>"  ></td>
        <td><input type="text" name="xm_zdsj_<%=j %>" name="xm_zdsj_<%=j %>" ></td>
        <td><input type="text" name="xm_bzxz_<%=j %>" name="xm_bzxz_<%=j %>"  ></td>
        <td><input type="text" name="xm_bdjg_<%=j %>" name="xm_bdjg_<%=j %>"  ></td>
        <td><input type="text" name="xm_dbqk_<%=j %>" name="xm_dbqk_<%=j %>"  ></td>
    </tr>
    
   <%
     }
   %>
    
     <tr>
        <td style="text-align: center">������</td>
        <td colspan="2">
            <input type="text" name="jbr" value="<%=data.get("jbr") %>"> 
        </td>
        <td style="text-align: center">�����</td>
        <td colspan="2"><input type="text" name="spr" value="<%=data.get("spr") %>"></td>
    </tr>
    
    <tr>
        <td>�ȶԼ�����</td>
        <td >
             <select name="bdjg">
                  <%=f.getOption("1,0","�ϸ�,���ϸ�",(String)data.get("bdjg")) %>
             </select>
         
        </td>
        <td>��ע</td>
        <td colspan="3"><input type="text" name="bdjcjl" style="width:350px;" value="<%=data.get("bdjcjl") %>"></td>
    </tr>

    
    <% if(!"".equals(user_area_id) && user_area_id.equals("36") && !"".equals(flag) && flag.equals("1")){ %>
	    <tr >
	       <td colspan="6" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="�޸�" class="btn">
	           <input type="button" value="�ر�" class="btn" onclick="window.close();">&nbsp;&nbsp;&nbsp; &nbsp;<input type="button" value="������Ϣ" class="btn" onclick="export_info('<%=id %>','export_BdjcInfo')">
	        </td>
	    </tr>
	<%}else if(!"".equals(user_area_id) && !user_area_id.equals("36") && !"".equals(flag) && !flag.equals("1")){ %>
	    <tr >
	       <td colspan="6" style="text-align: center"><input type="button" onclick="check_form(this.form)" value="�޸�" class="btn">
	           <input type="button" value="�ر�" class="btn" onclick="window.close();">&nbsp;&nbsp;&nbsp; &nbsp;<input type="button" value="������Ϣ" class="btn" onclick="export_info('<%=id %>','export_BdjcInfo')">
	        </td>
	    </tr>
    <%} %>
    
     <tr>
	      <td style='height:100%' colspan="6">
	         <iframe name='frm_zw_list' id='frm_zw_list' width=100% height=100% frameborder=0 allowtransparency="true"></iframe>
	       <br></td>
     </tr>
   
    
</table>

</form>

<script type="text/javascript">

var tr_jc_Show=0;
var tr_xm_show=0;
function jc_clickmore(m_id,count){
    if (0<=tr_jc_Show && tr_jc_Show<count-1){
         tr_jc_Show++;
         document.all(m_id+"_"+tr_jc_Show).style.display="";
    }else {
         alert("�����"+count+"������!");
    }
}

function jc_clickless(m_id,count){
   if (0<tr_jc_Show && tr_jc_Show<=count-1){
         document.all(m_id +"_"+ tr_jc_Show).style.display="none";
         tr_jc_Show--;
   }else{
         alert("������һ�����ڣ�");
   }
}


function xm_clickmore(m_id,count){
    if (0<=tr_xm_show && tr_xm_show<count-1){
         tr_xm_show++;
         document.all(m_id+"_"+tr_xm_show).style.display="";
    }else {
         alert("�����"+count+"������!");
    }
}

function xm_clickless(m_id,count){
   if (0<tr_xm_show && tr_xm_show<=count-1){
         document.all(m_id +"_"+ tr_xm_show).style.display="none";
         tr_xm_show--;
   }else{
         alert("������һ�����ڣ�");
   }
}

function check_form(form){
   if(form.qymc.value == ""){
      alert("����д��ҵ����!");
      return false;
   }
   
   if(form.bddw.value == ""){
      alert("����д�ȶԼ�ⵥλ!");
      return false;
   }
   
   if(form.bdrq.value == ""){
      alert("����д�������!");
      return false;
   }
   
   if(form.zwmc.value == ""){
      alert("����д��λ����!");
      return false;
   }
   
   if(form.sbmc.value == ""){
      alert("����д�Զ�����豸����!");
      return false;
   }
   
   if(form.zzdw.value == ""){
      alert("����д���쵥λ!");
      return false;
   }
   
   if(form.xhbh.value == ""){
      alert("����д�ͺż����!");
      return false;
   }
   

   var jcxm_name = document.getElementById("jcxm_name_0").value;
   var jcxm_bdff = document.getElementById("jcxm_bdff_0").value;
   var jcxm_jcff = document.getElementById("jcxm_jcff_0").value;
   
   
   if(jcxm_name =="" || jcxm_bdff =="" || jcxm_jcff==""){
      alert("������дһ�������Ŀ!");
      return false;
   }
   

   for(var i=1;i<7;i++){
      jcxm_name = document.getElementById("jcxm_name_"+i).value;
      jcxm_bdff = document.getElementById("jcxm_bdff_"+i).value;
      jcxm_jcff = document.getElementById("jcxm_jcff_"+i).value;
      
      if(jcxm_name !="" && (jcxm_bdff =="" || jcxm_jcff=="")){
         alert("��Ѽ����Ŀ��Ϣ��д����!");
         return false;
      }
   }
   
   
  var  xm_name = document.getElementById("xm_name_0").value;
  var  xm_bdsj = document.getElementById("xm_bdsj_0").value;
  var  xm_zdsj = document.getElementById("xm_zdsj_0").value;
  var  xm_bzxz = document.getElementById("xm_bzxz_0").value;
  var  xm_bdjg = document.getElementById("xm_bdjg_0").value;
  var  xm_dbqk = document.getElementById("xm_dbqk_0").value;
   
   
   if(xm_name =="" || xm_bdsj =="" || xm_zdsj=="" || xm_bzxz=="" || xm_bdjg=="" || xm_dbqk==""){
      alert("������дһ����Ŀ��Ϣ!");
      return false;
   }
   

   for(var i=1;i<7;i++){
       xm_name = document.getElementById("xm_name_"+i).value;
       xm_bdsj = document.getElementById("xm_bdsj_"+i).value;
       xm_zdsj = document.getElementById("xm_zdsj_"+i).value;
       xm_bzxz = document.getElementById("xm_bzxz_"+i).value;
       xm_bdjg = document.getElementById("xm_bdjg_"+i).value;
       xm_dbqk = document.getElementById("xm_dbqk_"+i).value;
      
      if(xm_name !="" && (xm_bdsj =="" || xm_zdsj=="" || xm_bzxz=="" || xm_bdjg=="" || xm_dbqk=="")){
         alert("�����Ŀ��Ϣ��д����!");
         return false;
      }
   }
   
   if(form.jbr.value == ""){
      alert("����д������!");
      return false;
   }
    if(form.spr.value == ""){
      alert("����д������!");
      return false;
   }
   
   form.submit();
  
}

function export_info(id,method){
   window.open("export_page.jsp?id="+id+"&method="+method,"frm_zw_list");
   
}

</script>



