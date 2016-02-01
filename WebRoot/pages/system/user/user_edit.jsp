<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/pages/commons/inc.jsp"%>
<%
	Map<?,?> map = null;
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

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<link rel="stylesheet" href="../../../web/index.css" />
<style type="text/css">
.tj1 {
	height: 30px;
	line-height: 30px;
	font-weight: bold;
	margin-left: 70px;
	width: 110px;
}
</style>
</head>

<body>
	<form name=form1 method=post action="user_update.jsp">
		<input type="hidden" name="objectid" value="<%=map.get("user_id")%>">
		<input type="hidden" name="user_id" value="<%=map.get("user_id")%>">
		<input type="hidden" name="yw_role_id" value="<%=map.get("yw_role")%>">
		<div class="frame-main-content" style="left:0; top:0;">
			<div class="fankui">
				<ul>
					<li><b>用户名</b> <span><input type="text"
							name="user_name" readonly value="<%=map.get("user_name")%>">
					</span>
					</li>
					<li><b>用户中文名</b> <span><input type="text"
							name="user_cn_name" value="<%=map.get("user_cn_name")%>">
					</span>
					</li>
					<li><b>所属部门</b> <span><select name=dept_id><%=optionDept%></select>
					</span>
					</li>
					<li><b>用户说明</b> <span><input type="text"
							name="user_desc" value="<%=map.get("user_desc")%>"> </span>
					</li>
					<li><b>&nbsp;</b> <span><input type="checkbox"
							name="sp_ctl_flag" value="1" <%=sp_ctl_flag%>>视频控制权限 </span>
					</li>
					<li><b>运维设置：</b> <span></span>
					</li>
					<li><b>所属地区</b> <span><select name=area_id id="area_id"
							onchange=f_r()>
								<%=areaOption%>
						</select> </span>
					</li>
					<li><b>&nbsp;</b> <span><input type=radio value=1
							name=yw_role> 省 <input type=radio value=2 name=yw_role>
							市 <input type=radio value=3 name=yw_role> 县 <input
							type=radio value=4 name=yw_role> 运维</span>
					</li>
					<li><b><input type="button" value="保存"
							class="tiaojianbutton tj1" onclick="f_update()" /> </b><input
						type="button" value="删除" class="tiaojianbutton tj1"
						onclick="f_del()" />
						<input type="button" value="返回"
						class="tiaojianbutton tj1" onclick="history.back()" />
					</li><li><b><input type="button" value="重置密码"
							class="tiaojianbutton tj1" onclick="f_pwd_reset()" /> </b><!-- <input
						type="button" value="管理权限配置" class="tiaojianbutton tj1"
						onclick="f_res()" /><input type="button"
						value="站位权限配置" class="tiaojianbutton tj1" onclick="f_station()" /> --><input type="button"
						value="权限配置" title="访问权限配置" class="tiaojianbutton tj1" onclick="f_page()" />
					</li>
				</ul>
			</div>
		</div>
	</form>
	<iframe name="user_action" width=96% height=60% scrolling="auto"
		frameborder="0" style="border:0px" allowtransparency="true">
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
var msg = "您确认要删除吗?";
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
var msg = "确认要重置密码吗";
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
function f_page(){
	form1.target="";
	form1.action="user_page.jsp";
	form1.submit();
}

var eless = document.getElementsByName("yw_role");
for(var i=0;i<eless.length;i++){
	if(eless[i].value == form1.yw_role_id.value){
		eless[i].checked = true;
	}
}
</script>
</body>
</html>
