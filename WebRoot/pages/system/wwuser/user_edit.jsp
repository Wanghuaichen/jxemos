<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/pages/commons/inc.jsp" %>
<%@page import="com.hoson.ww.*" %>
<%
  
  Map map = null;
  String objectid = request.getParameter("objectid");
   String sql = "select * from t_sys_ww_user where user_id='"+objectid+"'";
  String optionDept = null;
  String dept_id = null;
  String msg = null;
  String user_name = null;
  String sp_ctl_flag = null;
  String data_acl_sql = null;
  String areaOption = null;
   String optionStation = null;
	String sql1 = null;
  
  try{
	   map=DBUtil.queryOne(sql,null,request);
	   
	   if(map==null){
	    msg ="ָ���ļ�¼������ objectid="+objectid;
	       JspUtil.go2error(request,response,msg);
	    return;
	    }
	    
	    
	    //sql1 = "select station_id,station_desc from t_cfg_station_info";
		//optionStation = user.getMultipleOption(sql1,map.get("station_ids").toString());
   }catch(Exception e){
   JspUtil.go2error(request,response,e);
   return;
   }
   
%>

<body scroll=no>

<form name=form1 method=post action="user_update.jsp">
<input type="hidden" name="objectid" value="<%=map.get("user_id")%>">
<input type="hidden" name="user_id" value="<%=map.get("user_id")%>">
<input type=hidden name=station_ids >
<input type=hidden name=cols value="user_id,user_name,user_allname" >
<table border=0 cellspacing=1>

<tr class=tr0>
<td class='tdtitle'>�û���</td>
<td class=left>

<input type="text" name="user_name"  value="<%=map.get("user_name")%>">
</td>
</tr>

<tr class=tr1>
<td class='tdtitle'>�û�������</td>
<td class=left>

<input type="text" name="user_allname" value="<%=map.get("user_allname")%>">
</td>
</tr>
<%-- 
<tr class=tr0>
<td class='tdtitle' width="230px">ӵ��վλ<span style="color:red">(��סctrl���ɽ��ж�ѡ��</span></td>
<td class=left>

<select name=sel_station_ids multiple=true size="20"><%=optionStation%></select>
</td>
</tr>
--%>
<tr>
<td class='tdtitle'>
</td>
<td class=left>

<input type="button" value="����" onclick="f_query()" class="btn">
<input type="button" value="����" class="btn" onclick="f_update()">
<input type="button" value="��������" class="btn" onclick="f_pwd_reset()">
<input type="button" value="վλȨ������" class="btn" onclick="f_station()">
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
//var itemSelect=document.all["sel_station_ids"]; 
	    //var res="";  
	   // var num = 0;
	   // for(var i=0;i <itemSelect.options.length;i++) { 
	   // if (itemSelect.options[i].selected == true) { 
	   // 		res=res+itemSelect.options[i].value+",";
	   // 		num++;
	   // 		if(num>20){
	  //  			alert("ӵ��վλ���ܶ���20����������ѡ��");
	   // 			return;
	   // 		}
	   // 	} 
	  //  }  
	  //  form1.station_ids.value = res;
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

