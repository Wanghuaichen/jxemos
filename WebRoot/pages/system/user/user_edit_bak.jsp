<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%
  
  Map map = null;
  String objectid = request.getParameter("objectid");
   String sql = "select * from t_sys_user where user_id='"+objectid+"'";
  String optionDept = null;
  String dept_id = null;
  String msg = null;
  String user_name = null;
  String sp_ctl_flag = null;
  String data_acl_sql = null;
  String areaOption = null;
  
  try{
  	
  	data_acl_sql = App.get("data_acl_sql","0");
  	
  	
   map=DBUtil.queryOne(sql,null,request);
   
   
   areaOption = f.getAreaOption(map.get("area_id").toString());
   if(map==null){
    //out.println("ָ���ļ�¼������ objectid="+objectid);
    msg ="ָ���ļ�¼������ objectid="+objectid;
       JspUtil.go2error(request,response,msg);
    return;
    }
     sp_ctl_flag =(String)map.get("sp_ctl_flag");
    if(StringUtil.equals( sp_ctl_flag,"1" )){
     sp_ctl_flag =" checked";
    }else{
     sp_ctl_flag ="";
    }
    
    dept_id = null;
    dept_id=(String)map.get("dept_id");
    sql = "select dept_id,dept_name from t_sys_dept";
	optionDept = JspUtil.getOption(sql,dept_id,request);
    user_name=(String)map.get("user_name");
    
   }catch(Exception e){
   JspUtil.go2error(request,response,e);
   return;
   }
%>


<body scroll=no>

<form name=form1 method=post action="user_update.jsp">
<input type="hidden" name="objectid" value="<%=map.get("user_id")%>">
<input type="hidden" name="user_id" value="<%=map.get("user_id")%>">
<input type="hidden" name="yw_role_id" value="<%=map.get("yw_role")%>">
<table border=0 cellspacing=1>

<tr class=tr0>
<td class='tdtitle'>�û���</td>
<td class=left>

<input type="text" name="user_name" readonly value="<%=map.get("user_name")%>">
</td>
</tr>




<tr class=tr1>
<td class='tdtitle'>�û�������</td>
<td class=left>

<input type="text" name="user_cn_name" value="<%=map.get("user_cn_name")%>">
</td>
</tr>



<tr class=tr0>
<td class='tdtitle'>��������</td>
<td class=left>

<select name=dept_id><%=optionDept%></select>
</td>
</tr>


<tr>
<td class='tdtitle'>�û�˵��</td>
<td class=left>

<input type="text" name="user_desc" value="<%=map.get("user_desc")%>">
</td>
</tr>
<tr>
<td class='tdtitle'></td>
<td class=left>
<input type="checkbox" name="sp_ctl_flag" value="1" <%=sp_ctl_flag%>>��Ƶ����Ȩ��
</td>
</tr>

<tr>
<td class=left colspan="2">��ά���ã�</td>
</tr>

<tr>
<td class='tdtitle'>��������</td>
<td class=left>
<select name=area_id id="area_id" onchange=f_r()>
						<%=areaOption%>
					</select>
</td>
</tr>

<tr>
<td class='tdtitle'></td>
<td class=left>

<input type=radio value=1 name=yw_role >
                ʡ
                <input type=radio value=2 name=yw_role >
                ��
                <input type=radio value=3 name=yw_role >
                �� 
<input type=radio value=4 name=yw_role >
��ά
</td>
</tr>

<tr>
<td class='tdtitle'>
</td>
<td class=left>


<input type="button" value="����" onclick="f_query()" class="btn">
<input type="button" value="����" class="btn" onclick="f_update()">
<!--
<input type="button" value="�޸�����" class="btn" onclick="f_pwd_update()">
-->


<%
      if(!StringUtil.equals(user_name,"admin")){
%>
<input type="button" value="��������" class="btn" onclick="f_pwd_reset()">
<input type="button" value="ɾ��" class="btn" onclick="f_del()">


<input type="button" value="Ȩ������" class="btn" onclick="f_res()">

<input type="button" value="վλȨ������" class="btn" onclick="f_station()">


<%
	}
%>


</td>
</tr>
</table>
</form>


<iframe name="user_action"  width=96% height=60%  scrolling="auto" frameborder="0"  style="border:0px" allowtransparency="true">
</iframe>



<script>


function f_station(){
form1.target="";
form1.action="user_station_view.jsp";
form1.submit();
}

function f_query(){
form1.target="";
form1.action="user_query.jsp";
form1.submit();
}

function f_del(){
var msg = "��ȷ��Ҫɾ����?";
if(!confirm(msg)){return;}
form1.target="";
form1.action="user_del.jsp";
form1.submit();
}

function f_update(){
form1.target="";
form1.action="user_update.jsp";
form1.submit();
}

function f_pwd_update(){
//form1.target="user_action";
form1.target="";
form1.action="user_pwd_edit.jsp";
form1.submit();
}
function f_pwd_reset(){
//form1.target="user_action";
var msg = "ȷ��Ҫ����������";
if(!confirm(msg)){return;}
form1.target="user_action";
form1.action="pwd_reset.jsp";
form1.submit();
}

function f_res(){
//form1.target="user_action";
form1.target="";
form1.action="user_res_edit.jsp";
form1.submit();
}

var eless = document.getElementsByName("yw_role");
for(var i=0;i<eless.length;i++){
	if(eless[i].value == form1.yw_role_id.value){
		eless[i].checked = true;
	}
}

</script>

